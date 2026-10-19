# The painter's last reply

(ᵔ◡ᵔ) The painting is finished: *Winter evening by a frozen pond*, rendered at 1000px and 3200px from the final code. It's committed on branch `r10-arm2` (4 commits, not pushed). I only staged my program and notes; the renders sit in `out/`, which git ignores.

**The picture.** A low horizon under a big afterglow sky: smalt-gray at the top, fading through lilac and rose to a pale gold band. There's a thin crescent moon, the evening star and one low streak of cloud. On the left a stag-headed oak stands black against the glow, snow along its limbs, crows in its dead top. On the right are three dark young spruces carrying snow, with a fir wood on the horizon. Between them a frozen pond catches the last light, and a small back-turned man walks the path toward a church spire in the far haze. The foreground has a half-buried stone and dry grass laid last over the snow. A dark glaze deepens toward the edges, after Friedrich's advice to Carus, then aged varnish and cracks.

**What still fails:**
- The stone looks too much like a loaf.
- The snow in the middle distance is busier than his calm fields.
- The snow is opaque body color rather than thin over a light ground.
- I skipped the pencil underdrawing for time.

**Files:**
- Program: `paintings/src/bin/r10_winter_b.rs`
- Renders: `out/r10_winter_b.png` (1000px), `out/r10_winter_b_full.png` (3200px)
- Notes: `notes/r10_winter_b.md` (composition, method stage by stage, 14 friction items, critique)

**Top five friction points:**
1. **Editing any helper function below `main` makes every checkpoint stale.** Changing `paint_spruce` staled even the `snow` stage. Painting one helper per motif breaks resuming exactly when you're working on a motif. I used `--stale-ok` after checking by hand that earlier stages hadn't changed.
2. **`--resume X` starts after stage X, not at it.** To repaint the oak I had to resume from `pond`, the stage before. The error only says "stale", which hides the real mistake. A `--redo X` would match what a painter means.
3. **Masks can silently cover the whole canvas.** My stone formula went bad far from the stone, and the snow pass painted over half the oak and sky with no warning. The workaround was an early-return bounding box in every motif mask; a per-pass coverage report would have caught it.
4. **The oak growth presets come out sparse, with no control for crown fullness or outline.** I had to lower decline and decay and pick a seed from a sheet of six. The fir has an outline to grow into; the oak doesn't.
5. **Aimed paint mixing can go off-hue.** Near the bare red ground at the pond's edge it produced one salmon stroke, which I only found by zooming in. Giving the snow and ice passes a paint family without reds fixed it. Related: `Handling` isn't `Clone`, so a second, slightly changed pass means writing the whole builder out again.
