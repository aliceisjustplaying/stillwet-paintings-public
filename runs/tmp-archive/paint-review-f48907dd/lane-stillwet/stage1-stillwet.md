# Stage 1: stillwet lane

Worktree: wt-stillwet (branches from stillwet main f8c0a47). Nothing pushed, merged or deployed. No real dist, live studio or launchd job was touched.

Test command (the brief's command plus numpy, which looks.py imports, and markdown-it-py, which build.py imports):

    TMPDIR=<scratch>/tmp uv run --with pytest --with pillow --with numpy --with markdown-it-py pytest tests -q -p no:cacheprovider

The "fails on main" runs use each branch's new tests against main's source files (full log: lane-stillwet/verify.txt).
`tests/conftest.py` is byte-identical on every branch except R23, so the branches merge cleanly. An octopus merge of N17+N18+N19 had no conflicts.

| ID | branch | sha | change | on branch | on main | label |
|---|---|---|---|---|---|---|
| N17 | fix/N17-look-tool | 12cee53 | looks.py `events()` reads the `look` tool: whole looks are cuts; crop looks are placed by their canvas-unit crop (corners in either order); value/squint/mirror/grid looks are recognized and left out of the film; the legacy peek/read path is kept | 5 passed | 4 failed, 1 passed (the legacy-read test passes on both) | intentional behavior change (a new protocol is read) |
| N18 | fix/N18-white-reserve | 9a7bb1d | Whiteness (>50% of pixels above 235) and neighbor-jump rejection removed; only a look whose shape doesn't match the canvas is left out, and the count says so | 4 passed | 3 failed, 1 passed (the "a mask stays out by its source" guard passes on both) | intentional behavior change |
| N19 | fix/N19-exact-dedup | 6b0332e | A repeat is only an exact match: sha256 of every pixel, the size and the region. This replaces the every-997th-byte sample and the "close-up mean diff < 2" collapse | 3 passed | 3 failed | intentional behavior change |
| R23 | fix/R23-encoder-failure (branched from main, then merged N17+N18+N19 at 7466cca, since it depends on them) | 1d46d18 | Encodes to `.<name>.*.part` beside the clip. Checks ffmpeg's exit status and broken pipes, then uses ffprobe to confirm the width, height and frame count match what was written, before `os.replace`. Failure exits 1 and no media exits 3 (`NO_MEDIA`); either way the old clip stays and no .part is left. The child is killed and reaped in `finally` | 16 passed | vs 7466cca: 3 failed, 1 error | intentional behavior change |
| R20+R21 (one branch) | fix/R20-R21-kernel-lock | 2c63a76 | New `scripts/studio_lock.py`: an fcntl.flock on `.studio.lock`, with the fd handed to the script through exec. deploy.sh and sync-studio.sh re-exec through it at the old lock point. The lock is never deleted and never judged by age. The kernel releases it when the holder and its children exit. Deploy waits `STUDIO_LOCK_WAIT` seconds (default 120, as before). A busy sync exits 0 but now says so on stderr. DEPLOY.md is updated | 6 passed | 3 failed, 3 passed (the other three pass on both) | intentional behavior change |
| R16 (smallest safe step) | fix/R16-owned-dist | 1c1a1d9 | build.py `clear_dist()` deletes only the top-level names it makes (`MADE`) and keeps img/media/studio as before. If DIST holds anything else, it names those entries, exits and deletes nothing | 3 passed | 1 failed, 2 passed | intentional behavior change |

## Receipts
- R23 witnesses on the pre-fix code: an encoder shim exiting 42 and one dying midstream both gave `assert 0 not in (0, None)`, so the old code returned success.
- R23 end to end (real ffmpeg, synthetic current-format session): gaze and zoom clips both exit 0; `ffprobe` shows `stream,1280,854,243`. A value-only session gives exit 3, the message "no clip (no whole-canvas looks); an existing one is left as it was", and the old file is unchanged.
- R20 witnesses on main: "a second sync started while the first held the lock" (2 starts after the lock was aged 1 h). After kill -9 of the holder, the next sync never ran (1 start). Deploy ignored the shared wait (timed out at 30 s).
- R21 witness on main: `lane-stillwet/witness-r21/witness.sh` (a stubbed PATH where `seq` yields only the final try) prints "deploy: the studio lock (.studio.lock) is held ...", then `exit 1` and "lock left behind". With the new deploy.sh and `STUDIO_LOCK_WAIT=0`, the same witness ends with "deploy: dry run: nothing uploaded" and `exit 0`.
- R16 witness on main: the test with `notes.txt` and `backup/keep.png` beside the outputs fails with `Stop`, because main deleted both and kept building.
- The anonymity hook passed on every commit. No added line contains the name or `[local account redacted]`.

## Left open
- **N17**: The versioned observation event shared by easel, harness, viewer and gallery is not built; it is a cross-repo design decision. Linking to the provider-resized image (acceptance 2) is not done, because the session doesn't carry that image. Images from unknown tools are still counted as "skipped as not placeable or not renders" rather than reported separately. Not run against a real round-19+ session.
- **N18**: The aspect-mismatch rule stays: it checks geometry, not appearance. There is no archival index of all views; the film is a presentation.
- **N19**: The close-up place key still rounds the region to 2 decimals. No separate archival index.
- **R23**: ffprobe is now required, and a missing ffprobe counts as a failure. The film tests need real ffmpeg and ffprobe and skip without them. `numpy` is now imported but unused in looks.py (left alone). gaze_all.py only prints stderr and doesn't act on exit 3. The R16 ownership policy doesn't cover clips.
- **R20/R21**: The lock fd is inherited by child processes, so a child that daemonizes would hold the lock (ssh closes extra fds). `STILLWET_STUDIO_LOCK` is trusted as "I hold it", so setting it by hand bypasses the lock.
- **R20/R21 migration step for whoever merges**: if a `.studio.lock` folder from the old mkdir lock exists, sync exits 1 every minute with a message until it is `rmdir`'d. This is deliberate: it keeps an old-version holder from overlapping.
- **R16 (decision needed, bigger than a small PR)**: Still missing are building a new generation in private staging, validating it, publishing atomically under an ownership manifest, keeping the last good generation through build failures, and pruning only previously owned paths after success. Today, cleanup still runs before the build, so a failed build leaves a partial dist. This needs a layout decision: how dist/ becomes a published generation and how deploy.sh's `rsync --delete dist/` and the studio export into dist/studio fit it. `MADE` is a fixed list: a future new top-level output must be added to it, or the next build refuses (loudly, which is safe). R17 (symlink containment) and export_static.py in claude-paint are untouched.
