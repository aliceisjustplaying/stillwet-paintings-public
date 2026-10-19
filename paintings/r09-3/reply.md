# The painter's last reply

(^_^)ノ The painting is done: **Winter Evening with a Wayside Cross**.

It's a snowy dusk just after sunset:
- **Sky:** gray-violet above, with a lemon-rose glow low on the left.
- **Oak:** a gnarled dead oak stands on a snow mound, nearly black against the glow, with two crows hunched in it.
- **Cross and walker:** lower on the slope, a leaning wooden cross with a small roof, snow on its bar and roof. A man in a dark greatcoat and hat, seen from behind, walks toward it with a stick, leaving footprints behind him.
- **Distance:** a hazy fir wood on the right, and on the left a village church and copses almost lost in the glow.
- **Small details:** a thin crescent moon, the evening star, three birds, two snow-capped stones and dry grass painted over the snow.
- **Finish:** a faint darkening toward the edges (Friedrich's advice to Carus, MET PDF p.35), then varnish, cracks and relief.

The full 3200px render replayed cleanly in about 2 minutes ("23 chunks, painted in 121.5s") and is committed on r9-arm3 (not pushed).

**Files:**
- Source: `paintings/lua/r9a3_winter.lua`
- 1000px render: `notes/round9/arm3/painting_1000.png`
- 3200px render: `notes/round9/arm3/painting_3200.png`
- Notes (composition, method in 16 stages, 15 friction points): `notes/round9/arm3/notes.md`

**Top five friction points:**
1. **Paint laid over dry paint keeps every stroke's outline.** Shadows laid on dry snow with `color_over={shift=...}` came out as crisp blue scribbles like wire. With explicit colors plus `blend` they still left flame-like tongues past the edge. The only soft result came from modeling the mound, its lee and the drifts inside the first wet snow pass (editing chunk 5).
2. **The winter oak came out as a lollipop or a baobab.** A round drawn crown gave an evenly filled crown on a thin stem. Raising `girth` gave a trunk 76 wide with a round bulb painted below the foot. The fix was a wide, low, notched crown, `girth=0.12`, and clipping the thick wood to `above(foot line)`.
3. **The `rock` tool on small stones in snow.** It left vertical streaks, `blend` turned the shadow side into a flat black void, and `r:snow{}` looked like cotton wool at 3200px. I painted the stones by hand instead.
4. **Editing an early chunk silently moves what sits on it.** Raising the oak's `detail` regrew its limbs, and the crows placed by eye then floated in the air. I re-seated them on points read from `oak.limbs`. After an `edit`, it was also easy to add a new chunk on top of the old one by mistake.
5. **1000px and 3200px disagree on fine things.** The twigs look fuzzy at 1000 and like clean lace at 3200. The far hedge was a smooth stripe at 1000 and hard dashes at 3200. Each new `--scale 3.2` look window costs 15 to 30 s on the shared machine.

Also in the notes:
- The README's `.fill(false)` isn't a Lua `work` option.
- `try --look` shows the canvas after the rollback, so it can't preview paint.
- A fixed flat `orient=` angle laid the brush edge-on.
- `glaze` makes the whole canvas dry first.
- On the left, sky and snow were the same color at the horizon (`#dccdaa`), leaving no edge to paint the far hedge up to.
