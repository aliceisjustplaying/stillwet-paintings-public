- day 1, 09:00: # Studio Journal: Still Life with Quince, Terracotta, and Linen

  ## Sitting 1: Conception, Palette Formulation & Underdrawing

  ### Intention & Composition
  I am setting out to paint an intimate, atmospheric still life inspired by 17th-century Spanish bodegones and Chardin. A high cool light source from the upper left rakes across a warm, textured plaster wall and illuminates a walnut table. On the table rests an unglazed terracotta pitcher, a ripe bumpy quince with a cut section exposing its pale seed core, a small glazed earthenware bowl with dark ripe figs, and a folded coarse linen cloth cascading over the table's front edge.

  ### Canvas Setup
  - Linen: Plain weave, 18 warp x 14 weft threads/cm, sized at 500 mm width, aspect ratio 4:3 (W=1000, H=750).
  - Ground: Two coats. First coat is lead white with raw umber and yellow ochre (35 µm, applied with knife, texture 0.15), filling the weave interstices. Second coat is a warm ochre-umber imprimatura (20 µm, applied with roller), dry and semi-matte.

  ### Material Trials on Scratch Canvas
  - Tested palette piles:
    - `p_wall_dark`: raw umber 4, bone black 2, yellow ochre 1, burnt sienna 1. Deep warm shadow tone.
    - `p_wall_light`: raw umber 2, yellow ochre 3, lead white 5, green earth 0.5. Muted warm plaster with greenish-gray cast.
    - `p_wood`: raw umber 5, burnt sienna 3, bone black 1, yellow ochre 1. Dark aged walnut masstone.
    - `p_terracotta`: burnt sienna 4, red earth 2, yellow ochre 2, raw umber 1.
    - `p_terracotta_light`: burnt sienna 2, yellow ochre 4, lead white 3.
    - `p_quince_skin`: yellow ochre 4, cadmium yellow 2, raw sienna 1, lead-tin yellow 1, lead white 1.
    - `p_linen_body`: lead white 8, yellow ochre 1, raw umber 0.5.
    - `p_linen_shadow`: lead white 4, raw umber 2, vine black 0.5, cobalt blue 0.3.
  - Observed on scratch canvas:
    - Broad hand at width 40 with fill=true provides solid lay-in coverage over the textured ground while retaining the directional sweep of the flat bristle.
    - Modeling wet-into-wet with body hand followed by a light blend (pressure 0.4, width 25) fuses tonal values without obliterating the form's directional structure.
    - Hypothesis: A slightly heavier load (load >= 0.8) prevents dry-brush drag on unpainted dry imprimatura, whereas scumbling on semi-dry layers benefits from load ~0.3 at light pressure.
- day 1, 09:03: ### Campaign 1: Underdrawing Evaluation
  - The graphite underdrawing (pencil 2B) establishes clear proportional relationships.
  - The horizon line at y=480 places the tabletop solidly in the lower half of the frame, giving ample breathing room for the plaster wall behind.
  - Pitcher height (spanning y=205 to 555) creates a strong vertical anchor on the left, counterpointed by the horizontal rhythms of the fruit and bowl on the right.
  - The folds of the draped napkin break the front table edge (y=700) down toward y=745, establishing spatial depth toward the viewer.
  - Plan for Campaign 2: Block in the large background masses (the plaster wall and the dark walnut tabletop) using broad brushes with directional strokes, establishing the primary light-to-dark gradient across the room.
- day 1, 09:36: ### Campaign 2: Large Masses Evaluation
  - Background plaster wall and walnut tabletop laid in successfully.
  - The raking light gradient across the wall from upper-left (warm buff-olive) to lower-right (deep umber) creates convincing chiaroscuro and atmospheric space.
  - The tabletop sits with clear planar weight; the horizontal brush strokes convey the wood plank structure.
  - The front bevel at y=700..750 establishes the foreground plane cleanly.
  - Value and squint modes confirm strong structural values: light upper-left falling across to deep darks on the right and bottom.
  - The underdrawing remains visible through the midtones to guide the blocking in of the objects.
  - Plan for Campaign 3: Block in the primary masses of the still life objects—the unglazed terracotta pitcher, the coarse linen napkin folds, the ripe golden quince with cut wedge, and the dark glazed fig bowl—establishing their silhouette values, core shadows, and primary local colors.
- day 1, 10:01: ### Campaign 3: Object Blocking Evaluation
  - Silhouettes and local color block-ins are solidly anchored.
  - The spatial staging reads clearly: pitcher on the left acts as a tall warm pillar, linen spills forward over the apron, quince commands the mid-stage, and dark fig bowl grounds the right.
  - Observations on passages needing development:
    1. Pitcher modeling: Currently reads as flat silhouette. Needs volumetric modeling with directional strokes following form curvature—lit shoulder/belly on the left, core shadow on the right, warm reflected ambient light on the far right flank, and mouth rim structure.
    2. Linen cloth: Planar division is established, but boundaries need softening and crests need thick lead white impasto strokes to catch the raking light.
    3. Quince: Needs spherical modeling with halftones, core shadow, and delicate broken-color skin texture; cut wedge needs moist translucency and crisp seed cavity.
    4. Figs & bowl: Dark glazed bowl needs a sharp specular highlight on the rim; figs need dusty bluish bloom over dark skins and glistening highlights on the cut ruby pulp.
    5. Cast shadows: Need subtle feathering/blending at the penumbra edges.
  - Plan for Campaign 4: Volumetric modeling, halftones, core shadows, and reflected light on all objects wet-into-wet.
- day 3, 10:24: ### Campaign 4 & 5: Modeling, Final Accents, and Drying Evaluation

  #### Material Observations & Studio Lessons
  1. **Tool Signatures & Lua Scope**:
     - `Brush:touch` requires coordinates `(x, y)` and an optional table `{pressure = ...}`; passing a bare number for pressure caused an argument conversion error.
     - Global variables persist across chunks (`p = pile{...}`), whereas `local` variables do not. A failed chunk in Campaign 4 occurred when attempting to use a local mask defined in a previous chunk. Re-declaring masks locally within each campaign chunk ensured deterministic execution without leaking large mask memory.
     - A chunk error changes nothing on the canvas and does not advance the clock, preserving the physical state intact.

  2. **Substrate, Wetness, and Layering Conditions**:
     - *Substrate*: Linen (18x14) with knife-leveled ground (35 µm) and warm imprimatura (20 µm).
     - *Wetness*: Working wet-into-wet during Campaigns 3 and 4 allowed subtle sfumato transitions across the terracotta pitcher belly and the linen shadow slopes without sharp contour banding.
     - *Blending*: A wide filbert brush (width 25) with light pressure (0.35) and low blend coverage effectively fused the core shadow (`p_terracotta_core`) into the terracotta body (`p_terracotta_base`) and warm reflected ambient light (`p_terracotta_bounce`).
     - *Scumbling & Glazing*: The dusty fig bloom (`p_fig_bloom`: ultramarine ash 2.5, zinc white 1.5, medium 0.4) applied with hand "scumble" at low coverage (0.35–0.4) produced a delicate chalky veil over the dark purple-black skin without muddying the dark mass underneath.
     - *Impasto Relief*: The high-lead-white linen impasto (`lead white` 10, `yellow ochre` 0.5, `Naples yellow` 0.3) at load 0.9 and pressure 0.85 formed crisp physical ridges along the fold crests that catch the raking relief light distinctly.

  3. **Recipes & Ratios Evaluated**:
     - *Terracotta body*: burnt sienna 4, red earth 2, yellow ochre 2, raw umber 1. Natural earthen clay warmth.
     - *Terracotta core shadow*: raw umber 6, bone black 2.5, burnt sienna 2. Dense, non-chalky shadow.
     - *Terracotta bounce*: burnt sienna 3, raw sienna 2, lead white 1, yellow ochre 1. Sits naturally against the dark background.
     - *Ripe quince skin*: yellow ochre 4, cadmium yellow 2.5, raw sienna 1, lead-tin yellow 1, lead white 1. Waxy, vibrant, earthy gold.
     - *Quince cut flesh*: lead white 7, lead-tin yellow 2, yellow ochre 0.5. Crisp, pale, moist ivory.
     - *Cut fig pulp*: rose madder 5, vermilion 1.5, medium 0.3 with impasto seed touches (lead white 4, vermilion 2, cadmium yellow 1). Glistening ruby center.
     - *Aged walnut tabletop*: raw umber 5, burnt sienna 3.5, bone black 1, yellow ochre 1. Solid plank weight.

  4. **Drying Behavior (48-hour rest)**:
     - Advancing the clock by 2880 minutes (2 days) brought the oil films to touch-dry. The paint settled subtly into the linen weave, slightly leveling microscopic striations while preserving macro impasto ridges on the cloth crests and clay highlights.

  5. **Handoff for Next Sitting**:
     - *Unresolved passages*: None identified; all forms, tonal hierarchies, and edge transitions read coherently across value, relief, gallery, and squint modes.
     - *Hypotheses carried forward*: High-viscosity lead-white impasto maintains frozen ridge relief best when laid over semi-dry or setting underlayers rather than heavily fluid medium glazes.
     - *Uncertainties*: Whether further aging over simulated months would increase lead-white saponification / transparency; for current pictorial intentions, the opaque body of the white remains solid and luminous.
- day 3, 10:24: ## Sitting 2: Final Inspection, Reflection & Completion

  ### Studio Reflections
  Returning to the easel after a 48-hour rest, the picture has settled into complete harmony.
  - The raking cool daylight sweeps diagonally across the warm olive-buff lime plaster wall into the velvety umber chiaroscuro on the right.
  - The unglazed terracotta pitcher stands firm on the left, modeled with convincing cylindrical volume, warm earthen body color, deep core shadow, and delicate reflected table bounce.
  - The coarse folded linen cloth cascades with sculpted lead-white impasto ridges across the front edge of the walnut table, leading the viewer directly into the quiet scene.
  - The ripe knobby quince and its glistening cut wedge anchor the composition's center, offset by the deep violet figs and dark glazed bowl on the right.
  - All edges—from the soft penumbra of the cast shadows to the sharp specular glaze on the bowl lip—function in concert.
  The heart is completely content with this painting; no further marks are needed.

  ### Final Handoff Summary
  1. **Passages Unresolved / Deliberately Accepted**:
     - No passages remain unresolved. The slight organic irregularities in the earthenware rim and the knobby bumps of the quince skin were intentionally preserved to convey authentic handcrafted and natural form.

  2. **Practical Lessons Carried Forward**:
     - *Chunk Scoping*: In Lua, `local` variables do not persist between separate chunks. Any masks or helper geometry needed in subsequent passes must either be declared globally or redefined locally within each chunk.
     - *Tool Signatures*: `Brush:touch` expects `(x, y)` followed by an options table `{pressure = ...}`, not a raw numeric pressure argument.
     - *Wet-into-Wet Modeling*: Blending with a wide flat/filbert brush at light pressure (0.35) into freshly laid body paint (within ~1 hour of clock time) creates seamless cylindrical modeling without edge seams or patchy lifting.
     - *Failed Recipes Addressed*: Attempting to pass numeric pressure to `b:touch` failed initially; once diagnosed, using `{pressure = 0.5}` gave precise pinpoint impasto touches.
     - *Dry Layer Scumbling*: The dusty bloom on dark fruit is best achieved with low coverage (0.35) and a lean or semi-thinned scumble (`ultramarine ash` + `zinc white` + medium 0.4) over set paint, preventing pigment drag.

  3. **Material Conditions & Hypotheses Carried Forward**:
     - *Substrate*: Plain-weave linen (18 warp x 14 weft threads/cm) with knife-leveled ground and warm imprimatura.
     - *Hypothesis*: Heavy-body lead-white paint (load >= 0.85, pressure >= 0.8) retains physical impasto relief without leveling even across multi-day curing, providing durable tactile crests.
     - *Uncertainties*: The exact long-term yellowing rate of cold-pressed linseed oil in dark walnut passages over simulated decades remains unmeasured, though raw umber's drying speed should stabilize the film.
