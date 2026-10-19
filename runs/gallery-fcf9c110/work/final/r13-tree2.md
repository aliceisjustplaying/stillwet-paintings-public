# r13-tree2 session [local path redacted]

--- assistant 2026-09-25T17:45:00.199Z
The joins are cleaner. Last look at the whole before I write the critique.

--- assistant 2026-09-25T17:45:26.208Z
I'm happy with this as a study. Finishing the notes with the critique, then committing.

--- assistant 2026-09-25T17:45:42.019Z
(◕‿◕) I've finished the study: an old pedunculate oak alone on a low rise of snow under a pale overcast sky, rendered at 2400 × 3000 px.

**Files**
- Render: `out/r13_tree2_full.png`
- Program: `paintings/src/bin/r13_tree2.rs`
- Notes: `notes/r13_tree2.md` (method, 12 friction points, critique)
- Four commits on `r13-tree2`, the last `434d60b`. Nothing pushed.

The final render came from resuming the "snow" checkpoint with unchanged code, which the README says is exact. The last complete from-scratch run was just before two small late-stage changes (the drift's cool face and where branch strokes start).

**The tree**
- **Stag-headed:** a pale dead leader and a broken dead limb stand above a living crown that stops short of them.
- **Old damage:** a sawn-looking stump with a pale cut face and rings, and a hollow with rolled lips on the trunk.
- **The twigs:** about 19,000 pointed strokes that lift off at the tips (the log printed "18961 twigs").
- **Snow:** wet snow lies along the tops of the near-level limbs and in lumps in the main fork, with a drift at the foot.
- **Small things last:** a few brown dead leaves on low twigs, dry grass through the snow and a fallen branch.

The trunk and seven main limbs are placed by hand. Everything finer grows from them by rule: branches thin by cross-section at every fork (Leonardo's rule) and kink at each fork, as oaks do (`notes/research/trees.md` §1–2). The order follows the sources: pencil underdrawing, sky, snow, then the tree over the finished sky.

**Weaknesses (full critique in the notes):** the crown is too even a dome, and the main limbs are smooth curves where they should be gnarled. The snowfield is nearly empty. The main fork is a crossing of strokes, not a real junction.

**Top five friction points**
1. **A crackle net that looked like craquelure.** Light strokes from a soft brush at low pressure touched only the peaks of the knife-textured ground, leaving dark underpaint in a network. It stayed with relief lighting off, so it's color, not lighting. There's no way to see what one pass laid, so I added my own debug switches (`NORELIEF`, `SKIPF`, `SKIPL`) and ran four crop renders to find it. The fix was drying the underpaint first, full brush loads, filberts and a pressure floor of 0.45.
2. **Checkpoints go stale by position in the file, not by what a stage uses.** The tree code sits above `main` and the pencil stage uses it, so every tree edit made even the sky checkpoint stale. I worked with `--resume snow --stale-ok` throughout.
3. **Slow pencil stage and huge checkpoints.** The underdrawing, only about 20 pencil lines, took 43–48 s at 2400 px. Each checkpoint is 720–890 MB, over 6 GB per `--ckpt` run on a disk at 86%, so I deleted them by hand.
4. **No way to give a stroke a width at each point.** I converted widths to pressures myself with `Tool::pressure_for` and fed them as `swell` knots, which are spaced evenly along the stroke rather than at my points.
5. **Shape masks have no soft or open edges.** `Shape::ribbon` puts a round cap at every point, which twice left a large disc under the ground. `Mask::from_shape` has no soft edge, so a drift filled through it came out a hard white slab. I rebuilt the trunk as an outline polygon and painted the drift as rows of strokes that follow its surface.
