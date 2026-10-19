# Lane records: structured chain records (design PRs 1-7)

Worktree `wt-records`, left detached at `main` (4ec3169). Nothing pushed, merged or deployed. Scratch: `lane-records/`.
Tests at each tip: `uv run --no-project --with pytest pytest -q -p no:cacheprovider notes/round19/runner/` and `node --test notes/round19/runner/*.test.ts`.

| branch | sha | pytest | node | label |
|---|---|---|---|---|
| feat/records-base | 4fa0839 | 57 pass | 4 pass | merge of the 3 fixes (their own labels) |
| feat/records-1-schema | ce7efcd | 92 pass | 4 pass | new feature |
| feat/records-2-evidence | 0390757 | 107 pass | 4 pass | new feature |
| feat/records-3-words | 23ee10a | 151 pass | 4 pass | new feature |
| feat/records-4-render | ea8706e | 158 pass | 4 pass | new feature |
| feat/records-5-reader | 92001ab | 158 pass | 5 pass | new feature (reader.ts: .md write unchanged) |
| feat/records-6-runner | 54535fa | 169 pass | 5 pass | new feature; free-text path behavior-preserving |
| feat/records-7-docs | e1260dd | 170 pass | 5 pass | new feature + docs |

Every branch is a direct descendant of the one before (`git merge-base --is-ancestor` chain OK). The 57 base tests, including the free-text `GOOD_RECORD` and flag tests, pass unchanged at every tip.

## Per branch

**base (4fa0839):** `git switch -c feat/records-base main && git merge --no-edit fix/N11-reader-scope fix/N12-record-prescriptions fix/N14-probe-errors-not-recovery`. N11 fast-forwarded, then an octopus merge. No conflicts, nothing to resolve.

**1-schema (ce7efcd):** `record_schema.py`, schema `chain-observations/1`:
- Enums: category, operation, surface, brush kind, basis, role, hand, edge.
- Closed key lists for conditions, brush and params, with the easel's ranges.
- Tubes are names only, checked against the source box.
- Effect is 20-200 characters, cause ≤140, note ≤80.
- Free text must be markdown-inert: no newline or `` ` # * _ > | [ ] { } = < ``, no URL or file name, at most one sentence terminator.
- A single bad observation is dropped with its reasons. The whole record is rejected if it isn't an object, has the wrong schema or unknown top-level keys, has no observations or more than 40, or loses every observation.
- Tests: `test_record_schema.py`. §7's six observations (`records_fixtures.py`) pass, plus one case per violation.

**2-evidence (0390757):** `LogIndex` streams a pi JSONL log: call id → line, tool, args, result line, result text, whether it has an image and `isError`. An observation is dropped when:
- a cited log or call is missing, or the call has no result;
- it has no `operation` item, or no operation result shows `ok · chunk N` or "the chunk failed";
- `seen` has no image (look, `.png` read, image part or a named `.png`) at or after the operation;
- `printed` has nothing printed beyond the chunk, look and note lines;
- `easel_errors` has no failed chunk.

Kept observations carry `resolved`. Tests use fixture logs in both id styles: r17 F style (bash with a look in the same command) and r16 D style (write, then `easel do -f`, then a `.png` read), plus r19 `paint`/`look` and `isError:false` failures. A scratch check against the real 92 MB logs resolves §7 to exactly the design's lines: 624/625 chunk 129, 464/465 failed, log 2 109/110 chunk 162, 170-175 and 190-193.

**3-words (23ee10a):** your choice 1.
- **Clear command → drop.** A sentence, `Label:` or parenthesis that starts with an imperative; ", so/then <command>"; "you/one should/must/can"; "it's best to"; "the trick is".
- **Clear placement → drop.** `<part> of the picture|painting|composition|image|frame|scene|view`, "in the foreground/distance", "focal point".
- **Ambiguous → warn only.** `<x> of the canvas`, "edge of the …", bare "on the left", "in the middle", horizon, foreground, background, composition, motif, coordinates (`y 330`, `x~500`), always, never, instead, should, suits, "works well" and "read best".
- **Always drop.** `PAINTER_WORDS` and `check_studio_names` hits in any string field (via `studio_names()`, which honors the studio's own artist).
- **Warn.** `CODE_LINE`.

Measured corpus: every sentence of the 11 real records (r16 A/B/C/D, r17 F/O; 716 sentences) plus the 4 `studio_notes.md` versions (809 unique sentences in all). The r19 and r20 run folders hold no records.

| measure | result |
|---|---|
| drops | **13, all clear prescriptions** (e.g. "Use clip=true on every blend…", "Lay the darks after the pale has set.", "Pass it a number.", "…, so shorten them with distance.", "(use :map)", "…, so pass chunk files by full path.") |
| clearly-material sentences dropped | **0**; no studio_notes sentence drops |
| warn-only | 13 (such as "sometimes on one side of the canvas only", "swelled only slightly in the middle", "Patching the ring never matched.", "…out to x 700") |

Calibration that measurement forced:
- "Thin", "clip", "check" and "work with" start material sentences, so they're not commands.
- "one side of the canvas" is material, so "canvas" left the drop set.
- A coordinate described a curve's overrun ("out to x 700"), so coordinates moved to warn.

The labeled corpus is committed as `fixtures/r16_r17_record_sentences.json`. The test asserts that the dropped set equals the 13 labels. Also tested: the N12 probe drops; review-a's `**Glazing:** Always…` can't be written (not inert); no §7 observation warns.

**4-render (ea8706e):** `record_render.py`:
- Output: header, then per record a support line ("Observed on linen 15 by 13 threads per cm, over a ground laid by knife, then roller."), then categories in enum order.
- Each bullet is "effect. When: op, tubes, brush, clip, surface, hand, params, extent, note. (tag)", wrapped at 96 characters.
- Tag: "(printed by the easel)", "(seen once)", "(seen in N passes)" or "(reported, not verified)".
- No ids, slot, round, reader or label are rendered.
- Compatibility: a different medium or support excludes the record; a different commit excludes it unless `record_compat.json` pairs the two; a different box drops `mixing_piles` and observations naming tubes the box lacks.
- Report: `summary()` gives "T3: inherited 5 of 6 observations (p1: 3/3, p2: 2/3, 1 box)", and `inherited()` holds every exclusion plus `notes_sha256`.
- Tests: a golden `fixtures/section7_render.md` of §7, box, commit and compat, medium and support, and the report.

**5-reader (92001ab):** `reader_brief_structured.md` has numbered logs, the schema with one example, evidence by toolCall id, the N11 exclusions, "fewer, checkable observations beat full coverage", no 60-line rule and "commands are dropped". `reader-scope.ts` `checkRecordContent`: a `.json` record must parse, or the write throws "not JSON: …" so the reader can fix it in-session. `.md` records are unchanged. `reader.ts` calls it before writing. Test: `reader-scope.test.ts`.

**6-runner (54535fa):**
- `lane(..., records="free-text"|"structured"|"none")` defaults to free-text. The r19 LANES are untouched.
- `read_structured`: numbered brief, scope write `p<n>_observations.json`, then validate with logs, box tubes (from the studio guide's tube table) and names.
- It stamps `p<n>_record.json`: round, lane, slot, profile, code tag and commit (`BASE/.commit`), medium, box name and tube-table hash, support (linen and ground `apply` from the `canvas{}` chunk), reader model and brief/system hashes, logs, observations, dropped and warnings.
- It logs `RECORD DROPPED`, `RECORD FLAGGED` and `RECORD REJECTED`. A rejection keeps `p<n>_observations.rejected.json` and stops the lane, as today.
- `inherit_structured` renders into the next studio's notes and writes `p<n>_inherited.json` plus the summary line.
- `mixed_records` refuses a run folder that holds the other kind of record at startup. `--dry` shows the structured reader.
- The new modules are imported lazily, so a copied free-text runner still runs without them (checked: a copy of only the old files runs `--dry --only F`).
- Tests: a fake reader over the fixture logs makes the next studio's notes equal `studio_notes.md` + golden; drop and flag logging; five rejection cases; `none`; mixed kinds; `--dry`; a free-text next studio byte-equal to r19's `base + "\n" + "\n## More notes from the studio\n\n" + record`.
- The full `--dry` output (all LANES) is identical to feat/records-base (diff empty, after masking timestamps and studio hashes).

**7-docs (e1260dd):** `run/<lane>/condition.json` holds the label, reader, `reader_brief*.md` hashes and the record_schema/record_render hashes. It's written only for **structured chain** lanes. The r19 docstring and CHANGES.md describe the feature and give the gallery caption text. Your choice 2 is kept: the painter-facing heading stays neutral. Test: condition.json exists for a structured chain; none for a free-text chain or a single painter.

## Open points
1. **condition.json for r19's free-text chain (lane F):** the design says "chain lanes". I wrote it only for structured lanes so the r19 path adds no files. Needs your call.
2. **Gallery caption:** the gallery lives in stillwet, outside this worktree. The caption text is only in CHANGES.md.
3. **Deviations from the design text:**
   - The edge enum adds `loose` (easel_guide.md names it).
   - `When:` always starts with the operation, since the design's examples were inconsistent.
   - The header appears once, then a block per record (today repeats it per record).
   - The chunk regex is `ok · chunk N`, tighter than `chunk \d+` so guide text doesn't count.
   - An image in the same call as the operation counts (r17 painters looked in the same bash command).
4. **Ranges I set that the guide doesn't document:** coverage ≤50, length ≤5000, extent ≤5000, splay ≥0. The guide documents pressure, point, load, stiffness and feather 0..1, medium ≤0.95 and wait ≤10 years.
5. **Placement drops:** the clear-placement tier has no corpus hits (the real records hold none after the fixes). It's covered only by synthetic probes.
6. **No real reader run:** the structured brief hasn't been tried on a model. The reader.ts guard is unit-tested only, because the pi package isn't resolvable from node tests.
7. **PR8 skipped as instructed:** no `semantic_check` hook and no `p<n>_excerpts.json`.
8. **Released text in the repo:** `fixtures/r16_r17_record_sentences.json` is 100 KB of r16/r17 record sentences (no paths or names; the anonymity grep of the diff finds 0 hits).
9. **Box source:** the source box's tubes come from the studio's guide tube table, not `easel tubes`. The export guarantees they match (export_r16_studio:146-159).
