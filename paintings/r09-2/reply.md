# The painter's last reply

(´ー`) The painting is finished and committed on `r9-arm2`, with a full 3200px render and notes.

**Title:** *Winter Morning on the Ryck*

It's the flat country below Greifswald on a still, veiled morning. The sun sits low on the left behind the haze, and the frozen river winds out from under it toward the viewer. Pollard willows line a straight path to the town's three towers, and a man in a greatcoat and top hat walks along it, seen from behind. A big split willow on the left edge frames the view, its crown dark against the sky. The small details include a boat frozen in at the bank, an old fence line with two posts fallen, sledge ruts, long shadows from the low sun, reeds in the ice, dry grass laid last over the snow, crows and a post mill.

**Files**
- Program: `paintings/src/bin/r9_ryck_winter.rs` (13 stages, from the underpainting to the aged finish)
- Renders: `notes/round9/arm2/painting_1000.png` and `notes/round9/arm2/painting_3200.png`
- Notes: `notes/round9/arm2/notes.md` covers the composition and why, the method stage by stage and a 13-item friction list

**Top five friction points**
1. **Dark strokes with a pointed tip draw a warm tan outline around themselves.** Every trunk had a light-brown rim just outside its dark edge at 3200px. It was already there at `--stop willows`, before the varnish and relief light, and it went away when the edge strokes used `point: 0.0`. My reading: the few outer hairs lay a very thin brown film over the snow, and that thin film reads as a tan glaze. Workaround: blunt tips and a cooler grey in the edge strokes.
2. **Editing a helper function below `main` stales every checkpoint.** The staleness check covers "everything after the top-level item that holds it" (`notes/workflow.md`), so changing the willow or figure function stales the "fields" stage. I had to use `--stale-ok --ckpt` almost every time. That habit bit me once: I resumed after the stage I had just changed and looked at the old boat.
3. **Thin dark strokes over light snow look like glass tubing.** Shadows and ruts dragged as filbert strokes came out lighter in the middle with dark ridged edges, and the ruts as dashes. Workaround: a transparent glaze (`st.glaze(0.85)`) through a mask built from the sun's direction, laid before the willows. Laid after them, it ran over the nearer trunks as pale bands.
4. **Variation written into a `color(x, y)` function gets averaged away.** The river came out as one even band with a smooth edge and read as a road for three versions. It only became ice once I painted the variation as separate hand gestures: snow tongues dragged out from the banks over a darker base.
5. **Snow lying on top of things comes out as cotton balls.** Snow caps and foot drifts made with a round brush were fuzzy blobs or fog-like smears at 3200px. Drifts built from rows of short level strokes worked, but there's still no easy mark for a thin, crisp cap of snow.

The whole 3200px render took 174 seconds; that's from the run's own output: `wrote … r9_ryck_winter_full.png (3200px) in 174.1s`.
