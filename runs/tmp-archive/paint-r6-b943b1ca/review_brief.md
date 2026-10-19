# Code review: Round 6 night 1 (claude-paint)

You are a senior Rust reviewer doing a rigorous, skeptical review of last
night's changes to claude-paint, a physical oil-paint simulator (README.md
explains it). Assume nothing works until you've checked it. Your job is to
find real defects, not to praise. Repository: [local path redacted] Don't
edit tracked files or commit; your only output is the file named below.

Scratch: `[local path redacted] review-r6` once; export TMPDIR=TMP=TEMP to
it. Never write to /tmp. If you build or test, do it in a separate
worktree you create under your scratch dir
(`git -C [local path redacted] worktree add $TMPDIR/wt-<name> <branch>`),
wrap commands in `timeout`, and note the golden scene is recorded in the
debug profile (a --release run reports a golden mismatch by design).

## Scope (three change sets)
1. On main, already merged: `git diff 2c5a658..main -- crates paintings`
   - the easel root fix (crates/easel/src/session.rs `root()`)
   - hand time and sittings (merge of r6-time): crates/paint/src/tally.rs,
     crates/easel/src/time.rs, api.rs, look.rs (`--mode wet`), bristle.rs,
     handling.rs, stipple.rs, canvas.rs, tests/hand_time.rs. Notes:
     notes/time.md.
2. Branch r6-wet (unmerged): `git diff main...r6-wet -- crates paintings`:
   two-layer wet film, plough, blender drag, dirty brush tip, checkpoint
   format 7 (bristle.rs, wet.rs, drying.rs, checkpoint.rs). Notes:
   `git show r6-wet:notes/wet.md`.
3. Branch r6-oak (unmerged): `git diff main...r6-oak -- crates paintings`:
   broadleaf.rs (drawn twig selection, wood_strokes, angular growth),
   draw_trees.rs. Notes: `git show r6-oak:notes/oak.md`.

## What to look for
- Correctness: logic errors, off-by-one, wrong units (units vs pixels vs
  mm vs µm; minutes vs seconds), NaN/inf and division by zero, integer
  overflow or wraparound, unchecked indexing, panics reachable from Lua.
- Physics bookkeeping: paint volume conservation in the two-layer wet film
  (every path that moves paint between surface, body, bristle and tip),
  pickup/deposit symmetry, what happens at gel/bake and in checkpoints.
- Determinism: results must not depend on thread count, tile order or
  crop (the project guarantees this); look for hidden global state,
  HashMap iteration order, floating-point reductions in parallel.
- Replay compatibility claims: "hand time off = byte-identical" on main;
  are there paths where the tally or slicing changes output with hand
  time off?
- Performance and memory at 3200px (r6-wet adds ~44 bytes/pixel).
- Tests: do they actually test the claims, or would they pass on broken
  code? Missing edge cases.
- API and docs: misleading docs, Lua API footguns.
Prioritize: correctness and determinism bugs first, then conservation,
then tests, then everything else. Verify each finding by reading the code
(and running something if cheap); mark anything you couldn't verify as a
suspicion.

## Output
Write to [local path redacted]
- a findings list, most severe first, each: severity (blocker / major /
  minor / nit), change set (main / r6-wet / r6-oak), file:line, what's
  wrong, why it matters, a concrete fix, and "verified" or "suspected";
- a short verdict per change set: safe as is / fix before merge / needs
  rework.
Then reply with the same text. US English, no Oxford comma. The project is
published under the pseudonym "alice"; never write the owner's real name
or an absolute home path into anything that might be committed.
