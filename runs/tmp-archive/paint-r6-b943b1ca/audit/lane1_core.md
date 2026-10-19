# Lane 1 (paint core): test audit discovery report

Checkout: [local path redacted] at `9e7dc94` (main). Read-only; nothing in the repo was edited.
Scope read in full: `crates/paint/src/tests.rs`, the `#[cfg(test)]` modules of canvas, bristle,
handling, drying, wet, palette, spectral, stipple, tally, graphite, mask and noise, plus
`crates/paint/tests/{curved_drag_nan,ground_grain}.rs`. Around 150 tests, 14 of them `#[ignore]`d probes.

**Bottom line:** this surface is healthy. Nearly every test guards a physical contract: conservation,
footprints, resolution independence, drying, hiding or determinism. Most use an independent oracle,
such as brute force, spectral.js, the `noise` crate or a reviewer's numbers. I found **two
high-confidence candidates**. Both are small. No test fails on main.

---

## Candidate 1: `the_coil_has_a_nan_point` (delete)

- **Test:** `crates/paint/tests/curved_drag_nan.rs:34-42`.
- **What failure it can detect:** only a change in the test's own fixture `coil()` or in std f32 math.
  It asserts `PI.sin() < 0.0` and that the coil's non-finite point list is exactly `[10]`. It calls
  no paint code.
- **Non-test callers of the seam:** none. `coil()` is a local helper in the test file that copies the
  painter's program.
- **Stronger remaining proof:** `a_nan_point_is_an_error` (same file, `:57-61`) is
  `#[should_panic(expected = "point 10")]`. Validation reports the *first* non-finite point:
  `crates/paint/src/bristle.rs:1776-1777` returns
  `Err(format!("Gesture point {i} is not finite: ..."))` from
  `self.pts.iter().enumerate().find(...)`. If the coil had no NaN, or had one at another index
  (including an earlier one), that test would fail, because "point 1"/"point 3" doesn't contain
  "point 10". Its premise implies the whole assertion of `the_coil_has_a_nan_point`.
- **History:** added in `eefdfec` ("Repro for coast #17 ... fix pending ... (ignored test)"), when
  the panic test was `#[ignore]`d and this test was the only live proof of the diagnosis. The
  fix landed in `3b5ca5a` ("Reject non-finite gesture and touch numbers loudly") and un-ignored the
  panic test. That made this one redundant. `notes/workflow.md:424` now reads "### Fixed: ...".
- **Deletion unlocked:** the test (about 9 lines). No production change. While there, fix two stale
  pieces of text: the module doc at `curved_drag_nan.rs:6-7` still says the fix is proposed in
  "Open bugs", and `notes/workflow.md:451-453` says "Three tests pin the diagnosis, and
  `a_nan_point_is_an_error` is `#[ignore]`d".
- **Risk:** very low. The one real behavior (the rejection message names the NaN point's index)
  stays owned by `a_nan_point_is_an_error`.
- **Validation:** `timeout 600 cargo test -p paint --test curved_drag_nan` (run on main: 3 passed).

## Candidate 2: `strokes_bow_unless_ruled` plus `hand_trace_for_test` (move to owner and delete the test-only wrapper)

- **Test:** `crates/paint/src/tests.rs:581-604`. **Seam:** `crates/paint/src/handling.rs:1360-1363`:
  ```rust
  #[cfg(test)]
  pub(crate) fn hand_trace_for_test(hd: &Handling, drift: &crate::noise::Fbm, cx: f32, cy: f32, len: f32, rng: &mut Rng) -> Vec<(f32, f32)> {
      hand_trace(hd, drift, cx, cy, len, 0.0, rng)
  }
  ```
- **What failure it can detect:** a real one, and worth keeping. The median bow of a default
  handling's planned strokes falls below 0.03, or `ruler()` strokes stop being straight (median bow
  of 1e-3 or more). That is the "hand-like by default, ruler on request" contract.
- **Non-test callers of the seam:** none. `rg hand_trace_for_test` finds only its definition and
  `tests.rs:589`. The private `hand_trace` has production callers at `handling.rs:580` and `:726`.
- **Stronger remaining proof:** none elsewhere. `tally.rs:449` uses `ruler()` but tests only its
  order. The test itself stays; only its location and the wrapper go. `handling.rs` already has a
  `#[cfg(test)] mod tests { use super::*; ... }` at `:1365` that can call `hand_trace(hd, &drift,
  500.0, 500.0, 150.0, 0.0, &mut rng)` directly.
- **History:** wrapper and test both came in `17f180e` (hand-like stroke planning). The wrapper
  exists only because the test was put in the crate-level `tests.rs` instead of next to its owner.
- **Deletion unlocked:** the 4-line `#[cfg(test)] pub(crate)` wrapper, a test-only export. The test
  moves verbatim into `handling::tests`. Net change: -4 lines in the production file, test lines
  unchanged.
- **Risk:** negligible. Same assertions, same RNG seed and the same `bend = 0.0` the wrapper
  hardcoded.
- **Validation:** `timeout 600 cargo test -p paint --lib strokes_bow_unless_ruled` (run on main:
  1 passed as `tests::strokes_bow_unless_ruled`; after the move it's
  `handling::tests::strokes_bow_unless_ruled`).

---

## Held, not proposed: the ignored probes (owner decision)

There are 14 assertion-free `#[ignore]` probes: `probe_ink_width`, `probe_patch`, `probe_bare`,
`probe_mark_area` (bristle.rs); `probe_mark_thickness`, `probe_edges_over_seeds`,
`probe_laid_by_coverage` (handling.rs); `probe_laid_thickness` (wet.rs); `probe_contrast_aims`
(palette.rs); `tooth_depths` (graphite.rs); `print_ground_grain` and `save_ground_crops`
(tests/ground_grain.rs); and `diag_sky_bare_pixels` (tests.rs). The ignored `sky_bares_ground` does
assert. They match "assertion-free probes" on paper, but they're measurement instruments, not coverage
claims. CI never runs them. Twelve are cited in notes as the way to re-measure a calibration, for
example `notes/fixes_paint.md:94`: "rerun `probe_laid_by_coverage`"; `notes/loop2_grain.md:120-122`;
`notes/tip.md`; `notes/surface.md`; and `notes/pencil.md`. Keep those. Two are cited nowhere:
`probe_patch` (`bristle.rs:1738`, writes a PNG via `TIP_OUT`) and `probe_laid_thickness`
(`wet.rs:382`, "for choosing `aim`"). They're the only plausible deletions, but that call belongs to
whoever tunes tips and aims. Confidence is low, so I'm not proposing them.

## Retained false positives (looked suspect but are valuable)

- `noise::tests::worley_finds_the_true_nearest_features` pins the literals `id == 409115953` and
  `f1 == 1.1241378`. These are not self-generated: they're the reviewer's independent 7×7 brute
  force from review report `8112604` ("A 7×7 search ... finds F1 1.1241378, ID 409115953").
- `tests::scene_matches_golden` is a deliberate snapshot hash (the module doc explains
  `UPDATE_GOLDEN=1`). It's the only proof that refactors change nothing.
- `noise::tests::fields_are_copy`, `fbm_is_copy_and_unchanged` and `toolkit_is_copy_and_ranged`
  look like compile-time trait checks. They guard a public contract painters rely on (the doc cites
  winter #13, coast #7 and mountains #6), and they check against the `noise` crate's own `Fbm` as an
  oracle.
- `tally::tests::the_ledger_keeps_its_checkpoint_layout` asserts exact words, but that's the
  PAINTCK7 checkpoint storage format (storage contract).
- `tally::tests::since_is_the_difference` rebuilds `secs` from `pace` constants, but `Tally::since`
  has a production caller (`crates/easel/src/time.rs:379`) and `length_mm == 22.0` is independent
  (50 units × 0.44 mm).
- `wet::tests::with_hiding_keeps_the_other_fields` looks like a builder field test, but it's a
  regression for builder order clobbering `drying`.
- `mix_into_is_volume_weighted` and `km_zero_absorption_is_finite` use exact floats, but they're
  independent math: the 0.25/0.75 weights and KM's k→0 limit of 0.5/0.5.
- `footprint_bounds_every_touched_pixel`, `footprint_bounds_extreme_valid_tools` and
  `stipple::touch_footprint_bounds_every_touched_pixel` look like near-duplicates, but they cover
  different tool sets (presets, extreme valid tools, touches at three scales). The parallel scheduler
  depends on each.
- `drying::splitting_a_wait_changes_nothing` and `..._under_the_brush` look similar, but one covers a
  synthetic striped film and the other real strokes plus time to dry out. They were separate bugs.
- `curved_drag_nan::the_same_curve_with_finite_points_lays_paint` was a diagnosis control that now
  guards "a curved 11-point fine rigger drag lays paint".
- `spectral.rs` tests are not dead-code tests: `paintings/src/bin/study_spectral.rs` calls
  `SpectralPigment`, `mix_js` and `fit_shape`, and `matches_spectral_js` checks against external
  spectral.js output.
- `graphite::grades_parse` pins exact parse results, but that's the public grade-string contract
  plus a no-panic regression for UTF-8 (review 4 #9).

## Proof run (targeted, on main)

- `timeout 600 cargo test -p paint --test curved_drag_nan`: 3 passed.
- `timeout 600 cargo test -p paint --lib strokes_bow_unless_ruled`: 1 passed.
- I did not run the full suite; the brief asked for targeted runs only. No failing tests were
  seen, so there are no suspected product bugs to report.
