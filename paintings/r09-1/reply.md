# The painter's last reply

(^‿^) The painting is finished, committed on branch r9-arm1 and not pushed. It took about 60 minutes, and I closed the easel session afterward.

**Title:** *Winter Evening with Pollard Willows*

It's a flat, snowy lowland just after sunset. A frozen brook winds out of the lower left past a row of pollard willows that shrink toward a far village and its church spire. A big, old, split willow at the right is cut off by the top edge, with crows in its rods. A man in a greatcoat and tall hat walks toward the church, leaving footprints. The sky runs from slate blue down to a lemon afterglow, with a thin crescent moon, and there are dry reeds along the brook. I painted it at the Lua easel with `EASEL_WITHOUT=procedural`; `world` and `tree` were nil in the session. Every motif is a hand-written function: the willows, their rods and whips, the bark, the walker, the crows, the grass tufts and the footprints. Perspective sizes were worked out by hand (1 m = (y − horizon)/1.7 units).

**Files:**
- Source: `paintings/lua/winter_willows.lua` (22 chunks; the 3200px replay takes about 200 s)
- `notes/round9/arm1/painting_1000.png` (1000×714, from `easel save`)
- `notes/round9/arm1/painting_3200.png` (3200×2286, from `easel run --width 3200` on that exact log)
- `notes/round9/arm1/notes.md`: the composition and its Friedrich sources, the method in 13 stages, 17 friction items

**Top five friction points:**
1. **Glazes cross the motifs.** With the depth tools gone, nothing keeps a glaze "behind the trees." The land glaze drew a horizon line across the dark trunks, and a rectangle glaze left visible dark boxes over the rods. The fix was glazing the trunks and walker at one even strength along their whole height.
2. **Snow added later never matched the field.** The drifts over the trunk feet came out first as a pale oval, then a blue puddle, then pale rectangles (the `rect()` clip left straight sides). Other causes: part of the drift missed the glaze because it sat inside the trunk mask, and new opaque paint lies smoother than the textured, glazed field. What worked was the painter's move: fill below an irregular snow line with paint sampled from the field beside the trunk, then drag single strokes across.
3. **Dark paint over light dries into slivers.** The one-coat trunks looked solid while wet. After `dry()` the snow showed through in rows of horizontal light slivers, which look like a glitch; the plain look before drying gave no hint. A second coat after drying fixed it.
4. **Thin dark strokes go golden.** Riggers loaded with dark umber-gray came out golden and see-through over the snow and sky. The same thin paint riding the canvas weave made the finest whips dashed. The fixes were aiming the load at the look over what's there (`{at=, coats=}`) and adding `{medium=0.4}` to the whips.
5. **Lost edges reach into neighbors.** A lost edge on a broad filbert runs about two brush widths past its region and picks up wet paint there. The first wind-drift pass laid light bands straight across two trunks, so the trunk masks had to be grown by 10 units before subtracting them.

**What still looks digital, judged harshly:**
- The body snow's stroke ridges, lit by the default relief, look embossed across the whole field at 3200px. I left Alice's default in place.
- The trunks are flat dark shapes with little modeling.
- The 1000px render still has faint specks at the willow feet that the 3200px render doesn't.
