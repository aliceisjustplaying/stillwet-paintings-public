# Structured chain records: design

Scope: N12 (record steering) and the chain-learning half of D11. Decisions taken as given:
(1) structured records, (2) inheritance is a declared non-neutral condition, (3) an LLM check
may come later. Read-only design; nothing in the repo was changed.

Receipts: `r19_chains.py` = `notes/round19/runner/r19_chains.py` on `main` unless a branch is named.

## 1. What exists today

- The reader writes free markdown to `p<n>_record.md` (`reader_brief.md`, N11 branch: "Group by
  operation (mixing piles, strokes, blending, wet into wet, glazing, stippling, drying and time,
  masks and edges, brushes)", "Keep it under 60 lines").
- `record_problems` (r19_chains.py:571) checks line count, code blocks, `CODE_LINE`, `RECIPE`,
  `PAINTER_WORDS` and `scripts/check_studio_names`. Any hit rejects the whole record and stops
  the lane (r19_chains.py:615-621).
- The merge appends each earlier record verbatim under `## More notes from the studio`
  (r19_chains.py:889-894). There is no medium, box or version check.
- The 11 real r16/r17 records (`[local path redacted] 54-58
  lines) break every rule of the brief: prescription (r17 F p1 "Use `clip=true` on every blend
  near anything else.", "Lay the darks after the pale has set."), subject (r17 F p1 "`hatch` …
  reads as grass"), process (r16 D p1 "a full background and shelf lay-in about 73 minutes",
  "Compute times") and a looking/session section in both.
- Session logs are pi JSONL: each tool call is a `{"type":"toolCall","id":…}` part of an
  assistant message, answered by a `toolResult` with that `toolCallId`. Ids are
  provider-specific (`toolu_01UubR4…` in r17 F, `call_998948` in r16 D): treat them as opaque.
- `isError` doesn't mean the chunk failed: r17 F log 1 line 465 has `isError: false` with
  "error converting Lua function to f32 … (the chunk failed and changed nothing)".

## 2. Format: JSON, rendered by the runner

JSON, not constrained markdown: the runner is a stdlib-only uv script, so `json` validates
exactly with nothing to maintain; markdown "constraints" are the pattern game N12 lost
(review-a/REVIEW.md:60: `**Glazing:** Always put…` passes); and the painter never sees the JSON.
The runner renders it through fixed templates, so the reader controls no headings, emphasis,
quotes or layout, only short fields.
The reader writes **only observations**. The runner stamps the metadata, because the reader
can't be trusted to state the medium or version.

### 2.1 Reader output: `p<n>_observations.json` (the reader's one allowed write)

```json
{"schema": "chain-observations/1",
 "observations": [{
   "category": "blending",
   "operation": "blend",
   "conditions": {"surface": "open", "clip": false,
                  "brush": {"kind": "badger", "width": [30, 40]},
                  "params": {"coverage": [1.2, 2.0], "pressure": [0.2, 0.5]},
                  "tubes": [], "extent_units": null, "note": null},
   "effect": "The badger dragged wet paint across the edges of its mask and broke shapes beside it into separate lumps.",
   "cause": null,
   "basis": "painter_reported",
   "evidence": [{"log": 1, "call": "toolu_01UubR4dykeR1KExnqQN1haA", "role": "operation"},
                {"log": 1, "call": "toolu_01VZ2LgtmdiXAN98rnrHZ1aE", "role": "report"}]}]}
```

| field | type / limit |
|---|---|
| `category` | enum: `ground`, `pencil`, `mixing_piles`, `strokes`, `brushes`, `blending`, `wet_into_wet`, `glazing`, `stippling`, `drying_and_time`, `masks_and_edges`, `easel_errors`. The brief's nine, plus `ground` and `pencil` (studio_notes.md sections) and `easel_errors` (a refused call is a checkable tool fact). |
| `operation` | enum of easel verbs: `canvas`, `pile`, `stroke`, `touch`, `work`, `blend`, `stipple`, `glaze`, `scumble`, `hatch`, `cut_in`, `wait`, `drying`, `mask`, `pencil`, `erase`. It is a curated list, **not** every API name: the legacy tree/fir keys (`crown`, `species`, `horizon`, `season`; `crates/easel/src/legacy/draw_trees.rs:151,537`) name subjects. |
| `conditions.surface` | enum: `bare_ground`, `open`, `setting`, `tacky`, `touch_dry`, `dry`, `mixed`, `unknown` |
| `conditions.clip` | bool or null |
| `conditions.brush` | `kind` enum (`round flat filbert fan rigger badger stippler knife`); `width`, `point`, `load`, `stiffness`: number or `[lo, hi]` |
| `conditions.params` | keys from a closed allowlist (`coverage medium pressure feather fill threshold length hand edge wait_minutes touches_per_dip splay`); values are numbers, ranges, bools or an enum token (`hand`: `broad body detail blend hatch glaze scumble`; `edge`: `firm soft found lost`) |
| `conditions.tubes` | tube names that must be in the recipient box's `easel tubes` list. **No parts or ratios**: the ratio is the recipe. |
| `conditions.extent_units` | number or range: the passage's width in canvas units. No positions and no x/y keys. |
| `conditions.note` | ≤ 80 chars, markdown-inert (see 3.1) |
| `effect` | 20–200 chars, one sentence, markdown-inert, required |
| `cause` | ≤ 140 chars, markdown-inert, optional ("why, if the log shows it") |
| `basis` | enum: `printed` (the easel printed it), `seen` (in an image the painter looked at after the operation), `painter_reported` (only the painter's note or text says so) |
| `evidence` | 1–6 items `{log: 1-based index into the brief's log list, call: tool-call id, role: operation | source | image | report}` |

There are at most 40 observations. The rendered notes are then bounded at about 3 lines each.

### 2.2 The record the runner keeps: `p<n>_record.json`

```json
{"schema": "chain-record/1",
 "condition": "chain-inherited, non-neutral",
 "round": 20, "lane": "F", "slot": 1, "profile": "friedrich",
 "code": {"tag": "round-20", "commit": "<BASE/.commit>"},
 "medium": "oil", "box": {"name": "default", "tubes_sha256": "<of `easel tubes --markdown`>"},
 "support": {"kind": "linen", "linen": [15, 13], "ground_layers": ["knife", "roller"]},
 "reader": {"model": "anthropic/claude-opus-5-5", "brief_sha256": "...", "system_sha256": "..."},
 "logs": ["<abs path>", "..."],
 "observations": [ ...validated, each with "resolved": [{"line": 624, "tool": "bash", "result_line": 625, "chunk": 129}] ],
 "dropped": [{"index": 3, "why": ["evidence log 1 call X: no such tool call"]}],
 "warnings": [{"index": 0, "field": "effect", "pattern": "PRESCRIPTION"}]}
```

`code.commit` is `checkout()`'s `.commit` (r19_chains.py:626-643). `box` is `bin/box` (else
`default`) plus the tube table `scripts/export_r16_studio:146-159` already builds. `support` is
the source's chunk-1 `canvas{}`: `linen` and each ground layer's `apply` (the ground piles are
recipes, left out). The easel has no version string, so the code commit stands in for "engine
version".

## 3. Validation (`record_schema.py`, stdlib, called from `read_painter`)

### 3.1 Mechanical checks

The whole record is rejected (the chain stops, as today) if it is missing, not JSON, has the
wrong `schema`, has no observations or more than 40.
A single observation is dropped and logged in `dropped` (the record still passes if any remain)
when it has any of these:
1. An unknown key, a value outside an enum or a wrong type.
2. A length limit broken, or free text that isn't **markdown-inert**. Free text is `effect`,
   `cause` and `note`, and "inert" means no newline, `` ` ``, `#`, `*`, `_`, `>`, `|`, `[`, `]`,
   `{`, `}`, `=`, `<`, URL or more than one sentence terminator. This blocks code, recipes
   (`RECIPE` needs `{`), headings and quoted "instructions". API identifiers belong in the
   structured fields, where they're rendered.
3. Evidence that doesn't resolve: `log` out of range, `call` not a `toolCall` id in that log,
   or no `toolResult` for it.
4. No `operation` evidence. At least one cited call's result must show a chunk ran or failed
   (`chunk \d+` or `the chunk failed`); this holds for r16/r17 bash output and for r19's
   `paint` tool.
5. A `basis` its evidence can't back: `seen` needs an `image` item (a `.png` `read` or a `look`
   later in the log than the operation); `printed` needs result text beyond the chunk line;
   `easel_errors` needs a failed-chunk result.
6. Tubes outside the box, or brush and param values outside the easel's ranges.
7. A hit from `PAINTER_WORDS` or `check_studio_names` in any string field. That hit is a hard
   drop, as it is a hard reject today.

Warnings are logged and the observation passes (warn-and-pass, per the N12 change):
`PRESCRIPTION`, `PLACEMENT` and `CODE_LINE` matched per field on
`fix/N12-record-prescriptions`, plus imperative-first-word in `effect`. They go to
`p<n>_record.json#warnings` and the run log.

### 3.2 What it can't check

- Whether `effect` is about paint or the picture ("broke shapes beside it into lumps" vs
  "made the sky read deeper" look the same to a schema), paraphrased or non-English
  prescriptions, and hints ("a tall arch near the center works well").
- Whether the evidence supports the claim: it proves call X ran a chunk, not that X's output
  shows "30 hours" or that the image shows gaps.

**Where an LLM check plugs in:** a `semantic_check(record, excerpts)` hook in `read_painter`,
after `validate()` and before `render()`, off by default. The runner writes `p<n>_excerpts.json`
(each observation's cited call arguments and result text, ≤ 2 KB each, images referenced not
inlined), so the reviewer reads kilobytes, not a 92 MB log (r17 F log 1 is 92,233,623 bytes). The
reviewer is launched like the reader (reader.ts, READER_SCOPE read = record, excerpts, review
brief; write = `p<n>_verdicts.json`) and returns per observation `{scope: material | subject |
composition | prescription | process, supported: yes | no | unclear}`. Non-`material` or
`supported: no` becomes a drop; verdicts are kept for audit.

## 4. Rendering into the next studio's notes

The runner renders all text, and the painter sees only the rendered form. The layout is the
same header as r16–r19, then one block per included record:

```markdown
## More notes from the studio

Observed on linen 15 by 13 threads per cm, over a ground laid by knife, then roller.

### Blending
- The badger dragged wet paint across the edges of its mask and broke shapes beside it into
  separate lumps. When: badger 30–40 wide, unclipped, into open paint, coverage 1.2–2,
  pressure 0.2–0.5. (reported, not verified)
```

Categories in enum order; `When:` built from `conditions` by templates; the tag is "(printed by
the easel)", "(seen once)", "(seen in N passes)" or "(reported, not verified)" (the phrase
studio_notes.md:51 already uses). Evidence ids, slot, round, reader and the condition label are
**not rendered**: the painter can't open the logs, and the N11 brief keeps "nothing that tells a
reader there was another painter". The support line does imply an earlier canvas (choice b).

**Compatibility at export** (before `studio_notes.md` is written):

| record vs. recipient | action |
|---|---|
| `medium` or `support.kind` differs | exclude the whole record |
| `code.commit` differs | exclude the whole record unless `record_compat.json` (operator-written, committed) lists the pair as equivalent |
| `box` differs | drop `mixing_piles` observations and any observation whose `tubes` are missing from the recipient box; keep the rest |
| support params (linen, ground) | not checkable: the recipient picks `canvas{}` later. They are rendered as the context line. |

Every exclusion or drop goes to `run/<lane>/p<n>_inherited.json` and a log line (`F2: inherited
14 of 17 observations (p1: 9/9, p2: 5/8, 3 box)`); the hash of the bytes the painter got is kept
there too (D11 acceptance 1). Nothing disappears silently.

## 5. The condition, declared

- `LANES` entries get `"records": "structured"` (or `"free-text"` or `"none"`).
- `run/<lane>/condition.json` holds the label `chain-inherited, non-neutral`, the reader and
  renderer versions, and the hashes of `reader_brief*.md`.
- CHANGES.md and gallery captions say chain lanes inherit records by design. A later painter's
  results are not comparable with a blank studio's without that label.
- This meets N12 acceptance 1 by routing, not only by rejection. A composition directive that
  survives the mechanical check (see 7.3) reaches only a lane labeled non-neutral, with a
  warning logged.

## 6. Migration

- **Old rounds:** r16/r17/r19 `p*_record.md` stay as they are. They are released data, and the
  ledger's compatibility rule says "Preserve released behavior unless an explicit version change
  is approved". `records: "free-text"` keeps today's `record_problems` path, so r19 reruns are
  byte-identical.
- **New rounds** (r20+) use `records: "structured"`. Mixing formats in one lane is refused at
  startup.
- **reader_brief.md:** add `reader_brief_structured.md`: numbered logs ("log 1: …"), the schema
  with one example, evidence = the toolCall's `id`, output only `{OUT}` as JSON; keep the N11
  exclusions; add "fewer, checkable observations beat full coverage"; drop the 60-line rule.
- **reader tools:** READER_SCOPE `write` becomes `p<n>_observations.json` (reader-scope.ts
  unchanged). reader.ts's write wrapper adds `JSON.parse(p.content)` and throws "not JSON: …" so
  the reader fixes syntax in-session; the schema is validated only in Python.
- **runner:** `read_painter` branches on `records`: structured → validate → stamp → optional
  semantic check → save. `chain` merge → `render(records, recipient)`, which includes the
  compatibility check.
- **tests:** the existing `GOOD_RECORD` tests (test_r19_chains.py:213-257) stay for the
  free-text path. New tests are listed in section 8.

## 7. Worked example (two real records, converted by hand)

### 7.1 r17 F p1 (`[local path redacted]

Log 1 = `…paint-studio-cfa19c--/2026-09-27T10-41-24-604Z_01a0e274….jsonl`,
log 2 = `…T11-55-04-611Z_01a0e2b8….jsonl`.

| # | category / op | conditions | effect | basis | evidence (log:call → line) |
|---|---|---|---|---|---|
| 1 | blending / blend | badger [30,40], clip false, open, coverage [1.2,2.0], pressure [0.2,0.5] | The badger dragged wet paint across the edges of its mask and broke shapes beside it into separate lumps. | painter_reported | 1:toolu_01UubR4dykeR1KExnqQN1haA → 624, chunk 129 (op); 1:toolu_01VZ2LgtmdiXAN98rnrHZ1aE → 672 (report) |
| 2 | easel_errors / work | hand hatch; note "coverage given as a function" | work refused a function as its coverage and the chunk changed nothing. | printed | 1:toolu_01Fi7k928j58wVXh8f8j1XYK → 464/465 (op) |
| 3 | drying_and_time / wait | wait_minutes 1800 | The wait counted in minutes, so 1800 of them moved the canvas clock on by 30 hours. | printed | 2:toolu_01Y9c22xk1JRbFerzrrjzSRT → 109/110, chunk 162 (op) |

Rendered:

```markdown
### Blending
- The badger dragged wet paint across the edges of its mask and broke shapes beside it into
  separate lumps. When: badger 30–40 wide, unclipped, into open paint, coverage 1.2–2,
  pressure 0.2–0.5. (reported, not verified)

### Drying and time
- The wait counted in minutes, so 1800 of them moved the canvas clock on by 30 hours.
  When: wait. (printed by the easel)

### Easel errors
- work refused a function as its coverage and the chunk changed nothing. When: work, hatch
  hand, coverage given as a function. (printed by the easel)
```

What didn't fit:
- **Prescriptions had nowhere to go.** "Use `clip=true` on every blend…", "Pass it a number" and
  "Lay the darks after the pale has set" were dropped; their factual halves survive as #1, #2
  and an ordinary wet-into-wet observation.
- **Dropped:** "`hatch` … reads as grass" (subject); crop limits, replay times, shell exports,
  `timeout` (process/looking); "`local`s are gone in the next chunk, but globals persist" (a real
  easel-language fact, but D11 puts capability documentation in the common guide).
- **#3's arithmetic isn't checkable:** the cited result prints only "day 93, 21:43"; "30 hours"
  needs the clock before too. The validator passes it; the LLM hook would say `unclear`.
- **#2's `isError` is false** though the chunk failed, so `easel_errors` keys on result text.

### 7.2 r16 D p1 (`[local path redacted]

Log 1 = `…paint-studio-6399ad--/2026-09-27T00-05-28-335Z_01a0e02e….jsonl` (from
`p1_reader_brief.md`). Here the painter wrote each chunk with `write` and ran it with bash
`easel do -f`, so one operation spans two calls: `source` and then `operation`.

| # | category / op | conditions | effect | basis | evidence |
|---|---|---|---|---|---|
| 4 | mixing_piles / work | hand body, filbert 20, tubes [raw umber, bone black, red earth, lead white], medium 0.2, fill true | A dark pile holding a little lead white came out on the canvas as a pale mauve gray, far lighter than its masstone. | seen | 1:call_452249 → 170 (source, chunk 3 text); 1:call_998948 → 172, chunk 3 (op); 1:call_4155479 → 174 (image) |
| 5 | strokes / work | hand body, filbert 20, fill true, coverage 2.0, extent 100 | The passage came out as a patchwork of separate rectangular dabs in two tones, not a smooth plane. | seen | same three calls |
| 6 | drying_and_time / drying | medium [0.2,0.25] vs 0.15 | Queried at the same moment, the earth-and-black layer read setting while a later lead-white-rich layer read open. | printed | 1:call_7595596 → 190 (source); 1:call_214951 → 192, chunk 5 (op: "table drying: open / bg drying: setting") |

Rendered:

```markdown
Observed on linen 16 by 14 threads per cm, over a ground laid by knife, then brush.

### Mixing piles
- A dark pile holding a little lead white came out on the canvas as a pale mauve gray, far
  lighter than its masstone. When: raw umber, bone black, red earth and lead white, medium
  0.2, body hand, filbert 20. (seen once)
…
```

What didn't fit:
- **#4 loses its key condition:** the source has `{"lead white", 1}` in 8 parts. A part count is
  a recipe, "a little" is free text, and even the tube list is half a recipe. I kept tubes-only.
- **Fidelity:** the r16 record says the pile "dried" mauve; the evidence is the look right after
  chunk 3. Only the LLM hook catches drift like that.
- **Dropped:** chunk clock times ("background and shelf lay-in about 73 minutes"), compute times,
  the `timeout` fact (process); "Neither `hand="glaze"` nor `stipple` was used" (not an
  observation); "A whole look is 1000×800" (looking).
- **#5's `extent 100`** sizes a subject area; allowed as a width only, because brush-vs-band
  width is a material condition (studio_notes.md #17 does the same).

### 7.3 The N12 probe

"Always put a tall arch at the center of the picture." must become an observation with a
category, an operation and evidence that ran a chunk. As `effect` it passes the schema;
`PRESCRIPTION` and `PLACEMENT` warn, and warn-and-pass routes it into a lane labeled non-neutral.
Rejecting it outright needs choice (a) or the LLM hook.

## 8. Implementation plan (small PRs, in order)

1. **`record_schema.py`: types, enums, limits, markdown-inert.** Test: the §7 JSON passes; one
   case per violation (enum, length, newline, backtick, braces, >40) drops or rejects.
2. **Evidence resolution.** Test: fixture logs in both id styles: unknown id and missing result
   drop; `seen` without a later image drops; a failed chunk with `isError:false` counts as
   `easel_errors`; a write-then-run operation resolves.
3. **Field warnings and names.** Test: `PAINTER_WORDS` or a studio name in `note` drops; the N12
   probe warns; review-a's bypasses (`**Glazing:** Always…`) can't be written (markdown-inert);
   no §7 observation warns.
4. **`render()` plus compatibility.** Test: golden render of §7; a box mismatch drops
   `mixing_piles` and logs it; a commit mismatch excludes unless in `record_compat.json`;
   `p<n>_inherited.json` lists every exclusion.
5. **Reader side:** `reader_brief_structured.md`, `.json` write path, reader.ts JSON guard. Test
   (reader-scope.test.ts): writing non-JSON throws; valid JSON is written.
6. **Runner wiring:** `records` option, structured `read_painter`, stamping, merge via `render`,
   `--dry`, `condition.json`. Test (test_r19_chains.py): a fake reader writes observations over
   fixture logs; the next studio's notes equal the golden render; a `free-text` lane is
   byte-identical to today.
7. **Docs:** CHANGES.md and gallery caption. Test: `condition.json` exists for chain lanes only.
8. **Later: `semantic_check`**, off by default. Test: a stub `prescription` verdict drops and is
   recorded. Calibrate on the 11 real records before switching it on.

## 9. Open choices for [local account redacted]

- (a) In structured lanes, should `PRESCRIPTION`/`PLACEMENT` hits drop the observation or warn?
  The fields are short and declarative, so false positives should be rarer than on free text.
- (b) Should the painter-facing text say the notes are inherited from earlier work? Today it
  doesn't. The support line implies it.
- (c) `mixing_piles`: keep tubes-only, or drop the category from inheritance?
