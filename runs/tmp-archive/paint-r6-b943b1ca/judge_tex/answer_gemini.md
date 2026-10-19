(・_・)b

# Sky Texture Judging: Digital vs Oil Paint

Summary: Evaluated all 15 variants in Set L (`L01`–`L15`) and all 14 variants in Set S (`S01`–`S14`) from `judge_tex/` per `BRIEF.md:1` and the texture forensics documentation in `notes/round7/texture.md:8`. Ranked every variant from most digital to most like real oil paint on canvas, identified the exact switches that eliminate the "JPEG artifact" look, and defined the concrete visual mechanisms responsible.

---

### Set L (Lab Sky, L01–L15)

#### 1. Ranking (Most Digital / JPEG-like to Most Like Real Oil Paint)
1. **L09**: Flat mosaic patches with sharp, stepped tonal cliffs resembling coarse macroblock quantization (`palette.rs:103`).
2. **L11**: Unvarnished raw surface; harsh contrast amplifies stipple rims, dither grit and edge ringing (`canvas.rs:396`).
3. **L03**: Scattered touches without cell clustering; stark horizontal banding with dense TV-static speckle (`stipple.rs:443`).
4. **L08**: Missing fill dabs leave micro-voids under stipple that increase noisy edge clutter (`handling.rs:665`).
5. **L02**: Coarser aim quantization steps; stipple cells show stepped tonal transitions (`palette.rs:103`).
6. **L14**: No mix jitter; mechanical, uniform pigment color across touches (`palette.rs:478`).
7. **L07**: Engine baseline; prominent cellular stipple mottle, scalloped rims, periodic linen grid and chroma noise (`style.rs:136`).
8. **L05**: Cracks-off baseline (identical to L07 as Lab sky has no craquelure); full stipple mottle and weave grid (`tex_key.txt:5`).
9. **L04**: Flat primed ground; cellular stipple sits exposed against a featureless substrate (`canvas.rs:271`).
10. **L15**: Softened hair contact floor; subtly softens micro-rims but retains dense stipple mottle (`bristle.rs:846`).
11. **L06**: No relief lighting; unshaded stipple rims and canvas ridges reduce embossed harshness (`canvas.rs:439`).
12. **L01**: No linen weave; eliminates the synthetic periodic screen-door raster grid (`surface.rs:466`).
13. **L13**: Monochromatic dither; eliminates high-frequency RGB chroma noise and color speckling (`canvas.rs:497`).
14. **L12**: Dither disabled on 8-bit save; removes chroma and luma salt-and-pepper noise in flat tones (`canvas.rs:497`).
15. **L10**: Stipple completely disabled; broad, continuous, creamy oil brushstrokes flowing over canvas with natural blending. Most like real paint (`stipple.rs:1`).

#### 2. Variants That Clearly LOSE the JPEG-like Look
- **L10 (Primary)**: Skipping stipple (`stipple` off) decisively eliminates the JPEG-like look. The pervasive cellular mottle, the blotches with sharp scalloped rims and the porous speckle showing underlayer gaps all vanish completely. Texture scale expands from unnatural 4–16 px micro-blotches to broad, continuous stroke sweeps.
- **L01 (Secondary)**: Skipping canvas weave (`weave` off) removes the strict 8.1 px periodic warp/weft grid that reads as a digital screen-door or raster pattern.
- **L12 and L13 (Secondary)**: Skipping or monochromating save dither (`dither` / `dither_mono` off) eliminates per-pixel color noise (a* and b* high-frequency noise drops by 12–17%), removing chromatic salt-and-pepper speckling from smooth gradients.

---

### Set S (Asky, S01–S14, No Cracks)

#### 1. Ranking (Most Digital / JPEG-like to Most Like Real Oil Paint)
1. **S12**: Flat, squared-off patches with stepped boundaries resembling JPEG macroblock quantization (`palette.rs:103`).
2. **S04**: Unvarnished raw surface; cold, high-contrast micro-edges make stipple rims and noise stand out harshly (`canvas.rs:396`).
3. **S02**: Coarser aim quantization steps; cloud dabs display visible stepped tonal breaks (`palette.rs:103`).
4. **S10**: Scattered touches without dip cells; clumpy patch structure becomes an even, granular speckle (`stipple.rs:443`).
5. **S06**: No mix jitter; repeated pile colors produce mechanical uniformity across cloud touches (`palette.rs:478`).
6. **S11**: Missing fill dabs; micro-holes in cloud dabs remain unfilled (`handling.rs:665`).
7. **S09**: No-cracks baseline; standard cellular stipple clumping, periodic weave grid and chroma dither (`tex_key.txt:24`).
8. **S05**: Flat ground; stipple clumps sit starkly on smooth ground without natural tooth (`canvas.rs:271`).
9. **S08**: Softened hair contacts; slightly rounded dab borders, though patchy clumping dominates (`bristle.rs:846`).
10. **S14**: No relief lighting; flat height field softens dab rims and canvas ridge shadows (`canvas.rs:439`).
11. **S03**: No linen weave; eliminates the periodic 4.8 px grid pattern across the sky (`surface.rs:466`).
12. **S01**: Monochromatic dither; strips away high-frequency color speckle in pale sky gradations (`canvas.rs:497`).
13. **S07**: No save dither; eliminates per-pixel 8-bit quantization noise entirely (`canvas.rs:497`).
14. **S13**: Stipple completely disabled; soft, continuous, blended oil brushwork with zero cellular clumping or granular speckle. Most like real paint (`stipple.rs:1`).

#### 2. Variants That Clearly LOSE the JPEG-like Look
- **S13 (Primary)**: Skipping stipple (`stipple` off) transforms the passage. All granular clumping, scalloped dab edges and porous micro-mottle disappear. The sky is rendered as continuous, creamy oil paint carrying soft cloud gradients with genuine physical brush drag.
- **S03 (Secondary)**: Skipping canvas weave (`weave` off) eliminates the 4.8 px periodic fabric frequency that mimics an electronic display raster.
- **S07 and S01 (Secondary)**: Disabling or monochromating dither (`dither` / `dither_mono` off) removes independent RGB channel noise, eliminating chromatic salt-and-pepper speckling.

---

### 3. What, Visually, Is the "JPEG Artifact" Look Here?

Visually, the "JPEG artifact" look is not actual 8x8 discrete cosine transform block compression, but an emergent combination of high-frequency procedural noise and patch-level tone stepping. The primary culprit is the stipple pass (`crates/paint/src/stipple.rs`), which deposits clusters of small, circular brush touches with sharp scalloped rims and microscopic voids that mimic compression ringing, mosquito noise and granular compression grit. These touches cluster into discrete spatial patches (`crates/paint/src/stipple.rs:443`) and mix against underlayers in quantized steps (`crates/paint/src/palette.rs:103`), generating subtly flat plates with abrupt tonal boundaries that the eye reads as quantized macroblocks. Compounding this, independent per-channel triangular dithering at 8-bit save (`crates/paint/src/canvas.rs:497`) scatters per-pixel color speckle across smooth sky gradients like chroma subsampling noise, while the periodic linen weave (`crates/paint/src/surface.rs:466`) acts as an artificial raster screen. Together, these elements impose a uniform, synthetic pseudo-entropy across smooth gradients that reads as lossy digital compression rather than the continuous fluid blending of physical oil paint on canvas.
