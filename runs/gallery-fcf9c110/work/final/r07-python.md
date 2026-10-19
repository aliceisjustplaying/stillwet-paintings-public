# r07-python session [local path redacted]

--- assistant 2026-09-24T20:07:28.155Z
The crops hold up at 3200px: the sea lanes, the veiled crescent and the weathered stone all read as painted. Now I'll render the finals and check that output is deterministic.

--- assistant 2026-09-24T20:08:56.192Z
Finals are rendered and deterministic. Now the notes, then the commit.

--- assistant 2026-09-24T20:09:15.346Z
(ᵔ◡ᵔ) I've finished the control painting: ***The Chapel Gable at Evening***, one Python program that paints it from scratch with numpy. Both renders and the notes are committed on branch `r7-python` (commit `4047841`, not pushed).

**What it shows.** A ruined chapel gable stands dead on the central axis, on a bare ledge above a calm sea. It has a pointed arch with a round window above it. A man in a dark blue-green coat stands still inside the arch with his back to us, and his head sits on the ruled horizon against the brightest band of light. The sun has already set: the sky runs in bands from pale lemon at the horizon through rose and gray-violet up to dusk blue. A small crescent moon sits half-hidden behind thin cloud. The sea repeats the sky's light in paler lanes. There's no middle ground: ledge, then water, then sky.

**Files** (under `experiments/python_friedrich/`):
- `paint.py`: the program, **990 lines**. `uv run paint.py --width 3200 --out ...` takes about 40–60 seconds.
- `out_1000.png` and `out_3200.png`: the lossless renders.
- `NOTES.md`: how it works, what does and doesn't work, and time spent.
- `pyproject.toml` and `uv.lock` for the uv environment.

**Checks.** Two 1000px renders came out byte-identical (`cmp` passed), so the output is deterministic. A search of the committed files found no real name and no home paths.

**How it paints.** It lays a warm primed ground with a canvas texture, then faint pencil lines (horizon, axis, outlines). The main tool is a simulated brush stroke: each one carries a row of bristles that run dry at different points, and dry paint catches only on the raised texture. Paint goes on in layers: a brown underpainting, a thin sky layer, sky strokes in three sizes, then a pass of hundreds of thousands of tiny dabs for the smooth sky. Then come cloud strokes, the moon, the sea, the ground, the stone wall and the figure. Grass goes on last. It finishes with darkened edges, a warm varnish tone, raised-paint shading and a network of fine cracks. Every blur and texture is written by hand; no drawing library, image filter or scipy is used.

**Honest self-assessment.** At full view it works. It has one light and one order: the symmetry holds, the figure is still and on the axis, and the arch frames the brightest band. Seen whole, it's closer to Friedrich's restraint than to a follower's busy picture. Zoomed to 3200px:
- **Best:** the sea (long broken lanes of paint, a crisp horizon on the axis) and the veiled moon look painted by hand.
- **Most digital:** the outlines of the wall and figure are cut exactly like vector shapes rather than a brush edge.
- **Too even:** the upper sky is covered in fine horizontal brush-hair streaks.
- **Dull:** the bare foreground has no shape to it.
- **Flat:** the figure is basically a silhouette with a few fold strokes, and the cap reads as a flat lid.
- **Built in, not painted:** the stone courses are part of the target image, so the brush traces them instead of building them.

By the "less digital, more bad painter" yardstick, I'd call it a competent, slightly illustrative picture more than a convincing oil painting.

**Time:** about 30 minutes by the system clock, 13 look-and-fix rounds, well under the 2-hour budget.
