# Thermos review of Round 6 (claude-paint)

claude-paint is a physical oil-paint simulator in Rust: paintings are
programs (Lua at an "easel", or Rust binaries) and every mark is a simulated
bristle brush carrying wet paint over a canvas height field, composited by
Kubelka–Munk optics. Read README.md first. Repository: [local path redacted]

You are one of six reviewers (three model families × two review kinds).
Your review kind and its full instructions are in the skill file named in
your task: read that SKILL.md completely and follow it as your prompt.

## Scope: the Round 6 changes (two change sets)
1. **main**: everything merged since the start of Round 6:
   `git -C [local path redacted] diff 2c5a658..main -- crates paintings`
   (and `git log --oneline 2c5a658..main` for the commit story). This
   includes: the easel root fix (crates/easel/src/session.rs `root()`);
   hand time and sittings (crates/paint/src/tally.rs, crates/easel/src/
   time.rs, api.rs, look.rs `--mode wet`, handling.rs, bristle.rs,
   stipple.rs, canvas.rs, checkpoint.rs PAINTCK7); the review fixes to hand
   time; the relief default change (style.rs); bare trees (broadleaf.rs,
   crates/easel/src/draw_trees.rs); the varnish fix (surface.rs
   `settle_film`, canvas.rs `glaze`).
2. **r6-wet** (unmerged branch): `git -C [local path redacted] diff
   main...r6-wet -- crates paintings`: two-layer wet film, plough,
   blender drag, dirty brush tip, lift-off, reserved-film conservation,
   checkpoint PAINTCK8 (bristle.rs, wet.rs, drying.rs, checkpoint.rs).
Design notes to read as needed: notes/time.md, notes/oak.md,
notes/varnish.md on main; `git show r6-wet:notes/wet.md` for the branch.
A previous single-pass review already found and fixed five issues
(notes/round6.md, notes/advice/astra_r6.md; the fixes are in the diff):
don't re-report those unless the fix itself is wrong.

## Project invariants worth checking against
- Determinism: output must not depend on thread count, tile order or crop
  (tests exist; look for hidden global state, HashMap iteration order,
  parallel float reductions, anything seeded by time).
- Replay: existing Lua logs replay byte-identically unless a change is
  meant to alter output (then golden/replay hashes are re-recorded with a
  stated reason).
- Paint conservation (volume and per-pigment moments) across canvas,
  bristles and brush tip.
- Units: canvas units (1000 wide) vs pixels vs mm vs µm; minutes vs seconds.
- Memory at 3200px (a Form costs ~190 MB; r6-wet adds ~44 bytes/pixel).

## Rules
- Read-only: don't edit tracked files, don't commit, don't push, don't
  create branches in the main checkout. If you need to build or run
  something, create your own worktree under your scratch dir
  (`[local path redacted] thermos-<you>`; export TMPDIR=TMP=TEMP there;
  `git -C [local path redacted] worktree add $TMPDIR/wt <commit-or-branch>`)
  and wrap commands in `timeout`. The golden scene is recorded in the
  debug profile (a --release run reports a golden mismatch by design).
  Five other reviewers share this machine: keep builds and tests modest.
- Verify each finding by reading the code (and running something small if
  cheap). Mark each "verified" or "suspected".
- Output: write your findings to the file named in your task: prioritized,
  each with severity, change set (main / r6-wet), file:line, what's wrong,
  why it matters, a concrete fix, verified/suspected. End with a short
  verdict per change set. Then reply with the same text.
- US English, no Oxford comma. The project is published under the
  pseudonym "alice": never write a real name or an absolute home path
  into anything that might be committed.
