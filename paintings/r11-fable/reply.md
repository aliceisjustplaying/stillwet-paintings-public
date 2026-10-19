# The painter's last reply

(◡‿◡) Done. The painting is committed on branch `r11-fable` (6 commits, nothing pushed; `git log --oneline -6` above shows `3d2d086`…`9f80ae7`).

## Winter dusk on the marsh

A frozen marsh on the plain after sunset: afterglow low left, cold zenith, a wooded ridge in mist with a village spire right of center, a frozen pool mirroring the sky, a stag-headed dead oak with snow lying on its limbs, three spruces, a broken paling fence receding to the right, one wanderer from behind with his tracks coming up from the bottom edge, three crows and a thin crescent. Painted from the sourced method: graphite underdrawing with ruled straights, thin lay-in, stippled sky and far hills, firs as short hatches, grass flicked over the finished snow last, lead-white snow with slight foreground impasto, 1820 palette.

**Renders**
- `out/r11_winter_fable.png` (1000px, 34 s)
- `out/r11_winter_fable_full.png` (3200px, 213 s)
- Program: `paintings/src/bin/r11_winter_fable.rs` (stages: drawing, sky, far, snow, pool, oak, spruces, grass, fence, figure, birds, finish)
- Notes: `notes/r11_winter_fable.md` (composition and sources, stage-by-stage method, 16 friction items, critique after each look)

**Top five friction points**
1. **Two `Mark` types**: `paint::Mark` at the crate root is `hand::Mark`, but `Canvas::draw` wants `graphite::Mark` (not re-exported); the error "expected `&Mark`, found `&Mark<'_>`" is opaque. Worked around with a `pencil()` helper over `graphite::resample`.
2. **Editing any helper below `main` stales every checkpoint** (the model counts "everything after the item that holds the stage"), so writing a figure helper invalidated the sky's checkpoint; `--stale-ok --ckpt` each time.
3. **Stipple beads when it's a thing lying on a thing**: snow on limbs as touches became a string of white pearls at 3200px, and the mist veil (`aim(false)`) became salt on the ridge. Both replaced by strokes (a dragged stroke along the limb's upper side; a lead-white scumble via `Style::glaze(0.62)` fused with the badger).
4. **Aimed near-white over the warm ground gave pink piles** (lead white + red earth patches in the snow). Fixed with a `Palette::only` snow family without red earth/vermilion plus a thin opaque underpainting by masstone — and `only` panics at run time 25 s in if a tube name is wrong ("smalt" isn't in the 1820 palette).
5. **`World::height` puts a 1.72 m figure's head on the horizon** with a 1.7 m eye (physically right, useless for a Friedrich plain where figures are small); height hand-set at 54 units. Related: `Limb` gives no per-segment normal or up-side, so snow on wood is derived by hand from consecutive points.

Honest verdict (in the notes): the sky's stipple grain, the snow film with its craquelure, the pool's dusted rim, the snow on the limbs and the fence read as paint; the ridge (a noise-topped band), the evenly spaced tracks and grass, the banded sky transition and the regular spruce hatch still read as digital. The fence took ten minutes and is the most Friedrich-like particular in the picture; the next hour would go to more such things, not more sky passes.
