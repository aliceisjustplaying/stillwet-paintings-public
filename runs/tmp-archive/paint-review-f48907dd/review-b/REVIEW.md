# Review B: stillwet stage 1 branches (vs main f8c0a47)

Read-only. Worktree: review-b/wt. Scratch merge branch `review-b-scratch` (25ac803): R23 (which already contains N17+N18+N19) + R20/R21 + R16.
Scratch data: review-b/films (legacy film comparison), review-b/r23 (R23 edge cases), review-b/real (real look-tool sessions).

## Summary, by severity

| # | branch | verdict | headline |
|---|---|---|---|
| 1 | fix/R23-encoder-failure | **needs changes** | published clips become mode 0600, and Caddy (a different user) can't read them |
| 2 | fix/N17-look-tool | **needs changes (small)** | crop looks that go past the canvas edge are dropped silently: 41 of 227 in a real round-19 session |
| 3 | fix/N18-white-reserve | ship with nits (owner sign-off) | 3 of 28 published legacy films gain a hard cut to a diagnostic render |
| 4 | fix/R20-R21-kernel-lock | ship with nits | correct; launchd job works; tidy the migration and log noise |
| 5 | fix/R16-owned-dist | ship with nits | real dist/ passes the ownership check; `.DS_Store` would trip the refusal |
| 6 | fix/N19-exact-dedup | ship | intended: 17 legacy films gain 91 near-identical close-ups |
| - | merge hazard | note | `tests/conftest.py` gives an add/add conflict when R20 or R16 are merged with R23 |

Tests: every branch passes alone (N17 5, N18 4, N19 3, R23 16, R20 6, R16 3). The scratch merge passes 25. Without ffmpeg, 17 pass and 8 skip.
Fails without the fix (new tests run against the base source): N17 4/5 fail, N18 3/4, N19 3/3, R20 3/6, R16 1/3.
R23 against 7466cca: 3 fail and 8 error. The errors come from the fixture needing `looks.FFPROBE`, not from behavior, and the 3 test_looks_encode failures are the real witnesses. All match the intent doc.
Commit messages follow main's style: one-line subjects saying what the code now does, same author identity.
No added line contains `[local account redacted]`, `[local path redacted]`, `[local path redacted] the account name or a real name. Checked with `git diff main HEAD | grep '^+' | grep -iE ...`, which returned no matches.

## 1. fix/R23-encoder-failure: needs changes

**Blocker: clips are published 0600.** `looks.py:221` `tempfile.mkstemp(...)` creates the .part file with mode 0600, and `looks.py:227` `os.replace(part, out)` publishes it with that mode. Before, ffmpeg created the file itself (0644 under umask 0022).
- Measured: `new.mp4` from the branch `-rw-------`; ffmpeg alone `plain.mp4` `-rw-r--r--`. On real sessions: `review-b/real/2026-09-28.mp4` `-rw------- 25212260`.
- The mode survives the whole publishing chain. `exiftool -overwrite_original` (build.py:393, stamp_canary) keeps 0600 (tested). `shutil.copy` (build.py:591) keeps 0600 (tested). deploy.sh's `rsync -az` keeps permissions.
- On the VPS, files are owned by `agent` and served by Caddy `file_server` (pix/modules/stillwet.nix:12, 38). A 0600 looks clip ("Every look it took", build.py:645-646) would be unreadable to Caddy, so it would return 403.
- Fix: before `os.replace`, `os.chmod(part, 0o666 & ~umask)` (read umask via `os.umask(0); os.umask(old)`) or copy the old clip's mode. Add a test asserting `stat.S_IMODE(out.stat().st_mode) == 0o666 & ~umask`.

Other R23 findings (nits):
- SIGTERM leaves a `.part` file: `kill -TERM` mid-encode left `review-b/r23/.big.mp4.lq8ntnvg.part`. `finally` (looks.py:228-235) doesn't run on the default SIGTERM action. The .part is hidden and gaze_all.py keys on `out.exists()`, so it causes no harm besides clutter. Optional: a SIGTERM handler that raises SystemExit.
- Missing ffprobe gives a clean failure: `FFPROBE=/nonexistent` → "encoding failed (can't check the clip with /nonexistent ...)", rc=1, no clip and no .part. That works but is a new hard dependency; DEPLOY.md/README don't mention ffprobe.
- `import numpy as np` (looks.py:30) is now unused after N18 and N19 remove its only uses; the PEP 723 header still lists numpy.
- With ffmpeg absent, the reworked `film` fixture (tests/conftest.py:76, `pytest.skip`) silently skips every N18 and N19 test. Keep the FakeEncoder fixture for selection and identity tests; use the real encoder only for R23's decode test.
- Exit statuses 1 and 3 are correct (looks.py:345-354). gaze_all.py ignores them (it prints stderr only), as the intent doc says.

## 2. fix/N17-look-tool: needs changes (small)

The parsing matches the harness: easel-tools.ts:57 takes the path from the last line of `said`, and looks.py `look_info` does the same. Modes, grid, crop corner order and `size` handling all match easel-tools.ts:40-48.
Legacy sessions are unaffected. Every Rust-program session in the gallery manifest (28, gaze_all.py's set) was filmed with a hashing fake encoder. Frame counts, frame hashes and region classifications are identical between main and N17 for all 28 (review-b/films/cmp.txt).

**Issue:** crop looks past the canvas edge are dropped silently. The easel clamps a crop to the canvas (claude-paint crates/easel/src/look.rs:335-336, `cl = ... .clamp(lo, hi)`). looks.py keeps the raw crop (looks.py:124), and film() discards anything outside [0,1.001] (looks.py:306) without counting it.
In a real round-19 session (paint-studio-bfd78b, 2026-09-28T18-26), 41 of 227 crop looks (18%) have x1=1030 or 1020 and never reach the film. Placed 184, out of range 41, consecutive duplicates 5.
Fix: clamp look crops to [0,1000] × [0,1000/aspect], as the easel does. Treat a crop that is empty after clamping as unplaceable, and count unplaced close-ups in the summary line.

Nits: `info["path"]` is parsed but never used. Unknown tools still fall into the "skipped as not placeable" count (acknowledged in the intent doc).
End to end on two real look-tool sessions with real ffmpeg: rc=0, `stream,1280,948,11532` and `stream,1280,854,1806`.

## 3. fix/N18-white-reserve: ship with nits (needs owner sign-off)

It resolves N18's acceptance 1 and 2: the whiteness and neighbor-jump tests are gone (looks.py diff at old :181-196), and the tests fail on main.
Legacy impact (review-b/films/cmp.txt): 3 of 28 films change, each gaining one T_WHOLE cut. The re-admitted images were all neighbor-jump rejections, not whiteness rejections:
- r10-3 image 28: `$TMPDIR/sky.png`, a sky-only render (review-b/films/r10-3-jump-28.png)
- r14-p3 image 53: `$TMPDIR/plan.png`, a sky and flat-ground plan render (r14-p3-jump-53.png)
- r02-winter image 11: `out/fresh2_winter.png`, a debug render with a noise overlay and guide lines (r02-winter-jump-11.png)
These are real looks, so keeping them fits N18. But acceptance 3 ("diagnostic images distinguishable through metadata") isn't met: they are now indistinguishable from the painting and flash in published films.
Suggestion (provenance, not appearance): a legacy render whose `--out` isn't under `out/` (two of the three are in `$TMPDIR`) could be labeled diagnostic. Whoever approves the published-film change should see these three cuts first.

## 4. fix/R20-R21-kernel-lock: ship with nits

It resolves R20 and R21. flock on a never-deleted file (scripts/studio_lock.py:36, 44). The fd is passed through exec (studio_lock.py:57-58), and both scripts re-exec at the old lock point (deploy.sh:37-40, sync-studio.sh:9-11). Acquiring on the last try is success (the `break` at :45). Tests fail on main 3/6.
- Lock path: both scripts `cd "$(dirname "$0")"` first. The helper uses `realpath` and the re-exec guard compares against `$(pwd -P)/.studio.lock`, so it works from any cwd and through symlinks (tested: `test_deploy_and_sync_share_the_lock_from_any_working_directory`).
- launchd: the plist PATH is `@UVBIN@:/usr/local/bin:/opt/homebrew/bin:/usr/bin:/bin` (launchd/art.stillwet.studio.sync.plist.in). With that PATH, `python3` resolves to /etc/profiles/per-user/…/bin/python3 3.13.15 and `import fcntl` works. The plist runs sync-studio.sh directly, and the re-exec uses its absolute path, so this is fine. WorkingDirectory doesn't matter.
- Inheritance: the fd reaches every child (uv, export_static, rsync→ssh, curl). ssh calls closefrom at startup, and [local path redacted] has no ControlMaster/ControlPersist entries. None of deploy's children daemonize; no ffmpeg runs under the lock.
- Migration: the real repo had a live `.studio.lock/` directory at 17:07, gone at 17:08, so it's the current sync's transient mkdir lock. If the merge happens while an old sync holds it, the next minute's new sync exits 1 with the rmdir message and recovers once the old trap runs. Only a kill -9'd old holder needs a manual `rmdir`. `.gitignore` already covers `.studio.lock` as a file.
- Nits: a busy sync now writes a stderr line to the launchd log every minute while a deploy runs (studio_lock.py:51-53). `STILLWET_STUDIO_LOCK` set by hand skips locking (acknowledged). deploy re-runs its input checks after re-exec (harmless).

## 5. fix/R16-owned-dist: ship with nits

It resolves the "delete unrelated files" part; staging and atomic publishing are not done (acknowledged). The test fails on main 1/3.
- Real dist/ (`ls -la [local path redacted] 404.html, apple-touch-icon.png, favicon.ico, favicon.png, given, img, index.html, media, p, robots.txt, studio, style.css. All are in MADE∪KEPT (build.py:570-572), so the refusal doesn't trip. dist-preview/ has a subset (no given/robots.txt/studio), also fine.
- Every top-level write in build.py (`DIST / ...` at :595-599, 689, 758-775 and inputs.write_pages → given/) is in MADE.
- Nits: a Finder `.DS_Store` in dist/ would make every build refuse (safe, but annoying); consider ignoring it. MADE is a fixed list (acknowledged). The conftest.py:3 docstring command lacks `--with markdown-it-py`, which build.py needs for this test.

## 6. fix/N19-exact-dedup: ship

It resolves N19: sha256 of the pixels, plus size and repr(region) (looks.py diff: `sig = (digest, im.size, repr(reg))`); close-ups dedup on exact digest. Tests fail on main 3/3.
Legacy impact: 18 of 28 films change. 91 close-ups that the mean-diff<2 rule collapsed are back, with mean diffs from 0.02 to 1.99 (median 0.95; 24 under 0.5) (review-b/films/n19.py output). Films get longer by 8–72 frames at 10 fps. This matches the issue ("never use a lossy signature"). Mention it in the release note because published clips change.
Moving `region()` above the dedup is fine; region is pure.

## Merge hazard

The branches don't merge in any order without help. After R23, merging R20 or R16 gives an add/add conflict in tests/conftest.py (both add the file; R23 changed it). An octopus merge of R23+R20+R16 fails. Resolve by taking R23's conftest, a superset (`git checkout --ours tests/conftest.py` after merging R23 first). The intent doc's "so the branches merge cleanly" holds only for the N17/N18/N19 octopus.
