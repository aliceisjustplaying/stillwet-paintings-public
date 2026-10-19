# The painter's last reply

(＾▽＾) The painting is done at about 60 minutes, inside the 90-minute budget, with both renders and the notes committed on `r10-arm3` (not pushed).

**"Summer Afternoon: the Lime Tree on the Rise"**: flat summer meadows under a high sky with soft level cloud streaks. A single lime tree in full leaf stands on a low rise left of center. Two small figures seen from behind (a man in a green coat, a woman in a red dress and pale shawl) look across the plain to a far town with three church spires and a windmill. The middle distance has pollard willows along a ditch, haycocks, a hedgerow and copse, and two grazing horses. The foreground has a cart track with pebbles, grasses gone to seed, dock, yarrow and a thistle, and three swallows fly high up. The composition, the stage-by-stage method and an honest critique are in `notes/r10_summer.md`.

- **1000px render:** `out/r10_summer.png`
- **3200px render:** `out/r10_summer_full.png`, 202 s for the last one
- **Program:** `paintings/src/bin/r10_summer.rs`
- **Notes:** `notes/r10_summer.md`, with 17 friction items

The weakest parts, per the critique: the foreground grass is evenly spread texture rather than particular, the crown's shaded right edge is still too even an arc, and the composition is safe rather than Friedrich-empty.

**Top five friction points:**
1. **The engine's trees fail at small sizes.** Pollard willows (20–70 units) and hedge bushes grown with `broadleaf::Tree::grow` painted as bare trunk stubs or rows of black "hearts" with a few dots. There is no far-tree level of detail, so I wrote my own `willow` and `small_tree` motifs.
2. **Soft shade can't be laid as a glaze.** A glaze driven by a soft shadow mask left a hard dark slab with visible stroke ends, and a badger pass didn't soften it. Stippling the shadow read as a strip of clover at 3200px. What worked was building the shade into the meadow's own color, e.g. `(1.0 - 0.3 * lime_sh(x, y))` in `plain_c`/`bank_c`. A low-hiding stipple (`.paint(0.25, 0.3)`) did work as a cool shade over the lime's far side.
3. **Editing a helper function stales every checkpoint.** Changing `paint_lime` made the "bank" checkpoint stale, even though `paint_lime` only runs in the "lime" stage. I had to pass `--stale-ok` each time, which undercuts resume exactly when working on a motif.
4. **`Palette::paint` and `c.aim` both take a color and mean different things.** Bark mixed with `pal.paint(col, 0.35)` targets the paint's own color in the pot, and came out pale grey over the dark wood. `c.aim(pal, col, (x, y), r, 0.3, 1.0)` fixed it immediately, because it aims at how the paint looks where it lands.
5. **Clouds took four tries.** Clouds stippled into the wet sky were erased by the badger (blending brush) pass; only a white "worm" survived. The density fields are all hand-written, and my first three shapes came out as worms, cigars and cartoon sprites. `atmos::Clouds` needs a `World` camera and meters, too much to learn for one painting.

A small poem break:

> Under the lime the afternoon stands still,
> two backs turned toward the steeples' blue;
> the hay lies cocked along the mown strip,
> and swallows stitch the sky the whole day through.
