# The painter's last reply

(＾▽＾) The painting is finished and committed on `easel4-green` (last commit `dab2ce9`, not pushed). The final replay rendered at 3200 px without errors, in 316 s.

**The picture:** a summer morning seen from a grassy height, meant to be one Friedrich could have painted. A lone oak in full leaf stands on the brow, with an erratic boulder beside it and a small figure between them, seen from behind. Beyond the brow a dark wood falls away, and past it lies a wide green valley: field parcels, hedgerows, single trees, a river and a lane leading to a village with a spire. Hazed blue ranges and cumulus sit above.

Stage by stage it went: pencil drawing, sky, ranges and valley, woods, oak, stone and figure, grass, then refinement. Most passages took one to three undos before they worked.

**Files:**
- Session log: `paintings/lua/easel4_green.lua` (23 chunks)
- Renders: `out/easel4_green.png` (1000 px) and `out/easel4_green_full.png` (3200 px)
- Notes: `notes/easel4_green.md` (the picture and its Friedrich sources, every stage, how the easel felt, 10 friction points and a critique)

**Weak spots** (all in the critique): the middle of the hill is still a barcode of short upright grass dashes, and the field trees look like identical balls. The stone reads as a pale, smooth loaf. The village is too neat, and the thistle is a thin diagram of a plant.

**Top five friction points:**
1. **Pencil on the default ground:** a 2H pencil is invisible on the mid-toned red-brown Friedrich ground, and a 2B is only faint. I placed shapes with `show()` overlays instead.
2. **Paint laid over open paint:** the river ploughed through the wet valley to the red ground at 800–950 µm, and the boulder dragged the wet wood into its lit face. Waiting a day fixed both, but nothing warns you beforehand.
3. **Build-up on narrow masks:** two body passes on the oak's trunk left 1.5 mm of open paint. There's no simple way to ask `work` for one thin coat, which is how Friedrich painted.
4. **Hard masks look digital:** a glaze over the cloud shadows made flat gray slabs, stippling made speckle and the cloud shadows on the valley came out as dark ponds. Every mask needed blurring, roughening and lower coats.
5. **World versus canvas coordinates:** `w:ribbon` takes meters, and my first lane came out as a ruled line near the horizon. Drawing it in canvas points and converting them with `w:to_ground` worked.

**How it felt:** The paint, look, undo loop took 1–8 s per chunk and felt like painting, and waiting for passages to set mattered the way it would at a real easel. I could draw lines and silhouettes by eye (the brow, the wood's edge, the lane) with `outline{}`. The oak, the figure, the stone and the thistle I had to choose from seed previews, build as skeletons or model as solids. Every part that still looks digital is a loop or mask I wrote faster than I looked. The one chunk that turned the grass into meadow was the one where I varied lengths and curves by hand.
