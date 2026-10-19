(•̀ᴗ•́) Reviewed Round 6 for structural quality. Three findings follow, verified by code inspection rather than runtime tests. References use the named change set's file versions. These are maintainability findings, not claims of reproduced rendering failures.

## 1. High — r6-wet — Give the layered film one owner

**Where:** `crates/paint/src/bristle.rs:632–801, 1547–1570, 1638–1657`; `crates/paint/src/wet.rs:179–204`.

The new film model is split between canvas-wide parallel arrays (`vol`, `top`, `mid`, `midx`), a stroke-local `Vec<Mid>` containing the reserved pigment and unsafe operations inside the brush module. A volume is meaningful only when paired with pigment owned somewhere else. Both pickup and plough manually reconstruct those pairs after receiving an untyped `[f32; 3]` from `take` or `take_column`. Stroke completion must separately call `settle_mid` in both `drag_on` and `touch_on` (`bristle.rs:1202–1203, 1866–1867`).

This is a structural regression: a change to film representation requires coordinated edits to brush transport, raw-pointer access and stroke lifetime handling. Conservation becomes a protocol that callers must remember rather than a property of a small set of operations. The branch expands an already oversized `bristle.rs` from 1,898 to 2,357 lines; the concern is the new responsibility, not merely the count.

**Concrete fix:** Move layered-film mutation behind a dedicated wet-film view and a stroke-scoped reservation context. Return typed paint parcels containing volume, latent pigment and properties from pickup and column extraction. Let the film implementation resolve reserved pigment and finish reservations, leaving brush code to calculate contact coefficients and transport parcels. Keep the structure-of-arrays storage and existing operation order so this does not require per-pixel allocation or reordered floating-point arithmetic. Retain the conservation test at `bristle.rs:2250–2357` as an acceptance gate.

**Status:** Verified.

## 2. Medium — main — Extract the shared timed-pass protocol

**Where:** `crates/paint/src/handling.rs:845–931`; `crates/paint/src/stipple.rs:550–608`; `crates/paint/src/tally.rs:252–275`.

`batches` extracts only the easiest part of timed painting. Both callers independently clone and sort each batch, reserve stroke IDs, construct offsets, obtain the surface view, discard off-window tiles, invoke ordered painting, combine dirty bounds and advance hand time except after the last batch. These are the same replay-sensitive scheduling rules implemented twice around different mark painters.

The fixed-ID exception adds another protocol: `run_plans` receives a `sliced` boolean, while each plan independently carries an optional ID (`handling.rs:475–483, 775–781`). The caller must keep those two choices consistent. The earlier ID-watermark fixes should not be undone, but their shared invariant should not remain duplicated.

**Concrete fix:** Introduce a common timed-pass plan/executor alongside `sched::run_ordered` (`sched.rs:43–45`). It should own canonical ID allocation, crop filtering, dirty-bound aggregation and between-batch waits. Keep stroke/touch costing and tile painting specialized. Represent preassigned-ID passes explicitly instead of passing an unrelated boolean. Preserve existing RNG consumption, tile order and the unclocked final slice exactly; validate both callers against replay, crop and thread-count tests.

**Status:** Verified. This reports duplication remaining after the prior fixes, not the already-fixed timing failures.

## 3. Medium — main — Stop encoding brush interpolation policy as tree geometry

**Where:** `crates/paint/src/broadleaf.rs:1417–1435, 1579–1581`; `crates/paint/src/bristle.rs:750–757, 814–818`.

The tree module subdivides angular wood into points every 0.5 canvas units specifically so “a brush's spline through them keeps the corners.” The brush then densifies those points again, independently for its footprint and its painted path. This makes the tree's exported geometry compensate for an implementation detail of brush interpolation. Changing spline behavior now requires understanding and potentially retuning the tree's sampling workaround.

The new wood-selection and stroke-preparation responsibilities also grow `broadleaf.rs` from 1,510 to 2,000 lines. It did not newly cross 1,000 lines, but this substantial addition has a clear decomposition boundary.

**Concrete fix:** Extract wood selection and width-band construction into a focused module. Move corner-preserving path preparation into the canonical brush/path layer, exposing an explicit prepared-path contract used by both footprint calculation and painting. Initially preserve the exact 0.5-unit subdivision and subsequent spline calculations there; replacing them immediately with a true polyline would change output and should be a separate decision. This removes the tree-to-spline dependency without silently changing existing marks.

**Status:** Verified.

## Verdicts

- **main:** Request structural changes to timed-pass orchestration and wood-path preparation before quality sign-off. Findings 2 and 3 identify concrete seams without reopening the prior functional fixes.
- **r6-wet:** Hold quality approval until film ownership and transport are encapsulated. Finding 1 is the strongest blocker: reserved-film correctness currently spans too many independently maintained representations and call sites.
