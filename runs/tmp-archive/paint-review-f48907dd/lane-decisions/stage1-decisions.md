# Lane "decisions": report

Both worktrees are left detached at main and clean. Nothing was pushed or deployed. Every commit passed the pre-commit hook.

## A1. N12: pattern hits warn instead of rejecting
- Branch `fix/N12-record-prescriptions`, commit **c93be38** (follow-up to dbdb751). Label: **intentional behavior change**.
- What changed: `record_problems` keeps only the hard checks: empty, too long, code block, code, recipe, another painter and names. A new `record_flags` (r19_chains.py:615) returns the PRESCRIPTION and PLACEMENT hits. `read_painter` logs them as `RECORD FLAGGED (...)` and writes them to `run/<lane>/p<n>_record.flags.md` (r19_chains.py:638, 651). A stale flags file is removed before each read. The record still reaches the next studio. The success line now says "passed the hard checks ...; N flagged lines went on with it".
- Tests: 4 new cases in `test_a_record_with_only_flagged_lines_still_reaches_the_next_studio` check that the record reaches T2, that the flags file and log line are written and that nothing is rejected. One case checks that a flagged line plus another painter's name still rejects.
  - `uv run --no-project --with pytest pytest -q -p no:cacheprovider notes/round19/runner/test_r19_chains.py`: **32 passed** on the branch. With the old r19_chains.py: **4 failed, 28 passed**.
- Real records (scratch test `lane-decisions/test_n12_real.py`, not committed because it reads [local path redacted] both now reach the next studio with one flag each.
  - `[local path redacted] line 17, flagged as what to do ("Use `clip=true` on every blend…")
  - `[local path redacted] line 41, flagged as where things go in the picture ("…a full background and shelf lay-in…")
  - Output: `2 passed`, with `record written (... 1 flagged lines went on with it)` for each.
- `node --test notes/round19/runner/reader-scope.test.ts` doesn't apply here: the file exists only on fix/N11-reader-scope ("Could not find").

## A2. N14: probe errors that waiting won't fix stop the painter
- Branch `fix/N14-probe-errors-not-recovery`, commit **2000b51** (follow-up to 76c11d2). Label: **intentional behavior change**.
- What changed: `probe_fatal` (r19_chains.py:402) with `PROBE_FATAL` (:385) and `TRANSIENT` (:398). `probe_outcome` returns `("fatal", why)` only when the probe didn't answer ok, the error isn't a usage limit and no transient marker is present. `wait_out_limit` then logs `PROBE ERROR, painter stops now (attempt n): <why> (exit rc): <gist>; waiting won't fix it, rerun after fixing` and returns False (:461).
  - Fatal: 401/403, no API key, invalid or incorrect API key, authentication_error, permission_error, unauthorized, forbidden. 402, payment required, credit balance, credits are depleted, billing. Model not found or does not exist (not pi's "Using custom model id" warning), unknown model, model_not_found, not_found_error. 400, invalid_request_error.
  - Transient (always retried): 429, 5xx, rate limit, too many requests, "exceeded your current quota" (Google's 429 mentions billing), overloaded, timeout, ECONNRESET/ECONNREFUSED/ENOTFOUND/EAI_AGAIN, network. Anything that matches neither list is retried every LIMIT_PROBE_S up to LIMIT_GIVE_UP_H, as before. A usage limit is still waited out.
- Patterns come from real errors in [local path redacted] Checked against the real texts: Google `HTTP 402 … prepayment credits are depleted` gives "no credit or billing". `400 invalid_request_error … reasoning_effort is not allowed` gives "malformed". `429 GoUsageLimitError` is a usage limit, never fatal. pi's "No API key found for" text is in the pi dist.
- Tests: 9 new cases in `test_a_probe_error_waiting_wont_fix_stops_the_painter_at_once`, including the real Google 402 and the reasoning_effort 400. The retry test now covers 529 overloaded, HTTP 503, ECONNRESET, Google 429 billing-quota and an unknown error. The old case "401 invalid api key keeps retrying" moved to the stop test.
  - Same pytest command: **51 passed** on the branch. With the old r19_chains.py: **9 failed, 42 passed** (all 9 are the new stop cases; the transient cases pass on both, so their behavior is unchanged).

## B. N18: renders outside out/ are diagnostics
- Branch `fix/N18-white-reserve`, commit **4210e1e**. Label: **intentional behavior change**.
- What changed: in `region()` (looks.py:111), a whole render whose source path has no `out/` segment returns `"diagnostic"`. `film()` skips it (:199), and the first summary line counts it: `…, N whole renders outside out/ left out as diagnostics`. The count went on that line so it doesn't touch R23's rewritten last line.
- Tests: `test_whole_render_written_outside_out_is_a_diagnostic_and_counted` covers 4 paths ($TMPDIR/sky.png, /var/folders/…/plan.png, plan.png, notes/sky.png). `test_whole_render_under_out_is_filmed_however_it_looks` covers 3 paths (out/fresh2_winter.png, studio/out/p.png, /abs/studio/out/p.png).
  - `uv run --no-project --with pytest --with pillow --with numpy --with markdown-it-py pytest -q -p no:cacheprovider tests` on N18: **11 passed**. With the old looks.py: **4 failed**.
- Merged into `fix/R23-encoder-failure` as **84d7ca1**. There was one conflict: R23 had moved `reg = region(...)` above the loop's identity check. I kept R23's layout with `if reg in ("skip", "diagnostic")`. R23 suite: **28 passed**.
- Scratch merge: detached main + R23 + R20-R21 + R16 merged with **no conflicts** (the conftest add/add conflict the review predicted didn't happen). Suite: **39 passed**. The scratch merge commits were then abandoned, and the worktree is back at detached main.
- Legacy film comparison (review-b/films/cmp.py; outputs in lane-decisions/films/cmp_n18.txt and films/r23/cmp_r23.txt), frame counts:

  | film | main | N18 before | N18 now | R23 before | R23 now |
  |---|---|---|---|---|---|
  | r10-3 | 357 | 370 | **357** (same hash as main) | 370 | **357** |
  | r14-p3 | 880 | 893 | **880** (same hash as main) | 973 | **960** (= N19 alone) |
  | r02-winter | 442 | 455 | 455 (+1 cut, accepted) | 487 | 487 |
  | r01-winter | 540 | 540 | **475** | 540 | **475** |
  | r01-coast | 456 | 456 | **313** | 456 | **313** |
  | r01-mountains | 293 | 293 | **280** | 293 | **280** |

  The other 22 films are unchanged.

## Open: decision needed on N18 (r01 side effect)
The rule as written also removes real looks at the painting from the three r01 films: 17 whole renders the painter wrote to $TMPDIR. The contact sheet is `lane-decisions/films/r01_diag_sheet.png`. Several are full renders of the finished composition at a larger width:
- `cargo paint fresh_coast -- --width 3000 --out $TMPDIR/L.png` (and coastL2 through coastL6)
- `fresh_winter -- --width 2400 --out $TMPDIR/mid.png`
- `fresh_mountains -- --width 2000 --out $TMPDIR/f2k.png`

Main filmed all of these. r01-coast loses 11 of its 17 whole cuts.

Alternative, prototyped in scratch only (`lane-decisions/films/alt/`): count a render as a diagnostic only if it's outside out/ **and** its render command has `--stop <layer>` or `--plan`. r10-3's sky.png came from `--stop sky` and r14-p3's plan.png from `--plan`, so both still drop to main's count. r02-winter is still +1. r01-mountains is unchanged, r01-winter goes to 488 (drops 4 × `--stop distance`) and r01-coast to 404 (drops `--stop figure/clouds` renders). I committed [local account redacted]'s rule as stated. Switching to the alternative is a small follow-up if she prefers it.
