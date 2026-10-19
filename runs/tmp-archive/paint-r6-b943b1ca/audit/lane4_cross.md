# Lane 4: cross-cutting sweep for test-only seams (claude-paint @ 9e7dc94)

Read-only. Method: a scripted sweep (`lane4/sweep.py`, `lane4/helpers.py`
in this directory) splits every `.rs` file in `crates/` and `paintings/`
(including `paintings/src/bin` and `paintings/fresh*`, the painters'
programs) into production text and `#[cfg(test)]`/`tests/` text. It then
lists (a) `pub`/`pub(crate)` items whose name never appears in production
code outside comments and (b) test helper fns defined in more than one file.
I also read every non-`mod tests` `#[cfg(test)]` item, every `env::var`
switch and every `#[ignore]` probe. The workspace has no Cargo features
(`crates/*/Cargo.toml`, `paintings/Cargo.toml`). No
`#[allow(dead_code)]` exists outside `crates/paint/tests/ground_grain.rs:13`.

Baseline: every test named below passes on main:
- `cargo test -p paint --lib -- consumed_inset_is_an_empty_region amount_scales_lobes_set_after_it strokes_bow_unless_ruled drawing_survives_a_checkpoint`: 4 passed
- `cargo test -p easel --bin easel -- an_inset_that_consumes_the_shape_masks_nothing amount_zero_is_clean edit_a_chunk_in_place_from_a_checkpoint`: 3 passed
- `cargo test -p paint --lib crack::`: 12 passed, 1 ignored

The seam surface is small. The sweep found three `#[cfg(test)]` hooks in
production files (handling.rs:1360, session.rs:222 and crack.rs:1201) and
five `pub` items with only test callers (`is_open`, `f1_3`, `wet_total`,
`drawing_view` and `has_drawing`). None
of them costs much, so the candidates below are cleanups rather than big
deletions.

---

## Candidate 1 (high): `Outline::is_open` is called only by tests, and the easel binding keeps its own copy of the predicate

- **Tests:** `outline::tests::consumed_inset_is_an_empty_region`
  (crates/paint/src/outline.rs:1432), which asserts `is_open()` at
  lines 1437, 1441 and 1443.
  `draw_outline::tests::an_inset_that_consumes_the_shape_masks_nothing`
  (crates/easel/src/draw_outline.rs:371) covers the same review 4 #5
  contract through Lua.
- **Seam:** `pub fn is_open(&self) -> bool { !self.lines.is_empty() && !self.lines.iter().any(|l| l.closed) }`
  (outline.rs:764). No production caller: `rg '\bis_open\b'` finds only
  the definition and the three test asserts. The Lua `:mask()` binding
  re-implements it inline:
  `if !o.o.lines.is_empty() && !o.o.lines.iter().any(|l| l.closed) {`
  (draw_outline.rs:237).
- **What it can detect:** the paint test catches a regression in the
  consumed-inset-vs-open-line predicate at the paint layer. The easel test
  catches the user-visible version (an empty mask for an eaten inset, plus
  the error `"this line is open"`). Today the two layers carry two copies
  of one predicate, so each test only checks its own copy.
- **History:** review 4 #5 was fixed twice in parallel. 62f2e07 (easel,
  2026-09-23 16:00) inlined the check. b997038 (paint, 16:09) added
  `is_open()` "for consumed insets". notes/outline.md:168 records the
  intended follow-up: "The Lua `:mask()` guard should test `is_open()`
  instead of 'has no closed line'; that binding is the easel fixer's."
  Nobody did it.
- **Stronger remaining proof:** the easel test is the owner of the user
  contract. The paint test owns the predicate once the binding calls it.
- **Action: rewrite at the boundary.** Change draw_outline.rs:237 to
  `if o.o.is_open() {` and drop the duplicate comment. Keep both tests: the
  paint seam then has a real caller, and the easel test exercises it
  through Lua. Net -1 production line. One predicate instead of two.
- **Deletion unlocked:** the inline duplicate (not the method).
- **Risk:** low. The expression is identical. Validation:
  `timeout 600 cargo test -p easel --bin easel draw_outline:: && timeout 600 cargo test -p paint --lib outline::`

## Candidate 2 (high): the `#[cfg(test)] hand_trace_for_test` wrapper exists only so a sibling module can reach a private fn

- **Test:** `tests::strokes_bow_unless_ruled` (crates/paint/src/tests.rs:582),
  which calls `crate::handling::hand_trace_for_test(h, &drift, 500.0, 500.0, 150.0, &mut rng)` at line 589.
- **Seam:** `#[cfg(test)] pub(crate) fn hand_trace_for_test(...) { hand_trace(hd, drift, cx, cy, len, 0.0, rng) }`
  (crates/paint/src/handling.rs:1360-1363). Its only caller is tests.rs:589.
  `hand_trace` is private (`fn hand_trace(` at handling.rs:1307). The
  wrapper exists only because `crate::tests` is a separate module.
- **What it can detect:** a real contract. Default strokes bow like a hand
  and `ruler()` (handling.rs:213, exposed to Lua as `ruler` at
  api.rs:820) is straight (`hand > 0.03 && ruler < 1e-3`). Nothing else
  checks straightness: in `rg ruler crates/paint/src` the only other test
  is tally.rs:449, and it checks scatter order, not geometry.
- **History:** both the wrapper and the test arrived in 17f180e ("strokes:
  hand-like stroke planning ...").
- **Stronger remaining proof:** none. Keep the test and move it.
- **Action: merge into `handling::tests`** (handling.rs:1365-1367 already
  has `use super::*`). Call `hand_trace(h, &drift, 500.0, 500.0, 150.0, 0.0, &mut rng)`
  directly and delete the wrapper.
- **Deletion unlocked:** the 4-line `#[cfg(test)]` wrapper in production
  source.
- **Risk:** very low. The test logic is unchanged. Validation:
  `timeout 600 cargo test -p paint --lib strokes_bow_unless_ruled`

## Candidate 3 (high, small): the `#[cfg(test)] Session::checkpoints` accessor duplicates field access the test already has

- **Test:** `session::tests::edit_a_chunk_in_place_from_a_checkpoint`
  (crates/easel/src/session.rs:727). At line 736 it calls `let cp = s.checkpoints();`.
- **Seam:** `#[cfg(test)] pub fn checkpoints(&self) -> Vec<usize> { self.snaps.keys().copied().collect() }`
  (session.rs:221-225). Its only caller is session.rs:736. The same test
  already reaches private state directly (`s.keep = 2;` and
  `assert_eq!(s.log.len(), 8);`), because it lives in a child module of
  `session`.
- **What it can detect:** the assertion
  `cp.contains(&6) && cp.contains(&7) && cp.len() <= 4` guards the
  undo ring plus the bounded doubling checkpoint grid (the memory bound
  behind `--checkpoints`, 081fd5b). This is internal state, but it is the
  only guard of the bound, so keep the assertion.
- **History:** 081fd5b ("easel: edit a chunk in place ... per-chunk
  checkpoints in memory on a doubling grid").
- **Stronger remaining proof:** the rest of the test (splice, replay
  bits, clock) covers the behavior. The grid assertion stays.
- **Action: rewrite in place.** Use
  `let cp: Vec<usize> = s.snaps.keys().copied().collect();` and delete
  the accessor.
- **Deletion unlocked:** 5 lines of `#[cfg(test)]` production-file code.
- **Risk:** very low. Validation:
  `timeout 600 cargo test -p easel --bin easel session::`

## Candidate 4 (optional, low value): the `#[cfg(test)] crack::raster` convenience wrapper

- **Tests:** `crack::tests::islands` helper (crack.rs:1542, which calls
  `raster` at 1545) and `crack_in_dark` (crack.rs:1896, calling it at 1904).
- **Seam:** `#[cfg(test)] pub(crate) fn raster(net, k, w, h, px) { raster_window(net, k, &Local::uniform(), (0, 0, w, h), px) }`
  (crack.rs:1201-1204). No production caller. Production uses
  `raster_window` directly.
- **What it can detect:** nothing of its own. It is a fixture shortcut.
- **Action:** inline `raster_window(..., &Local::uniform(), (0, 0, w, h), px)`
  at the two call sites (or move the wrapper into `mod tests`). Saves 4
  lines in the production region. Do it only as part of a crack.rs batch.
- **Risk:** nil. Validation: `timeout 600 cargo test -p paint --lib crack::`

## Deferred (owner call): `Worley::f1_3` is public toolkit API that only tests call

- **Tests:** `noise::tests::worley_finds_the_true_nearest_features`
  (noise.rs:538, a brute-force check at line 576) and
  `toolkit_is_copy_and_ranged` (noise.rs:490), which only calls it in an
  assertion-free probe line, `let _ = r.get3(..) + c.f1_3(..)` (noise.rs:513).
- **Seam:** `pub fn f1_3` (noise.rs:346). No production or painting
  caller. The Lua `WorleyU` binding exposes only 2-D `at` and call
  (api.rs:802-812). notes/atmosphere.md:32 documents it as toolkit.
- **History:** added in ebc4965 (noise toolkit); made exact in 377dc5e.
- **Action:** under the Round 7 feature freeze (principles.md "Feature
  freeze") this is dead engine code. Deleting `f1_3`, its brute-force
  block and the `let _` line saves about 25 production lines and 15 test
  lines. Its test is sound, so leave the call to the owner. Do not delete
  the test alone.

---

## Retained false positives (looked suspect but are valuable)

- `Canvas::wet_total` (wet.rs:324) is `pub` with only test callers (12
  sites). It is the observer for the paint-conservation invariant
  (principles.md "conserves paint") in `drag_conserves_paint` (tests.rs:55)
  and `touch_conserves_paint` (stipple.rs:606), which cover different entry
  points. Review evidence cites it (notes/review/review_optics.md:18). Keep it.
- `Canvas::drawing_view` and `has_drawing` (graphite.rs:727 and 500) are
  test-only today (checkpoint.rs:371-372). notes/pencil.md:178 marks
  `drawing_view` as ready for a planned `look --mode drawing`. It is also
  the only observer of the cell `a`/`r` fields the PAINTCK6 checkpoint
  stores (683a039). Keep it.
- `amount_scales_lobes_set_after_it` (outline.rs:1399) vs easel
  `amount_zero_is_clean_even_with_explicit_lobes` (draw_outline.rs:388)
  cover review 4 #6 at two layers: paint `Character::amount` commutes with
  lobes, and the binding applies lobe before amount (draw_outline.rs:64-83).
  Keep both. The paint fixture comment "the binding's order: amount, then
  an explicit lobe" (outline.rs:1405) is stale: the binding now does the
  opposite. Fix the wording only.
- `session::tests::object_keys_walk_in_creation_order` (session.rs:859) vs
  `tests/determinism.rs::object_keyed_tables_replay_the_same_in_every_process`:
  the first checks within one process and the second across three processes
  (per-process hashing). The risks differ.
- `PAINT_DEBUG` env switches (handling.rs:738 and 830, sched.rs:175,
  stipple.rs:572) print dev timing only. No test depends on them, so they
  are not a test seam.
- The 17 `#[ignore]` env-driven probes (for example `probe_*` in
  bristle.rs, handling.rs, wet.rs, atmos.rs and palette.rs, and
  `ground_grain.rs`) are assertion-free, but they are opt-in measurement
  instruments. None of them forces a production seam. The per-module lanes
  can judge them. The only env hook in a running test is the `EDGE_OLD`
  print in `edges_are_covered_like_the_inside` (handling.rs:1720 and
  1732), and it is harmless.
- The duplicated test helpers are too small to be worth a shared seam: the
  identical 5-line `run` in draw_trees, draw_firs, draw_outline and
  draw_rocks tests (for example draw_rocks.rs:344) and the 3-line
  `brush_volume` in tests.rs:18 and stipple.rs:584. Sharing them would need
  a `#[cfg(test)] pub(crate)` support module, which trades roughly 15 lines
  for a new seam.
- `water_depth` (scene.rs:358), `spectral::mix_ks` (spectral.rs:152) and
  most `drying::drier::*` constants have zero callers anywhere, tests
  included. That makes them dead vocabulary or API, not test seams, so they
  are out of this lane's scope. Spectral is documented as "optional; not
  integrated" (761e8e3).

## Suggested batch

Candidates 1-3 (plus 4 if touching crack.rs) form one small PR. It removes
about 13 lines of test-only production-file code and 1 duplicated predicate,
moves one test to its owner module and deletes no tests. Proof:
`timeout 600 cargo test -p paint --lib -- outline:: strokes_bow_unless_ruled crack::`
and `timeout 600 cargo test -p easel --bin easel -- draw_outline:: session::`.
