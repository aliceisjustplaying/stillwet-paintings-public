# Review C: structured chain records (feat/records-base … feat/records-7-docs)

Read-only. Worktrees: `review-c/wt` (tip e1260dd), `wt-main` (4ec3169), `wt-base` (4fa0839), `wt-mut` (mutation runs, restored). Probe scripts: `review-c/probe/`.
Tests at the tip: 170 pytest pass, 5 node pass.
Line numbers are at the tip unless a branch is named. Paths are relative to `notes/round19/runner/`.

## Verdicts

| branch | verdict | why |
|---|---|---|
| feat/records-base | ship with nits, **if** N11/N12/N14 may change round 19's runner (finding 1); otherwise needs changes | `--dry` identical, but the round 19 runtime changes |
| feat/records-1-schema | needs changes | "markdown-inert" is ASCII-only: zero-width, bidi and line-separator characters pass (finding 3) |
| feat/records-2-evidence | ship with nits | correct on real logs and fast; operation and image evidence are loosely typed (finding 6) |
| feat/records-3-words | needs changes | easel-verb imperatives pass (finding 2); checks are per field, not on the rendered text (finding 4) |
| feat/records-4-render | ship with nits | compatibility filter correct and listed; the schema exclusion is untested (finding 9) |
| feat/records-5-reader | ship | `.json` guard only; the `.md` path is unchanged |
| feat/records-6-runner | needs changes (small) | `support_of` renders painter-written Lua text unchecked (finding 5); records stamped round 19 (finding 10) |
| feat/records-7-docs | ship with nits | the label is written only for structured chains, as the report says |

## Findings, by severity

### 1. High (decision): feat/records-base changes the runtime behavior of round 19, which has already run

- Round 19 has run: `[local path redacted] ends "2026-09-29 21:32:02 all lanes finished". Its runner is main's: `cmp [local path redacted] notes/round19/runner/r19_chains.py` on main reports no difference.
- `--dry` is byte-identical for main, base and tip (all lanes) once studio names and timestamps are masked: md5 `4e9a96d8…` for both main and tip (`review-c/dry-*.m`). The next studio's free-text notes are built the same way (r19_chains.py:1187, pinned by `test_a_free_text_lane_s_next_studio_gets_exactly_round_19_s_notes`).
- `--dry` doesn't show the runtime changes. Base (the N11/N12/N14 merge) changes three things when a round 19 lane runs:
  - The reader runs under READER_SCOPE (r19_chains.py:739). It can no longer read anything but the logs, the journal and its brief, so round 19's reader could now write a different record.
  - `record_flags` writes `p<n>_record.flags.md` and logs `RECORD FLAGGED` (r19_chains.py:705, 743).
  - `probe_outcome` stops a painter on a "fatal" probe (r19_chains.py:432) where main kept probing.
- The records stack itself (branches 1–7) adds nothing to the free-text path except the startup `mixed_records` check (r19_chains.py:1240). That check refuses none of the 15 real `r19/run/*` folders.
- **Decision for [local account redacted]:** if "nothing may change past rounds" covers the round 19 runner file, the three fixes (and the structured feature, see 10) belong in a round-20 runner, and `notes/round19/runner` should stay at main.

### 2. High: clear commands that start with an easel verb pass (feat/records-3-words)

`_COMMANDS` (record_schema.py:309-311) leaves out the easel's verbs on purpose. `_THEN_COMMANDS` + `_OBJECT` (record_schema.py:314-318) is applied only after ", so" or ", then". These pass with no drop and no warning (`probe/smuggle.py`):

- "Clip every blend that sits near anything else in the painting."
- "Mix the darks with more medium so they spread over the ground evenly."
- Also not caught: "It helps to clip every blend…", "Next time clip every blend…", "I recommend clipping every blend…", "Blends near other shapes want clip on…" and German "Immer die Mischungen dünn halten…" (the last group is the paraphrase limit the design accepts).

Suggested fix: add `_LEAD + (_THEN_COMMANDS|stipple|scumble|hatch|mask|erase|cut|restate|lift|crop) \s+ _OBJECT \b` to PRESCRIPTION_DROP. On the 716 corpus sentences plus 380 studio_notes sentences it adds **0** drops, and it catches "Clip every…", "Mix the…", "Glaze the shadows…" and "Wait a day…" (`probe/probe_rule.py`).

### 3. High: unicode gets past the markdown-inert and word checks (feat/records-1-schema, -3-words)

`NOT_INERT` (record_schema.py:55) is an ASCII class. `_LEAD` (:306) and `TERMINATOR` (:57) need `\s` after the period. `PAINTER_WORDS` (:342) matches ASCII only. Results (`probe/smuggle.py`, `probe/sep.py`):

- `"…edges.\u200bAlways put an arch in the middle"`: a zero-width space demotes the clear "Always" from **drop** to warn-only. U+202E (bidi override) does the same. Both reach the rendered bullet.
- `"U\u200bse clip on every blend…"`, Cyrillic `"Usе clip…"`, `"pain\u200bter"` and Cyrillic `"Сlaude"` all PASS: the command, "another painter" and the model name are hidden.
- U+2028 and U+0085 are not refused and reach the rendered notes. `str.splitlines()` counts them as line breaks (a 2-line bullet becomes 3).
- `…` and `;` aren't terminators, so "…wet paint… Paint the sky first… Then the arch" is one "sentence".

Fix: NFKC-normalize, then refuse any character in Unicode categories Cc/Cf/Zl/Zp/Co/Cs (or allow only printable Latin plus `–·°×`). Count `…` and `;` as sentence breaks.

### 4. Medium: a command split across fields passes, because checks run per field but the renderer joins them (feat/records-3-words / -4-render)

`word_problems` checks `effect`, `cause` and `note` separately (record_schema.py:375-400). `when()` appends the note after ", " (record_render.py:88-89), and `bullet()` joins effect, cause and When (record_render.py:103-104). With note = `"so clip every blend near others"`, every field is clean. The rendered text reads "…When: blend, unclipped, so clip every blend near others.", which PRESCRIPTION_DROP catches only on the rendered bullet (`probe/split.py`). With cause = `"then clip every blend near others"`, neither check catches it.

Fix: also run `word_hits` on each rendered bullet (whitespace collapsed) and drop on a hit. Log it as a render-time drop in `p<n>_inherited.json`.

### 5. Medium: the support line renders painter-written Lua text with no checks (feat/records-6-runner)

`support_of` (r19_chains.py:791-799) regexes the first chunk text containing `canvas{`, comments included, and takes every `apply="(\w+)"`. `support_line` renders the result verbatim (record_render.py:108-115), outside PAINTER_WORDS and names. Demo (`probe/studio`): a canvas chunk ending `-- apply="Claude"` renders as

> Observed on linen, over a ground laid by knife, then Claude.

The same demo shows a second problem: `linen=15`, the single-number form (api.rs:1217 accepts it), gives `linen: None`, so the thread counts disappear. Real paintings use the pair form (every `r16/r17/r19` painting I grepped).

Fix: keep only `apply` values in {knife, roller, brush} (the easel's own enum, crates/easel/src/api.rs:1484-1488), strip `--` comments first, and accept the one-number linen. Better: take the canvas setup from the easel (`s.setup`, api.rs:1239) rather than the Lua text.

### 6. Low: operation and image evidence are loosely typed (feat/records-2-evidence)

- Any cited call whose result text contains `ok · chunk N` or "the chunk failed" counts as an operation (record_schema.py:285), whatever the tool. That includes a `read`, or a bash `grep` or `cat` of an earlier reply. On the real r19 CTEST log no non-`paint` result matches, so this is theoretical today.
- `_shows_image` accepts any result that names a `.png` (record_schema.py:254-255), such as an `ls`.
- `operation` isn't compared with the call's arguments: a `glaze` observation can cite a `stroke` chunk.

Suggested: operation calls only from `paint`, or bash running `easel do`. Image calls only from `look`, a `read` of a `.png`, or an image part. Warn when the operation verb is missing from the args or source.

### 7. Low: a repeated tool-call id silently takes the later call (feat/records-2-evidence)

`self.calls[p["id"]] = …` (record_schema.py:232) overwrites. r16-style ids are short (`call_998948`). The real r17 F logs have 0 duplicates. Suggested: record duplicates and drop an observation that cites an ambiguous id.

### 8. Low: a home-relative scratch path in the committed fixture (feat/records-3-words)

`fixtures/r16_r17_record_sentences.json` line 2 (`about`) contains `[local path redacted]<lane>/p<n>_record.md`. The rest is clean: 0 hits for `/Users`, `[local account redacted]`, `toolu_`, `call_<n>`, `.jsonl`, `paint-studio`, URLs or `@`, and no model or provider name. The only capitalized non-initial words are "Prussian" and "Lua". "painter" appears 0 times. `records_fixtures.py:81,92,97` and `test_record_schema.py:169` use the placeholder `[local path redacted] Suggested: "the released r16 and r17 reader records (run/<lane>/p<n>_record.md)".

### 9. Low: test gaps (mutation run, `probe/mutate.py`)

20 mutants: 15 killed, 1 was a no-op and 4 survived:

- `=` removed from `NOT_INERT` (record_schema.py:55): the only `=` case also has backticks (test_record_schema.py:56).
- `wait_minutes` upper bound removed (record_schema.py:42).
- The schema-mismatch exclusion in `render` (record_render.py:151).
- The stale `p<n>_record.json` unlink at read start (r19_chains.py:824).

The killed mutants cover the easel_errors, seen-after, no-result and printed checks, reject-when-none-kept, terminators, URLs, painter words and names, box tubes, box drop of mixing piles, compat pairing, medium, `mixed_records` at startup and the free-text notes separator. The tests are behavioral: they drive `chain()` with a fake reader over fixture logs and compare against a golden render. None of the new tests is implementation-coupled.

### 10. Low: structured records live in round 19's runner and are stamped round 19 (feat/records-6-runner)

The feature is meant for "rounds 20 on" (r19_chains.py:50 at the tip). `round_number()` comes from `TAG = "round-19"` (r19_chains.py:102, 758). The test asserts `rec["round"] == 19`. Round 20 already has its own runner outside the repo (`[local path redacted] This ties into finding 1: the code belongs in a round-20 runner.

### 11. Nits

- `LogIndex.TEXT_MAX` (16 KB) could cut off a chunk line. Of the 4 real r17 F results that long, none had one (`probe/trunc.py`).
- `condition.json` is rewritten on every start (r19_chains.py:1142), so a brief edited mid-lane changes the hash without a record of when. The per-record `brief_sha256` covers it.
- The compatibility checks on medium and support can't fire inside the runner today. `recipient_of` and the stamp both hard-code `oil` and `linen`, and records come only from the same lane and commit. They are covered only through `render()` tests.

## Checked and clean

- **Round 19 free text:** `--dry` identical main→tip. The notes composition is unchanged (r19_chains.py:1187). reader.ts writes `.md` unchanged (`checkRecordContent` returns early for anything but `.json`, reader-scope.ts in -5-reader). `mixed_records` refuses no real r19 lane.
- **Painter-facing leaks:** the rendered notes hold no ids, slots, rounds, reader or label (`test_nothing_rendered_says_where_it_came_from`). The painter's `read` is confined to its studio (harness/painter/painter.ts:9), so `run/<lane>/` (records, condition.json) is out of reach. Enum fields can't carry text. `tubes` must be box names. The params allowlist is closed. Values are numbers, ranges, bools or enum tokens.
- **Evidence on real logs:** the 92,233,623-byte r17 F log 1 plus log 2 index in 0.25 s at 30 MB RSS. §7's ids resolve to 624/625 chunk 129 and 464/465 failed with `isError: false`, as the design says. In a real r19 log, 31 of 32 `paint` results show `ok · chunk N` and 1 shows "the chunk failed".
- **Compatibility:** medium, support or commit (without a compat pair) excludes the whole record. A box change drops mixing_piles and missing-tube observations. Every exclusion is in the report and `p<n>_inherited.json` with the notes hash. Tube-name mixing observations stay when the box matches, per [local account redacted]'s decision.
- **Word corpus:** re-measured at 716 sentences with 13 drops, equal to the 13 labels, and 0 studio_notes drops. I independently listed 60 corpus sentences that start with an easel verb or "Thin/Repaint/Restate". All are declarative and correctly not dropped. The 12 warn-only corpus sentences are reasonable. Caveat: the `clear` labels were written by the implementer after calibrating, so `dropped == clear` shows consistency, not recall. Findings 2–4 show the recall gaps.
