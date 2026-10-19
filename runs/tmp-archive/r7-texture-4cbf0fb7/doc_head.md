# Texture forensics: what in the paint could read as "JPEG artifacts"? (Round 7)

Alice sees something like JPEG artifacts in the texture of lossless renders
("the entropy still reads like JPEG artifacts"; "not the crackle at all,
it's something about texture"). This note lists every source of pixel-scale
texture in a render, where it lives in the code, a switch that takes each
out on its own, and what each switch does to a set of measurements on four
fixed windows. **No verdict:** the variants are in `notes/round7/texture/`
under neutral numbers (v01–v28) so they can be judged blind; the key is
`notes/round7/texture/key.md`. Judges: look at the images before reading on.

## How it was made

- Engine: this branch = main (variant d) plus `crates/paint/src/texoff.rs`:
  switches read from the environment variable `PAINT_TEXOFF`
  (comma-separated), **default off**. With it unset, the benchmarks
  `notes/loops/l5_near.lua` and `l3_green.lua` at 1000 px are
  byte-identical to main (checked, see the end).
- Paintings (logs unchanged, scratch copies): arm 1
  (`git show r7-arm1:paintings/lua/willows.lua`), arm 2
  (`git show r7-arm2:paintings/src/bin/pond_poplars.rs`, built as a
  scratch binary) and the Round 6 Lab sky A (`notes/lab/sky_A.lua`).
- Windows (units; 3200 px renders with `--crop`, default margin 40), each
  saved at 1:1 as a lossless PNG:
  - `Asky`   willows 650,60–850,200 (640×448 px): the upper right sky
  - `Apond`  willows 650,465–850,545 (640×256 px): the water right of the trunk
  - `Bsky`   pond_poplars 650,150–850,290 (640×448 px): the glow band
  - `labsky` sky_A 350,260–550,400 (640×448 px): between the two cloud banks
  (willows was rendered as one crop 650,60–850,545 and cut into the two windows.)
- Two families: **as painted** (one switch off; cracks as the painter
  finished) and **no cracks** (craquelure off plus one switch), because in
  A and B the cracks dominate every fine-scale number and hide the rest.
- Measurements: `scripts/texture_metrics.py` (committed; its docstring
  defines every number). Run with
  `uv run scripts/texture_metrics.py file.png ...`.
- Calibration: the Round 6 lossless crop `notes/round6/jpeg_check/sky_A_full_crop.png`
  and its q80 JPEG `sky_A_full_crop_q80.jpg` score **block8 0.94 % vs 68.1 %**
  and b8/b7,9 1.33 vs 58.4. Everything else changes little between them
  (L_8-16 0.762 vs 0.766), so the texture numbers describe the paint, not
  compression.

## The suspects and where they live (line numbers on main)

| # | suspect | where | what it does at pixel scale | switch |
|---|---|---|---|---|
| 1 | 8-bit save dither | `crates/paint/src/canvas.rs:497` (`save`) | triangular dither of ±1 LSB, **independent per channel** (hash per pixel and channel): per-pixel luma *and* chroma noise | `dither` (round only), `dither_mono` (one dither value for all three channels) |
| 2 | relief lighting | `canvas.rs:439` (`relief`); strength `style.rs:136` `(0.06, 0.006)`; called by `relief()` / `Finish` | shades the height field (weave, ridges, crack cupping) from the upper left | `relief` |
| 3 | linen weave | `surface.rs:466` (`linen_um`), laid by `build_support` `surface.rs:216` | a periodic height field: 15 warp / 13 weft threads per cm; felt by the bristles, pools thin paint, lit by relief | `weave` (height 0) |
| 4 | grounds | `canvas.rs:271` (`prime`, knife texture: value noise at 0.3/0.9 mm); `style.rs:203` (`brush_ground`, the brushed top ground) | the ground's own relief (striations, knife noise) under thin paint | `ground` (all grounds primed flat) |
| 5 | bristle footprints | `bristle.rs:846` (drag hair radius floor 0.55 px), `bristle.rs:1454` (touch 0.75 px), `bristle.rs:987` (smoothstep coverage per pixel center) | how a hair's contact is rasterized: aliasing on the pixel grid | `hairsoft` (floors 1.2 / 1.5 px) |
| 6 | stipple touches | `stipple.rs` (`stipple_with`, `touch_on` in `bristle.rs`) | many small round touches with a sharp rim; the layer under shows in the gaps | `stipple` (passes skipped) |
| 7 | stipple patches ("a load serves about one patch") | `stipple.rs:443` `cell = g·√dips` (at least 2 widths), in passages `stipple.rs:425` (≥ 12 widths) | the touches of one dip land in one square patch of a grid: pile-to-pile color differences can tile the passage | `dipcells` (a pile's touches scattered over the passage) |
| 8 | per-pile mix jitter | `palette.rs:478` (`remix`), `mix_jitter: 0.06` `style.rs:132`; OKLab jitter for unmixed paint (`handling.rs`, `stipple.rs`) | every dip's proportions vary by 6 % (relative sd) | `jitter` |
| 9 | aiming over the underlayer (color_over/aim) | strokes: `handling.rs:943` (`stroke_under`); stipple: `stipple.rs:497` (`judge_under` per dip); marks: `palette.rs:542` | each pile is mixed for what it will sit on, judged from the canvas at that spot: the under-texture feeds into the pile | `aim` (piles by masstone) |
| 10 | quantized aim recipes | `palette.rs:103` `Q_UNDER = 100` (underlayer keyed on 0.01 OKLab steps); stipple memo `stipple.rs:267` (`seen` on 1/120 steps) | neighboring dips over slightly different underlayers share or flip recipes: small tone steps | `aimfine` (4× finer keys) |
| 11 | look-and-fill dabs | `handling.rs:665` (`fill_gaps`), on by `handling.rs:445` | dabs into bare spots after a covering pass | `fill` |
| 12 | varnish | `crates/easel/src/api.rs:1808`, `paintings/src/run.rs:607` (a glaze, `canvas.rs:396`, pools in hollows) | a warm film, thicker in the hollows; lowers contrast | `varnish` |
| 13 | craquelure | `crack.rs:1329` (`crack`), its milky varnish veil `crack.rs:1443` | cracks, cupping, grime | `cracks` |
| – | drying noise | `drying.rs:127` (value noise in the drying rate, per mm) | only when the paint dries, not a pixel texture itself | not switched |

Periods these predict at 3200 px (arm paintings are 440 mm wide, 0.1375
mm/px; the Lab sky is 300 mm, 0.094 mm/px): the weave at 4.85 px (warp)
and 5.6 px (weft) in A and B, 7.1 and 8.2 px in the Lab sky. Stipple
patch sizes from the formulas (estimates, clustering ignored): Lab sky
(width 2.6, coverage 2.6, 18 touches a dip) about 5.2 units = 17 px; A's
second sky (width 3.2, coverage 1.7, 40 a dip) about 10 units = 33 px;
B's sky passes (2.4 / 2.4 / 18 and 1.5 / ≤2.1 / 22) about 15 and 10 px.
Passages (tiles, one brush each) are 30–40 units, about 100–125 px.

## Headline measurements

**No block grid.** In every window and variant, blockiness at 8 and 16 px
is at noise level: 0.8–2.3 % in the skies at 8 px against 68 % for the
q80 JPEG of the Lab sky. The pond's 8–11 % is striation, not a grid: the
same measure gives 13.7 % at 6 px, 13.0 % at 9 and 39 % at 17 (as
painted). b8/b7,9 only means something when block8 is large; here it
wanders between 0.7 and 2.7 with the noise. JPEG's own signature, 8×8
blocking, is not in the renders.

**Regular periods that are there** (grid, peak/median of the edge-profile
spectrum at 4–40 px): the weave. The Lab sky peaks at 8.13 px (the weft)
at 50.9; with `weave` off the peak falls 64 % (to 18.5) and with
`relief` off 34 % (the weave shows through the relief lighting and the
paint it pools). Without cracks, A's sky peaks at 4.84 px (the warp,
32.7) and B's at 5.59 px (the weft, 30.7); `weave` halves A's peak (-48 %).

**What changes the texture most (changes of 10 % or more; the tables
below have all of it):**

| switch | Lab sky | A sky (no cracks) | B sky (no cracks) | A pond (no cracks) |
|---|---|---|---|---|
| cracks | (no cracks in it) | as painted → no cracks: L_2-4 -70 %, L_4-8 -54 %, L_8-16 -27 % | L_2-4 -65 %, L_4-8 -52 %, L_8-16 -41 % | L_2-4 -53 %, L_8-16 -40 % |
| stipple | L_2-4 -61 %, L_4-8 -75 %, L_8-16 -82 %, L_16-32 -76 %; flat% 0.06 → 29.7 | L_2-4 -36 %, L_4-8 -54 %, L_8-16 -73 %, L_16-32 -70 %; flat% 2.8 → 42 | L_4-8 -35 %, L_8-16 -53 %; b* hf -30 % | (no stipple in it) |
| aim | L_2-4 … L_16-32 -23 to -27 %; flat% ×8.5 | L_2-4 -16 %, L_8-16 -27 %; a* hf +29 %; flat% ×4 | L_4-8 -14 %; b* hf -23 %; flat% +26 % | – |
| dipcells | grid -21 % | grid +72 % | L_4-8 +34 %, L_8-16 +40 %, L_16-32 +48 %; flat% -38 % | (no stipple) |
| dither / dither_mono | a* hf -17 %, b* hf -12 % (both) | a* hf -33 %, b* hf -17 % (both) | a* hf -23 %, b* hf -12 % (both) | a* hf -22 % |
| relief | grid -34 %; flat% +29 % | flat% +80 %; grid -31 % | flat% +26 % | flat% +72 % |
| weave | grid -64 % | grid -48 % | – | – |
| varnish | flat% -26 % (dE 7.3: color) | flat% -22 % (dE 11) | flat% -11 % (dE 7.9) | dE 8.0 |
| ground | grid +38 % | flat% +32 % | grid ×2 | flat% +33 % |
| jitter, aimfine, fill, hairsoft | under 10 % on the texture bands; aimfine flat% -45 % in A | | | |

(Band = the standard deviation of L* carried by texture of that period in
px; "hf" = the 1–2 px noise of that channel; "flat%" = pixels in flat
5×5 patches; dE = mean ΔE76 against the family's baseline.)

**Per-pixel chroma noise.** a*/b* noise at 1–2 px is 0.23–0.30 / 0.30–0.47
in every window. The independent-per-channel dither is a steady share of
it: taking it out lowers a* by 17–33 % and b* by 11–17 %; `dither_mono`
does the same to chroma and keeps the luma dither (L_2-4 unchanged or up).
Without stipple the chroma noise stays while the lightness texture falls,
so the chroma/luma ratio rises to 2.8 in the Lab sky and the A and B skies.
That is the dither's chroma, alone on a smooth passage.

## What each switch changes (by eye, 2× nearest, crack-free A sky and the Lab sky)

- **stipple**: the sky becomes smooth horizontal strokes. The cellular
  mottle, the blotches with sharp scalloped rims and (Lab sky) warm
  specks where the underlayer shows between touches all go. By far the
  largest change in the 4–32 px bands.
- **aim**: the stipple's patches grow into larger, flatter tiles with
  steps between them (some near-square in the A sky); the tone drifts
  (dE 2–4) because unaimed piles don't compensate for the underlayer.
- **dipcells**: the blotches break into a finer, more even speckle; in B's
  sky the texture gets stronger in every band (the piles' differences are
  scattered touch by touch instead of patch by patch).
- **cracks**: removes the crack network. In A and B it is the main 2–8 px
  texture as painted.
- **dither / dither_mono**: no visible change at 1:1; chroma noise down.
- **relief, weave, ground**: small; the weave's period drops out of the
  spectrum, relief off flattens the finest shading (flat% up).
- **varnish**: a color change (cooler, more contrast), texture a touch
  stronger without it.
- **jitter, aimfine, fill, hairsoft**: hard to see; measurements within a
  few %.

## Tables

