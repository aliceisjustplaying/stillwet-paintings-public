#!/usr/bin/env -S uv run --script
# /// script
# requires-python = ">=3.11"
# ///
"""Build the stillwet-paintings records from the M3 sources.

    uv run export.py OUT --runs-data PATH --private-names FILE [--ledger FILE] [--only ID ...]

OUT gets one folder per stillwet.art painting (paintings/<id>/), one per lane studio with no site painting
(studios/<paint-studio-hex>/), the given documents by hash (docs/), the runner records (runs/), the scrubbed
manifest, the round captions and INDEX.md. Sources are read only:

- [local path redacted] dist/paintings.json, dist/studio/data (sessions.json and each studio's events.json), inputs_data
- [local path redacted] manifest.json, rounds.md
- [local path redacted] the runners' studios.json mappings missing from the copies below
- [local path redacted] the studio folders (brief, notes, journal, Lua)
- [local path redacted] studio and runner text the M3 no longer has elsewhere
- a clone of stillwet-runs-data (--runs-data): the scrubbed run-tree records

Every text file passes the same redactions: local paths and the account name, tailnet hosts and addresses, opaque
provider blobs in JSON, and long third-party quotes in reference documents. Raw logs of OpenRouter Stealth models
stay out. The ledger lists every redaction and exclusion.
"""
import argparse
import base64
import collections
import hashlib
import json
import os
import re
import shutil
from pathlib import Path

HOME = Path.home()
SRC = HOME / "src" / "a"
SITE = SRC / "stillwet"
DATA = SRC / "stillwet-data"
COLLECTION = SRC / "claude-paint" / "archive" / "collection"
RUN_TREE = SRC / "stillwet-runs"
STUDIO_DATA = SITE / "dist" / "studio" / "data"
SITE_URL = "https://stillwet.art"

STEALTH_MODELS = {"space-bunny-free"}
TEXT_SUFFIXES = {".md", ".txt", ".json", ".jsonl", ".lua", ".py", ".diff", ".patch", ".log", ".csv", ".sh",
                 ".toml", ".yml", ".yaml", ".rs", ".js"}
MAX_BYTES = 20 * 1024 * 1024
MAX_MEDIA_BYTES = 50 * 1024 * 1024
MEDIA_SUFFIXES = {".png", ".jpg", ".jpeg", ".mp4"}
TONN_FILES = re.compile(r"(^|/)(tweets\.jsonl|rows\.md|method\.md|tonn[^/]*\.md)$")
QUOTE_SCOPE = re.compile(r"(^docs/|/research/|/notes/[^/]*materials[^/]*\.md$|REVIEW|RECONCILE|/briefs?\d*/|/stage/|/gaps/|/strip/)")

RUNS_ROOTS = [(re.compile(r"(?:~|[local path redacted]\s\"'<>]+)/src/a/stillwet-runs/"), "runs/"),
              (re.compile(r"(?:~|[local path redacted]\s\"'<>]+)/tmp/(gallery-fcf9c110|paint-r6-b943b1ca)/"), r"runs/\1/"),
              (re.compile(r"(?:~|[local path redacted]\s\"'<>]+)/src/a/(paint-studio-[0-9a-z-]+)/"), r"\1/")]
SUBS = []


def load_private_names(path):
    """The names that must not appear, kept out of this public script: a JSON object with "accounts" (local account
    names), "hosts" (tailnet machine names, redacted wherever they stand alone), "url_hosts" (names redacted only as a
    URL host) and "tokens" (other strings, such as the tailnet's own name)."""
    names = json.loads(Path(path).read_text())
    alt = lambda xs: "|".join(sorted(map(re.escape, xs), key=len, reverse=True))
    SUBS[:] = [
        ("tailnet host", re.compile(r"\b[a-z0-9-]+\.tail[0-9a-f]{4,}\.ts\.net(?::\d+)?\b", re.I), "[tailnet host redacted]"),
        ("tailnet host", re.compile(r"\btail[0-9a-f]{5,}\.ts\.net\b|\b(?:%s)\b" % alt(names["tokens"]), re.I), "[tailnet redacted]"),
        ("tailnet IP", re.compile(r"\b100\.(?:6[4-9]|[7-9]\d|1[01]\d|12[0-7])\.\d{1,3}\.\d{1,3}(?::\d+)?\b"), "[tailnet IP redacted]"),
        ("tailnet host", re.compile(r"(?<=://)(?:%s)(?::\d+)?\b" % alt(names["hosts"] + names["url_hosts"]), re.I), "[tailnet host redacted]"),
        ("tailnet host", re.compile(r"(?<![\w.-])(?:%s)(?![\w-])" % alt(names["hosts"]), re.I), "[tailnet host redacted]"),
        ("local path", re.compile(r"--Users-[A-Za-z0-9_.]+-[^\s\"'<>]*?--"), "[local path redacted]"),
        ("local path", re.compile(r"(?:[local path redacted]\s\"'<>]+|[local path redacted]\s\"'<>]+|~)/(?:[^\s\"'<>\\)\]\x60]+)"), "[local path redacted]"),
        ("local account", re.compile(r"[local path redacted]\s\"'<>]+|\b(?:%s)\b" % alt(names["accounts"]), re.I), "[local account redacted]"),
    ]
OPAQUE_KEYS = re.compile(r"^(thinkingSignature|thoughtSignature|encrypted_content|signature|encryptedContent|redacted_thinking)$")
BASE64 = re.compile(r"^(?:data:[\w/+.-]+;base64,)?[A-Za-z0-9+/=_-]{400,}$")
QUOTES = re.compile(r"\u201c([^\u201d]{1,6000})\u201d|(?<![\w=])\"([^\"\n]{1,3000})\"(?!\w)")
FENCE = re.compile(r"(^\x60\x60\x60.*?^\x60\x60\x60)", re.S | re.M)


class Ledger:
    def __init__(self):
        self.redactions = collections.Counter()
        self.redacted_files = collections.defaultdict(set)
        self.excluded = []
        self.written = {}
        self.quotes = []
        self.duplicates = []

    def hit(self, kind, rel, n=1):
        self.redactions[kind] += n
        self.redacted_files[kind].add(rel)

    def exclude(self, source, reason):
        self.excluded.append({"source": source, "reason": reason})


L = Ledger()


def scrub_text(s, rel):
    if rel.startswith("runs/"):
        if Path(rel).name == "LAUNCH.md" or rel.endswith("/handoff/prompts/index.md"):
            s = s.replace("The Captain", "The operator").replace("the Captain", "the operator")
            s = s.replace("addressed Captain notification", "addressed notification to the operator")
        if Path(rel).name == "session.jsonl":
            s = s.replace("Capy MCP", "MCP")
    for pattern, repl in RUNS_ROOTS:
        s, n = pattern.subn(repl, s)
        if n:
            L.hit("local path mapped to repo path", rel, n)
    for kind, pattern, repl in SUBS:
        s, n = pattern.subn(repl, s)
        if n:
            L.hit(kind, rel, n)
    return s


def scrub_json(obj, rel):
    if isinstance(obj, dict):
        out = {}
        for k, v in obj.items():
            if OPAQUE_KEYS.match(k) and isinstance(v, (str, list, dict)) and len(json.dumps(v)) > 40:
                L.hit("opaque provider blob", rel)
                continue
            out[scrub_text(k, rel)] = scrub_json(v, rel)
        return out
    if isinstance(obj, list):
        return [scrub_json(v, rel) for v in obj]
    if isinstance(obj, str):
        if BASE64.match(obj) and not re.fullmatch(r"[a-f0-9]+|[A-Za-z_/.-]+", obj) and not decodes_to_text(obj):
            L.hit("opaque provider blob", rel)
            return "[opaque data removed]"
        return scrub_text(obj, rel)
    return obj


def decodes_to_text(s):
    try:
        return base64.b64decode(s.split(",", 1)[-1] + "==", validate=False).decode("utf-8").isprintable() or True
    except (ValueError, UnicodeDecodeError):
        return False


def words(s):
    return len(s.split())


def trim_quotes(text, rel):
    """Trim long third-party quotations in reference and review documents: any quote of 25+ words, and in the two
    caption-heavy notes (trees.md, bob_ross.md) any of 12+ words. Kept: the first 10 words and the attribution around
    the quote. Kendric Tonn's public posts and the notes built from them stay verbatim."""
    if TONN_FILES.search(rel) or not QUOTE_SCOPE.search(rel):
        return text
    parts = FENCE.split(text)
    limit = 12 if Path(rel).name in ("trees.md", "bob_ross.md") else 25

    def cut(m):
        inner = m.group(1) or m.group(2)
        if words(inner) < limit:
            return m.group(0)
        L.hit("long third-party quote trimmed", rel)
        L.quotes.append({"file": rel, "words": words(inner), "start": inner[:120]})
        short = " ".join(inner.split()[:10]) + " [\u2026]"
        return ("\u201c%s\u201d" if m.group(1) is not None else "\"%s\"") % short
    return "".join(QUOTES.sub(cut, p) if i % 2 == 0 else p for i, p in enumerate(parts))


def write(out, rel, data, source):
    suffix = Path(rel).suffix
    if suffix not in TEXT_SUFFIXES:
        L.exclude(source, "not a text record (%s)" % (suffix or "no suffix"))
        return False
    if not isinstance(data, str):
        try:
            data = data.decode("utf-8")
        except UnicodeDecodeError:
            L.exclude(source, "not UTF-8 text")
            return False
    if "\x00" in data:
        L.exclude(source, "binary content")
        return False
    if suffix == ".json":
        try:
            data = json.dumps(scrub_json(json.loads(data), rel), ensure_ascii=False, indent=1) + "\n"
        except ValueError:
            data = scrub_text(data, rel)
    elif suffix == ".jsonl":
        lines = []
        for line in data.splitlines():
            try:
                lines.append(json.dumps(scrub_json(json.loads(line), rel), ensure_ascii=False))
            except ValueError:
                lines.append(scrub_text(line, rel))
        data = "\n".join(lines) + "\n"
    else:
        data = scrub_text(data, rel)
        if suffix in (".md", ".txt"):
            data = trim_quotes(data, rel)
    raw = data.encode("utf-8")
    if len(raw) > MAX_BYTES:
        L.exclude(source, "larger than 20 MiB")
        return False
    if re.search(r"data:image/[a-z]+;base64,", data):
        L.exclude(source, "embedded image data")
        return False
    path = out / rel
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_bytes(raw)
    L.written[rel] = source
    return True


def copy(out, rel, src):
    return write(out, rel, Path(src).read_bytes(), str(src))


def sha256(path):
    with Path(path).open("rb") as f:
        return hashlib.file_digest(f, "sha256").hexdigest()


class Media:
    def __init__(self, out):
        self.out = Path(out)
        self.by_hash = {}
        for root in ("paintings", "runs"):
            for path in sorted((self.out / root).rglob("*")):
                if path.is_file() and not path.is_symlink() and path.suffix.lower() in MEDIA_SUFFIXES:
                    digest = sha256(path)
                    if digest in self.by_hash:
                        raise ValueError("Duplicate media in output: " + path.relative_to(self.out).as_posix())
                    self.by_hash[digest] = path

    def add(self, folder, source, name, role, expected=None):
        source = Path(source)
        if Path(name).suffix.lower() not in MEDIA_SUFFIXES or Path(name).name != name:
            raise ValueError("Invalid media filename")
        if source.stat().st_size > MAX_MEDIA_BYTES:
            raise ValueError("Media exceeds 50 MiB: " + name)
        digest = sha256(source)
        if expected is not None and digest != expected:
            raise ValueError("Media checksum mismatch: " + name)
        target = self.by_hash.get(digest)
        if target is None:
            target = self.out / folder / name
            if target.exists():
                raise ValueError("Media filename already has different content: " + name)
            target.parent.mkdir(parents=True, exist_ok=True)
            shutil.copyfile(source, target)
            if sha256(target) != digest:
                raise ValueError("Copied media checksum mismatch: " + name)
            self.by_hash[digest] = target
            L.written[target.relative_to(self.out).as_posix()] = str(source)
        link = Path(os.path.relpath(target, self.out / folder)).as_posix()
        return "- [%s](%s): %s; SHA-256 `%s`" % (name, link, role, digest)


def studio_dirs(name, runs_data):
    """Where a studio's own folder survives: the M3, the watercolor run folders, or claude-paint's collection."""
    found = [SRC / name] if (SRC / name).is_dir() else []
    hexpart = name.removeprefix("paint-studio-")
    for base in (runs_data / "stillwet-runs").glob("*watercolor/paint-studio-*"):
        if base.name.endswith(hexpart):
            found.append(base)
    if not found and (COLLECTION / "studios" / name).is_dir():
        found.append(COLLECTION / "studios" / name)
    return found


def studio_files(studio):
    """The studio's text records: brief, launch notes, notes (with the journal), Lua and the committed program."""
    for f in sorted(studio.rglob("*")):
        rel = f.relative_to(studio).as_posix()
        if not f.is_file() or f.is_symlink():
            continue
        top = rel.split("/")[0]
        if rel in ("BRIEF.md", "LAUNCH.md") or top == "notes" or \
                (top in ("paintings", "scratch", "lua") and f.suffix == ".lua") or \
                (top == "out" and f.name == "committed.lua"):
            yield rel, f


def last_reply(events):
    says = [e.get("text", "") for e in events if e.get("kind") == "say" and e.get("text", "").strip()]
    return says[-1] if says else None


def lane_files(runs, studio):
    """Runner records of the lane that painted in this studio, from runs/**/studios.json."""
    hits = []
    for f in sorted(runs.glob("**/studios.json")):
        try:
            mapping = json.loads(f.read_text())
        except ValueError:
            continue
        if not isinstance(mapping, dict):
            continue
        for key, value in mapping.items():
            if value == studio:
                m = re.fullmatch(r"([A-Z]+?)(\d+)", key)
                lane, n = (m.group(1), m.group(2)) if m else (key, "1")
                hits.append((f.parent, lane, n))
    return hits


def put_studio(out, folder, studio, runs_data):
    brief, journal = None, None
    for base in studio_dirs(studio, runs_data):
        for rel, f in studio_files(base):
            if rel == "BRIEF.md":
                if brief is None:
                    brief = copy(out, folder + "/brief.md", f) and "brief.md"
            elif rel == "notes/journal.md":
                if journal is None:
                    journal = copy(out, folder + "/journal.md", f) and "journal.md"
            elif rel.endswith(".lua"):
                name = rel.removeprefix("paintings/lua/").removeprefix("paintings/").removeprefix("lua/").replace("out/easel/", "committed/")
                if not (out / folder / "lua" / name).exists():
                    copy(out, folder + "/lua/" + name, f)
            elif not (out / folder / "studio" / rel).exists():
                copy(out, folder + "/studio/" + rel, f)
        if brief is None and base.parent.name.endswith("watercolor") and (base.parent / "BRIEF.md").exists():
            brief = copy(out, folder + "/brief.md", base.parent / "BRIEF.md") and "brief.md"
    return brief, journal


def put_runner(out, folder, studio, stealth):
    found = []
    for run_dir, lane, n in lane_files(out / "runs", studio):
        rel_dir = run_dir.relative_to(out).as_posix()
        found.append((rel_dir, lane, n))
        for name, dest in (("p%s_sittings.json" % n, "sittings.json"), ("p%s_outcome.json" % n, "outcome.json")):
            f = run_dir / lane / name
            if f.exists() and not (stealth and dest == "sittings.json"):
                write(out, folder + "/" + dest, f.read_bytes(), str(f))
    return found


def given_md(out, pid, g, docs):
    lines = ["# What the painter was given", "",
             "Extracted from the session logs by stillwet's inputs_extract.py. Each document links to the copy it saw, "
             "one file per version under docs/.", ""]
    for it in g["items"]:
        if it["kind"] == "note":
            lines.append("- %s: %s" % (it.get("title", "Note"), it.get("text", "")))
            continue
        shas = [it["sha"]] + [s for _, s in it.get("sections", [])]
        links = []
        for i, s in enumerate(shas):
            if s in docs:
                label = "full text" if i == 0 else it["sections"][i - 1][0]
                links.append("[%s](../../docs/%s)" % (label, docs[s]))
        path = " (\x60%s\x60)" % it["path"] if it.get("path") else ""
        lines.append("- %s%s: %s" % (it.get("title", it["kind"]), path, ", ".join(links) or "no copy kept"))
    if g.get("missing"):
        lines += ["", "## Not recovered", ""] + ["- %s" % (m if isinstance(m, str) else json.dumps(m)) for m in g["missing"]]
    if g.get("opened"):
        lines += ["", "## Also opened in the studio, not given", ""] + ["- \x60%s\x60 (%s)" % (o["path"], ", ".join(o.get("how", []))) if isinstance(o, dict) else "- \x60%s\x60" % o for o in g["opened"]]
    write(out, "paintings/%s/given.md" % pid, "\n".join(lines) + "\n", "inputs_data/given.json#" + pid)


def record_md(out, folder, title, facts, links, words, sections):
    lines = ["# " + (title or "(untitled)"), "", "| | |", "|---|---|"]
    lines += ["| %s | %s |" % (k, str(v).replace("|", "\\|").replace("\n", " ")) for k, v in facts if v not in (None, "", [])]
    if words:
        lines += ["", "> " + words.replace("\n", "\n> ")]
    lines += ["", "## Records", ""] + ["- " + x for x in links]
    for head, body in sections:
        if body:
            lines += ["", "## " + head, ""] + body
    write(out, folder + "/RECORD.md", "\n".join(lines) + "\n", "generated")


def runner_links(lanes):
    return ["[%s/%s/](../../%s/%s/): the runner's lane folder (painter %s), and [studios.json](../../%s/studios.json)"
            % (d, lane, d, lane, n, d) for d, lane, n in lanes]


def build_runs(out, runs_data, stealth_studios):
    sources = {}
    for f in sorted((runs_data / "stillwet-runs").rglob("*")):
        if f.is_file() and not f.is_symlink():
            sources["runs/" + f.relative_to(runs_data / "stillwet-runs").as_posix()] = f
    for f in sorted((COLLECTION / "runners").rglob("*")):
        rel = "runs/" + f.relative_to(COLLECTION / "runners").as_posix()
        if f.is_file() and not f.is_symlink():
            if rel in sources:
                L.duplicates.append(str(f))
            else:
                sources[rel] = f
    for f in sorted(RUN_TREE.glob("gallery-fcf9c110/r*/run/studios.json")):
        rel = "runs/" + f.relative_to(RUN_TREE).as_posix()
        if f.is_file() and not f.is_symlink() and rel not in sources:
            sources[rel] = f
    stealth_lanes = set()
    for rel, f in sources.items():
        if f.name != "studios.json":
            continue
        try:
            mapping = json.loads(f.read_text())
        except ValueError:
            continue
        if isinstance(mapping, dict):
            for key, value in mapping.items():
                if value in stealth_studios:
                    stealth_lanes.add(str(Path(rel).parent / re.sub(r"\d+$", "", key)) + "/")
    hexes = {s.removeprefix("paint-studio-") for s in stealth_studios}
    for rel, f in sources.items():
        if f.name == "events.json":
            L.exclude(str(f), "older studio viewer export; the current site export is in the painting folder")
        elif "/uvcache/" in rel:
            L.exclude(str(f), "dependency license file from a uv cache, not a record")
        elif any(rel.startswith(x) for x in stealth_lanes) or any(h in rel for h in hexes):
            if f.suffix in (".lua", ".md"):
                copy(out, rel, f)
            else:
                L.exclude(str(f), "raw log or sitting record of an OpenRouter Stealth model (space-bunny-free)")
        else:
            copy(out, rel, f)


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("out", type=Path)
    ap.add_argument("--runs-data", type=Path, required=True)
    ap.add_argument("--private-names", type=Path, required=True)
    ap.add_argument("--ledger", type=Path)
    ap.add_argument("--only", nargs="*")
    a = ap.parse_args()
    load_private_names(a.private_names)
    out = a.out
    out.mkdir(parents=True, exist_ok=True)
    media_files = Media(out)

    paintings = json.loads((SITE / "dist" / "paintings.json").read_text())
    manifest = json.loads((DATA / "manifest.json").read_text())
    man = {m["id"]: m for m in manifest}
    sessions = {s["p"]: s for s in json.loads((STUDIO_DATA / "sessions.json").read_text())}
    given = json.loads((SITE / "inputs_data" / "given.json").read_text())
    stealth_studios = {p["studio"] for p in paintings if man[p["id"]]["painter_model"] in STEALTH_MODELS}
    stealth_studios |= {k for k, s in sessions.items() if s.get("model") in STEALTH_MODELS}
    for m in manifest:
        if m["painter_model"] not in STEALTH_MODELS:
            continue
        if m.get("studio_id"):
            stealth_studios.add(m["studio_id"])
        for log in m["session_log"] if isinstance(m["session_log"], list) else [m["session_log"]]:
            hit = re.search(r"paint-studio-[0-9a-f]+", log or "")
            if hit:
                stealth_studios.add(hit.group(0))

    if not a.only:
        build_runs(out, a.runs_data, stealth_studios)

    docs = {f.stem: f for f in sorted((SITE / "inputs_data" / "docs").iterdir())}
    used_docs = {}
    painting_studios = set()
    index = []
    for p in paintings:
        pid = p["id"]
        if a.only and pid not in a.only:
            continue
        m = man[pid]
        folder = "paintings/" + pid
        studio = m.get("studio_id") or p["studio"]
        painting_studios |= {p["studio"], studio}
        stealth = m["painter_model"] in STEALTH_MODELS
        ev_path = STUDIO_DATA / p["studio"] / "events.json"
        events = json.loads(ev_path.read_text())["events"] if ev_path.exists() else []
        links = []
        if ev_path.exists() and not stealth:
            copy(out, folder + "/events.json", ev_path)
            links.append("[events.json](events.json): the studio viewer's log of the session (thinking, tool calls, words), as stillwet.art serves it")
        elif ev_path.exists():
            L.exclude(str(ev_path), "studio viewer log of an OpenRouter Stealth model (space-bunny-free); stillwet.art still serves it")
        reply = last_reply(events)
        if reply:
            write(out, folder + "/reply.md", "# The painter's last reply\n\n" + reply.strip() + "\n", str(ev_path))
            links.append("[reply.md](reply.md): the painter's last message")
        brief, journal = None, None
        if studio.startswith("paint-studio-"):
            brief, journal = put_studio(out, folder, studio, a.runs_data)
        g = given.get(pid)
        if g:
            for it in g["items"]:
                for s in [it.get("sha")] + [s for _, s in it.get("sections", [])]:
                    if s and s in docs:
                        used_docs[s] = docs[s]
            given_md(out, pid, g, {s: docs[s].name for s in used_docs})
            links.append("[given.md](given.md): what the painter was given, with links to each document")
            if not brief:
                b = next((it for it in g["items"] if it.get("doc_kind") == "brief"), None) or \
                    next((it for it in g["items"] if it["kind"] == "user"), None)
                if b and b["sha"] in docs:
                    brief = copy(out, folder + "/brief.md", docs[b["sha"]]) and "brief.md"
            j = SITE / "inputs_data" / "journals" / (pid + ".md")
            if not journal and j.exists():
                journal = copy(out, folder + "/journal.md", j) and "journal.md"
        if brief:
            links.append("[brief.md](brief.md): the brief")
        if journal:
            links.append("[journal.md](journal.md): the painter's journal at the end")
        if (out / folder / "lua").exists():
            links.append("[lua/](lua/): the painting's Lua (the finished program, committed chunks and scratch)")
        if (out / folder / "studio").exists():
            links.append("[studio/](studio/): the studio's other notes at the end of the run")
        lanes = put_runner(out, folder, studio, stealth)
        for name in ("sittings.json", "outcome.json"):
            if (out / folder / name).exists():
                links.append("[%s](%s): the runner's %s record" % (name, name, name.split(".")[0]))
        links += runner_links(lanes)
        media = []
        full = next((f for f in (SITE / "dist" / "img" / (pid + s) for s in ("-full.jpg", "-large.jpg")) if f.exists()), None)
        if full:
            media.append("Finished image: %s/img/%s (SHA-256 \x60%s\x60)" % (SITE_URL, full.name, sha256(full)))
        master = DATA / m["final_file"] if m.get("final_file") else None
        if master and master.exists():
            media.append("Full-resolution original (%s px), not hosted: SHA-256 \x60%s\x60" % ("x".join(map(str, m.get("final_size") or [])), sha256(master)))
        clip = next((f for f in (SITE / "dist" / "media" / (pid + s) for s in (".mp4", "-1920.mp4")) if f.exists()), None)
        if clip:
            media.append("Timelapse: %s/media/%s (SHA-256 \x60%s\x60)" % (SITE_URL, clip.name, sha256(clip)))
        local_media = []
        if master:
            local_media.append(media_files.add(folder, master, "final" + master.suffix.lower(), "Full-resolution final"))
        master_clip = DATA / "clips" / m["clip"] if m.get("clip") else clip
        if master_clip:
            local_media.append(media_files.add(folder, master_clip, "timelapse.mp4", "Source timelapse"))
        previous_record = out / folder / "RECORD.md"
        if previous_record.exists():
            previous_media = re.search(r"^## Media\n(.*?)(?=^## |\Z)", previous_record.read_text(), re.M | re.S)
            if previous_media:
                for line in previous_media[1].splitlines():
                    entry = re.fullmatch(r"- \[[^\]]+\]\(([^)]+)\): .*SHA-256 `([a-f0-9]{64})`", line)
                    if entry and not any(entry[2] in current for current in local_media):
                        target = media_files.by_hash.get(entry[2])
                        if target is None or (out / folder / entry[1]).resolve() != target.resolve():
                            raise ValueError("Recorded media checksum is missing: " + pid)
                        local_media.append(line)
        media.append("Page: %s/p/%s.html" % (SITE_URL, pid))
        if p["studio"] in sessions:
            media.append("Studio viewer: %s/studio/?p=%s" % (SITE_URL, p["studio"]))
        facts = [("Painting", "\x60%s\x60" % pid), ("Round", m["round"]), ("Date", m.get("date")), ("After", m.get("after")),
                 ("Kind", m.get("kind")), ("Painter", m["painter_model"]), ("Provider", m.get("painter_provider")),
                 ("Thinking", m.get("thinking")), ("Harness", m.get("harness")), ("Studio", "\x60%s\x60" % studio),
                 ("Sittings", m.get("sittings")), ("Session minutes", m.get("session_minutes")),
                 ("Cost (USD)", m.get("cost")), ("Subject", m.get("subject"))]
        words_ = m.get("painter_words")
        if words_:
            words_ = "%s\n\n(%s)" % (words_, m.get("painter_words_who") or "the painter")
        record_md(out, folder, m.get("title"), [(k, scrub_text("" if v is None else str(v), folder)) for k, v in facts], links,
                  scrub_text(words_ or "", folder), [("On stillwet.art", ["- " + x for x in media]), ("Media", local_media)])
        index.append((pid, m.get("title"), m["round"], m["painter_model"], folder))

    studio_index = []
    if not a.only:
        lane_studios = set()
        for f in (out / "runs" / "gallery-fcf9c110").glob("r*/run/studios.json"):
            try:
                mapping = json.loads(f.read_text())
            except ValueError:
                continue
            if isinstance(mapping, dict):
                lane_studios |= {v for v in mapping.values() if isinstance(v, str) and v.startswith("paint-studio-")}
        catalog = json.loads((COLLECTION / "catalog.json").read_text())
        lane_studios |= {s["id"] for s in catalog["studios"] if s["id"].startswith("paint-studio-")}
        for studio in sorted((set(sessions) | lane_studios) - painting_studios):
            s = sessions.get(studio, {})
            folder = "studios/" + studio
            if not s and not studio_dirs(studio, a.runs_data):
                continue
            stealth = studio in stealth_studios
            ev_path = STUDIO_DATA / studio / "events.json"
            links = []
            if ev_path.exists() and not stealth:
                copy(out, folder + "/events.json", ev_path)
                links.append("[events.json](events.json): the studio viewer's log")
            elif ev_path.exists():
                L.exclude(str(ev_path), "studio viewer log of an OpenRouter Stealth model (space-bunny-free); stillwet.art still serves it")
            events = json.loads(ev_path.read_text())["events"] if ev_path.exists() else []
            reply = last_reply(events)
            if reply:
                write(out, folder + "/reply.md", "# The painter's last reply\n\n" + reply.strip() + "\n", str(ev_path))
                links.append("[reply.md](reply.md): the painter's last message")
            put_studio(out, folder, studio, a.runs_data)
            for name, what in (("brief.md", "the brief"), ("journal.md", "the painter's journal"), ("lua/", "the Lua"), ("studio/", "the studio's other notes")):
                if (out / folder / name.rstrip("/")).exists():
                    links.append("[%s](%s): %s" % (name, name, what))
            lanes = put_runner(out, folder, studio, stealth)
            for name in ("sittings.json", "outcome.json"):
                if (out / folder / name).exists():
                    links.append("[%s](%s): the runner's %s record" % (name, name, name.split(".")[0]))
            links += runner_links(lanes)
            if not links:
                L.exclude(studio, "no text records found for this lane studio")
                continue
            outcome = s.get("outcome") or {}
            facts = [("Studio", "\x60%s\x60" % studio), ("Round", s.get("round")), ("Lane", s.get("lane")),
                     ("Painter", s.get("model")), ("Thinking", s.get("thinking")), ("Sittings", s.get("sittings")),
                     ("Outcome", ("%s: %s" % (outcome.get("status"), outcome.get("reason"))) if outcome else None),
                     ("On stillwet.art", "%s/studio/?p=%s" % (SITE_URL, studio) if s else None)]
            record_md(out, folder, s.get("title") or studio, [(k, scrub_text("" if v is None else str(v), folder)) for k, v in facts],
                      links, None, [("Note", ["A lane studio with no painting in the stillwet.art gallery."])])
            studio_index.append((studio, s.get("title"), s.get("round"), s.get("model"), folder))

    for sha, f in sorted(used_docs.items()):
        copy(out, "docs/" + f.name, f)

    if not a.only:
        write(out, "manifest.json", json.dumps(manifest, ensure_ascii=False), str(DATA / "manifest.json"))
        copy(out, "rounds.md", DATA / "rounds.md")
        lines = ["# Index", "", "Every painting on [stillwet.art](%s), one folder each, in the gallery's order." % SITE_URL, "",
                 "| Painting | Title | Round | Painter |", "|---|---|---|---|"]
        lines += ["| [%s](%s/RECORD.md) | %s | %s | %s |" % (i, f, (t or "(untitled)").replace("|", "\\|"), r, mo) for i, t, r, mo, f in index]
        lines += ["", "## Lane studios with no gallery painting", "", "| Studio | Title | Round | Painter |", "|---|---|---|---|"]
        lines += ["| [%s](%s/RECORD.md) | %s | %s | %s |" % (i, f, (t or "").replace("|", "\\|"), r or "", mo or "") for i, t, r, mo, f in studio_index]
        rounds = sorted((d.name for d in (out / "runs" / "gallery-fcf9c110").iterdir() if d.is_dir() and re.fullmatch(r"r[\d.]+[a-z-]*", d.name)),
                        key=lambda r: (float(re.match(r"r([\d.]+)", r).group(1).rstrip(".")), r))
        lines += ["", "## Runner records", "",
                  "The run tree's text records keep their relative paths under [runs/](runs/), so the provenance paths in "
                  "[manifest.json](manifest.json) resolve. Round captions are in [rounds.md](rounds.md).", ""]
        lines += ["- [%s](runs/gallery-fcf9c110/%s/)" % (r, r) for r in rounds]
        lines += ["- Other runs: " + ", ".join("[%s](runs/%s/)" % (d.name, d.name) for d in sorted((out / "runs").iterdir()) if d.is_dir() and d.name != "gallery-fcf9c110")]
        write(out, "INDEX.md", "\n".join(lines) + "\n", "generated")

    ledger = {"paintings": len(index), "studios": len(studio_index), "files": len(L.written),
              "quotes": L.quotes, "duplicates": L.duplicates,
              "redactions": dict(L.redactions), "redacted_files": {k: sorted(v) for k, v in L.redacted_files.items()},
              "excluded": L.excluded}
    if a.ledger:
        a.ledger.write_text(json.dumps(ledger, indent=1, ensure_ascii=False))
    print(json.dumps({k: v for k, v in ledger.items() if k not in ("redacted_files", "excluded", "quotes", "duplicates")}, indent=1))
    print("excluded:", collections.Counter(e["reason"] for e in L.excluded).most_common())


if __name__ == "__main__":
    main()
