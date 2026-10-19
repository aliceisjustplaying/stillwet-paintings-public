# r13-tree1 session [local path redacted]

--- assistant 2026-09-25T17:35:58.958Z
Stippled sky reads as paint now. The leaves came out as confetti, too many and too orange, so I'm cutting them back to a few hanging clusters.

--- assistant 2026-09-25T17:39:58.053Z
Painting's done. I'll run one clean whole render (no resume) in the background to confirm the final file, and finish the notes meanwhile.

--- assistant 2026-09-25T17:42:43.608Z
(´～`) I finished the study inside the budget, in about 50 minutes. It's an old, stag-headed oak standing alone in snow under a stippled gray winter sky.

**Renders**
- Final whole picture: `out/r13_tree1_full.png` (2400 × 3000), from a clean, non-resumed run: `wrote …/out/r13_tree1_full.png (2400px) in 136.1s`.
- Program: `paintings/src/bin/r13_tree1.rs`. Notes, method, friction and critique: `notes/r13_tree1.md`. Committed on `r13-tree1` (last commit `321280c`), not pushed.

**What the painting is.** The tree is a skeleton the program grows (`Tree::grow`, about 5,400 limbs). The rules come from `trees.md`:
- **Tapering:** each side limb takes its share of the parent's cross-section (`w^1.9 − wc^1.9`), so widths only ever fall outward.
- **Crooked oak habit:** the parent limb kinks away from each child it gives off.
- **Stag head:** the dead limbs break off thick, keep only stubs, and stand above the living crown.
- **Foot and bole:** buttress roots run into the snow, and the bole has burrs.

**How it's painted, in order:**
1. A graphite drawing of the tree.
2. A thin sky, blended and stippled twice.
3. Far woods and body-color snow.
4. The trunk as one area, stroked along the limb and lit like a cylinder, with bark fissures drawn into the wet paint.
5. Limbs with pointed rounds and twigs with a pointed rigger, each stroke pressed where the limb leaves its parent and lifted toward the tip.
6. A few of last year's brown leaves on low twigs, snow in bands on the flatter limbs, a drift at the foot, and grass and weed stalks flicked up last.
7. No varnish and no cracks.

**Weak spots** (the full critique is in the notes): the composition is safe and centered, the living crown is too even a haze, there's little snow on the limbs, the dead limbs wobble instead of breaking sharply, and the underdrawing doesn't show through at all.

**Top five friction points**
1. **Trees have no engine support.** I wrote about 300 lines of skeleton, spatial hash and capsule-distance code before the first mark. Painting the trunk *along* its limbs meant three separate per-pixel lookups of the same geometry: the mask, the `angle(|x,y|)` field and the `color(|x,y|)` field. A way to hand `work` a per-point frame (direction, position across the limb, width) once would help anything painted along a form.
2. **A handling can't take another brush.** There's no `.tool(t)` on `Handling`, so a 5-unit filbert for the trunk, or a 1.3 round for the far woods (the hatch preset's brush is 2.6), meant rebuilding the whole preset from `Handling::new` and copying its settings by hand.
3. **`Held.tool` is public, but the bristles are built in `Held::new`.** Assigning a new tool silently leaves bristles that don't match it. My workaround is a new `Held` per limb, picked from a set of brush sizes (`round_for`).
4. **Editing a helper function stales every checkpoint.** All the tree code lives after `main`, and the staleness model counts that for every stage. So every change to the tree staled the 2-minute sky. I used `--resume "sky light" --stale-ok` on every iteration, which is exactly the override the model is meant to prevent.
5. **Checkpoints and first tries.** A 2400 px checkpoint is 720–893 MB, about 8 GB for a full `--ckpt` run on a disk with 100 GB free; I deleted them at the end. Separately, every hand-placed detail came out regular on its first try: disk-shaped fork snow from `Touch`, arrowhead twig tips, confetti leaves, scalloped and snowball-shaped drift lumps, cotton-lump woods. The noise module has uneven spacing, but hand-placed drags and touches get no help with it, so each motif had to work it out again.
