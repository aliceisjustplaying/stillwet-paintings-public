# The painter's last reply

(◕‿◕) The painting is done: **Winter Morning by a Frozen Pond**. It's a contre-jour winter dawn under a tall sky that fades from smalt gray-violet through rose to straw. A dead oak and a few young firs stand on a snowy bank on the left. A frozen pond lies in the middle distance with reeds along its edges. A misty fir wood and a small Gothic spire sit on the far shore. One figure seen from behind, in a greatcoat and hat with a walking stick, walks a trodden path toward the church. Dry grass pokes through the snow in front. It's painted on the `friedrich_early` palette over a pencil underdrawing.

**Files** (all committed on `r8-arm3`, nothing pushed):
- Source: `paintings/lua/pond.lua` (26 chunks). `easel check` reported "replay matches the live canvas exactly (26 chunks)".
- Renders: `notes/round8/arm3/painting_1000.png` and `notes/round8/arm3/painting_3200.png`, lossless copies of `easel run` output.
- Notes: `notes/round8/arm3/notes.md` covers the composition and why, the method stage by stage and 17 friction points.

**Top five friction points** (details and workarounds are in the notes):
1. **Body strokes over tacky or dry paint come out as a lacy net.** Instead of a covering film you get a web of stroke outlines with the old paint showing through. This hit both the far hills and the trodden path. Workaround: `dry()` first, then only stipple or glaze anything laid over earlier paint.
2. **A winter `tree_in` oak reads as wire and claws.** The default `paint_wood` bands gave thorny spikes and beaded, dotted limbs, and `kink` made claw-like wedges. A pointed rigger at `pressure=0.04` drew chains of beads. Workaround: I stroked the fine wood myself from `wood_strokes{max=1.2}`, with pressure from `pressure_for(w)` lifting to 0. Even so, at 3200 every limb is a smooth tube of one even tone.
3. **The trunk flares into a round bulb below its given foot.** A tree on a slope shows a "bottle" end sitting on the snow. It took four tries to bury it: masked `work` left boxes, a stipple left a pale oval, sampled colors picked up the sky and a glaze left a gray ghost disk. What worked was opaque snow touches along a lumpy drift line I drew by hand.
4. **`blend` right after a broad sky pass lifts the paint into pale, thin blotches** (22 µm against 50 µm around them). Workaround: a heavier first pass with no blend, then a wet-in-wet stipple.
5. **Scattered small marks read as confetti.** Noise-placed grass tufts looked evenly sprinkled at 1000px, and dry-brushed ice streaks came out as ruled, dashed double lines. Workarounds: 19 hand-placed clumps of different sizes with glazed hollows at their feet, and the ice streaks as a glaze instead.

Smaller API gaps are also in the notes: `work` doesn't expose `fill`, `fir:paint` takes no `pal`, `fir_wood{foot=}` rejects a function, and the fir wood's floor band has hard edges.

Some flaws are still visible:
- The oak trunk is flat and dark.
- A few warm specks of ground show through the snow at 3200.
- The bank's crest barely separates from the flat snow beyond it.
