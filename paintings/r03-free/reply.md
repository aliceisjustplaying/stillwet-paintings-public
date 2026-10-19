# The painter's last reply

(ᵔ◡ᵔ) The painting is finished: **"Dolmen on the Baltic Shore at Evening."** It shows a megalithic grave (a Hünengrab) on a dune barrow just after sunset. There's an afterglow sky with a crescent moon, the evening star and faint cloud wisps, two bare oaks (one dead), a small figure in a dark coat seen from behind with a walking stick, two sails on a calm sea and a dark dune foreground of grass, heather, sunk stones and seed heads.

It took about 45 minutes (13:13–13:58) and 38 chunks. `easel check` reports "replay matches the live canvas exactly (38 chunks, 50.5s)". The log and notes are committed on `easel3-free` and nothing was pushed.

**Files**
- Painting (the session log): `paintings/lua/easel3_free.lua`
- Renders: `out/easel3_free.png` (1000px) and `out/easel3_free_full.png` (3200px). `out/*.png` is in `.gitignore`, so the renders are on disk but not committed.
- Notes: `notes/easel3_free.md` (the picture and why, the stages, how the easel felt, friction and a critique)

**Top five friction points**
1. **`wait()` sometimes jumps the clock by weeks.** After a `glaze`, `wait(120)` went from clock 3150 to 45631.6. After I undid a `dry(); varnish{}` chunk that had ended at 99438, the next `wait(240)` landed on 99678, which is exactly 99438 + 240. It looks like undo restores the easel's clock but not the time the canvas has seen. I didn't confirm this in the source.
2. **`work()` strokes spill past the mask unless you pass `clip=`.** Without it the stones' outline looked like stacked plates and the first sea pass bumped up over the horizon. The fix was `clip=` on every pass where the edge matters.
3. **Keeping things "behind" other things is all manual masking, and that caused most of my errors.** Glints crossed the stones and the barrow, and the sea veil painted over the figure. Each fix meant closing the session, editing the log with `sed` and waiting 27–50 s for a replay. The figure problem only showed up in the 3200 render.
4. **The world's scale doesn't match motifs placed in canvas units.** `w:height` put a 1.75 m man on the path at 157–181 units, taller than my dolmen. `eye=` is an absolute height rather than height above the ground, so my first camera ended up inside the knoll.
5. **Stone shapes jump from too smooth to too rough.** `rough(0.1·r, 1.4·r)` made egg-shaped stones and `rough(1.2, 14, s, true)` made a cork crust. I needed six tries, plus `cut` planes and `silhouette{}:roughen(0.9, 16)`. Related: `relief(0.6)` turned the sky into thick impasto because the default is only `(0.2, 0.02)` (`crates/paint/src/style.rs:128`), and the README doesn't say so.

**How the easel felt:** The loop of painting a chunk, looking at it and undoing it felt most like painting, because looking cost almost nothing and most of my chunks worked fine as code but were wrong as pictures. The physics made choices for me the way real paint does: dark strokes let the bright sky show through, a flat brush dragged wet tree paint and a stippled veil made the sky look painted. It felt like programming whenever a fix meant mask algebra or hand-editing the log and replaying, which a program written in one go would never have caught because it would never have been looked at.

**Honest critique:** The value structure and the stippled sky are the strongest parts, and the oaks hold up at 3200. The sea is still a plain band, the foreground details are hard to find at normal size, the figure looks cut out at 3200 with a faint pale haze around him and the two trees framing the dolmen are a bit stagey.
