You're back at the easel. The painting is as you left it. Your brief is in BRIEF.md and your journal in notes/journal.md.

## BRIEF.md

# Paint a picture

Compose and paint one original landscape in the manner of George Inness,
at the easel, a simulator of oil paint on linen. The place, subject and
composition are yours to invent. Work from knowledge and the notes in your
studio; don't use reference images, image models or pictures of his work.

## Your studio
- The folder [local path redacted] this brief, your notes and the easel.
- You paint at the easel: paint a chunk, look at the canvas, paint the
  next. Its tools are `paint`, `look`, `note`, `status` and `log`;
  notes/easel_guide.md explains them.
- There is no undo. To change a passage, paint over it, or lift wet
  paint off with a brush.
- You mix your own paint on the palette, from the tubes, in the
  proportions you choose.
- Time passes on the painting's own clock: every mark takes the time a
  hand takes, and `wait(minutes)` lets it rest, as long as you like; paint
  dries as that time passes. Real time between chunks doesn't count.

## The rules of the studio
- Paint shapes and marks, not computed pictures: don't encode an image in
  masks, amounts or proportions.
- Shapes are drawn, not copied: don't make a mask or stroke by mirroring
  or rotating another mask's or stroke's coordinates. A shape that mirrors
  another is drawn as its own shape, not as `m:at(x, 2*H - y)` or
  `m:at(W - x, y)`. Moving a shape and reusing your own helpers are fine.

## What to read
notes/easel_guide.md; notes/studio_notes.md;
notes/research/inness_materials.md (his materials and method) and
notes/research/oil_paint_physics.md as needed.

## Working
- You make every artistic decision.
- Look at your painting often, whole and close up.
- Keep a working journal with `note` as you go: your own working notes.
  You can revise them.
- Develop the painting until you judge it complete.

## Your reply
When you stop working, reply with the painting's title if you give it one
and a few sentences about the picture.

## Your journal (notes/journal.md)

Your own notes, quoted as you wrote them:

> - day 1, 09:00: Plan. A late-Inness evening: "meadow at the close of day". Canvas 30x45-ish (1140 mm, aspect 1.5), linen ~16x14, lead white knifed ground with a thin warm stain (raw sienna/raw umber/touch of red earth) as he did.
>   Composition (W 1000, H 667): horizon low ~y 420. Left: big group of oaks/elms x 60-430, crowns to ~y 110, soft edges dissolving into sky, a few sky-holes. Right of center: two slender young trees ~x 650-700 against the glow. Far: soft blue-violet hills on the horizon. Middle: meadow, warm light patch where low sun strikes, a small figure with a red note ~x 560 on a path. Lower right: a still pool taking the sky glow. Foreground: dark warm, scrubbed.
>   Values: sky light (glow near horizon right-center), trees dark, meadow mid with one light patch, foreground dark. Color: olive, gold, rose in the glow, blue-gray in the distance; one red accent.
>   Process: chalk lines -> thin transparent umber lay-in, rubbed, lights wiped -> sky opaque, blended -> distance -> tree masses, edges lost -> meadow -> pool -> figure, trunks -> dry -> glazes and scumbles to unify.
> - day 4, 14:42: Day 4 afternoon, after first opaque campaign. Stain + umber lay-in came out fine. Sky laid in three bands and blended: reads pale, too even, a bit cold. Tree group: first pass blended into a uniform light olive (blender over loaded clumps kills the dark); restated shadows as crescents under each clump. Still reads as one round bush - needs a broken, taller silhouette, sky holes, trunks, ground showing under it, warmer darks. Meadow is a flat olive; pool too white and large. Let it all dry overnight and go back over dry paint (scumble/glaze/drag), as Inness did.
> - day 10, 13:23: Day 10. Trouble: holes and the gap under the right tree came out as clean pasted shapes, too white; the tree group still reads as a dome-bush with a flat dark cap. Sky is flat, cool and banded. Plan: repaint the whole sky wet, warmer and more varied (violet-gray cloud above, rose-gray bank, a lemon-cream glow right of center), carrying it into the tree's edges and opening a notch between the crowns and gaps under the canopy; then while the sky is open stipple foliage edges into it so they fuse and get lost, the way his trees dissolve in the air.
> - day 10, 16:20: Day 10 evening. Repainted sky warmer (gray-violet top, rose-gray middle, cream left, lemon glow right) - better. Big tree group now one dark soft-edged silhouette against it: much more like him, but flat inside and floating on the horizon with no base or trunks. Slender trees on the right: stippled foliage looked like dots; blending with a mask grown 4 made clean round cotton-ball shapes, milky from sky lifted in. Must rework them: irregular, darker, lacy, sky cut back in. Hill band is a flat lilac stripe - break it. Foreground is a monotonous rust band. Next session over dry paint.
> - day 22, 07:06: Day 22, mistake: scumbled warm/olive lights into the big tree (white in the mix -> opaque light blotches), then blended -> the blender spread the light film over the whole dark interior. Rag-lifting with a wiped flat only half-cleared it and left rectangles. Lesson: never blend a light scumble over a dry dark; lights in the trees go on last, small, not blended. Plan: let the film dry, then repaint the tree mass dark with foliage-shaped strokes, letting a little of the olive show as internal variation.
> - day 23, 11:26: Day 23. Repainting the patch of sky around the slim trees: a rectangle of sky color painted over a dry sky shows as a pasted panel (mask edge, note 48). Fixed by repainting the WHOLE sky wet in one session (s1-s4 bands, blended), and the crown halos went with it. Then feathered all tree edges with small filbert-5 leaf strokes into the wet sky, plus a soft blender at very light pressure: big tree now reads as foliage against the air. Slim trees read as young elms/poplars. Next: trunks pale where they crossed wet sky - restate when set. Hill band flat lilac stripe - break. Meadow, pool, foreground all need real work. The base "hedge" under the big trees reads as a wall.
> - day 30, 15:04: Day 30. Horizon went badly: pale hill mix far too chalky; then a cobalt glaze came out streaky, and blending a rect that held both the wet glaze and the wet near ridge dragged the dark ridge paint up into the sky -> a dark band with a ruled top. Lessons: (1) never blend a mask that contains two different wet passages of different value; (2) piles with lead white 2+ parts come out much paler than I expect - test the value small first; (3) don't fix wet mistakes wet. Plan: wait till dry, repaint sky strip y~350-402 with s4 (same pile as the dry glow, so seam vanishes), then hills wet into it with a mid-value violet, then ridge with tree-top lumps after.
> - day 40, 16:10: Day 40, stepping back. State: sky has seams/patches from local repairs (y 300-400 right half); slim-tree crowns float (sky strip covered their trunks), small tree has a cobalt skirt; horizon is a heavy dark hedge band right across; meadow flat yellow, pool a white blob, foreground rust band. Decided: stop patching. Light is contre-jour (sun low behind the slim trees), so: (1) one full wet sky repaint around the dry trees, feather tree edges into it, hills wet-in-wet in same sitting; (2) one full meadow session: lit far strip, mid meadow darker/cooler in backlight with long shadows of the slim trees running toward us, pool as a narrow gleam, foreground dark warm, all wet together; (3) trunks, figure with red note, accents; (4) unifying glazes and scumbles.
> - day 48, 23:25: Day 48. Another wet disaster on the horizon: distant tree-line pile (white 0.9 of ~4 parts) came out pale lilac-gray, lighter than the hills; lifting it with a wiped flat in vertical passes left a ribbed "fence" and erased the trunk bases. RULES now: test every new pile with one small stroke and look before a pass; for darks near the horizon use NO or only a trace of lead white; never lift by striping - leave it to dry and paint over.
> - day 59, 00:12: Day 59. Ridge glazed and blended: now a soft blue-gray wood-line, reads as distance. Trunks restated with a pointed round, dark, they hold. Remaining big faults: (1) hedge band under big trees is a hard rectangle with a vertical right end; (2) its cast shadow on the meadow has a hard scalloped edge and cut-off right end; (3) meadow mustard, too saturated; (4) pool a white blob; (5) foreground band dull; (6) no figure yet. Next session, over dry paint: rework the shadow zone + hedge base together wet, graded, long horizontal strokes, edges lost.
> - day 62, 01:51: Day 62. Meadow repainted wet as one session: lit field, tree shadow, dark foreground, then blended with a badger: it has turned into a soft misty field, much more Inness than the earlier flat mustard. But: soft filbert "blend" across the slim-tree shadows LIFTED the paint and left a pale cut-out shape; repainted; then a rect blend left a vertical seam at x=560; a soft-edged blend over the seam fixed it. Rule: blend masks must be soft (soften 30-40) where they end inside a wet field. Tree shadows lost - put back later as thin glazes over dry. Next: hedge rectangle under the big trees (vertical right end x~545).
> - day 68, 02:22: Day 68. Again: "haze" pile (white 3 : ochre 0.8, medium .35) laid as opaque cream band. Lifted by horizontal clean-flat passes -> pale ticks at stroke joints, like a fence. Must stop testing on the canvas edge and then going straight to a broad pass: a scumble of lead-white mix is OPAQUE here at any load. For atmospheric veils use glaze hand with medium 0.8+, little white. Will repaint the far field strip when dry.
> - day 77, 03:49: Day 77. Cloud bank attempt: scumbled flat mauve shape, then badger-blended into a broad warm-gray upper sky - looks good, atmospheric, the hard rect left edge fixed by a soft blend. Cost: blender veiled the leaf fringe of the big trees gray. Warm sienna glaze in the tree interior blended into soft warm variation - good. To do: restate leaf fringe; reduce fence-post trunks; figure (red note) ~x560 y505; maybe a sliver of water; shadows of slim trees as thin glazes; foreground interest; final warm glaze.
> - day 82, 05:14: Day 82. Tree group now sits on the ground: whole under-canopy painted deep shade with one window of far light; trunks only hinted. Reads as a grove at last. Next: figure + red note, thin glazed shadows of the slim trees, grass texture to break the hard straight base of the grove, a small sky-gleam of water lower right, foreground scrubbed with warm accents, cover test smudge at lower right.
> - day 88, 06:23: Day 88. Slim-tree shadow glazes came out as crisp leaf shapes; a badger over them (on dry meadow) left PALE ribbons, lighter than the meadow, and ate the trunk feet. A thinly spread medium-rich glaze reads lighter than bare dry paint here. Foreground: broad fgD + rust/dark scumbles, then badger in 4 directions -> warm, soft brown band, good. Next: when dry, repaint the lit meadow right half wet (mLit), with shadows as soft dark horizontal strokes wet-into-wet, no blender; restate trunk feet.
> - day 92, 06:40: Day 92. The meadow-right badger mask reached up over the grove's foot (x 520-640) and down into the foreground: the light field now swallows the grove's base corner and makes a hard vertical seam with the shadow at x~530, and the whole lower-right is a flat yellow. Plan when dry: one final meadow session, the whole width, value graded (far gold strip -> mid olive -> dark warm foreground), the grove shadow diagonal; masks start BELOW the grove base line; restore grove foot afterward with foliage strokes.
> - day 101, 07:39: Day 101. Big change for the better: whole meadow repainted wet in one sitting (lit side gold-olive grading down to warm dark, grove shadow diagonal, foreground), badgered; the grove's long shadow lying over the field toward us now holds the picture together. Slim trees given trunks to their feet; their shadows softened to haze. Now the endgame: (1) figure with a red note at the light/shadow edge ~x 590 y 500; (2) a few lit touches: grass tips at shadow edge, grove's right flank catching light; (3) the hedge-like base band of the grove (y 440-475) still too even - break it; (4) warm glaze over lower foreground, maybe a cool veil in the shadow; (5) sky: upper left is fine; a trace of rose near the glow.
> - day 105, 08:03: Day 105. Two more blunders in the meadow: a scumble of mLitG with load 0.3 laid opaque cream lozenges; then covering them with a body pass using edge="lost" ran strokes 40+ units past the zone — over the figure, the grove's foot and the far gold strip. Rule: for any pass near something to keep, use clip= a soft mask, never edge="lost". Repainting the right meadow wet now, clipped.
> - day 105, 08:38: Day 105 later. Local repairs keep making seams (vertical edges at x~415-480, a lozenge of light at the grove foot). Only whole-area wet sessions have worked (day 45 sky, day 97 meadow). Decision: when dry, redo the day-97 meadow recipe over the full width in one sitting (same piles, same shadow geometry), badger it whole, then restate the grove foot as dark foliage, then the figure. No more local patching of the meadow.
> - day 123, 11:11: Day 123. Figure placed (red shawl, dark skirt) at x606 y506, right at the shadow's edge with a short cast shadow: the single warm note is where it should be. The grove's shadow now carried down to the foreground and softened: the left half is one big dark L. Final passes planned: (a) warm reflected-light variations in the shadow field (thin scumble, then badger), (b) a few warm-gold touches on the grove's sun-side flank and the slim crowns' right edges, (c) foreground grass accents, (d) overall unifying warm glaze, very thin, lower half.
> - day 136, 14:17: Day 136. folO (white 0.9 of ~4.3 parts) laid in a "rim" band came out as an opaque pale khaki crescent on each slim crown. Lifted most of it wet with a clean, wiped filbert, short random strokes; left a lighter ring. And again: every pile with more than a trace of white reads much paler than expected once laid with fill=true. Next, when dry: retest folM small; repaint slim crowns whole (not rims) with leaf strokes, dark on the left/inner side, a mid olive on the right side, and a few, very few, gold leaves.
> - day 146, 19:40: Day 146. Glazed the under-canopy band deep and badgered: the grove interior now reads as one dark, the base-band "hedge" is gone, the window survives as one small glimpse of far light. Lifted the gray smudge in the sky right of the grove. Remaining: left edge of grove has bare light-ground speckles (outer leaves vs sky ok); sky near grove top-left fine. I think the picture is nearly there. Last: unify with very thin warm glaze over lower half? Check with squint first.
> - day 149, 21:24: Day 149. Calling it finished. It reads as late Inness, more or less: a dark grove held against a warm, misty evening sky, its long shadow lying over the meadow toward us, three young trees backlit by the glow, a far blue ridge, and one small figure with a red shawl right at the edge of light and shade. What's still wrong: the slim crowns are too crisp and round, the far gold strip is a little too insistent, and the grove's leaf fringe on the left is cut out against the sky. I'm not going to push these. Every local fix on dry paint here has left a seam. Lessons for next time: test values small first; a lead-white mixture is opaque at any load; only whole-area wet sessions and soft-edged badger passes have worked; clip everything near what must be kept.
> - day 165, 02:55: Day 165. A last session on the two faults I'd listed. Slim crowns: redrawn as three new outlined masks (C1, C2, C3), with a split between the two tall ones and a third, smaller crown lower on the right, so they no longer read as one round blob. Repainted with leaf strokes radiating from each tree's base, warm olive (slimA) on the sun side, dark (slimB/cDk) in clusters, a medium-rich fringe (slimEdgeB), and a very light badger only at the edges. The sky-gap line between the middle and small crowns came out pale twice: lifted with short random rag-strokes, then filled with dark leaves. Grove's left edge: lifted a light scumble that went wrong (s3 laid opaque again), then a dark leaf fringe with halftone leaves outside it. Trunks restated thicker with a filbert, dark, down to their feet. Gold strip: two glaze tests both read as grey bars, lifted. I'm leaving the strip as it is. The tiny test ghosts at the left edge are covered as well as they'll go. Finished.

## Your globals

(the 150 most recently assigned of 196)
- `holes`: table with 0 entries
- `under`: mask(8501 sq units)
- `openings`: mask(21157 sq units)
- `skyR`: mask(292532 sq units)
- `treeAll`: mask(133270 sq units)
- `sA`: pile(lead white 5, cobalt blue 0.8, red earth 0.25, raw umber 0.25, yellow ochre 0.3; medium 0.12)
- `sB`: pile(lead white 6, red earth 0.32, cobalt blue 0.45, yellow ochre 0.5, raw umber 0.12; medium 0.12)
- `sC`: pile(lead white 10, yellow ochre 0.6, lemon chrome 0.35, red earth 0.05; medium 0.1)
- `sD`: pile(lead white 10, lemon chrome 1.3, cadmium yellow 0.3, orange chrome 0.12; medium 0.1)
- `sE`: pile(lead white 8, yellow ochre 0.8, orange chrome 0.15, red earth 0.12; medium 0.1)
- `farWoods`: pile(lead white 2.5, cobalt blue 0.8, raw umber 0.6, bone black 0.15, yellow ochre 0.4, red earth 0.15; medium 0.1)
- `tEdge`: pile(raw umber 2, Antwerp blue 0.45, yellow ochre 1, lead white 0.9, bone black 0.15; medium 0.12)
- `treeBody`: mask(119774 sq units)
- `treeOuter`: mask(145963 sq units)
- `tMass`: pile(raw umber 2, Antwerp blue 0.55, yellow ochre 0.7, bone black 0.3, raw sienna 0.5; medium 0.15)
- `rig`: brush(rigger 3.2, 134% full)
- `trunkP`: pile(raw umber 2, bone black 0.6, Antwerp blue 0.15, lead white 0.25; medium 0.2)
- `fol`: pile(raw umber 1.6, lead white 1, Antwerp blue 0.35, yellow ochre 0.9, bone black 0.12; medium 0.15)
- `folD`: pile(raw umber 2, Antwerp blue 0.45, yellow ochre 0.6, bone black 0.3, lead white 0.3; medium 0.15)
- `slimF`: mask(22943 sq units)
- `folClumps`: mask(11228 sq units)
- `folM`: pile(raw umber 2, Antwerp blue 0.4, yellow ochre 1, bone black 0.2, lead white 0.5, raw sienna 0.3; medium 0.15)
- `slimCrown`: mask(27865 sq units)
- `tr`: pile(raw umber 2, bone black 0.5, red earth 0.15, lead white 0.2; medium 0.15)
- `wl`: pile(raw umber 1.6, Antwerp blue 0.45, bone black 0.2, lead white 0.9, yellow ochre 0.4, red earth 0.1; medium 0.12)
- `shadeBase`: pile(raw umber 2, Antwerp blue 0.5, bone black 0.35, yellow ochre 0.5, raw sienna 0.3; medium 0.1)
- `underBase`: mask(23512 sq units)
- `trD`: pile(raw umber 1.5, bone black 0.8, Antwerp blue 0.1; medium 0.15)
- `cloudRose`: pile(lead white 6, red earth 0.35, yellow ochre 0.5, orange chrome 0.08, cobalt blue 0.12; medium 0.15)
- `cloudV`: pile(lead white 4, cobalt blue 0.7, red earth 0.35, raw umber 0.3, yellow ochre 0.2; medium 0.2)
- `tOlive`: pile(yellow ochre 1.4, raw umber 0.8, Antwerp blue 0.3, lead white 0.9, raw sienna 0.4; medium 0.2)
- `tWarm`: pile(raw sienna 1.2, raw umber 1, yellow ochre 0.8, Antwerp blue 0.25, lead white 0.5; medium 0.2)
- `glzTree`: pile(raw umber 1.5, Antwerp blue 0.35, yellow ochre 0.6, bone black 0.15; medium 0.7)
- `folO`: pile(raw umber 1.6, Antwerp blue 0.35, yellow ochre 1, lead white 0.9, bone black 0.12, raw sienna 0.3; medium 0.15)
- `slim2`: mask(23651 sq units)
- `crowns`: mask(20529 sq units)
- `s1`: pile(lead white 5, cobalt blue 0.85, red earth 0.22, raw umber 0.28, yellow ochre 0.25; medium 0.12)
- `s2`: pile(lead white 7, red earth 0.3, cobalt blue 0.35, yellow ochre 0.6, raw umber 0.08; medium 0.12)
- `s3`: pile(lead white 10, yellow ochre 0.7, lemon chrome 0.4, red earth 0.08, cobalt blue 0.05; medium 0.1)
- `s4`: pile(lead white 10, lemon chrome 1.4, cadmium yellow 0.3, orange chrome 0.15; medium 0.1)
- `skyAll`: mask(251400 sq units)
- `skyLine`: table with 20 entries
- `treeKeep`: mask(139424 sq units)
- `hFar`: pile(lead white 5, cobalt blue 0.8, red earth 0.3, yellow ochre 0.35, bone black 0.08; medium 0.12)
- `hNear`: pile(lead white 2.2, cobalt blue 0.7, raw umber 0.6, red earth 0.2, yellow ochre 0.4, bone black 0.12; medium 0.12)
- `hFar2`: pile(lead white 2.5, cobalt blue 1, red earth 0.35, bone black 0.1, yellow ochre 0.15; medium 0.1)
- `hNear2`: pile(lead white 0.8, cobalt blue 0.8, raw umber 0.9, bone black 0.2, yellow ochre 0.35; medium 0.1)
- `glzHill`: pile(cobalt blue 1, red earth 0.3, raw umber 0.25; medium 0.85)
- `hNear3`: pile(lead white 0.35, cobalt blue 0.6, raw umber 1, bone black 0.25, yellow ochre 0.45, Antwerp blue 0.12; medium 0.1)
- `hA`: pile(lead white 1.2, cobalt blue 1, red earth 0.35, raw umber 0.4, yellow ochre 0.2; medium 0.1)
- `hB`: pile(lead white 1.8, cobalt blue 1, red earth 0.4, raw umber 0.25, yellow ochre 0.3; medium 0.1)
- `stripSky`: mask(20394 sq units)
- `farHills`: mask(10639 sq units)
- `hA2`: pile(lead white 1.2, cobalt blue 1.15, red earth 0.4, raw umber 0.35, yellow ochre 0.15; medium 0.1)
- `hillShape`: mask(18325 sq units)
- `hillCurve`: table with 15 entries
- `hNear4`: pile(lead white 0.5, cobalt blue 0.7, raw umber 1, bone black 0.2, yellow ochre 0.4, red earth 0.1; medium 0.1)
- `ridgeCurve`: table with 42 entries
- `ridgeM`: mask(12861 sq units)
- `glzRidge`: pile(raw umber 1.4, Antwerp blue 0.4, bone black 0.3, yellow ochre 0.3; medium 0.75)
- `skyAll2`: mask(265575 sq units)
- `skyLine2`: table with 7 entries
- `treeKeep2`: mask(139424 sq units)
- `hillsF`: mask(15382 sq units)
- `G`: mask(244647 sq units)
- `fgD`: pile(raw umber 2, raw sienna 0.9, bone black 0.3, yellow ochre 0.5, Antwerp blue 0.15, red earth 0.12; medium 0.12)
- `groundLine`: table with 8 entries
- `mFar`: pile(yellow ochre 2, raw sienna 0.8, lemon chrome 0.35, lead white 0.9, Antwerp blue 0.06; medium 0.1)
- `mOl`: pile(yellow ochre 1.6, raw umber 1, raw sienna 0.7, Antwerp blue 0.22, lead white 0.35; medium 0.1)
- `mSh`: pile(raw umber 2, Antwerp blue 0.35, yellow ochre 0.8, bone black 0.2, raw sienna 0.3; medium 0.1)
- `poolN`: mask(3944 sq units)
- `shStreak`: pile(raw umber 2, Antwerp blue 0.4, bone black 0.25, yellow ochre 0.5; medium 0.15)
- `treeShadow`: mask(51512 sq units)
- `baseM2`: mask(23146 sq units)
- `win1`: mask(1505 sq units)
- `win2`: mask(805 sq units)
- `trunkS`: pile(raw umber 1.6, bone black 0.6, Antwerp blue 0.15, lead white 0.35, red earth 0.1; medium 0.15)
- `distT`: pile(lead white 0.9, cobalt blue 0.8, raw umber 0.8, red earth 0.25, yellow ochre 0.3, bone black 0.1; medium 0.12)
- `dT1`: pile(cobalt blue 1, raw umber 0.7, red earth 0.2, lead white 0.25, yellow ochre 0.15; medium 0.1)
- `dT2`: pile(cobalt blue 1, raw umber 0.5, red earth 0.25, lead white 0.6, yellow ochre 0.2; medium 0.1)
- `fieldFar`: pile(yellow ochre 2, raw sienna 0.6, lead white 1, raw umber 0.3, red earth 0.1; medium 0.1)
- `ridge2`: mask(7468 sq units)
- `glzR`: pile(raw umber 1, cobalt blue 0.8, bone black 0.15, red earth 0.15; medium 0.8)
- `mDeep`: pile(raw umber 2, Antwerp blue 0.4, bone black 0.3, yellow ochre 0.5, red earth 0.1; medium 0.1)
- `mHalf`: pile(raw umber 1.2, yellow ochre 1.2, Antwerp blue 0.3, lead white 0.2, bone black 0.08; medium 0.1)
- `mLit`: pile(yellow ochre 1.5, Antwerp blue 0.22, raw umber 0.5, lead white 0.6, lemon chrome 0.25; medium 0.1)
- `mLit2`: pile(yellow ochre 1.5, raw sienna 0.5, lead white 1, lemon chrome 0.3, Antwerp blue 0.08; medium 0.1)
- `M`: mask(234869 sq units)
- `shadowZ`: mask(71526 sq units)
- `bushR`: mask(6638 sq units)
- `glzCrown`: pile(raw umber 1.5, Antwerp blue 0.4, yellow ochre 0.5, bone black 0.2; medium 0.7)
- `haze`: pile(lead white 3, yellow ochre 0.8, cobalt blue 0.15, red earth 0.05; medium 0.35)
- `glzWarm`: pile(raw sienna 1, red earth 0.25, raw umber 0.3; medium 0.85)
- `cT1`: pile(lead white 4, cobalt blue 0.5, red earth 0.3, raw umber 0.25, yellow ochre 0.2; medium 0.3)
- `cT2`: pile(lead white 5, red earth 0.35, orange chrome 0.15, yellow ochre 0.4; medium 0.3)
- `cV`: pile(lead white 3, cobalt blue 0.6, red earth 0.35, raw umber 0.4, yellow ochre 0.15; medium 0.3)
- `cloudBank`: mask(62307 sq units)
- `underDk`: pile(raw umber 2, Antwerp blue 0.45, bone black 0.35, yellow ochre 0.45, raw sienna 0.3; medium 0.12)
- `winA`: mask(2625 sq units)
- `trFaint`: pile(raw umber 2, bone black 0.3, red earth 0.2, lead white 0.35, yellow ochre 0.2; medium 0.15)
- `trHint`: pile(raw umber 1.5, bone black 0.6, Antwerp blue 0.1; medium 0.15)
- `grassSh`: pile(raw umber 1.6, Antwerp blue 0.3, yellow ochre 0.9, bone black 0.15, raw sienna 0.3; medium 0.15)
- `shGlz`: pile(raw umber 1.5, Antwerp blue 0.3, bone black 0.2, yellow ochre 0.3; medium 0.8)
- `footR`: mask(5972 sq units)
- `mLitB`: pile(yellow ochre 1.5, raw umber 0.55, Antwerp blue 0.16, lead white 0.7, red earth 0.06; medium 0.1)
- `mMidB`: pile(yellow ochre 1.2, raw umber 1, Antwerp blue 0.25, lead white 0.35, bone black 0.05; medium 0.1)
- `mLitG`: pile(yellow ochre 1.5, raw umber 0.4, Antwerp blue 0.18, lead white 0.7, lemon chrome 0.12; medium 0.1)
- `meadowB`: mask(201900 sq units)
- `baseBand`: mask(29783 sq units)
- `headM`: mask(19 sq units)
- `headP`: pile(raw umber 1, red earth 0.3, lead white 0.6, yellow ochre 0.3; medium 0.1)
- `redP`: pile(red earth 1, Indian red 0.4, orange chrome 0.35, lead white 0.15; medium 0.1)
- `shawlM`: mask(114 sq units)
- `skirtM`: mask(146 sq units)
- `skirtP`: pile(raw umber 1.5, bone black 0.5, Antwerp blue 0.2, lead white 0.2; medium 0.1)
- `sunP`: pile(lead white 10, lemon chrome 0.9, cadmium yellow 0.15, orange chrome 0.05; medium 0.15)
- `fgGlz`: pile(raw sienna 1, raw umber 0.8, red earth 0.15; medium 0.85)
- `meadowC`: mask(200955 sq units)
- `groveFoot`: mask(8570 sq units)
- `mMix`: pile(yellow ochre 1.35, raw umber 0.72, Antwerp blue 0.21, lead white 0.5, lemon chrome 0.06; medium 0.1)
- `mMix2`: pile(yellow ochre 1.5, raw umber 0.62, Antwerp blue 0.18, lead white 0.55, lemon chrome 0.12; medium 0.1)
- `mMix3`: pile(yellow ochre 1.5, raw umber 0.5, Antwerp blue 0.17, lead white 0.65, lemon chrome 0.14; medium 0.1)
- `LR`: mask(47258 sq units)
- `goldTouch`: pile(yellow ochre 1.5, raw sienna 0.6, lead white 0.5, lemon chrome 0.2, raw umber 0.2; medium 0.15)
- `wSh`: pile(raw sienna 1, raw umber 1, yellow ochre 0.5, Antwerp blue 0.08, red earth 0.08; medium 0.3)
- `glzOl`: pile(raw umber 1.2, Antwerp blue 0.4, yellow ochre 0.3, bone black 0.25; medium 0.75)
- `cDk`: pile(raw umber 2, Antwerp blue 0.5, yellow ochre 0.6, bone black 0.3; medium 0.15)
- `cMid`: pile(raw umber 1.6, Antwerp blue 0.35, yellow ochre 1.1, bone black 0.1, lead white 0.25, raw sienna 0.3; medium 0.15)
- `sh2`: pile(raw umber 1.6, Antwerp blue 0.3, yellow ochre 1, bone black 0.12, raw sienna 0.35, lead white 0.12; medium 0.15)
- `glzDeep`: pile(raw umber 1.2, Antwerp blue 0.35, bone black 0.35, yellow ochre 0.2; medium 0.75)
- `winGlz`: pile(raw umber 1, raw sienna 0.6, Antwerp blue 0.1; medium 0.85)
- `slimDk`: pile(raw umber 1.8, Antwerp blue 0.4, yellow ochre 0.9, bone black 0.15, raw sienna 0.3, lead white 0.15; medium 0.15)
- `slimEdge`: pile(raw umber 1.6, Antwerp blue 0.35, yellow ochre 0.8, bone black 0.12, raw sienna 0.3; medium 0.55)
- `slimMd`: pile(raw umber 1.6, Antwerp blue 0.3, yellow ochre 1.1, bone black 0.1, raw sienna 0.4, lead white 0.3; medium 0.15)
- `slimA`: pile(raw umber 1.8, Antwerp blue 0.4, yellow ochre 1, bone black 0.15, raw sienna 0.4; medium 0.15)
- `slimB`: pile(raw umber 2, Antwerp blue 0.45, yellow ochre 0.7, bone black 0.25, raw sienna 0.3; medium 0.15)
- `C1`: mask(14708 sq units)
- `C2`: mask(12562 sq units)
- `C3`: mask(4236 sq units)
- `CN`: mask(31243 sq units)
- `c1o`: outline(1 line(s), closed, length 587, 41 strokes, 0 corners, scale 167)
- `c2o`: outline(1 line(s), closed, length 543, 38 strokes, 0 corners, scale 160)
- `c3o`: outline(1 line(s), closed, length 321, 31 strokes, 0 corners, scale 102)
- `CNp`: mask(31075 sq units)
- `slit`: mask(280 sq units)
- `slimEdgeB`: pile(raw umber 2, Antwerp blue 0.45, yellow ochre 0.7, bone black 0.2, raw sienna 0.3; medium 0.4)
- `skC`: pile(lead white 10, yellow ochre 0.75, lemon chrome 0.35, red earth 0.1, cobalt blue 0.06, raw umber 0.08; medium 0.1)
- `skW`: pile(lead white 10, lemon chrome 1.1, cadmium yellow 0.2, orange chrome 0.1, yellow ochre 0.3, raw umber 0.06; medium 0.1)
- `tHalf`: pile(raw umber 1.5, yellow ochre 0.9, Antwerp blue 0.3, lead white 0.35, bone black 0.1, raw sienna 0.2; medium 0.25)
- `glzStrip`: pile(raw umber 1, Antwerp blue 0.25, cobalt blue 0.3, red earth 0.1; medium 0.8)

## The canvas clock

- Latest journal entry stamped: day 165, 02:55

## The canvas

The whole canvas as it was when this was written: paint-studio-33a5bf/out/easel/painting/1ecc4e33-b97c-489a-a297-380c1ea583b7.png