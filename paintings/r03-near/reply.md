# The painter's last reply

(｡•̀ᴗ-)✧ The painting is finished and rendered at both sizes, about 60 minutes in. It's a close view of a bedded sandstone block at the edge of a spruce wood on a late-autumn morning:
- A young birch with a few yellow leaves grows from a crack in the top and grips the edge with its roots.
- Moss, dry grass and heather sit on the ledges, with dark weathering streaks and lichen below them.
- Dead rust bracken, a mossy boulder, grass, stones, a fallen branch and fallen birch leaves fill the foreground.
- Behind: dark spruces at left, a pale stippled sky, a misty far wood and four small crows.

**Files** (the renders are ignored by git, so they're on disk only; everything else is committed on `easel3-near`, not pushed):
- Session log (the painting, 26 chunks): `paintings/lua/easel3_near.lua`
- 1000px render: `out/easel3_near.png`
- 3200px render: `out/easel3_near_full.png`
- Notes (reasoning, 18 stages, how the easel felt, 13 friction points, critique): `notes/easel3_near.md`

**My critique:** the rock still looks too much like stacked masonry. Its beds are rectangular and its straight base is only hidden by a band of bracken. The front spruces are flat dark cutouts, and the foreground is murky rather than full of particular, lit detail.

**Top five friction points:**
1. **Paint was still wet after a painting-day.** The README's `wait(24*60)` between passages wasn't enough for my thick floor: `drying()` still said "open". The rock painted over it went see-through, with the far wood showing through. The floor needed about 26 painting-days, so I called `dry()` before every later passage.
2. **Shadow masks came out as hard outlines.** A mask built as `(m:grow(n) - m):soften(k)` puts a ring around the whole shape. A softened `rect()` band glazed as a hard bar. I had to write `mask(function)` falloffs by hand.
3. **`sward` covered everything.** The defaults made about 69,000 grass tufts that erased the floor, the shadows and the bracken, and tufts can't be colored from what's under them. It took three tries: noise patches, sparse spacing and a color from `sample()` under each tuft.
4. **Most first attempts came out too even, too dense or too bright.** The far wood looked like a hedge, the ferns like orange icons, the moss like a green outline, the leaves like pollen and the young spruces like a planted row. `hand="scumble"` laid opaque blobs. Every irregularity had to be written by hand with noise.
5. **Undo throws away the chunk's code, and time is partly hidden.** I switched to chunk files run with `do -f` so I could edit and rerun them. The clock jumps looked hidden: a foreground chunk with one `wait(24*60)` moved the clock about 19,000 minutes. I think `glaze()` spends time, but I didn't confirm it. A `dry()` after glazes jumped 87 days.

**How the easel felt:** The look-judge-undo loop felt like real painting. `--mode value,squint` showed me the rock didn't stand out, and glazing the foreground darker fixed it the way a painter would. Below "which color where", though, it was programming: a crack-wobble helper, a bracken generator and four attempts at building the rock from blocks by trial and error. Feedback came much faster than from a normal program, and paint wetness and timing shaped the result. But every mark was a coordinate I estimated from a JPEG; I never touched the picture.
