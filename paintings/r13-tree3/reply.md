# The painter's last reply

(´▽`) I painted the study: an old pedunculate oak alone in a snowfield under a low overcast sky, whole from its root flare in a snow drift to the hairline twigs. The live lower crown is round, and the dead leader stands silver-gray above it with sawn-looking stubs, which fits Roloff's note that Friedrich's old oaks often have dead tops. The horizon crosses the lower trunk, the low viewpoint he drew from. It took about 33 minutes and is committed on `r13-tree3` in five commits, not pushed. No aged finish: the program ends with `o.end(...)` and `c.relief(...)`, no `Finish::aged`.

**Renders**
- Final: `out/r13_tree3_full.png` (2400 × 3000). A clean run from scratch takes 2 min 16 s, and 110 s of that is the sky.
- Earlier final kept as a fallback: `[local path redacted]
- Program: `paintings/src/bin/r13_tree3.rs`. Notes, log, friction and critique: `notes/r13_tree3.md`.

**How it's made**
- **I chose the tree's frame; a grower filled in the rest.** I set the trunk and five main limbs by hand, with their thicknesses following Leonardo's rule. A grower then adds the branching, the crooked zigzags and the dying back.
- **I checked the skeleton before painting.** The `TREE_PREVIEW` switch writes the bare skeleton in under a second. I compared 8 seeds and kept seed 104.
- **The tree is all brush gestures, no masks.** Limbs are strokes laid side by side along the wood, branches are one pointed round each and twigs are a pointed rigger lifted off at the bud. Bark, lichen, bud clusters and a few withered brown leaves are added by hand the same way.
- **The rest.** Snow sits only where the snow research says it would. The sky is thin paint with three stipple passes, and the tufts go in last, over the snow, as in the National Gallery report.

**Honest critique**
- The sky's cloud bands look regular, almost ruled, when you see the whole picture.
- The wood is nearly one color.
- The twigs are spread too evenly through the crown; a real old oak has clumps and gaps.
- The snowfield is empty.
- Some of the snow sits on limbs too steep to hold it.

**Top five friction points**
1. **Blunt brushes can't make a stroke that tapers.** A filbert's mark width barely changes with pressure (`0.45 + 0.55p` in `Tool::mark_width`), so limbs ended in round caps. Workaround: strokes that converge as the wood thins, and wood under 7 units handed to a pointed round (`point: 1.0`).
2. **There's no way to work a passage along a path.** `Handling` staggers strokes within masks, but plain drags across a limb banded into seams and gave the edges a row of bumps. Workaround: shuffled stroke order, breaks staggered per stroke and edge strokes that run the whole length.
3. **Checkpoints go stale for the wrong reason.** Editing the tree grower, which sits above `main`, made the 110 s sky checkpoint stale although the sky hadn't changed. Workaround: `--stale-ok --ckpt`, then a clean run for the final.
4. **The sky costs most of the render time.** It takes 110 s of each run, while about 30,000 tree strokes take under 10 s. So the sky got the fewest looks and is the weakest part.
5. **A masked passage shows a cut edge unless its color comes from its surroundings.** The first drift at the foot came out as a white box. Workaround: build its color from the snowfield's color and let it drift away only near the trunk.

The notes also cover two smaller ones: there's no in-engine skeleton or underdrawing preview, and small touches of mixed earth colors drift orange-straw.

The stage checkpoints in `out/*.ckpt` (gitignored) take about 5 GB of disk. I've left them in place; delete them if you don't need them.
