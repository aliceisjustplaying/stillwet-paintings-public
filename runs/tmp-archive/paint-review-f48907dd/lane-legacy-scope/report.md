# Lane legacy-scope: report

Worktree: wt-stillwet (left detached at main f8c0a47, clean). Scratch: lane-legacy-scope/. Follow-up commits only: no rebase, no new branches.

Test command (TMPDIR/TMP/TEMP set to lane-legacy-scope): `uv run --no-project --with pytest --with pillow --with numpy --with markdown-it-py pytest -q -p no:cacheprovider tests`

## Marker
Look-tool images are recognized by the `"look": True` mark that N17's `look_info()` already sets (fix/R23 looks.py:114). `from_look_tool(src)` (looks.py:223) reads it. The legacy path in `events()` never sets it, so all legacy images get main's rules. On N18 or N19 alone (neither has N17), nothing sets the mark, so every image is legacy and both branches behave like main. Their tests use hand-built look-marked sources.

The legacy rules are written with PIL (`ImageChops` and `ImageStat`) instead of numpy, because R23 dropped numpy. The sums are exact integers followed by one division, so the thresholds decide the same way. The proof below confirms it.

## 1. N18: fix/N18-white-reserve, a49e2ce
- **Change:** removed 4210e1e's "whole render outside out/ = diagnostic" rule. Main's whiteness and neighbor-jump rejection is back for legacy images and skipped for look-tool images (looks.py:307, :342). The summary line counts "old-harness whole looks that aren't the painting."
- **Tests:** tests/test_looks_film_selection.py. 6 pass on the branch. Against main's looks.py (scratch copy `lane-legacy-scope/onmain`), 4 fail:
  - the 3 look-tool tests (white reserve, blank canvas, major revision);
  - `test_old_harness_mostly_white_render_is_left_out`, only because main's summary wording differs. Its frames match main.
- **Label:** intentional behavior change for look-tool images. Legacy is back to main's behavior.

## 2. N19: fix/N19-exact-dedup, db9e355
- **Change:** look-tool images use exact identity: sha256 of all pixels, size and region, for both the consecutive repeat and the close-up repeat (looks.py:327, :356). Legacy images keep main's every-997th-byte `hash` (:332) and the mean-diff < 2 close-up collapse (:364).
- **Tests:** tests/test_looks_film_identity.py. 6 pass on the branch. Against main's looks.py, the 3 look-tool tests fail and the 3 legacy tests pass.
- **Label:** intentional behavior change for look-tool images. Legacy is back to main's behavior.

## 3. Merges into fix/R23-encoder-failure
- **736782b** (merge N18) and **d0ff83d** (merge N19). Each conflict was resolved by starting from R23's side and applying the same change: the "look" mark picks the rule, and the "diagnostic" region and its count are gone.
- d0ff83d adds `test_look_tool_images_are_marked_and_old_harness_images_are_not` (tests/test_looks_events.py). It runs a real `look_call` session and a bash-read legacy render through `events()`: marks are [True, False], and the blank look-tool canvas is filmed.
- **Result:** 27 passed on fix/R23-encoder-failure.
- **Label:** intentional behavior change (reverts the out/ rule) plus a new test.

## 4. Proof
- **Script:** lane-legacy-scope/proof/cmp.py, using review-b/films/cmp.py's method: fake hashing encoder, VW=64, FPS=10, `check` stubbed, the manifest's 28 Rust-harness sessions. The looks.py copies it ran are in proof/looks_*.py.
- **Legacy (proof/legacy.txt):** `films identical to main (count, per-frame hashes, classes): {'fix_N17-look-tool': 28, 'fix_N18-white-reserve': 28, 'fix_N19-exact-dedup': 28, 'fix_R23-encoder-failure': 28, 'main': 28}`. The per-frame sha256 lists are compared, not just the totals.
- **Against the reviewers' numbers:** R23's frame count and total hash equal review-b/films/cmp.txt's main column for 28 of 28 films. That column is also lane-decisions/films/cmp_n18.txt's main column, e.g. r02-winter `442:582c42fd`, r10-3 `357:33228901`, r14-p3 `880:4bd183ed`. Before this lane, R23 differed on 18 films (review-b cmp.txt).
- **Real round-19 look-tool session (proof/r19.txt):** paint-studio-bfd78b 2026-09-28T18-26, copied to proof/r19-bfd78b.jsonl.

  | looks.py | Film | Frames | Close-ups | Skipped as unchanged | Whole looks rejected |
  |---|---|---|---|---|---|
  | main | none: `SystemExit: no whole-canvas looks` (main can't read the `look` tool) | – | – | – | – |
  | N18 alone, N19 alone | none (same reason) | – | – | – | – |
  | fix/N17-look-tool | yes | 4071 | 213 | 12 | 1 (white/jump) |
  | fix/R23-encoder-failure | yes | 4172 | 224 | 1 | 0 |

  The same 184 whole looks, 20 skips and 227 crops appear in both N17 and R23. With the clamp, 0 close-ups fall outside the canvas; before the fix, 41 were dropped (REVIEW.md:45). The +101 frames are 11 extra close-ups × 8 (T_GAZE) plus one whole look × 13 (T_WHOLE).

## 5. Scratch merge
- On a detached main: `git merge --no-ff` of fix/R23-encoder-failure, then fix/R20-R21-kernel-lock, then fix/R16-owned-dist, giving e42bd82 (not on any branch).
- No conflicts. Suite: `38 passed in 5.86s`.
- Afterward: `git switch --detach main`, and the worktree is clean at f8c0a47.

## Open
- On N18 alone, `test_old_harness_mostly_white_render_is_left_out` asserts the new summary wording, so it fails on main for wording only. Its frames match main.
- Mixed sessions (look-tool and legacy images in one log) apply each rule by image. The jump test only compares legacy images with each other. No such session was checked.
