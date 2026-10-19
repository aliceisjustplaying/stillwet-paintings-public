# r12-tree1 session [local path redacted]

--- assistant 2026-09-25T17:01:54.045Z
Now the sky light is only a faint cool sheen on the lit side of the trunk and left limb, which models the wood gently. Final clean render from scratch, with no adopted checkpoints:

--- assistant 2026-09-25T17:04:25.776Z
The final render is done (a clean 136 s run). Last step: log the final round in the notes and commit.

--- assistant 2026-09-25T17:04:41.691Z
(´-ω-`) The study is finished: one old stag-headed oak standing alone in snow under a pale winter sky. It took about 40 minutes, and everything is committed on branch `r12-tree1` (not pushed).

**Files**
- Painting: `out/r12_tree1_full.png` (2400 px wide). The last version is a clean run from scratch with no checkpoints, in 136 s.
- Program: `paintings/src/bin/r12_tree1.rs`
- Notes: `notes/r12_tree1.md` (method, a log of 13 versions, critique and 11 friction points)
- The engine (`crates/paint`) is untouched.

**The painting.** A crooked, two-armed oak with a grey dead limb broken off at the right and a burl at the fork. The live crown ends in a haze of fine twigs. Snow lies along the tops of the level limbs and banks up against the foot on the windward side. The oak casts a soft shadow to the right. The sky is stippled, with a thin broken line of distant woods on a low horizon. Small details, added last as he did: a few of last year's brown leaves on low twigs, dry grass over the finished snow, the broken-off limb lying half buried and crows on the dead limb. The order of work follows the sources: warm ground, pencil drawing, thin stippled sky, then the tree over the dry sky, then details.

**Honest critique.** It reads as a Friedrich-like old oak, and the twigs look brushed at full size. But the crown is still too open for an old oak, closer to a wind-stripped tree than his dense twig network. The snow field is bland, the top of the sky is a very even gradient, and the crows and fallen branch look clumsy up close.

**Top five friction points**
1. **Growing the tree gives almost no control.** With the same settings, limb counts swing from 7 to 983 depending on the random seed. The "decline" setting is blunt: 0.32 gave a nearly dead 114-limb pole. You can't ask for a live lower crown with a dead top, or for a crown width. One crown ran 1,250 units wide on a 1,000-unit canvas. My workaround was a contact-sheet mode in my program to compare 12 seeds at a time and pick by eye.
2. **Checkpoints go stale too easily.** Any edit to a helper function below `main` invalidates every stage's checkpoint, including the sky's, which costs 2 minutes to repaint. I had to override with `--stale-ok` and check by hand that nothing earlier had changed, which is easy to get wrong.
3. **A stroke can't follow a width profile directly.** To make one stroke taper along a limb, I resampled the limb evenly and fed a pressure per point through the stroke's `swell` knots. Those are interpolated with a smoothstep, so the width goes slightly flat at each knot. There's also no way to ask for a brush that makes a mark of a given width.
4. **Checkpoints are 738 MB each** at this size, and `--ckpt` writes one for every stage, about 7 GB per run. I worked around it with small checkpoints of cropped regions.
5. **Tree roots lie flat on the ground** in the picture. They came out as dark boards on the snow instead of diving in. I shortened them and painted my own root flares, then buried them in a snow bank.

The other six (sparse crowns, no "up" direction on limbs, about 110 s of ground and sky on every full render, far woods that stayed a continuous band, drying that only works on the whole canvas, dry-brush that's hard to dose) are in the notes.
