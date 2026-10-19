# Craquelure revamp (branch `cracks`)

## Round 7: less neat (branch `r7-cracks`)

Alice on the aged *Evening at a Mountain Lake*: "we do want the age stuff",
but the craquelure is "still too neat, still too digital"
(`notes/round6/alice_review.md`, last section). The old render
(`notes/paint1/evening_lake_aged_3200.png`) showed why. One fine polygon
web covered the whole picture. Every crack had about the same width, the
islands had about the same size everywhere, and the density was the same in
the sky and the water. In the dark fir wood the cracks simply stopped at
the silhouette, because the paint's lightness decided whether they formed,
so they looked cut by a mask.

### What the literature says (text sources only)

- **The network lives in the ground; paints differ in how they carry it.**
  In the classic model the glue-bound ground is the most brittle layer
  (strain at break about 0.002) and cracks first. Janas et al. found that
  some aged paints are more brittle than that. Lead white paint "continues
  to get stiffer and stronger" but keeps "considerable flexibility" and is
  "resistant to cracking" from its own shrinkage. Zinc white and verdigris
  become "extremely brittle". Umbers lose strength and grow more plastic
  [JANAS22]. Kim et al. found that canvas-aging cracks appear "regardless of
  the paint layer colors" and form more easily where the paint over the
  ground is thin [KIM22].
- **Width and depth.** By OCT a canvas-aging crack measured 70 µm wide and
  370 µm deep in thin paint, and 50 µm by 236 µm in thicker paint. Drying
  cracks are wider and shallower (89 × 181 µm), and in thicker paint wider
  and deeper (123 × 219 µm) [KIM22]. A saturated fine network in a lead-white
  paint layer measured 20 ± 8 µm wide, with islands about 6 paint
  thicknesses apart [JANAS22]. Real cracks vary. Knife-made fakes are
  "similar": "wide/deep or narrow/shallow" [KIM22]. Artificial craquelure
  generally comes out "uniform in appearance, while genuine craquelure has
  cracks with irregular patterns" [WIKI].
- **Hierarchy.** "The top bar of each T formed first", which gives primary
  and secondary generations (Bucklow, in the research notes). Italian panels
  show "distinct secondary networks of thin cracks" [WIKI, after Bucklow
  1997]. New cracks form midway between old ones until the spacing
  saturates [JANAS22].
- **Thin films don't crack by themselves.** Below a critical thickness a
  drying film stays whole. Near it, cracks form as "isolated star-shaped
  crack junctions", and thick films form complete networks. Stiffer paints
  crack "more spread out" [WIKI, after Giorgiutti-Dauphiné 2016].
- **Direction.** Dutch canvases crack "perpendicular to major axis of
  painting". French canvases, on thicker grounds, show "non-directional
  cracks with smooth, curved lines" [WIKI, after Bucklow 1997].
- **The stretcher.** "Most old cracked paintings have cracks corresponding
  to the stretcher inside edges" [HACK04]. Conservators name the stretcher
  bar crease (cracks along the inner edges of the bars), draw crackle
  ("parallel cracks emanating from the corners … creating a ripple
  effect"), pinwheel cracks from impacts, traction crackle and varnish
  blanching from "very minute cracking" [HART].
- **Cupping.** Most of the tension is carried in the paint and ground, "but
  where the paint cracks, all the tension is taken by the canvas", and the
  "re-alignment of forces causes the islands of paint to cup" [HACK04].
  Raking light shows cupping that frontal light nearly hides (research
  notes, §5).
- **Friedrich.** A thin paint over a two-to-four-layer ground whose top is
  "a patchy whitish" lead white [KÖR p.284], and "one to two very thin
  layers" of paint [SMB-proj]. *The Sea of Ice* has an "ear-of-grain"
  craquelure [HH]. No quantitative crack study of a Friedrich exists
  (`notes/research/friedrich_materials.md` §2, §8).

### Against the algorithm

The Round 3 engine already had the right skeleton: a sequential network
(nucleate at the highest stress/strength, run across σ1, relax, T-junctions),
spacing fitted to the ground, corners, a stretcher band and a weave prior
for thin grounds. What made it neat:

| Real craquelure | Round 6 engine | Round 7 |
|---|---|---|
| a few long first cracks dominate; later ones are finer | opening ≈ released stress: 1.0, 1.0, 0.8, 0.6, 0.4 by generation | `hierarchy`: 2.2, 1.1, 0.5, 0.2, 0.1 (≈ 73 µm down to hairlines) |
| width swells and pinches; cracks fade out | ±30% over 0.7 mm; free ends taper | also ×e^±0.55 over 3.5 mm; later cracks close shut for stretches |
| passages differ a lot | ±30% stress, lightness and film prune 0–3 generations | `patchy`: a strength field over ~11 cm (a patchy ground) grows a different network: some passages keep only their first cracks |
| a direction on some canvases | none (thick ground) | `grain`: tension along the length, drifting ±25°; a tendency (0.15) |
| grime differs; varnish residues | the same soot in every crack | `grime`: per crack amount (width, a patchy cleaning), 18% amber |
| cracks in darks show (pale ground, dust) | dark slot on dark paint, invisible, so cracks end at the dark's edge | walls show the ground: a faint light line in darks |
| thin paint: hairlines; thick: wider | opening from the film, saturated in the wet engine (film reads 250–1000 µm) | recalibrated (below) |

### What changed (`crates/paint/src/crack.rs`)

1. **`hierarchy`** (0..1, default 1). A crack's opening is
   `1.7 × 0.68^generation` × a per-crack log-normal (σ ≈ 0.45) × its
   released stress, blended with the old opening by `hierarchy`. Along the
   crack a slow swelling (e^±0.55 over 3.5 mm) multiplies the old fine
   variation. Later generations close to nothing over stretches (12%, 25%,
   38% and 50% of their length for generations 1–4, in 5 mm pieces). The
   cupping scales with √(generation factor), so primaries cup most.
   Physically: a crack keeps opening while the islands on either side
   shrink into it, so the first cracks, which split the largest islands,
   open most.
2. **`patchy`** (0..1, default 1). The film's strength is multiplied by up
   to e^1.1 ≈ 3 by a broad field (110 mm features, skewed so most of the
   canvas cracks well). There the network stops about three generations
   early. It is grown that way, not pruned, so its ends are real
   T-junctions or free ends, and it is canvas-wide, so crops match.
3. **`grain`** (0..1, default 0.15). ±`0.25 × grain` of the mean stress added
   along the canvas's longer side, its direction drifting ±25°. With it,
   cracks start off the ideal heading by up to ±50° where the stress is
   nearly isotropic, so the direction stays a tendency. At 0.5 it looked
   like rain.
4. **`grime`** (0..1, default 1). The crack's color is its shadowed walls
   (`SLOT` × paint over pale ground, 50% ground under thin paint, 15% under
   thick; the ground's color `GROUND_WALL` is an assumed yellowed lead white
   over ocher). Over them lies a gray-brown grime whose amount differs per
   crack: it grows with the opening, varies ×0.4–1.6 per crack and drops by
   up to 80% where a patchy past cleaning reached. 18% of cracks hold amber
   old varnish instead. Over lights a crack reads dark, and over darks a
   faint light line (test: 2× the paint, the old soot 0.8×).
5. **Thickness recalibrated.** The film bookkeeping counts every coat laid,
   also paint blended or wiped away, so in the wet engine it reads far above
   a real film: the lake's sky about 250 µm and the fir wood 500–1000 µm (a
   film map is in the scratch notes). `THICK_UM = 150..700` now marks thin
   to thick (it was 30..150, which saturated everywhere). The opening uses a
   physical film of 20–300 µm across that range.
6. `Cracks::even(seed)`: the Round 6 recipe (all four at 0), for
   comparisons and for the tests that measure the network.

The easel's `cracks{}` accepts `hierarchy`, `patchy`, `grain` and `grime`
(`crates/easel/src/api.rs`, one line each in the key list and the override
macro). The crack walls need the local field, so `Local` gained `walls`.
Nothing else in the shared files changed.

### API

```lua
-- the last chunk, as before: now uneven by default
wait(24*60); varnish{color="#e6d3a4", coats=0.3, vary=0.1}; cracks{}; relief()
cracks{grain=0.4}                        -- a canvas that cracked more across its length
cracks{patchy=0.3, hierarchy=0.6}        -- a more even, finer web
cracks{hierarchy=0, patchy=0, grain=0, grime=0}   -- the Round 6 look
relief(0.3)                              -- raking light: the cupped islands show
```

```rust
o.finish(&mut c, &mut rng, &Finish::aged(st.relief)); // Cracks::aged: all four on
let k = Cracks { grain: 0.4, ..Cracks::aged(seed) };
let old = Cracks::even(seed);
```

### Evidence (`notes/cracks_r7/`, lossless, built from the renders)

Made from the log on `r7-paint-wet` with `cracks{}` added before `relief()`
in the last chunk. That branch's easel (the wet engine) rendered the
painting at 3200 and at 1000 once. A scratch hook saved the canvas just
before `cracks{}`, and a harness cracked and lit it with the old and the
new code (its old output is byte-identical to
`notes/paint1/evening_lake_aged_3200.png`).

- `evening_lake_cracks_before_after_3200.png`: 1:1 crops of the 3200 render,
  before | after: the sky with the moon, the lake's glow and mirror, the
  dark fir wood against the glow. Plain crops: `before_*.png`,
  `after_*.png`.
- `evening_lake_cracks_before_after_1000.png`: the whole at 1000, each
  cracked at that resolution.
- `evening_lake_aged_r7_1000.png`, `evening_lake_aged_r7_3200.png`: the
  plain aged painting.
- `raking_light_water_3200.png`: the lake crop under `relief(0.3)`, the
  Round 6 recipe | Round 7: the cupped islands along the first cracks.

What I see. **Sky:** before, a dark, even web of 3–4 mm islands everywhere.
After, a few long wandering cracks that open and pinch, finer ones between
them that fade out, larger quiet stretches in the dark upper sky and a
denser web low in the glow. **Lake:** a well-developed passage, but with
visibly different islands, some cracks bold and many hairlines. **Firs:**
before, cracks stopped at the silhouette. After, they run on into the wood
as faint warm lines, sparser there (dark, oily, thick paint). **At 1000:**
before, a fine mesh over the whole picture. After, it is barely there: a
few long lines, a denser patch low right and draw crackle at the corners,
about what one sees standing back from an old varnished canvas.

### Tests (`crack::tests`)

- `first_cracks_open_widest`: opening by generation 1.0 … 0.4 without
  hierarchy, 2.2 … 0.08 with it; each generation narrower.
- `patchy_development_leaves_quiet_passages`: crack length per 20 mm cell,
  coefficient of variation 0.04 → 0.25, quiet cells 0 → 7%.
- `grain_turns_the_first_cracks_across`: first cracks within 30° of
  vertical on a landscape canvas: 0.34 (none), 0.56 (0.15), 0.94 (1).
- `cracks_in_darks_read_light`: over paint of 0.020 the old soot gives
  0.016 and the new walls and grime 0.041 (it fails with `grime: 0`).
- `crop_cracks_like_the_whole`: the whole `crack()` output of a crop
  matches the whole canvas within 1e-4 away from its edge.
- The older network tests pin `Cracks::even`.

### Open issues / next

- **Paint identity.** Lightness and film still stand in for pigment:
  "dark" means an oily earth or black and "light" means lead white. The wet
  engine knows the pigments while the paint is wet. A per-pixel record of
  lead white, zinc and verdigris content would let brittle paints crack
  finely and tough ones hold (Janas).
- **Own drying cracks in thick paint** (star junctions near the critical
  thickness, full networks above it) are not modeled. The film bookkeeping
  would first need a physical thickness.
- **The ground's color** in the crack walls is a constant. The canvas
  doesn't store its ground color, and storing it means a checkpoint format
  change.
- **Not done:** pinwheel impact cracks, roll damage (no solid text source
  found), the *Sea of Ice* "ear-of-grain" pattern and traction crackle.
- The factors (1.7, 0.68, the closing fractions, e^1.1, 0.25, grime ×0.4–1.6,
  18% amber, the thickness range) are tuned by eye on this painting within
  the measured widths. They are assumptions.
- The corners' draw crackle shows at 1000 as faint arcs. That is physical
  (Hartmann), but it may read as a pattern.

### Sources (Round 7)

- [JANAS22] A. Janas, M. F. Mecklenburg, L. Fuster-López, R. Kozłowski,
  P. Kékicheff, D. Favier, C. K. Andersen, M. Scharff, Ł. Bratasz,
  "Shrinkage and mechanical properties of drying oil paints", *Heritage
  Science* 10, 181 (2022). https://www.nature.com/articles/s40494-022-00814-2
- [KIM22] S. Kim, S. M. Park, S. Bak, G. H. Kim, C.-S. Kim, J. Jun,
  C. E. Kim, K. Kim, "Investigation of craquelure patterns in oil paintings
  using precise 3D morphological analysis for art authentication",
  *PLoS One* 17(7): e0272078 (2022).
  https://pmc.ncbi.nlm.nih.gov/articles/PMC9333328/
- [HACK04] S. Hackney, "Paintings on Canvas: Lining and Alternatives",
  *Tate Papers* 2 (2004).
  https://www.tate.org.uk/research/tate-papers/02/paintings-on-canvas-lining-and-alternatives
- [WIKI] "Craquelure", Wikipedia (after S. Bucklow, "The Description of
  Craquelure Patterns", *Studies in Conservation* 42 (1997), and
  F. Giorgiutti-Dauphiné, "Painting cracks", *J. Appl. Phys.* 120, 065107
  (2016)). https://en.wikipedia.org/wiki/Craquelure
- [HART] Hartmann Fine Art Conservation, "Conservation damage terms".
  https://www.hartmannconservation.com/damage-terms
- AIC Conservation Wiki, "Crackle" (Stout's 1974 terms, Bucklow's features).
  https://www.conservation-wiki.com/wiki/Craquelure
- [KÖR], [SMB-proj], [HH]: `notes/research/friedrich_materials.md`.

---

