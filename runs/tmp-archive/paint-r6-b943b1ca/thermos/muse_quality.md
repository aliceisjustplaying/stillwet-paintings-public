# Thermo-nuclear code quality review: Round 6 (main) and r6-wet

Scope: `2c5a658..main` (hand time and sittings, easel root fix, relief
default, bare trees, varnish fix) and `main...r6-wet` (two-layer wet film,
plough, blender drag, dirty tip, lift-off, reserved-film conservation,
PAINTCK8). I read the diffs, the new modules in full (`tally.rs`,
`time.rs`, `surface.rs` settle paths, `draw_trees.rs` planning,
`broadleaf.rs` wood selection, `wet.rs`, the `bristle.rs` Surf methods,
`drying.rs`, `checkpoint.rs`, the three study bins) and verified every
finding against the code. No builds were run; all findings below are
structural and readable directly from the source.

Priorities follow the skill order: structural regressions first, then
missed code-judo moves, spaghetti growth, boundary problems, file size,
modularity and legibility.

---

## 1. Hand-time `flush` is sprinkled across a dozen verb sites (main, high)

- Severity: high. Change set: main.
- Location: `crates/easel/src/api.rs:490,518,996,1134,1638,1662,1671,1688,1697,1703,1715`,
  `crates/easel/src/draw_pencil.rs:71`, `crates/easel/src/session.rs:216`,
  implemented in `crates/easel/src/time.rs:92` (`flush`).
- What is wrong: every verb that paints or reads the clock must remember to
  call `crate::time::flush` with the right force flag, wrapped around its own
  borrow/release dance (`b:stroke` and `b:touch` use `flush(st, false)`,
  `work`/`stipple` use `flush(st, true)`, queries like `clock` and `drying`
  flush first, `glaze` needs flush-waited-flush in that order, `session.rs`
  flushes again at chunk end). This is temporal coupling spread over ~13
  call sites: any new verb or query that forgets the call silently mis-times
  the painting, and the force-flag convention (`false` for single strokes,
  `true` for covering verbs and queries) lives only in habit, not in a type.
  `flush` itself does five jobs at once: compute owed time, advance the
  canvas clock, resync `hand.clocked`, siphon non-hand drying time into
  `unreported`, and maybe start a new sitting or report an overrun.
- Why it matters: the feature that most needs to be obviously right (time
  drives drying, which drives what the picture looks like) is the one most
  smeared across the codebase. Reviewing any future verb means auditing its
  flush placement by hand.
- Concrete fix: keep the behavior and restructure the implementation behind
  one helper, e.g. `time::with_canvas(st, force, |s, c| ...)` that borrows
  once, runs the closure, then flushes uniformly. Split `flush` into
  `clock_owed()` (pure accounting) and `note_elapsed()` (sitting/reporting)
  so callers cannot get half the protocol. The glaze path then becomes one
  call instead of flush-waited-flush.
- Status: verified.

## 2. The sliced-batch loop is copy-pasted between handling and stipple (main, high)

- Severity: high. Change set: main.
- Location: `crates/paint/src/handling.rs:781` (`run_plans`, `sliced: bool`
  param, batches/offsets/`surf()`/`hand_pass` loop at ~848-935) and
  `crates/paint/src/stipple.rs:506-610` (same `tile_secs`, `batches`,
  per-batch offsets, `surf()`, `hand_pass` shape). Shared driver:
  `crates/paint/src/tally.rs:252` (`batches`).
- What is wrong: two near-identical orchestration loops (cut order into
  slices, assign stroke ids per slice so a wait sees later slices as fresh,
  rebuild offsets, re-fetch `surf()`, filter tiles against the crop window,
  paint, `hand_pass` between slices) now live in two modules. They will drift:
  the id-assignment discipline that the `the_slices_after_a_wait_are_fresh_work`
  test pins down must be kept in sync twice. Along the way `run_plans` grew a
  10th parameter, a bare `sliced: bool` flag (`true` from `work`, `false`
  from `fill_gaps` and cut-in paths), on a function that already carries
  `#[allow(clippy::too_many_arguments)]`. Both `Plan` structs independently
  grew the same `want: Rgb` field (`handling.rs:482`, `stipple.rs` plus
  `aim_at` neighbors) for palette-dip accounting.
- Why it matters: this is the exact failure mode the skill targets: working
  code that doubles the concepts a reader must hold. A bug fix in slice
  discipline now needs to land in two places or paintings age differently by
  verb.
- Concrete fix: the code-judo move is a small `SlicedRun` driver next to
  `tally::batches` that owns batches, per-slice id assignment, offsets and
  the `hand_pass` interstitial, taking a per-batch paint closure. Both verbs
  keep only their tile-paint closures. Replace `sliced: bool` with an options
  struct (or an enum `Slice::{On, Off}`) and share one `Want`/`Dip` accounting
  helper instead of two `want` fields.
- Status: verified.

## 3. The two-layer film is a parallel-array explosion across Wet, Surf and drying (r6-wet, high)

- Severity: high. Change set: r6-wet.
- Location: `crates/paint/src/wet.rs:182` (`Wet` gains `top/tlat/thide/mid/midx`),
  `crates/paint/src/wet.rs:273` (`whole`), `crates/paint/src/wet.rs:287`
  (`film_over`, 9 args, `#[allow(clippy::too_many_arguments)]`),
  `crates/paint/src/bristle.rs:587-790` (`Surf` gains 5 raw-pointer fields and
  8 new unsafe methods: `body`, `add`, `lay`, `settle_mid`, `stir`,
  `add_body`, `take_column`, `take`), plus lockstep updates in `look_px`,
  `dry`, three `drying.rs` rate sites, `settle` stiffness via `prop`,
  and checkpoint v8.
- What is wrong: one physical idea (a surface film over a body) is stored as
  5 parallel `Vec`s on `Wet`, mirrored as 5 raw pointers on `Surf`, plus a
  `mids: Vec<Mid>` side table indexed through a per-pixel `midx` array. Every
  behavior added to the film must touch ~8 sites in lockstep, and the compiler
  cannot check that they stay in sync. `take_column` returns `[f32; 3]` with
  positional meaning (surface, set-aside, body) that callers destructure by
  index. The `mid` lifecycle (`lay` sets it aside, `settle_mid` resolves it,
  "never seen between strokes" by discipline) has exactly two `settle_mid`
  call sites (`bristle.rs:1203,1867`); a third stroke path that forgets the
  call leaks reserved film silently.
- Why it matters: this is the branch's core abstraction and it is held
  together by convention. Future wet-film work (or a third layer) multiplies
  the parallel arrays again.
- Concrete fix: introduce a per-pixel `Film { body, top }` value type (or at
  minimum a `TopFilm` struct owning `top/tlat/thide`) with methods for
  `prop`, `stir`, `take` and layered compositing, so `Wet` holds two arrays
  instead of eight and `Surf` exposes safe indexed accessors. Turn the
  lay-then-settle_mid protocol into a guard object created at stroke start
  whose drop/settle resolves the reservation, so forgetting is impossible.
  Replace the `[f32; 3]` with a named struct.
- Status: verified.

## 4. bristle.rs grows 1896 to 2357 lines with no decomposition (r6-wet, high)

- Severity: high. Change set: r6-wet.
- Location: `crates/paint/src/bristle.rs` (whole file; constants at :87-107:
  `STIR`, `THIN_FILM`, `GLANCE`, `TIP_RUN`, `CUSHION`, `PLOUGH_KEEP`,
  `PLOUGH_STIFF`; `Bristle::fold_tip` at :375; `lift_off` at :967;
  `exchange` inner loop at ~:1338-1700).
- What is wrong: the file was already ~1.9k lines at the base and absorbs the
  whole wet-on-wet feature without a split: dirty-tip state on `Bristle`
  (`tip/tlat/thide` mirroring the canvas two-layer pattern at bristle
  scale), 7 new tuning constants, the `exchange` inner loop now interleaving
  deposit, cover, lay, stir, plough with bow-wave stiffness gating, three-way
  pickup accumulation, `fold_tip` with `TIP_RUN` e-folding, and bilinear
  plough redistribution for fine hairs. No file crosses the 1k-line threshold
  in this diff only because both giants were already far past it; growing an
  already-unscannable file by 460 lines is the same smell, stronger.
- Why it matters: `exchange` is now the single hardest function to reason
  about in the engine, and paint conservation (the branch's own review theme)
  depends on getting every interleaved step right in one loop body.
- Concrete fix: split the file: `exchange.rs` (the per-pixel pipeline as
  named stages on a `PixelCtx` struct instead of a dozen locals), `tip.rs`
  (dirty-tip ownership and folding), `liftoff.rs` (lift behavior). Group the
  7 constants into a `WetParams` struct with documented provenance so tuning
  is data, not 7 more globals. The conservation tests added at the file tail
  should move to a dedicated test module with them.
- Status: verified (line counts and code read; no build run).

## 5. Growth and painting policy are fused in broadleaf.rs, now 2000 lines (main, high)

- Severity: high. Change set: main.
- Location: `crates/paint/src/broadleaf.rs` (1510 lines at base, 2000 now):
  `straighten` at :571, `WoodStroke` at :1401, generic `subdivide` at :1419
  and `polylen` at :1438, `is_fine` at :1445, `drawn` at :1456, `wood_strokes`
  at :1523, `twig_mass` at :1593; `Tree` gains `twig_w` at :480 and `angular`
  at :483 duplicating `Species` fields.
- What is wrong: the growth module (how trees grow: buds, vigor, pipe model)
  now also owns the painter's line-vs-tone policy: a greedy fine-wood
  selection with scoring (`length x lead-boost x edge-factor x hash jitter`),
  a per-spot dedup `HashMap`, a length budget, band-splitting with parent
  pull-back, leading-twig splicing, and a blurred density tone with 98th
  percentile normalization. Tucked in beside it are two generic polyline
  helpers that belong in `path`/`shape`. `Tree` caches `twig_w`/`angular`
  copied from the `Species` it was grown with, so two sources of truth for
  the same parameters now exist on one struct.
- Why it matters: a reader trying to understand growth must wade through
  painting selection and vice versa. The next tree feature pays the combined
  complexity cost of both.
- Concrete fix: move `drawn`/`wood_strokes`/`twig_mass`/`WoodStroke` (and the
  `lead` bookkeeping that exists only to serve them) into a new `wood_paint`
  module that borrows the skeleton; move `subdivide`/`polylen` to the
  geometry helpers; either drop the duplicated `Tree` fields in favor of
  keeping the `Species` (or document why the cache exists and assert the
  invariant).
- Status: verified.

## 6. Canvas behavior lives in tally.rs, the wrong layer (main, medium)

- Severity: medium. Change set: main.
- Location: `crates/paint/src/tally.rs:200-340` (the `impl Canvas` block:
  `set_hand_time`, `hand_time`, `hand_slice_secs`, `hand_owed`,
  `clock_hand`, `hand_pass`, `tally`, `tally_mut`, `mm_per_unit`,
  `stages`, `stage_shares`).
- What is wrong: a module whose header says "painting nothing here: the
  ledger only counts" now owns clock-advancing behavior (`hand_pass` calls
  `self.wait`, i.e. paint aging) and view helpers (`stages`,
  `stage_shares`) plus a trivial `mm_per_unit()` getter that merely forwards
  a `canvas.rs` field. A reader looking for "what advances the clock" will
  not look in the ledger, and a reader auditing the ledger must skip methods
  that mutate drying state.
- Why it matters: boundary drift of exactly the kind that makes the next
  time-related change land in the wrong file again.
- Concrete fix: keep `Tally`, `Piles`, `stroke_secs`, `touch_secs` and
  `batches` in `tally.rs` as pure counting; move the `impl Canvas`
  clock/aging methods to `canvas.rs` (or a small `hand_clock.rs`), and delete
  the `mm_per_unit()` forwarder in favor of the field access the rest of the
  engine already uses.
- Status: verified.

## 7. The sitting lifecycle is split across four functions plus call-site pairs (main, medium)

- Severity: medium. Change set: main.
- Location: `crates/easel/src/time.rs:41` (`Hand`: 8 fields covering sitting
  schedule, palette piles, ledger baseline and reporting buffer),
  `time.rs:72` (`begin_rested`), `time.rs:92` (`flush`), `time.rs:129`
  (`note_overrun`), `time.rs:149` (`waited`); callers:
  `crates/easel/src/api.rs:1638-1662` (glaze must call flush, then waited,
  then flush again, in order).
- What is wrong: starting/ending sittings, palette resets, overrun warnings
  and drying-time reporting are four separate entry points with ordering
  rules enforced only by call-site discipline. `Hand` fuses four concerns
  (when the sitting started and how long it is; the palette LRU; the ledger
  baseline from `canvas{}`; the `unreported` minutes buffer for the chunk-end
  note), so snapshotting, testing or reusing any one concern drags the other
  three along.
- Why it matters: this works, but it makes the surrounding code more
  spaghetti: every future time-aware verb must learn the flush/waited
  handshake, and `Hand` is already the second thing every `Snap` clones.
- Concrete fix: expose one transition API such as
  `time::advanced(st, minutes, Cause::{HandWork, DryingWait, Rest})` that owns
  the flush/waited/handshake internally, and split `Hand` into `Sitting`
  (start/hours/sittings/warned) and the ledger/palette pieces it merely
  carries.
- Status: verified.

## 8. Two palette trackers with different lifetimes (main, medium)

- Severity: medium. Change set: main.
- Location: `crates/paint/src/tally.rs:98-132` (`Piles::dip`/`trip`);
  per-pass instances in `crates/paint/src/handling.rs:810` and
  `crates/paint/src/stipple.rs:504` (`Piles::default()` fresh per
  `run_plans`/stipple call) vs the per-sitting instance in
  `crates/easel/src/time.rs:51` (`Hand::piles`, fed by `time::trip` for held
  brushes).
- What is wrong: the same `Piles` type counts palette trips with two
  lifetimes that mean different things (a covering pass re-mixes colors the
  sitting already has, and vice versa), and nothing in the code states which
  semantic is intended. The per-pass ledgers reset the LRU every pass, so
  `remixes` depends on pass chunking rather than on what the painter actually
  mixed.
- Why it matters: hand-time numbers (remix counts feed `pace::REMIX = 20 s`
  each, the largest single price in the model) rest on an accounting boundary
  nobody has named. If the semantics are intended, they deserve one comment;
  if not, sittings are over- or under-billed.
- Concrete fix: either thread the sitting's `Piles` through `run_plans` and
  stipple so one LRU owns the sitting, or document on `Piles` why pass-local
  and sitting-local piles coexist and which feeds the timesheet.
- Status: suspected (semantics need author confirmation; the two lifetimes
  are verified in code).

## 9. `settle` vs `settle_film`: two parallel leveling models (main, medium)

- Severity: medium. Change set: main.
- Location: `crates/paint/src/surface.rs:176` (`settle`/`settle_for`) vs
  `:292` (`settle_film`); shared helpers `rheology`, `level_band`,
  `box_blur`; the conserve-locally-then-exactly epilogue at :257 and :378;
  `PEAK_FILM_UM` at :394 reaching into `canvas::MIN_FILM_UM`.
- What is wrong: one canvas now has two film-leveling implementations with
  duplicated scaffolding (band radii from pixel size, per-band decay plus
  yield floor, blur-ratio rescale, global exact rescale) and subtly different
  physics justified at length in comments. `glaze()` silently switched to the
  new path while everything else uses the old one, so which physics a mark
  gets depends on which verb laid it. The exact-conservation rescale is
  copy-pasted between them.
- Why it matters: the volume-conservation invariant (a stated project
  invariant) is now enforced by two copies of the same epilogue. A fix to one
  will not reach the other.
- Concrete fix: extract the shared pieces (band radii from `px_mm`,
  `level_band` application, the blur-ratio plus exact conservation epilogue)
  into helpers both paths call; long term, one film model parameterized by
  dry-relief vs wet-layer rather than two functions. At minimum, name the
  dispatch rule in one place (which verbs use which settle and why).
- Status: verified.

## 10. Positional tuples and 9-arg functions on the r6-wet boundary (r6-wet, medium)

- Severity: medium. Change set: r6-wet.
- Location: `crates/paint/src/bristle.rs:967` (`lift_off` returns
  `(f32, f32, f32)`), `bristle.rs:756` (`take_column` returns `[f32; 3]`),
  `crates/paint/src/wet.rs:287` (`film_over` takes 9 args under allow),
  `bristle.rs:794` (`Mid`).
- What is wrong: three new boundaries communicate in positional floats. The
  `Kind -> (roll, taper)` match in `lift_off` is behavior of the tool switch
  that lives in a free function returning an undocumented triple (a flat onto
  its edge vs a round to its point is exactly the kind of rule that deserves
  a named type). `take_column`'s three layers come back by array position next
  to `Mid`'s named fields, so the two halves of one transaction use different
  conventions. `film_over`'s 9 parameters (four of them parallel
  latent-plus-prop pairs) make every call site an exercise in argument order.
- Why it matters: boundary murk of this kind is where layer-swap bugs hide
  (surface vs body vs set-aside), and the compiler cannot help.
- Concrete fix: return named structs (`Lift { lift, roll, taper }`,
  `Column { surf, aside, body }`), make the `Kind` match a method on
  `Kind`/`Tool`, and take a `&FilmView`/`&PixelFilm` parameter object in
  `film_over` instead of 9 scalars.
- Status: verified.

## 11. Study scaffolding triplicated, debug probes committed in engine tests (r6-wet, medium)

- Severity: medium. Change set: r6-wet.
- Location: `paintings/src/bin/study_wet.rs` (549 lines, 32 fns),
  `paintings/src/bin/study_wet_control.rs` (319 lines),
  `paintings/src/bin/study_wet_lab.rs` (187 lines); each defines its own
  `cell`/`rect`/`field`/paint-constructor/measurement helpers;
  `crates/paint/src/wet.rs:425,609,633` (`probe_laid_thickness`,
  `probe_touch`, `probe_seam`: `#[ignore]` tests that `println!` instead of
  asserting).
- What is wrong: ~1050 lines of bin code with three copies of the same grid,
  mask and underlayer scaffolding, differing only in the gestures measured.
  Meanwhile the engine's own test module carries ignored printf-probes that
  run nothing in CI and rot silently.
- Why it matters: the studies are the branch's evidence base; as committed
  they are write-only code. The next person to rerun or extend a study must
  fix three copies, and the in-engine probes look like coverage while
  asserting nothing.
- Concrete fix: extract one shared study-support module (grid, rect masks,
  standard underlayers, table printing) used by all three bins; move the
  `#[ignore]` probes out of `wet.rs` into the bins (or delete them now that
  `notes/wet.md` has recorded the numbers).
- Status: verified.

## 12. Wet-mode display bolted into a 1251-line look.rs (main, low-medium)

- Severity: low-medium. Change set: main.
- Location: `crates/easel/src/look.rs:27` (`wet: bool`, the 6th mode flag),
  `:973` (`if v.value && !v.wet`), `:1016-1045` (`STAGE_TINT`,
  `STAGE_LEGEND`, `stage_colors`), legend drawing at :994-999.
- What is wrong: a new display mode arrives as one more bool alongside
  value/squint/mirror/dried/relief, with an ad-hoc interaction rule
  (`value` is silently disabled under `wet`) and presentation math plus
  legend layout inline in the look pipeline. `View` is becoming a bag of
  flags whose combinations are defined by scattered conditionals.
- Why it matters: small today, but this is how the file reached 1251 lines:
  every future overlay will add one more bool and one more special case.
- Concrete fix: extract the stage overlay (tint map plus legend) into its own
  small module with its own tests, and make mode interactions explicit (either
  exclusive modes or a documented composition order) instead of
  `value && !wet` at the call site.
- Status: verified.

## 13. `touch_secs` takes a width it ignores (main, low)

- Severity: low. Change set: main.
- Location: `crates/paint/src/tally.rs:155-158` (`let _ = w_mm`), called at
  :177 as `touch_secs(mark_mm(tool, mm_per_unit))`.
- What is wrong: every caller computes a mark width to pass in, and the
  function discards it. The parameter suggests size-dependent pricing that
  does not exist; the comment explains why, but the signature still charges
  every reader (and every future editor) the confusion.
- Why it matters: tiny, but it is pure noise in a brand-new API that should
  be setting the file's standard.
- Concrete fix: drop the parameter (or keep it with a `#[allow]`-free
  rationale in the name, e.g. a unit struct), and simplify the two callers
  and the `since_is_the_difference` test that passes `1.32` to no effect.
- Status: verified.

## 14. Checkpoint serialization grows by manual appends (r6-wet, low)

- Severity: low. Change set: r6-wet.
- Location: `crates/paint/src/checkpoint.rs:40` (`PAINTCK8`), :181 (`top/
  tlat/thide` writes), :318 (reads), :406 (test offset math).
- What is wrong: each generation appends another hand-packed block to one
  linear format with manual `put_all`/`get_all` pairing and a test that
  recomputes byte offsets by hand (`film = n * (1 + LAT + 3) * 4`). The
  transient `mid/midx` reservation is correctly not persisted, but nothing
  asserts there is no in-flight reservation at write time; a checkpoint taken
  mid-stroke would silently drop reserved paint on resume.
- Why it matters: checkpoints are the resume/edit correctness backbone. The
  format works, but every layer added this way raises the odds of a paired
  read/write slip that old-file rejection then has to catch.
- Concrete fix: add small section read/write helpers (length-prefixed vec
  blocks with a shared name table) so v9 is declarative, and
  `debug_assert!(wet.mid.iter().all(|&m| m == 0.0))` at write time to pin the
  no-in-flight-invariant.
- Status: verified (code read; mid-lifecycle confirmed at finding 3).

## 15. `detail` float threaded through five layers; per-knot Lua round-trips (main, low)

- Severity: low. Change set: main.
- Location: `crates/easel/src/draw_trees.rs:38` (`detail_for`),
  `TreeU.detail` at :31, `GroupU.detail` at :525, `lay_wood` at :316,
  `wood_strokes`/`twig_mass` detail params; `plan_stroke` at :279 taking
  `&dyn Fn(f32) -> Result<f32>`; pressure plumbing at ~:340-360
  (`pressure=[1,1]` dummy plus real `swell` knots).
- What is wrong: one painter-facing knob (`detail`) is plumbed as a bare
  `f32` through the tree object, the group object, two query methods and the
  stroke planner, each with its own `unwrap_or(...).clamp(0,1)`. The planner
  calls back into Lua (`mark_width` once, `pressure_for` per knot, up to 24
  per stroke) through a `dyn Fn` closure, and works around the brush API by
  sending dummy `pressure=[1,1]` with the real shape in `swell`.
- Why it matters: the dummy-pressure-plus-swell convention is a private
  protocol between two functions that the next brush-API change will break
  silently; the per-knot callbacks are a suspected (unmeasured) cost in the
  exact loop that paints every winter tree.
- Concrete fix: bundle the knob into a `WoodStyle { detail, ... }` struct
  resolved once per call; resolve pressures in one batch (or cache
  `pressure_for` over the knot widths); replace the dummy-pressure protocol
  with an explicit planner-to-brush constructor both sides name.
- Status: verified for the plumbing and the dummy-pressure convention;
  suspected for the performance cost (no measurement taken).

---

## Verdicts

- **main**: solid behavior work (the review-fix commits for findings 1-3 of
  the earlier review show the process works) but a structural step backward
  in three places: the flush scattering (finding 1), the duplicated slice
  loop (finding 2) and the growth/policy fusion in broadleaf (finding 5).
  Findings 1 and 2 are the ones I would block on: they are small, mechanical
  restructurings (one wrapper, one shared driver) that delete whole classes
  of future mistakes while preserving behavior. Findings 6-9, 12, 13 and 15
  are rework worth doing but not blockers. No file crosses the 1k-line
  threshold in this change set, but broadleaf (1510 to 2000) and handling
  (1831 to 1879) grow while already far past it, which is the same debt in a
  larger coat.
- **r6-wet**: the wet-film physics reads as careful and well-evidenced, but
  its implementation buys that quality with the branch's most aggressive
  complexity growth: the parallel-array film (finding 3) and the
  undecomposed bristle.rs (finding 4) are both presumptive blockers under
  this skill's bar. Findings 10, 11 and 14 should be fixed before merge as
  well; none of them is large. I would not merge r6-wet in its current shape
  despite trusting its pictures: the structure makes the next wet-film change
  (and the PAINTCK9 after it) harder than this one was.
