# Review E: round 21 runner stack (feat/r21-runner-import … feat/r21-records-7-docs)

Read-only. Worktrees: `review-e/wt` (tip a494c60), `wt-feat-r21-runner-import`, `wt-fix-r21-N14-probe`, `wt-t` (walked through every branch), `mut/` (mutation copy). Scratch scripts and outputs are in `review-e/`.
Line numbers are at the tip and relative to `notes/round21/runner/` unless a branch is named.

## Answers

- **Safe to run single-painter lanes: y**
- **Safe to run free-text chain lanes: n** as the branches stand. It becomes y once H1 and H2 are fixed (or H1 is handled by hand) and a live reader smoke test passes (H3).
- **Safe to run structured chain lanes: n.** It has the same H1–H3 blockers, plus M1 and M2. Mechanically, it works end to end.

## Verdicts

| branch | verdict | why |
|---|---|---|
| feat/r21-runner-import | ship | all 6 files `cmp`-identical to `[local path redacted] the pin fixture is identical too |
| fix/r21-N14-probe | ship with nits | right on every real limit, auth and credit error; 1 transient read as fatal, 4 fatal read as transient (L1, L2) |
| fix/r21-N11-reader-scope | needs changes (small) before any chain | the scope is correct end to end; the reader now needs 3 files beside the runner and nothing checks for them (H1) |
| fix/r21-N12-record-flags | ship with nits | flags work in the live launch; a curly `’` hides `Don’t` from them too (M2) |
| feat/r21-records-1-schema | needs changes for structured chains | Latin-script homoglyphs and diacritics pass (M1); `’` is allowed but the patterns only spell `'` (M2) |
| feat/r21-records-2-evidence | ship | review-c findings 6 and 7 fixed and re-probed |
| feat/r21-records-3-words | ship with nits | 0 false drops on 714 real sentences; "Please …" and "1) …" commands pass (L4) |
| feat/r21-records-4-render | ship | the whole-bullet check and the support enum are verified |
| feat/r21-records-5-reader | ship | the `.json` guard works in the live launch |
| feat/r21-records-6-runner | ship with nits | runs end to end; an uncaught `code_commit()` error kills the lane thread (L3) |
| feat/r21-records-7-docs | ship with nits | CHANGES.md:60 lists the files a structured copy needs, not the reader files every chain needs (H1) |

## How chains were tested (offline, no API calls)

`sim/sim_chain.py` imports the runner from a **copied** runner folder (`sim/deploy/`: every non-test file) and runs the real `chain()` for a two-painter lane. Painting, export, check and finish are stubbed. It uses round 19 SONF's real `p1_sittings.json`, which points at 3 real session logs, and SONF's real journal, all read-only. The reader runs as the runner builds it: `reader_cmd` with `READER_HARNESS` unchanged, `READER_SCOPE` from `chain()`, pi 0.99.1, pi-black and `reader.ts`. `READER` is swapped for a fake provider (`sim/fakeprov.ts`) backed by a scripted local server (`sim/fakeserver.py`), which issues the tool calls and records the tool results.

- **Free text** (`sim/ft/`):
  - Allowed: reads of the brief, logs 1 and 3 (one spelled with `[local path redacted] and the journal, then the write of `p1_record.md` (relative path).
  - Refused: `[local path redacted] `run/SIM/../../studios/st-SIM1/BRIEF.md`, the studio's `studio_notes.md`, `p1_sittings.json`, writing `p1_record.flags.md` and writing studio 2's notes.
  - The system prompt the model received is exactly `reader_system_prompt.md` plus `<cwd>`, and the only tools are `read,write`.
  - `RECORD FLAGGED` was logged, and `p1_record.flags.md` was written.
  - Studio 2's `studio_notes.md` is the round's notes plus `## More notes from the studio` and the record.
- **Structured** (`sim/st/`, real call ids from SONF log 1, the real studio's guide and `painting.lua`):
  - `reader.ts` refused a non-JSON write ("not JSON: … write p1_observations.json again as JSON") and accepted the rewrite.
  - Dropped: a bad call id, `Clip every…` and a `→`.
  - The record is stamped `round: 21`, with support `linen [18, 15], ground_layers [knife, brush]` from the real canvas call.
  - `condition.json` and `p2_inherited.json` were written, and studio 2 got the rendered notes.
  - Four smuggled commands reached studio 2 (M1, M2, L4).
- **Mutation** (`mutate_e.py`, on a copy of the repo; baseline 199 passed):
  - Killed: dropping the journal or the brief from the scope, no `READER_SCOPE`, no `reader.ts`, `--tools read,write,bash`, a structured scope with only the first log, `TRANSIENT` ignored and no NFKC. That is 8 of 8.
- **Not tested:** a live reader call to `anthropic/claude-opus-5-5` (see H3).

## Findings, by severity

### H1. High (chains): the reader's files must sit beside `r21_chains.py`, and nothing checks for them (N11, -7-docs)

- `READER_HARNESS` loads `HERE / "reader.ts"` (which imports `./reader-scope.ts`) and `HERE / "reader_system_prompt.md"` (r21_chains.py:208-210).
- The deployed folder `[local path redacted] has only the 6 imported files.
- I copied those 6 files plus the tip's `r21_chains.py` (`sim/deploy-min/`) and ran the chain:
  - `--dry` exits 0 and shows nothing wrong.
  - The reader fails at launch: `Error: Failed to load extension ".../reader.ts": Extension path does not exist` (`sim/ftmin/run/SIM/p1_reader_err.txt`).
  - The log reads `SIM1: record MISSING (the reader exited 1, …)`, then `SIM2: exporting…`: painter 2 goes on with no record (H2).
- Every reader in every chain would fail this way.
- CHANGES.md:60-61 names only the structured files (`record_schema.py`, `record_render.py`, `reader_brief_structured.md`).
- **Fix:**
  - At startup (`main`, r21_chains.py:1191 ff.), for any lane with `painters > 1` and `record_kind != "none"`, check that `reader.ts`, `reader-scope.ts`, `reader_system_prompt.md` and `BLACK` exist. For structured lanes, also check the three structured files and `code_commit()`. Refuse to start if any is missing.
  - Document the full copy set in CHANGES.md.

### H2. High (free-text chains, as imported): a missing record doesn't stop the lane

- r21_chains.py:985-988 logs `record MISSING` and then writes `p<n>.done`, so the next painter paints with plain notes. The lane is still a chain lane in name, but painter 2 inherited nothing.
- The earlier `p<n>_record.md` isn't removed before the reader runs (r21_chains.py:966-977). On a rerun, a reader that fails leaves the old record in place, and the log says "record written".
- The structured path already does both right: it unlinks first (`read_structured`, `out.unlink`/`rec.unlink`), and on reject it doesn't mark the painter done ("the painter isn't done, rerun to read it again").
- The report lists this as open point 3. Round 19 fixed it in 21dce0d.
- **Fix:** mirror the structured path. Unlink `out` before the run. On `rc != 0` or no `out`, log `RECORD MISSING … chain stops` and `return` without writing `p<n>.done`.

### H3. High (operational, chains): the Opus reader was refused by Anthropic in round 19, and nothing here changes that

- `[local path redacted] "This request was blocked as it seems to violate Anthropic's Terms of Service restrictions on reverse engineering or duplicating model outputs."
- The imported runner's own comment above `DSF` (r21_chains.py:217-218) says: "No chains (the reader was blocked on 2026-09-29)."
- `READER` is still `anthropic / claude-opus-5-5` (r21_chains.py:206). N11 changes the launch (a clean system prompt and 2 tools), not what is sent: the painter's logs.
- My sims prove the launch and the scope, not that the provider will answer.
- With H2 unfixed, a refused reader silently turns a chain into single painters.
- **Before a chain lane:** run one reader by hand on a finished r21 single painter's logs, with the exact `reader_cmd` and `READER_SCOPE`. Alternatively, make `READER` switchable to a non-Anthropic model.

### M1. Medium (structured): Latin-script homoglyphs and diacritics get past the words and names checks (-1-schema)

`odd_chars` admits any letter whose Unicode name starts with `LATIN ` (record_schema.py:79). NFKC doesn't fold these. Probe `probe_latin.py`:

- These PASS with no drop and no warning, and I confirmed the first two in studio 2's rendered notes (`sim/st/studios/st-SIM2/notes/studio_notes.md`):
  - `Çlip every blend…`
  - `The earlier pɑinter…` (U+0251)
  - `ᴄlip every…` (U+1D04)
  - `Clïp every…`
  - `Néver let a blend…`
  - `Alwaẏs keep…`
  - `Usᴇ clip…`
- Their ASCII twins all drop.
- Review-c's Cyrillic, zero-width, bidi and line-separator cases are all fixed.
- **Fix:** run the word and name checks on a folded copy (NFKD, drop combining marks) and allow only ASCII letters plus Latin-1 letters. Or refuse non-ASCII letters: across 714 real record sentences, the only non-ASCII letter is one `μ` (`probe_corpus_e.py`).

### M2. Medium (structured; also free-text flags): a curly apostrophe hides every contraction pattern (-1-schema, -3-words, N12)

- `’` is in `TEXT_EXTRA` (record_schema.py:64), and NFKC keeps it.
- The patterns spell only ASCII: `don'?t` (record_schema.py:379), `'ll want` and `it's best` (:397-398), and `don't` in N12's `PRESCRIPTION`.
- `Don’t leave any blend unclipped near other shapes, it lumps up.` passes with no warning and reached studio 2's notes. `You’ll want to clip every blend…` and `Do n’t glaze` pass too.
- The 714 real sentences hold 0 curly apostrophes, so this is a gap against a reader that writes typographic quotes, not a false-drop risk.
- **Fix:** map `‘’` to `'` (and `“”` to `"`) in `plain()` before the checks.

### L1. Low (N14): a transient OpenCode error is read as fatal

- The error is `400: {"type":"server_error","message":"Error from provider (Console): Upstream request failed: Model is unavailable."}`. It is real, from OpenCode Zen (`oc-sdk-zen`, deepseek-v4-flash-free, `[local path redacted]
- `probe_outcome` returns `fatal: the request was malformed` (rule at r21_chains.py:422), so the painter stops.
- It is reachable only inside `wait_out_limit`, after a Go or Free usage limit. That makes it unlikely for r21's DSF (Zen) lanes.
- **Fix:** add `server_error|is unavailable` to `TRANSIENT` (r21_chains.py:426).

### L2. Low (N14): four real errors that waiting won't fix are probed for up to 24 h

Classification of all 576 distinct real `errorMessage`s: `classify.py`, `errors.txt`. These come out `unavailable` and are probed every 30 min until `LIMIT_GIVE_UP_H`. Before N14, the next sitting would crash and reach `MAX_CRASHES` sooner.

- `opencode API error (403): {"type":"FreeTierError",…}`: `STATUS` (r21_chains.py:412) doesn't match `error (403)`.
- `Provided authentication token is expired.`
- `Codex error: The 'gpt-5.4' model is not supported when using Codex with a ChatGPT account.`
- Anthropic `429 … "error_code":"credits_required" … "out_of_credits"`: the 429 makes it transient.

Everything else is right:

- Go usage limits come out `limited`.
- 429 rate limits, 5xx, overloaded, timeouts and fetch or connection errors come out `unavailable`.
- Fatal as it should be:
  - Missing or absent API keys, in 5 formats.
  - Google 402 "prepayment credits are depleted".
  - OpenAI "no credits remaining".
  - Anthropic `not_found_error` for a model.
  - `reasoning_effort is not allowed`.
- Google's 429 "check your plan and billing" is correctly transient.
- `pi --print` exits 1 and prints `401: {…}` on stderr (checked against the fake server), which is the shape `probe_outcome` parses.

### L3. Low (-6-runner): a `code_commit()` failure after the reader runs kills the lane thread

`code_commit()` raises `RuntimeError` (r21_chains.py:1003). It is called with no handler at :1130 (after the reader has run) and :1153. The thread dies with a traceback and no "chain stops" log. The export already needs the tag, so this can only happen if the tag changes mid-run. **Fix:** fold it into the H1 preflight.

### L4. Low (-3-words): commands that follow "Please" or a list number

- `Please clip every blend that sits near anything else in the work.` and `1) clip every blend near anything else, 2) glaze only when dry.` pass.
- `_LEAD` (record_schema.py:376) has no `please` and no `\d+\)`.
- `You'd better clip…` passes too (paraphrase).

### Nits

- `→` is refused, which would drop 1 of the 714 real sentences. `µm` becomes Greek `μ` and is refused (report open point 6).
- `condition.json` is rewritten on every start (r21_chains.py:893), carried over from review-c.
- Pre-existing:
  - `studio()` hashes with the prefix `"r19"` (r21_chains.py:253).
  - A continued sitting lists its session file twice in `logs`, so the reader brief names it twice. This is harmless.

## Review C's findings, at this stack

| # | status | receipt |
|---|---|---|
| 1 (round 19 runtime changed) | fixed: round 19 untouched | `git diff --stat main feat/r21-records-7-docs -- notes/round19 notes/round17 notes/round16` is empty; all changes are under `notes/round21/` |
| 2 (easel-verb imperatives) | fixed | `review-c/probe/smuggle.py`: "imperative clip" and "imperative mix" DROP |
| 3 (unicode) | fixed for zero-width, bidi, U+2028/0085/VT/FF, Cyrillic, fullwidth `#`, ellipsis and semicolon; **Latin homoglyphs remain (M1)** | `smuggle.py`, `sep.py`, `probe_latin.py` |
| 4 (split across fields) | fixed | `split.py`: every case is a rendered drop, including the `then` cause |
| 5 (support line) | fixed | `f5/`: a commented `canvas{}`, `apply="Claude"` and a trailing `-- apply="brush"` are ignored; `linen=15` gives [15, 15]; the result is `['knife', 'roller']` |
| 6 (loose evidence) | fixed | a `read` whose result says `ok · chunk` isn't an operation; an `ls` naming a `.png` isn't an image (`f6/`) |
| 7 (duplicate ids) | fixed | "log 1 has more than one tool call c3 (ambiguous)" |
| 8 (path in fixture) | fixed | 0 `tmp` hits in `fixtures/r16_r17_record_sentences.json` |
| 9 (test gaps) | fixed per the report; my 8 mutants were all killed | `mutate_e.py` |
| 10 (stamped round 19) | fixed | the sim's record has `round: 21, code.tag: round-21` |

## Checked and clean

- **Import:** `cmp` shows all 6 files identical to `[local path redacted] and `fixtures/r21_chains_as_imported.py` is identical to the source runner.
- **Tests** on every branch match the report: 26 / 30 / 35 / 85 / 105 / 155 / 181 / 181 / 202 / 203 pytest; node 4 (N11 through -4), then 5.
- **Single-painter lanes:**
  - Masked `--dry` output (all 5 lanes) is md5 `e0d742c7…` on the import, N14, N11, N12, -6 and -7.
  - `--briefs` output is identical between import and tip.
  - Neither creates `run/`.
  - The code diff from the import to the tip touches only `wait_out_limit` (N14), `lane()` (a new default key), the reader block and the structured branches (not taken when `painters == 1`), `condition.json` (structured chains only) and the startup `mixed_records` check. For a free-text lane, `mixed_records` refuses only `p*_record.json` or `p*_observations*.json`, and none exist.
- **Free-text notes composition:** unchanged for single painters, where `range(1, 1)` is empty, and pinned by the test.
- **Runtime:**
  - The runner declares `requires-python >=3.11` and uses only the standard library; it parses under 3.10 and the tests pass on the local 3.13 and 3.14.
  - `record_*` are imported lazily, so a free-text copy without them runs.
  - pi 0.99.1 loads `reader.ts` and pi-black from a folder outside the repo.
  - `--no-approve` is accepted.
- **Real record sentences:** 714 sentences from the 11 released r16 and r17 records give 12 drops, all genuine commands (`probe_corpus_e.py`).
- **Operator precondition, not a bug:** `BASE` (`[local path redacted] doesn't exist yet, and this repo has no `round-21` tag (`git tag` shows round-16, round-19, round-20). The export and `code_commit()` both need them.
