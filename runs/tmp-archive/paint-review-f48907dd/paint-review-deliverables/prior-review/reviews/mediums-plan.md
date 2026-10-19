# Refactoring for oil on panel and watercolor

Ship **oil on a prepared panel first**, using the existing oil model. Then add **watercolor as a separate material state**, sharing the easel, geometry and optical calculations. The main simplification is to give support preparation, paint behavior, material inventories and artist instructions separate owners.

This is a design proposal against `f97d5c0`, informed by the [adversarial review](review.md) and primary material research. No implementation changes were made. The proposed watercolor scope is paint that responds to wetness, drying and rewetting; its numerical coefficients will need calibration.

## The boundaries to introduce

| Responsibility | Concrete owner and change |
|---|---|
| Support and preparation | One descriptor for linen, prepared panel or sized paper. Construction supplies physical dimensions, initial reflectance and surface texture; paper additionally supplies water-holding and absorption properties. Extract this from [Style](../repos/claude-paint-reviewed/crates/paint/src/style.rs#L62) and the [Lua setup](../repos/claude-paint-reviewed/crates/easel/src/api.rs#L1144). |
| Paint behavior | One explicit choice of oil or watercolor state at the painting boundary. Each state owns its mutable material arrays and advancement in time. Keep the existing oil implementation and numerical order intact during extraction. |
| Paint formulation | Keep pigment identities, but give oil and watercolor their own formulation records. [Tube](../repos/claude-paint-reviewed/crates/paint/src/palette.rs#L24) currently combines color with oil stiffness and drying. Watercolor needs water quantity, component pigment amounts and pigment-specific deposition/lifting properties. |
| Shared mechanics | Retain frames, masks, paths, deterministic randomness, drawing geometry and image delivery. Extract brush contact coverage when both media use it; oil and water own their loading, deposition and pickup behavior. [Brush exchange](../repos/claude-paint-reviewed/crates/paint/src/bristle.rs#L1129) already has this boundary. |
| Shared optics | Reuse [Kubelka–Munk layering](../repos/claude-paint-reviewed/crates/paint/src/pigment.rs#L161), the calculation of light absorption and scattering through paint. Calibrate watercolor optical amount against pigment deposit; retain existing oil calibration for its engine versions. |
| Artist instructions | The studio brief selects Bruegel style. Material support and transport code contain physical properties. One small studio configuration selects medium, support, box, documents and allowed artist names. |

Dispatch between media at setup, material application, time advancement and rendering. The inner transport loops operate on one medium's concrete arrays. Begin by extracting support construction; extract additional shared code when the watercolor implementation actually needs it.

## Implementation order

### 1 Repair the guarantees the new paintings will depend on

Close the iterator and temporary-weak-table replay gaps, repair partial log commits, bound native work and correct launch/reader failures from the review. Remove the extra whole-painting clone on failure: [run already takes ownership of its snapshot](../repos/claude-paint-reviewed/crates/easel/src/session.rs#L272), so [restore](../repos/claude-paint-reviewed/crates/easel/src/session.rs#L189) can consume it and move its state back.

Give the easel a committed surface-activity counter. Pigment marks, drawing, water application and lifting count; observation and plain waits do not. Include it in rollback and publish it after persistence succeeds. This removes the runner's [Lua-text classifier](../repos/claude-paint-reviewed/notes/round19/runner/painting_chunks.py#L69) and will recognize watercolor interventions that leave no immediate colored mark.

These repairs gate new painter launches. The support work can proceed independently while those repairs are prepared.

### 2 Add the prepared panel and Bruegel inventory

The engine's [Canvas already permits absent linen](../repos/claude-paint-reviewed/crates/paint/src/canvas.rs#L241). Mandatory linen comes from Style and Lua setup. Add an explicit prepared-panel path with a smooth, pale ground, while preserving the existing linen constructor for old logs.

Describe the cured preparation independently of oil-palette piles: the present [ground parser](../repos/claude-paint-reviewed/crates/easel/src/api.rs#L1410) requires every ground to come from those piles. A chalk-and-glue ground is a distinct preparation material. For the first panel implementation, construct its final prepared surface directly. State that ground absorbency and preparation chemistry are approximations; the existing oil solver does not model a full chalk/glue absorption process.

Add a sourced Bruegel material box. Keep historical oil boxes and their numbers unchanged. Gate delivery finishing on support: [cracking currently invents linen pitch when linen is absent](../repos/claude-paint-reviewed/crates/paint/src/crack.rs#L1351). The first panel release should use ordinary oil drying and an explicit finish choice; panel aging can follow a researched model later.

**Release result:** a painter can set up a smooth prepared panel, draw, mix the selected oil paints, make fine and broad marks, dry them and replay the result exactly.

### 3 Establish the watercolor session and time boundary

Introduce one immutable session specification containing engine version, medium and material box. Move version ownership out of the palette. Resolve the specification before constructing Lua, because [tool registration and the owned-global baseline](../repos/claude-paint-reviewed/crates/easel/src/session.rs#L128) are established at session creation.

Write those identifiers before the first chunk. Keep support, preparation, physical size and seed in the logged setup command: [persistence is append-only](../repos/claude-paint-reviewed/crates/easel/src/main.rs#L703), so setup must not rewrite an earlier header. Missing medium in historical logs means legacy oil. Validate the selected box, support and medium before allocating arrays.

Give simulation time one owner. Each medium advances to the requested time, including time consumed by strokes. Preserve legacy oil timing; the current [one-minute and fifteen-minute hand-time batching](../repos/claude-paint-reviewed/crates/easel/src/time.rs#L22) needs a finer event schedule for watercolor. Repair the reviewed oil gel-settlement dependence on wait boundaries under a new engine version. Schedule watercolor material operations at the same simulated times regardless of chunk boundaries; a chunk ending must not make the next brush encounter an older wash. Save any solver progress needed to resume that timeline exactly.

Split Lua registration into common setup/geometry/observation and concrete oil/watercolor modules. This removes medium branching from the already large `api.rs` while keeping each medium's material contract explicit.

### 4 Build a complete small watercolor experiment

Use one sized-paper preset and a small fixed palette. The first experiment should cover wet-on-dry, wet-on-wet, drying, adding clean water and lifting pigment.

Its state needs surface water, water within the paper, mobile pigment and deposited pigment. The transport model computes water flow; retain velocity or other flow history only if the selected solver needs it. Retain individual pigment amounts after mixing and drying; final RGB is a rendered view. The current [oil bake](../repos/claude-paint-reviewed/crates/paint/src/drying.rs#L484) reduces deposits to RGB, which cannot supply the pigment identity needed by later lifting or separation.

For a bounded initial model, retain ordered dry washes with their pigment deposits and one active wash. Rewetting transfers eligible pigment back to the active wash according to its lifting parameters. Put explicit limits on retained washes and palette size, and report those limits before accepting work. Define layer retirement before implementation: it must preserve pigment identity needed by supported lifting operations, and reaching a limit must fail before accepting another wash. Local drying must leave other wet regions free to continue evolving. This proposed representation must be checked against glazing and lifting experiments before extending it.

Water amount and pigment amount need separate controls. Keep oil's existing `medium=` meaning unchanged; the watercolor API should name water explicitly. Start from shared path/contact geometry and give a watercolor brush its own reservoir and exchange behavior.

### 5 Complete watercolor behavior and delivery

Add edge accumulation, pigment-specific granulation and backruns—spreading fresh water into a partly dried wash—through the transport/deposition model. Tune them against material experiments. Treat the small wash experiment as a prototype until those characteristic effects, rewetting and delivery are verified.

Select finishing from the logged medium and support. [The finishing script](../repos/claude-paint-reviewed/scripts/finish_painting#L27) currently adds oil varnish and cracks by default and waits in month-sized increments. Watercolor delivery should dry through its own model and render the paper and deposits. Keep `paint`, `look`, `status`, notes, the viewer and gallery observation flow shared, with medium/support metadata attached to the result.

## Material research and its limits

For Bruegel, the Kunsthistorisches Museum documents oak panels and a smooth, sanded, pale chalk-and-animal-glue ground. Its pigment findings include earths, lead-tin yellow, vermilion, blacks, lead white and azurite. That supports a conservative prepared-panel preset and a researched inventory, with work-specific qualifications. [KHM technical research](https://bruegel.at/en/revealing-glimpses-into-the-heart-of-panel-paintings/)

The Met describes thin luminous layers and thicker direct marks in *The Harvesters*. Those are useful material behaviors to support. A panel preset should leave composition and brushwork to the painter. [Met material account](https://www.metmuseum.[opaque token redacted])

Azurite is absent from the current catalog. Several proposed Bruegel pigments already have oil records, including lead-tin yellow, but their values are estimates. Establish missing records and document proxy choices and uncertainty. The research above does not establish one universal palette or exact optical and rheological coefficients for all Bruegel paintings.

For watercolor, Curtis and colleagues separate surface flow, pigment deposition/lifting and capillary water, with optical layering afterward. They explicitly describe their model as empirical. It is a useful starting reference, and the engine already cites it for optics. [Computer Generated Watercolor](https://grail.cs.washington.edu/wp-content/uploads/2015/08/curtis-1997-cgw.pdf)

Paper treatment matters: ARCHES describes cotton paper with gelatin sizing and different surface textures. Winsor & Newton lists pigment-specific granulation and staining. Use those as qualitative calibration targets; manufacturer categories do not supply solver coefficients. [ARCHES paper properties](https://arches-papers.com/arches-range-of-papers/watercolor-and-wet-techniques/arches-aquarelle/), [watercolor pigment properties](https://uk.winsornewton.com/pages/professional-watercolour)

Experiments on watercolor droplets also show that initial paper wetness and surface water distribution affect dried patterns. This supports including wetness in calibration trials. It does not validate a chosen whole-painting solver. [Droplet experiments](https://arxiv.org/abs/1909.09098)

## Performance and verification

Live sessions are fixed at [2400 pixels wide](../repos/claude-paint-reviewed/crates/easel/src/main.rs#L43). At 2400×2400, one field with a 32-bit value per pixel costs approximately **23 MB**. Eight pigments with mobile and deposited fields alone cost **369 MB**, or **737 MB** with a full rollback copy. These are allocation estimates for one mobile/deposited set, excluding flow, paper, image and temporary buffers. Each additional full dry wash of eight pigment fields adds about **184 MB**, or **369 MB** with a full rollback copy; taller aspect ratios also cost more.

Allocate only the selected medium's arrays, share immutable support data, reuse transport buffers and process wet bounds with enough neighboring cells for each step. Calculate the allocation budget from resolution, aspect ratio, pigment count and retained washes before allocation. Start with the snapshot move above and measure memory and latency at actual session resolution. If full-resolution transport exceeds the agreed resource budget, use an explicitly logged simulation grid and qualify its detail limits; display resolution alone must not imply more simulated detail.

Water flow can enter a viewing crop from outside it. Initially simulate the whole support and crop the output. The existing [cropped-canvas optimization](../repos/claude-paint-reviewed/crates/paint/src/canvas.rs#L151) cannot establish an exact watercolor replay with a fixed margin.

Use a small set of independent release checks:

- Existing oil logs retain their expected images and material state through structural extraction; changed physics is engine-versioned.
- Failed chunks restore deposits, water, brushes, time and activity; live, replay and checkpoint resume agree on the complete relevant state. The [checkpoint format](../repos/claude-paint-reviewed/crates/paint/src/checkpoint.rs#L16) must include every new field that affects later marks.
- Observation leaves simulation state exactly unchanged. Chunk splitting keeps material operations on the same timeline. Split waits agree at the target time within a declared numerical tolerance for the new solver, with saved solver progress preventing accidental step resets. Same-log replay still needs exact agreement.
- Water accounting matches input, absorption, evaporation and removal; pigment accounting matches mobile, deposited and removed amounts. Values stay finite and nonnegative under bounded inputs.
- Small material trials demonstrate pale-ground transparency and fine panel marks; watercolor trials demonstrate wetness-dependent edges, granulation, glazing and pigment-dependent lifting. Compare against independent swatches or experiments, with tolerances and approximations stated.

One primary check should own each contract at its real boundary. No live watercolor benchmark or new implementation test has run in this design review.

## Painter inputs and remaining reviewed cleanup

Export a common tool guide plus only the selected medium's physics, support preparation and artist material notes. Generate the paint table from that medium's actual formulation. Keep developer source literature outside the painter packet; curate its material facts so unrelated artists, compositions and example recipes do not enter shared physics notes.

The requested Bruegel brief intentionally names the artist. Inherited material notes must be bound to medium, support, box and engine revision. Existing oil-on-linen notes contain drying, weave and irreversible-setting assumptions that would mislead a watercolor successor. Give readers bounded session text and real image files, and preserve exact input bytes and hashes outside the painter's readable folder.

Use one supported future runner and the same small studio configuration for export and launch. Preserve historical runners as records. Repair gallery output ownership, image invalidation and locking before delivering through those paths. Delete the duplicated Lua world recipe and share shadow traversal when scene code is touched; neither is a dependency of adding prepared panel or watercolor transport.
