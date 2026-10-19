# Runner and script findings (#16–#21): verification

Repo: `[local path redacted] at `08f632434fd03bf7e85129539f7e184a91db9056` (`git rev-parse HEAD`). The repo was not edited: `git status --porcelain | wc -l` → `0` after all probes. Probes and outputs are in `[local path redacted] No painter, reader or provider was launched: #18 patched `subprocess.run`, and #16 and #21 ran only the local easel binary and the exporter's cargo build in a scratch clone.

Baseline: the round 19 runner tests pass in a uv venv (`.venv/bin/python -m pytest -q test_r19_chains.py` → `16 passed in 0.14s`).

---

## #16 Valid brush aliases can end a painting prematurely: CONFIRMED (severity: P3 rather than P2)

**Code**
- `notes/round19/runner/painting_chunks.py:53` detects a method only when it is called directly: `re.search(rf"[.:]\s*(?:{alt})\s*[({{\"]", code)`. So `local s = b.stroke` (no call) doesn't match.
- `painting_chunks.py:70-79`: aliases are only collected inside `if paints:` (`# aliases: `dab = work`, `local s = b.stroke``). So the alias the comment names is only learned in a chunk that has already been judged to paint.
- `painting_chunks.py:25-31,42`: string literals are replaced with `""` before matching, so `b["stroke"](b, …)` becomes `b[""](b, …)` and can never match.
- Consequence path: `r19_chains.py:286-287`: `if done and not added_painting(done[-1]): return (None, "the painter is done: …")`, where `added_painting` compares `painting_after > painting_before` (`r19_chains.py:260-264`), which comes from `count_painting` (`:254-257`).

**Probe** (`probe16.py`, `alias.lua`)
```
method alias across chunks: [(1, True), (2, False), (3, False)]
bracket-indexed method: [(1, True), (2, False)]
bracket via variable: [(1, True), (2, False)]
```
I ran the same log through the real easel (`target/debug/easel run alias.lua`). It completed 3 chunks, and the rendered PNGs differ after chunk 2 and after chunk 3 (`base!=two (chunk 2 marked)`, `two!=alias (chunk 3 marked)`). A rerun was byte-identical (`two deterministic`), so the difference comes from real marks and not from nondeterminism. The classifier still says `[(1, True), (2, False), (3, False)]`. These calls are valid because brush methods are mlua userdata methods (`crates/easel/src/api.rs:379 m.add_method("stroke", …)`, `:411 m.add_method("touch", …)`).

**Severity:** the mechanism is real, but it only triggers when *every* painting chunk in a sitting uses such syntax. None of the 38 existing `[local path redacted] logs contain `["stroke"]`-style indexing or `x = y.stroke`-style method aliases (the grep returned no files). The painter-facing guide teaches `b:stroke(...)` (`notes/easel_guide.md:119`). The effect is an early stop, not data loss. I'd rate it P3; the review's P2 is defensible only on consequence.

**Fix sketch (~10 lines + 2 tests):** (a) At `:53`, drop the call-suffix requirement, so any `[.:]method\b` reference counts. That matches the module's documented bias toward "paints" (`:13-14` "a chunk … that mentions a verb it doesn't call" counts). (b) Before stripping, also match `\[\s*(["'])(stroke|touch|…)\1\s*\]`. (c) Collect `x = y.method` aliases in every chunk, not only when `paints`. Dynamic `b[m]` can't be handled by regex. The robust alternative is to have the easel report per-chunk mark counts and use those. **Test:** add the three fixture logs above to `test_r19_chains.py` and assert chunks 2 and 3 are painting.

---

## #17 The four-sitting cap contradicts the current handoff: PARTIALLY CONFIRMED (the handoff is stale, not the code; P3 documentation drift)

**What HANDOFF says** (`notes/HANDOFF.md:4-7`): "**Runner rules (9dd39d6):** no 4-sitting cap: the painter stops after a sitting it ends itself without adding paint; 20 completed sittings is only a safety cap (logged NOT FINISHED). Crashes and usage limits count for nothing."

**What the code does**
- `r19_chains.py:97-99`: "A painter works in up to MAX_SITTINGS sittings (completed ones, and crashed ones that painted)…" and `MAX_SITTINGS = 4`.
- `r19_chains.py:288-291`: crashed sittings that painted are counted, and the stop message is `f"stopped after {max_sittings} sittings (MAX_SITTINGS)"`, which has no NOT FINISHED.
- Test `test_r19_chains.py:80-84` `test_a_painter_that_keeps_painting_stops_after_four_sittings`; `:93` "s1 painted: it counts (three of four)".

**Git history settles the direction.**
```
9dd39d6 2026-09-28 13:34  round 19 runner: the painter decides when it's done …; 20 sittings is only a safety cap, logged as NOT FINISHED; crashes and usage limits count for nothing
3dff3fb 2026-09-28 13:55  HANDOFF: sitting rules, compaction test, viewers on launchd      <- last HANDOFF commit
a6b5f38 2026-09-28 19:44  round 19 runner: the 4-sitting cap is back as the default (completed sittings and crashed ones that painted count); usage limits still count for nothing …
```
`git show a6b5f38` changes `-MAX_SITTINGS = 20` to `+MAX_SITTINGS = 4` and replaces `"NOT FINISHED: the safety cap of …"` with `"stopped after {max_sittings} sittings (MAX_SITTINGS)"`. HANDOFF is not describing a planned change. It describes 9dd39d6, and the author deliberately reverted that about 6 hours later without updating HANDOFF. The missing NOT FINISHED is intended, because a 4-sitting stop is again a normal end.

**A real inconsistency the review didn't name:** the runner's own module docstring still describes the reverted policy: `r19_chains.py:23-26` "MAX_SITTINGS completed sittings is only a safety cap (logged as NOT FINISHED). A sitting that crashes … is no judgment and counts for nothing". The `--dry` text also still says "(safety cap {MAX_SITTINGS}; …)" (`:764`). Both contradict `:97-99` and `:288-291` in the same file. The scratch copy agrees with the tracked one (`[local path redacted] MAX_SITTINGS = 4`).

**Severity:** P3 (documentation and comment drift). The review's repair ("reconcile … distinguish a forced stop") points the wrong way if taken from HANDOFF, because it would undo a later, deliberate change.

**Fix sketch (text only, ~8 lines):** add a HANDOFF entry for a6b5f38 (4-sitting cap restored, crashed-that-painted counts), and fix the docstring at `r19_chains.py:21-27` and the dry text at `:764`. No code change or new test; the existing tests at `:80-94` already pin the intended policy.

---

## #18 Failed provider probes are accepted as recovery: CONFIRMED (severity: P3)

**Code:** `r19_chains.py:378-386`
```python
r = subprocess.run(probe_cmd(m), …, capture_output=True, text=True, timeout=600)
out = r.stdout + r.stderr
except subprocess.TimeoutExpired:
    out = "probe timed out"
if not usage_limit(out):
    log(f"{tag}: the provider answers again …")
    return True
```
`r.returncode` is never read, and `usage_limit` (`:342-346`) only looks for `GoUsageLimitError|FreeUsageLimitError|usage limit (exceeded|reached)`.

**Probe** (`probe18.py`; `subprocess.run` and `time.sleep` monkeypatched, so pi never ran):
```
timeout -> wait_out_limit returned True
auth    -> wait_out_limit returned True   (401 authentication_error, rc=1)
balance -> wait_out_limit returned True   (402 credits are depleted, rc=1)
network -> wait_out_limit returned True   (ENOTFOUND, rc=1)
```
Each run logged "the provider answers again after 0.0 h".

**Severity:** P3. After a false recovery the next sitting runs (`r19_chains.py:504`). If the quota is still active, it ends as `limited` again (`:513`) and costs nothing. Otherwise it is a crash that uses one of `MAX_CRASHES = 6` (`:100`, `:525-532`) and ends `NOT FINISHED`, which a rerun can resume. The cost is time, a misleading log line and crash slots, not paint or data.

**Fix sketch (~6 lines):** in the `try` block, accept recovery only when `r.returncode == 0` and stdout contains `ok`. Treat a timeout as "not answered" and keep waiting. Log a non-limit failure's `gist(out)` as a separate category. **Test:** move the probe outcome into a pure function `probe_answered(rc, out, timed_out)` and table-test it with the four cases above plus `(0, "ok")`.

---

## #19 Reader records enter trusted notes without adequate boundaries: CONFIRMED (severity: P2 is fair)

**Code**
- Reader launch: `r19_chains.py:539-541`, `["pi", "--print", "--no-context-files", "--no-skills", "--no-prompt-templates"] + READER + [prompt]`. It has no `--no-extensions`, no `--system-prompt`, no `--tools` and no `--no-approve`, unlike the painter's `HARNESS` (`:90-92`). The docstring says so: "Round 16's reader launch: the machine's own pi setup".
- On this machine that setup is `[local path redacted] packages (`pi-herdr-subagents`, `pi-web-search`, `pi-black`, …) plus `[local path redacted] `--no-context-files` only "Disables `AGENTS.md` and `CLAUDE.md` discovery" (pi `docs/cli.md:212-213`), while APPEND_SYSTEM.md "Adds instructions to Pi's system prompt" (`docs/configuration.md:20`). The reader therefore gets extra system text and subagent and web tools. (The runs were on this machine per HANDOFF line 1, but settings could have differed at run time.)
- The reader reads everything: `reader_brief.md:8` "Read every log in that order, each from the first line to the last".
- Verbatim admission: `r19_chains.py:781-786` appends `"\n## More notes from the studio\n\n" + rec.read_text()` to the next painter's `notes/studio_notes.md`, with no check. The exclusions exist only as prose (`reader_brief.md:18-27`).
- Failure isn't fatal: `:806-809` ignores `run(...)`'s return code, logs `record {'written' if out.exists() else 'MISSING'}` and then writes `p{n}.done` anyway. The next painter then silently gets no record (`:784 if rec.exists()`).

**This has happened:** `notes/HANDOFF.md:139-140` records that "the B2 reader was blocked by a content filter …, so B3 had only B1's notes". The scratch runner notes the same on 2026-09-29 ("the reader was blocked on 2026-09-29: fresh").

**No contamination found in the records that exist:** grepping `r17/run/{F,O}/p1_record.md` and `r16/run/{A,C}/p1_record.md` for subject words (sky, tree, water, horizon, jug, snow, foreground, …) returned no hits. This agrees with the review's "No particular contaminated output was established."

**Fix sketch (~15 lines):** launch the reader like the painter: `--no-extensions`, plus an explicit `-e BLACK` (it currently gets pi-black from the global packages), a fixed `--system-prompt`, `--tools read,write` and `--no-approve`. Fail closed: when rc≠0 or the record is missing, don't write `.done` and stop the lane. Add a lint that rejects records over 60 lines or containing a subject or process word list, and hold the record for human review before it is merged. **Test:** unit-test the admission gate (missing record → no `.done`; a record with a banned term is rejected), and snapshot `reader_cmd()` for the isolation flags.

---

## #20 The integrity check lacks the original live painting: CONFIRMED (severity: P2 is fair)

**Code**
- `scripts/check_painting:12-18`: step 1 replays the copied log, step 2 runs `easel check`, "a second replay in a fresh session, compared bit for bit with the first", and step 3 compares with the painter's save "if there is one".
- `:23-25`: "The saved-PNG comparison is reported, not judged". `:89-93`: the exit code depends only on `$ok` from `E check`.
- Runner close: `r19_chains.py:417-422` runs only `bin/easel close`. The server's `close` only runs `self.save_log()` (`crates/easel/src/main.rs:706-708`). The painter tools are `paint, look, note, status, log` plus `read` (`harness/painter/easel-tools.ts:21-103`, `r19_chains.py:89`), with no save.
- The server does support `save <path>` (`main.rs:696-700`), so the runner could capture the canvas itself.

**Evidence from real runs:** every round 19 check in `[local path redacted] reads, for example, `SONF1: check: ok: 323 chunks replay to the same canvas; the painter saved no picture; …`. KIMIF1, MUSEF1, GEMB1, GEMF1, CTEST1, SELFH1 and NEWF1 read the same way, so each "ok" was replay against replay only. Given #5, #6 and #7 (failed chunks and finalizers can make the live canvas differ from its replay), this check cannot detect that failure.

**Fix sketch (~20 lines):** in `paint()` before `close_easel(d)`, run `bin/easel save <rd>/p<n>_live.png` while the last sitting's server is still up. Pass it to `check_painting` as an optional third argument, and make a mismatch exit 1 (`check: DIFFERS from the live canvas`). Without a baseline, label the result "replay-only agreement". If the server had been reopened by a replay after a crash (`open_easel`, `:425-436`), mark the baseline as not original. **Test:** a script test that runs `check_painting` with a deliberately different baseline PNG and expects exit 1.

---

## #21 Export code and notes can come from different commits: CONFIRMED (severity: P3 rather than P2)

**Code** (`scripts/export_r16_studio`): `:72` `sha=$(git -C "$repo" rev-parse --short "$branch")` sets the cache key and the reported commit. Every later read resolves the moving name again: `:102` `git archive … "$branch" -- … crates`, `:136` notes, `:137` notices, `:159` guide comparison (`git show "$branch:notes/easel_guide.md"`), `:178` catalog (`git show "$branch:crates/paint/src/palette.rs"`) and `:231` the report. The runner passes a branch name: `r19_chains.py:747 env = {"R16_BRANCH": BRANCH}`.

**Reproduction** (scratch `git clone --shared` in `runner/clone`, fresh `STUDIO_BUILDS`; `STUDIO_BUILD_HOOK=hook21.sh` advances `probe21-base` to a commit whose guide ends in `MOVED-BRANCH-MARKER`, after the source archive was extracted):
```
hook: probe21-base moved to 33d262b…
exported the blank studio from probe21-base (08f6324) to …/studio21
exit 0
builds21/: 08f6324  08f6324.lock
grep -c MOVED-BRANCH-MARKER studio21/notes/easel_guide.md → 1
```
The binary came from 08f6324, the guide came from 33d262b, the report names 08f6324 and every check passed. The guide check at `:159` compares against the same moved branch, so it can't catch this.

**Severity:** P3. It needs a commit to the base branch during the roughly one-minute export window (53 s cold here). Such commits are plausible, since the authors commit to base branches often, but the window is narrow. The damage is silent provenance mismatch, not corruption. The review's reasoning is correct.

**Fix sketch (~8 lines):** `sha=$(git -C "$repo" rev-parse --verify "$branch^{commit}")` (full hash). Use `$sha` for every `archive` and `show` and for the cache directory, report `$branch ($sha)`, and have the runner record the sha it exported. **Test:** a variant of `scripts/tests/export_concurrent.sh` whose `STUDIO_BUILD_HOOK` advances the branch, then asserts that the studio's guide equals `git show <old sha>:notes/easel_guide.md`.

---

## Prompt exposure table: the Friedrich tree note and reader records

- **The tree note is added after export: CONFIRMED.** `r19_chains.py:787-788` runs `if t["profile"] == "friedrich": shutil.copy(HERE / "trees.md", d / "notes" / "research" / "trees.md")` after the export at `:776`. The exporter's note list doesn't include it (`export_r16_studio:134-135`; `grep -n trees scripts/export_r16_studio` returns no hits).
- **Its citations and source list stay intact: CONFIRMED.** Source stripping only runs inside the exporter (`export_r16_studio:141-143`), before the copy. `notes/round19/runner/trees.md:87` `## Sources`, with URLs at `:89-103`, and inline keys such as `[ROL17]` and `[ATF; HTC; WT]` (`:10-11`).
- **The lane is told to read it: CONFIRMED.** `r19_chains.py:113` `"notes/research/trees.md (how trees are built) and\n"` goes into `READING["friedrich"]` and then into the brief via `{READING}` (`brief_template.md:28`, rendered at `briefs/friedrich.md:34`).
- **It emphasizes damaged and mature trees: CONFIRMED.** `trees.md:11` "Old trees shrink downward … 'stag-headed,' with dead limbs standing above the living foliage, and usually hollow", plus `:10` (dieback stages), `:31` (dead branches and stubs) and `:42` ("Old and damaged oaks"). The review treats this as a possible prior, not a proven effect, and that framing is right.
- **Reader records are the strongest indirect route, with no gate: CONFIRMED;** see #19 (`r19_chains.py:781-786`, `reader_brief.md:18-27`).

---

## Summary

| # | Verdict | Review severity | My severity | Fix size | Key receipt |
|---|---|---|---|---|---|
| 16 | CONFIRMED | P2 | P3 (0 of 38 real logs use the syntax) | ~10 lines + 2 tests | `painting_chunks.py:53,70-79`; easel renders marks, classifier says `[(1,True),(2,False),(3,False)]` |
| 17 | PARTIALLY CONFIRMED: HANDOFF is stale; code is the later deliberate policy (a6b5f38, 19:44 > HANDOFF 13:55) | P2 | P3 (docs); the runner's own docstring `:23-26` and dry text `:764` also contradict the code | text only | `r19_chains.py:99 MAX_SITTINGS = 4`; `git show a6b5f38` |
| 18 | CONFIRMED | P2 | P3 (costs time and crash slots, resumable) | ~6 lines + table test | `r19_chains.py:379-386`; probe: timeout/401/402/ENOTFOUND all → `True` |
| 19 | CONFIRMED | P2 | P2 | ~15 lines + gate tests | `r19_chains.py:541,781-786,806-809`; the reader gets global packages + APPEND_SYSTEM.md |
| 20 | CONFIRMED | P2 | P2 | ~20 lines + script test | `check_painting:23-25,89-93`; `main.rs:706-708`; every r19 "check: ok" says "the painter saved no picture" |
| 21 | CONFIRMED (reproduced) | P2 | P3 (narrow window) | ~8 lines + hook test | `export_r16_studio:72 vs 102/136/159/178`; binary 08f6324 + guide 33d262b, exit 0 |
| Prompt table (trees.md, reader records) | CONFIRMED | n/a | n/a | n/a | `r19_chains.py:113,787-788`; `trees.md:87-103` |
