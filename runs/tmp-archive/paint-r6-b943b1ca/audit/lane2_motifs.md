# Lane 2: paint motifs and scenes, test audit (discovery, read-only)

Checkout: [local path redacted] at 9e7dc94 (main). Nothing in the repo was edited.
Mutation experiments ran in a `git archive` copy at [local path redacted] (created with agent-tmp; the brief's audit dir holds only this report).

## Scope and baseline

In-scope files with tests: crack (13), scene (13), atmos (8), outline (8),
growth (7), form (7), rock (5), broadleaf (4), broadleaf/wood (3), fence (3),
fir (3), checkpoint (3), pigment (3), surface (3), sched (2), path (1). That's 86
tests. color, edge, hand, lib, rng, shape and style have no tests.

Baseline on main, in the scratch copy:
`timeout 600 cargo test -q --release -p paint --lib -- crack:: scene:: atmos:: outline:: growth:: form:: rock:: broadleaf:: fence:: fir:: checkpoint:: pigment:: sched:: surface:: path::`
gave `83 passed; 0 failed; 3 ignored`. No test fails on main, so there's no product-bug lead.

Overall, this lane is healthy. Nearly every test asserts physical or geometric
behavior with independent expectations: shadow direction from one sun, the
penumbra widening with distance, Fresnel, pipe-model widths, islands against
target size, T-junctions, the weave coupling, conservation within bounds, and
checkpoint rejection of corrupt data. I found few candidates.

## Candidates

### 1. `crack::tests::crop_origin_doesnt_move_the_local_field` (crates/paint/src/crack.rs:1717-1755)

- **What it can detect:** the private `Canvas::crack_local` averaging grid
  being anchored to the crop's corner instead of the canvas. It compares
  `Local::at` reach and opening between whole and crop to within 1e-4.
- **Non-test callers of the seam:** `crack_local` is called in production by
  `Canvas::crack` (crack.rs:1338), so deleting the test unlocks no production
  code.
- **Stronger remaining proof:** `crop_cracks_like_the_whole`
  (crack.rs:1927-1955) compares final crop pixels to whole-canvas pixels
  (worst difference < 1e-4) through the public `Canvas::crack`. Mutation check
  in the scratch copy:
  - Mutant A reverted c948163's anchoring on both axes (`nx = f.w.div_ceil(n)`,
    cells from buffer 0, `o = f.x0*px`). Both tests fail:
    `crop differs from whole by 0.025319844`.
  - Mutant B anchored x correctly and y wrong. Both tests fail:
    `crop differs from whole by 0.015207469`.
  - So the pixel-level owner catches the regression on each axis.
- **History:** `git log -S` shows the test landed in c948163 ("local field cells
  anchored to the whole canvas grid ... non-aligned crop regression"). That
  commit is the 308th from HEAD. `crop_cracks_like_the_whole` came later, in
  0c8c939 (the 43rd), with "crop = whole" tests. The regression test predates
  the stronger end-to-end test, which now covers it.
- **Deletion unlocked:** about 39 test lines. No production code.
- **Risk:** low. The end-to-end crop happens to cut cells on both axes. If
  someone later moves its crop units to a cell-aligned origin, the guard would
  weaken. Mitigation: move the regression's doc comment (review3 physics #2,
  cells cut by the crop) onto `crop_cracks_like_the_whole` and state that its
  crop must not start on a cell boundary. Optionally add the
  `f.x0 % n != 0 && f.y0 % n != 0` precondition assert, which is test-local.
- **Validation:** `timeout 600 cargo test -p paint --lib crack::tests::crop_`,
  plus the Mutant A/B diffs above re-applied in a scratch copy. Expect the
  remaining test to fail on both.
- **Proposed action:** merge into `crop_cracks_like_the_whole` (keep its
  history comment and the non-aligned precondition), then delete.

### 2. `rock::look::grisaille` (crates/paint/src/rock.rs:1532-1612)

- **What it can detect:** nothing. It's `#[ignore]` and returns early unless
  `ROCK_LOOK` is set. It has no assertions: it writes `rock_look.ppm` and
  `println!`s plane counts. This matches the "assertion-free coverage probe"
  pattern.
- **Non-test callers of the seam:** everything it calls has production callers
  in the easel bindings:
  - `Rock::core`, `reflected` and `value` (crates/easel/src/draw_rocks.rs:244-246);
  - `cast` and `snow` (draw_rocks.rs:277);
  - `lit_share` (draw_rocks.rs:328).
  So it unlocks no production code.
- **Stronger remaining proof:** the behavior contracts are owned by
  `rock::tests::{many_planes_and_no_single_seam, a_crack_is_a_dark_groove,
  deterministic_and_kinds_differ, it_casts_a_shadow_on_the_ground}`. Looking at
  rocks is covered by painter-facing studies in paintings/src/bin
  (study_motifs, study_form `--grisaille`).
- **History:** added in 35bd323 ("rock: planes cut tangent to an inflated
  mass"). It was a developer look tool while retuning rock planes. Unlike the
  project's other ignored probes (probe_twilight in notes/atmosphere.md:59;
  probe_bare and probe_mark_area in notes/surface.md; the probes in
  notes/fixes_paint.md:55), nothing in notes/ or README cites it. `rg
  'ROCK_LOOK|rock::look|rock_look'` only matches itself.
- **Deletion unlocked:** about 80 test lines. No production code.
- **Risk:** low. It only affects whoever still uses it as a viewer. If Alice
  wants to keep it, move it to a `paintings/src/bin` study instead of a test.
- **Validation:** `timeout 600 cargo test -p paint --lib rock::` (all 4 pass;
  the ignored count drops by 1).
- **Proposed action:** delete, or move to a study bin if the owner still uses
  it. Medium-high confidence, subject to the project's instrument convention
  (see the retained items).

### 3. The equal-heights sub-block of `outline::tests::lobes_are_continuous_at_joins_and_the_seam` (crates/paint/src/outline.rs:1374-1379)

- **What it can detect:** any change to the lobe shape constants. The expected
  value `2.0 * ((PI * u).sin().powf(0.6) - 0.55)` is the implementation's own
  formula. It was copied from the pre-refactor line that b997038 removed
  (`- d += h * ((PI * u).sin().max(0.0).powf(0.6) - 0.55);`), and the same
  constants live in `lobe_troughs` (outline.rs:1128-1132) and `lobe_offset`
  (outline.rs:1146). This matches "expected values produced by the helper under
  test", and it asserts through the private `lobe_offset`.
- **Non-test callers of the seam:** `lobe_offset` and `lobe_troughs` are
  private and have production callers in the line drawing (outline.rs:1089
  area). Nothing is unlocked.
- **Stronger remaining proof:** the same test's continuity asserts at knots and
  the seam, its "bulge rises above the dips" assert, and its whole-line
  no-step check through `Outline::draw` all cover the review 4 #8 contract.
  `amount_scales_lobes_set_after_it` covers amplitude. The sub-block's only
  distinct job was a one-time refactor-equivalence check ("equal heights: the
  old shape") in b997038.
- **Deletion unlocked:** 6 test lines.
- **Risk:** low. Retuning lobe roundness (0.6) or dip depth (0.55) is an
  aesthetic choice, and today it fails this test with no behavior regression.
- **Validation:** `timeout 600 cargo test -p paint --lib outline::tests::lobes`
- **Proposed action:** delete the sub-block and keep the rest of the test.
  Medium confidence.

### 4. Small tidy-ups (same batch, no behavior)

- **`let _ = rs[0].ridge(...)`**, atmos.rs:1549 in `ranges_are_uneven`: a
  no-assert "doesn't panic" line. `RangeLayer::ridge` has production callers
  (crates/easel/src/world.rs:437; paintings/src/bin/study_sky.rs:110). Either
  drop the line or assert something about the ridge.
- **`let _ = m.sample(on.0, on.1);`**, scene.rs:1837 in
  `off_the_panel_is_nothing`: a dead probe inside a loop whose on-panel asserts
  follow after the loop. Drop it.
- **`crack::raster`**, crack.rs:1201-1204, is a `#[cfg(test)] pub(crate)`
  wrapper around `raster_window` in production code. Only the tests use it
  (crack.rs:1545 and 1904). Move it into `mod tests` as a helper. It's 3 lines,
  so this is cosmetic.
- **Validation:** `timeout 600 cargo test -p paint --lib -- atmos:: scene:: crack::`

## Retained false positives (looked suspect, but valuable)

- **`atmos::tests::probe_twilight`** (atmos.rs:1552, ignored, no asserts): a
  measurement instrument cited as the source of the recorded twilight numbers
  in notes/atmosphere.md:59. The project uses ignored probes on purpose.
  Optional upgrade: assert "twilight zenith is blue, not purple" in
  `twilight_structure`, which has no zenith-color check today.
- **`crack::tests::full_canvas_speed`** (crack.rs:1959, ignored, no asserts):
  the perf instrument behind 70a0ac1's "1714 mm canvas 10 s → 3.3 s". It's
  documented in its own doc comment.
- **`scene::tests::a_distant_caster_does_not_panic_the_shadow_march`**: named
  like a no-panic probe, but it's a real regression (the march's minimum step
  passing its 0.5 m cap at 310 m) and it asserts the cast stays in [0, 1].
- **`form::tests::thin_ellipsoids_keep_their_surface`**: the exact
  `23.108446` is the analytic ellipsoid front, not a copied snapshot. The loop
  checks against `100*sqrt(1-e)`.
- **`form::tests::turn_follows_its_contract`**: it destructures `Sdf::Turn { m
  }` (internals), but it's the documented yaw/pitch/roll sign contract, and its
  second half checks through `hit` and facets.
- **`outline::tests::amount_scales_lobes_set_after_it`**: its `lobed` closure
  replays the easel binding's default `lobe_height = 0.35`
  (crates/easel/src/draw_outline.rs:71-72). It still guards the public
  `Character::amount` order-independence. Its comment "the binding's order:
  amount, then an explicit lobe" (outline.rs:1405) is stale: the binding now
  applies `lobe=` first, then `amount=` (draw_outline.rs:64-81). That's a
  comment fix, not a deletion.
- **The `deterministic_*` tests** (crack, outline, rock, fir, growth): seed
  determinism is a stated project contract (notes/principles.md: "Is it
  deterministic and physical"), and each also asserts that different seeds
  differ.
- **The checkpoint offset constants and `malformed_geometry_is_invalid_data`**:
  a storage-format contract (corrupt input is `InvalidData`, not a panic).
- **`sched::batches_cut_the_order_by_hand_time` exact vectors and
  `surface::the_total_is_made_exact_within_the_bounds` exact `k`**: small inputs
  whose expected values can be computed by hand, not copied from a run.

## Suggested batch

A single test-only PR that does these five things:

1. Merges candidate 1 into `crop_cracks_like_the_whole`.
2. Deletes candidate 2 (or moves it to a study bin).
3. Deletes the candidate 3 sub-block.
4. Applies the candidate 4 tidy-ups.
5. Fixes the stale outline comment.

Roughly -130 test LOC and 0 production LOC.
