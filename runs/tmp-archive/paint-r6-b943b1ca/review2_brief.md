# Code review: the Round 6 maintenance round (claude-paint)

You are a senior Rust reviewer doing a rigorous, skeptical review of a
maintenance round on claude-paint, a physical oil-paint simulator (read
README.md). Assume nothing works until you've checked it; your job is to
find real defects introduced or left by these fixes, not to praise.
Repository: [local path redacted] Don't edit tracked files or commit; your
only output is the file named below.

Context: eight reviewers found bugs B1–B10 and structural problems S1–S6
(notes/round6/thermos.md, including a "Status" section at the end). Three
agents fixed them; this review checks the fixes.

## Scope
1. main: `git diff eff0ef6..main -- crates paintings Cargo.toml`
   (merges of r6-maint-b and r6-maint-a, plus the release-profile change).
   Key areas: `Canvas::paint_pass` and `TileOrder` in crates/paint/src/
   sched.rs, handling.rs, stipple.rs (S1, B2); B1's fill using the dry
   film gained since the pass began (handling.rs `fill_gaps`); B4 varnish
   through the hand clock; B5 `work_with`/`stipple_with` and the sitting's
   palette; S4 `time::verb` in crates/easel/src/time.rs and api.rs;
   `Tally::to_words/from_words` (PAINTCK7 byte order); `stage_at_index`;
   S3 `broadleaf/wood.rs`, `path::{length, arclen}`; S5 surface.rs
   `Bands`, `conserve_total`, `raise`, and settle_film's exact bounds.
2. r6-wet: `git diff 7a1340f..r6-wet -- crates paintings` (the branch's
   restructure and fixes, then two merges of main): `Layer`, film.rs
   `Stroke` reservation, exchange.rs `contact()`, `Mode`, B3 plough
   stiffness, B7 dirty tip for rounds, B8 checkpoint validation, B9
   stroke-local set-aside film, the shared study module, the merge
   resolution in checkpoint.rs (PAINTCK8 after main's Tally words).

## What to look for
- Behavior claims: "refactors are byte-identical with hand time off" (RNG
  consumption, tile order, float operation order, stroke ids); where could
  that be false for logs other than the two benchmarks?
- The new abstractions: can `paint_pass` or `time::verb` be misused? Does
  every verb that should go through `time::verb` do so? Does the `Stroke`
  reservation settle on every exit path, including early returns and
  panics? Is `Drop`-based settling sound with parallel tiles?
- Correctness of the bug fixes (B1 especially: the dry-film comparison;
  B5: palette shared across passes; B3/B7), and new tests that would pass
  on broken code.
- Checkpoint compatibility (PAINTCK7 on main, PAINTCK8 on r6-wet),
  determinism across thread counts and crops, conservation.
Verify each finding by reading the code (and running something small in
your own worktree under a scratch dir if cheap: `[local path redacted]
review2`, export TMPDIR=TMP=TEMP, `git worktree add $TMPDIR/wt <ref>`,
wrap commands in `timeout`). Mark each "verified" or "suspected".

## Output
Write to [local path redacted] findings
most severe first, each with severity (blocker / major / minor / nit),
change set (main / r6-wet), file:line, what's wrong, why it matters, a
concrete fix, verified/suspected; then a one-line verdict per change set.
Reply with the same text. US English, no Oxford comma. The project is
published under the pseudonym "alice": never write a real name or an
absolute home path into anything that might be committed.
