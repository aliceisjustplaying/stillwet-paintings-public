# The painter's last reply

(ᵔᴥᵔ) The painting is finished: *Daybreak in the Riesengebirge*, a wanderer by a granite tor. Both renders are done and everything is committed on `amnesia-mountains` (last commit `cd8871f`; not pushed). The whole job took about 54 minutes, including the full render.

**The picture.** It's dawn before sunrise, seen from a dark granite knoll:
- **Near:** a wanderer seen from behind stands by a woolsack-granite tor, with wind-thinned spruces (one dead) and dwarf pine on the knoll.
- **Middle:** a sea of valley fog with lit billows fills the lower right, below a dark wooded range with spruce tips along its crest.
- **Far:** a cool blue-gray range, then the grayed-violet Schneekoppe with a nub of its St. Laurentius chapel, against a lemon-to-gray-blue stippled sky.
- **Small details:** a thin waning crescent turned toward the hidden sun and four birds.

The method follows `notes/research/friedrich_materials.md`: a pencil drawing, a thin underpainting, stippled sky, mist and far hills, hatched firs, upward grass flicks last, then the figure and birds.

**Where things are:**
- Program: `paintings/src/bin/fresh2_mountains.rs` (903 lines, 22 stages)
- Renders: `out/fresh2_mountains.png` (1000px) and `out/fresh2_mountains_full.png` (3200px)
- Notes: `notes/fresh2_mountains.md` has the composition and its Friedrich sources, the method stage by stage, 18 friction items and a critique.

**My critique, briefly:** the value structure, the fog and the figure work. The weak spots are that the mid range's gullies are generic noise, the knoll is a large, quiet dome, and some 3200px marks (spruce needles, grass tufts) still bead into blobs. The details are in the notes' Critique section.

**Top five friction points** (full list in `notes/fresh2_mountains.md`):
1. **Hidden layers leak through, and you only see it at 3200px** (items 9 and 14). Three separate leaks painted pale paint under the dark knoll:
   - The fog mask's density was nonzero under it.
   - A `Ridge` reaches its full depth across the whole canvas, so the near range was painted under the knoll.
   - `Style::blend()` isn't clipped, so badger passes dragged wet fog across mask edges.

   The fix was an `off_knoll` mask (line 99) on every pale passage, including the near range (line 358), plus `.clip(true)` on every blend (lines 209, 251, 346, 414, 448). Finding them took stage-by-stage bisection with pixel counts.
2. **Stippling over dark passages reads as static at 3200px** (item 10). It gives pale dots and hollow rings. Mist over dark ground had to become a brushed veil fused with the badger (line 411); stippling stays over light passages.
3. **`--stop` silently doesn't stop** (item 5). `--stop far_range` never matches the stage "far range" (`--resume` takes the underscored form), and `--resume X --stop X` runs to the end. Several "intermediate" renders I trusted were actually the final image. Related: a `--stale-ok` resume doesn't refresh its checkpoint (item 18), which trains you to pass the flag by reflex.
4. **The aged crack preset doesn't fit** (items 1 and 11). Its 70 µm hairlines become full dark pixels at 1000px. It also assumes a 60 µm ground while `Style::friedrich` primes 240 µm, which turned the cracks into a weave grid. I set the crack width and depth myself and took `ground_um` from the style (line 694).
5. **Small marks turn into blobs at 3200px, and the pale ground flecks through dark paint** (items 3 and 12). There's no pointed-tip model, so spruce tips, birds and grass came out as pegs, beans and beads until I used thin riggers with slow press-in and lift-off (line 379). Bare ground showed through dark body color until I added a brushed underpainting. There's also no builder for a handling's brush size; I worked around it with a small extension trait (line 700).
