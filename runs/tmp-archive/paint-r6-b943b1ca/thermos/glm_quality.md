# Thermo-nuclear code-quality review — Round 6 (glm)

Scope reviewed: `2c5a658..main` (crates, paintings) and `main...r6-wet` (crates, paintings), read in full; notes/time.md, notes/oak.md, notes/round6.md, notes/advice/astra_r6.md consulted so previously found issues (checkpoint hand state, finish-drying accounting, kept order, wet conservation) are not re-reported.

Findings, most important first.

---

## 1. The hand-time batching machinery is duplicated, and the two copies have already diverged — main, high

**Where:** `crates/paint/src/handling.rs:844–931` (`run_plans`) and `crates/paint/src/stipple.rs:549–609` (`stipple`).

**What's wrong.** Both functions grew the same five-step skeleton, pasted into the middle of each:

1. per-tile hand seconds into `tile_secs` while counting the ledger;
2. `tally::batches(&order, &tile_secs, slice)`;
3. per batch: re-take ids (`in_batch.sort_unstable()`, `next_stroke_ids`, `offsets`) "in tile order… all at once for a single slice";
4. filter the order for the crop, `run_ordered`, merge dirty bounds, `wet.touch`;
5. `hand_pass(bsecs)` between batches.

The two copies are already drifting: `handling.rs:846–851` picks the hand-time order through the canonical helper (`tile_order(Order::Sweep(FRAC_PI_2), …)`, gated on `hd.order_set`), while `stipple.rs:547–549` hand-rolls its own sweep with `order.sort_by_key(|&i| (i / tw, (i % tw) % 2, i))` — a second, bespoke ordering policy with a subtly different meaning (row-major with phase tiebreak, not a directional sweep). Two ways to say "how a hand works down a region" in one change set is exactly the kind of special-case growth that turns into spaghetti the next time someone touches either function.

**Why it matters.** This is the load-bearing part of the hand-time model (the paint must age identically in `work` and `stipple`, and the tests pin byte-identical output). Duplicating it means every future fix — and review round 6 already had to fix three things here — must be made twice, and the two copies will not fail the same way.

**Fix (code judo: delete the copy, don't polish it).** Extract one runner, e.g. in `handling.rs` or a small `slicing.rs`:

```rust
/// Paint `tiles` in hand-time slices of `slice` seconds (`order` pre-computed,
/// `secs` each tile's hand time). Calls `ids(tiles_in_batch)` for per-slice
/// stroke-id planning and `paint(order)` per batch, ageing the paint between
/// batches. Returns the merged dirty bounds.
fn paint_sliced(
    &mut self, order: &[usize], secs: &[f64], slice: Option<f64>,
    ids: &mut dyn FnMut(&[usize]) -> (u32, Vec<u32>),
    mut paint: impl FnMut(&mut Self, &[usize], &[(u32, u32)]) -> Bounds,
) -> Bounds
```

Both call sites keep only their own parts: `work` passes `tile_order` and its drag closure, `stipple` its touch closure, and the sweep-vs-checkerboard policy moves into one function (`hand_order(hd.order_set, ...)` / a `tile_order` variant) so it can't diverge again. The `sliced: bool` parameter on `run_plans` (handling.rs:781) also folds away: pass `Option<f64>` slice directly — `None` from `fill_gaps` and the cut-in path, `self.hand_slice_secs()` from `work`.

**Verified** (read both functions side by side; the skeletons are line-for-line the same modulo touch-vs-drag).

## 2. The batch loop is dropped in without reindenting — main, high (same change)

**Where:** `handling.rs:854–931`, `stipple.rs:557–609`.

The new `for (bi, (order, bsecs)) in batches.into_iter().enumerate() {` wraps roughly 70 pre-existing lines that keep their old indentation, and the loop's closing brace sits back at the outer level (`handling.rs:929–931`: `        }\n        }` then `}`). Reading `run_plans`, a reader cannot tell by eye where the per-batch scope begins and ends; the brace pairing at the end (`hand_pass` line, unindented `}`, fn `}`) has to be counted. `cargo fmt` would refuse or fix this wholesale — as written it defeats both rustfmt and humans.

**Fix:** reindent the wrapped bodies (or, with finding 1, extract them into the runner so the loop body is three lines again). Also consider naming the sentinel: `let last = bi + 1 == n_batches;` … `if !last { self.hand_pass(bsecs); }` reads better than a bare index comparison in two files.

**Verified** (read the file regions as committed).

## 3. `time::` plumbing is scattered across every verb handler in the Lua layer — main, medium

**Where:** `crates/easel/src/api.rs` (16 `time::` calls), `session.rs:216`, plus `time.rs` itself.

**What's wrong.** Round 6 added `crate::time::flush(...)` / `waited(...)` / `trip(...)` calls one by one into `work`, `stipple`, `drag`, `touch`, `load`, `reload`, `wipe`, `glaze`, `dry`, `wait`, `drying`, `clock`, `hand_time`, `sitting`, `rest`, `timesheet`. Two of those are *queries* that now mutate the clock (`drying(x, y)` at api.rs:1714 and `clock()` at api.rs:1713 flush with force) — correct for reproducibility, but nothing in `api.rs` says that is the invariant; a future verb that reads the clock without flushing reintroduces the exact bug review r6 finding 2 fixed, and only a test in another crate would catch it. The feature's contract ("what must call flush, when") lives implicit across a dozen call sites.

**Why it matters.** This is feature logic leaking into every shared path. The rule is simple when stated once: *any verb that marks paint, or reads the hand's clock, first flushes owed hand time; any verb that passes wall-clock drying time calls `waited`.* Right now that rule is enforced by programmer memory at 16 sites.

**Fix:** one wrapper in `time.rs`, e.g.

```rust
/// Run `f` as a verb that paints (flush owed hand time first) or dries
/// (`waited` after): the time module owns the rule, not each verb.
pub fn verb<T>(st: &S, waited_min: Option<f64>, f: impl FnOnce() -> T) -> T
```

and each handler becomes `time::verb(&st1, None, || { ... })` / `time::verb(&st1, Some(minutes), ...)`. That deletes 16 scattered calls down to one call per verb, and the rule lives in one place with its comment (`time.rs` module docs) and its tests.

**Verified** (counted the call sites; the invariant is stated only in `time.rs`'s module doc).

## 4. `broadleaf.rs` took 1510 → 2000 lines by appending a whole subsystem — main, medium

**Where:** `crates/paint/src/broadleaf.rs` (now 2000 lines): `straighten` (571), `WoodStroke`/`subdivide`/`polylen` (1419–1443), and `Tree::{is_fine, drawn, wood_strokes, twig_mass}` (1449–1625) — about 380 new lines of "how a painter strokes and tones wood", appended to a file whose first 1400 lines are the growth model.

**What's wrong.** These are two different concerns sharing one file: growing the tree model, and turning the grown model into painter's strokes at a `detail` level (selection by character, band splitting, pull-out from the parent, the twig-mass tone). The only types they share are `Limb`/`Tree`. The file was already over the 1k-line line before this change; this diff pushes it to 2k and makes the wood-stroking feature hard to find (it sits after `lay_touches`, before `self_touch_w`).

**Fix:** split out `crates/paint/src/broadleaf/wood.rs` (or `wood.rs` at crate root) holding `WoodStroke`, `subdivide`, `polylen`, `straighten` and the `impl Tree` block; `broadleaf.rs` keeps growth and exposes `limbs`/`crown`/`seed`/`step` (it already publishes `twig_w` and `angular` as public fields, added by this same diff precisely so the stroker can read them — the seam is already cut; use it). This drops `broadleaf.rs` back under ~1650 and gives the stroker a home a reader can find.

**Verified** (read the appended block end to end; it references `Species.angular`, `Limb.lead`, `self.step` and nothing else private beyond `Limb` fields).

## 5. r6-wet's set-aside film (`mid`/`midx`) rests on an invariant enforced three files away — r6-wet, medium

**Where:** `wet.rs:191–198` (`mid`, `midx` fields), `bristle.rs:657–697` (`Surf::lay`), `bristle.rs:1327+` (`exchange` pickup and plough read `mid[*sf.midx.add(i)]`), `bristle.rs:1202, 1866` (`settle_mid`).

**What's wrong.** While a stroke runs, a pixel can hold "an earlier surface film set aside under this stroke's paint", with its pigment stored in the stroke-local `Vec<Mid>` and its index in the whole-canvas `midx` buffer. That means `midx[i]` is only meaningful *for the stroke that owns pixel i right now*. Correctness depends on: (a) `run_ordered` never runs two strokes with a shared wet pixel concurrently; (b) `mid[i] == 0` at every stroke start, i.e. `settle_mid` ran to completion for the previous stroke even on early exits; (c) nobody forgets `settle_mid` when adding a new verb (both `drag_on` and `touch_on` carry the `// SAFETY` comment; the next one may not). None of these is checked where the data is used — the code's own guard is only `*self.mid.add(i) <= 0.0` in `lay`, which is exactly the invariant being relied on, asserted nowhere. One test (`a_third_stroke_over_two_wet_colors_conserves_paint`) asserts `wet.mid` is all zero *after its strokes*; that is a spot check, not a guard.

**Why it matters.** If the scheduler's disjointness or the settle discipline ever slips, the failure is silent cross-contamination of pigment between strokes — the exact class of bug the conservation test was built to catch, and it would not catch this one (pigment moves, moments stay).

**Fix (cheap, at the right place):** in `Surf::settle_mid`, end with a debug-only sweep of the stroke's bounds asserting `mid == 0` and `midx` stale; in `Surf::lay`'s set-aside branch, `debug_assert!(*self.mid.add(i) <= 0.0)` is already implied — instead assert the inverse invariant at stroke start (`debug_assert_eq!(*self.mid.add(i), 0.0)` for pixels first touched). And move the scheduler-disjointness dependency from a one-line SAFETY comment into the `Wet::mid` field doc (it is half there already: "never seen between strokes").

**Verified** (invariant chain read end to end; concurrency behavior suspected — the scheduler claim is documented but I did not stress it).

## 6. `exchange` keeps accreting physics; the per-bristle parameter block is now its own unread function — r6-wet, medium-low

**Where:** `bristle.rs:1327` to about 1890 on r6-wet (~560 lines). The diff adds `STIR`, `THIN_FILM`, `GLANCE`, `TIP_RUN`, `CUSHION`, `PLOUGH_KEEP`, `PLOUGH_STIFF` consts at the top and ~120 lines inside the pixel loop: `cushion`, `glance`, `drag_in`, `stir`, `keep`, `from_tip`, the three-way `take`, the `film_over`-style layering.

**What's wrong.** The function now interleaves three logically separate passes (pickup from the column, deposit with drag-in/lay, stir + plough) with per-bristle physics constants mixed by five nested `.max()`/`clamp` expressions (`drag_in` alone is a max of three terms). Each line is documented and each is individually defensible — this is not spaghetti born of laziness — but the function has no internal shape left: a future knob (the branch's own notes list paint heaping and stroke endings as next steps) has ten local variables to interact with. The new consts live at module top while `BURY` and `WET_FILM` live near `Surf`, so even the constants are split by accident of history.

**Fix:** keep the hot loop, but hoist the per-bristle block into a small struct built once per bristle:

```rust
/// How one bristle meets the wet film under it (built per bristle per step).
struct Pass { cushion: f32, drag_in: f32, stir: f32, keep: f32, from_tip: f32 }
```

and split `exchange` into `pickup(...)`, `deposit(...)`, `plough(...)` helpers over that struct (all `#[inline]`, same codegen). That turns the pixel loop back into readable phases without changing behavior, and gives the conservation test finer places to assert from.

**Verified** (read the r6-wet function in full).

## 7. `settle_film`'s exact-conservation rescale runs after the caps, so the caps are approximate — main, low

**Where:** `crates/paint/src/surface.rs:292–399` (`settle_film`); the rescale at 392–398; the clamps at 319 (`PEAK_FILM_UM` floor in `kept`) and 345 (`POOL_MAX` cap in `gain`).

**What's wrong.** The function clamps per-pixel (peaks keep at least `PEAK_FILM_UM`, hollows gather at most `POOL_MAX·add`) and then makes the total exact by multiplying every pixel by `k = sa/so`. If `so > sa` (k < 1), a clamped peak film can end below `MIN_FILM_UM` and a capped pool above `POOL_MAX·add`; the test tolerates 1% slack (`lo >= 0.99 * MIN_FILM_UM`, `hi <= 2.25 * 2.0 * 1.01`), which suggests the author saw it and chose to accept it. The invariant the doc states ("Volume is conserved locally and then exactly", "They keep at least PEAK_FILM_UM") is therefore soft at both ends.

**Why it matters (mildly).** At 3200 px the worm-line defect this function exists to kill lived exactly in the clamp tails; a change that re-opens them by a percent would be invisible to the doc and caught only by the test's slack.

**Fix:** apply the global correction only where it cannot violate a cap — pixels strictly between the clamps — or do one bounded redistribution pass over unclamped pixels; then tighten the test to exact bounds.

**Suspected** (logic read and confirmed in order; I did not construct a case where k < 1 materially — the test's slack suggests it happens).

## 8. Small boundary and duplication items — main, low

- **`touch_secs` takes a parameter it throws away** — `crates/paint/src/tally.rs:155–158`: `let _ = w_mm; // (the index of difficulty is the same at any size)`. A kept-for-symmetry unused argument is a contract that lies: callers (e.g. `Tally::touch`) compute and pass `mark_mm` for nothing. Either drop the parameter (and the `mark_mm` call at the call site), or if `w_mm` is coming (per-size dwell?), say so in the doc. **Verified.**
- **`polylen` duplicates the canonical path-length helper** — `crates/paint/src/broadleaf.rs:1438–1440` is byte-for-byte the same sum as `crate::tally::path_len` (`tally.rs:161`). And `draw_trees.rs`'s new `plan_stroke` (draw_trees.rs:314–320) re-derives an arc-length table a third time. One `pub fn path_len` (plus, if wanted, one `pub fn arclen(pts) -> Vec<f32>`) used by all three. **Verified.**
- **`Tally` is serialized field-by-field, by hand, twice** — `crates/paint/src/checkpoint.rs:168–180` (write) and `297–314` (read) spell out nine fields in parallel, with a validation list (`is_finite`) covering only the f64s. The file already has the right pattern one screen up: `Drawing::to_f32s()` / `from_f32s()`. Give `Tally` the same (`to_u64s()/from_u64s()` or a bits slice) so the next ledger field doesn't have to be remembered in four places. **Verified.**
- **The glaze handler computes area in mm² inline in the Lua layer** — `crates/easel/src/api.rs:1641–1649` sums mask data and divides by `scale²`, then converts with `mm_per_unit()²`. That is a units-and-geometry computation living in the Lua binding layer; the engine already owns every other mm conversion (`tally::stroke` takes `mm_per_unit` and does this math). A `Canvas::area_mm2(&Mask)` (or `tally.glaze_area(&Canvas, &Mask)`) keeps the conversion in the layer that owns mm. **Verified.**

## 9. Things checked and found sound (so other reviewers don't have to re-derive them)

- **Determinism of the ledger**: counting happens per tile, sequentially, over the whole canvas before the crop filter (`handling.rs:813–837`, `stipple.rs:506–516`); `Piles::dip` uses `rposition` + push/pop (no map-order dependence); `drawn()`'s `starts` HashMap is only key-looked-up, never iterated; the tiebreak `then(a.1.cmp(&b.1))` in the `cand` sort makes the selection order total. Tests pin thread counts and crop equality.
- **`time.rs`'s clock algebra**: `flush`'s `away = now − s.clock − hand` and the single-consumption of finishing-verb drying via `unreported` are consistent, and the chunk-end reporting (`session.rs:233–244`) takes `unreported` with `std::mem::take`, so repeated queries can't double-report. The `Hand` snapshot/restore in `Snap` keeps undo exact.
- **Checkpoint numbering**: PAINTCK7 (hand time) then PAINTCK8 (surface film), version history documented at `checkpoint.rs:20–33`; the r6-wet reader appends after the hand-time block and the corrupt-drawing test was updated to match (`checkpoint.rs:405–410` on r6-wet).
- **r6-wet memory**: the surface film costs `top` (4 B) + `tlat` (3·4) + `thide` (3·4) + `mid` (4) + `midx` (4) = 36 B/px, consistent with the stated ~44 B/px budget in notes/round6.md; no per-pixel heap allocation anywhere in the hot path.
- **r6-wet's conservation test module** (`bristle.rs`, end) is exemplary: moments over canvas plus bristles, per-moment relative tolerances, and assertions that the exercised paths actually ran (`MID_MOVES` counters). This is the right standard for a physics change.

---

## Verdict

**main — approve with two changes requested.** The hand time change set is well tested and the counting layer is clean (the `tally` module is a genuinely good abstraction: pure, deterministic, and priced in one place). But findings 1 and 2 are a real structural regression: the same ~70-line batching skeleton now exists twice with divergent sweep policies and both copies deliberately formatted outside `cargo fmt`'s reach. Extract the shared runner and reindent before anything else lands on `run_plans`; finding 4's split can follow at leisure but should happen before `broadleaf.rs` grows again.

**r6-wet — approve, with hardening requested.** The two-layer film is the best-justified change in the round: a clear physical model (surface film over body), a conservation test that would embarrass most simulators, and notes that document every constant as an estimate rather than hiding them. The cost is that `exchange` has crossed from "big but organized" into "accreting" (finding 6), and the `mid`/`midx` mechanism depends on an invariant nothing asserts (finding 5). Neither blocks merging on quality grounds; both should be fixed in the first pass after merge, while the author still remembers why the SAFETY comment is true.
