# Thermo-nuclear code quality review: Round 6 (opus, quality)

Scope: `git diff 2c5a658..main -- crates paintings` (main) and
`git diff main...r6-wet -- crates paintings` (r6-wet). I verified every
finding by reading the code at the named refs; the counts come from
`git grep` on those refs. I built nothing. Correctness findings that fall
out of a structural problem are listed with it.

File sizes (lines at 2c5a658 → main → r6-wet): no file goes from under 1k
lines to over 1k. Two files that were already large grew a lot:
`crates/paint/src/broadleaf.rs` 1510 → 2000 (main) and
`crates/paint/src/bristle.rs` 1898 → 2357 (r6-wet). `api.rs` (1809) and
`look.rs` (1251) grew by less than 70 lines each.

---

## main

### M1. High: hand time runs through the easel as scattered `flush` calls, with four copies of the clock
*main · crates/easel/src/time.rs:92-118, api.rs:490, 518, 996, 1134, 1638, 1661-1662, 1671-1678, 1688-1697, 1703, 1715, draw_pencil.rs:71, session.rs:214-245 · verified*

The clock state now lives in five places:
- `Canvas::clock()`
- `Studio.clock` (a lagging copy, rebased on `clock0`)
- `Tally.clocked`, in the engine
- `Hand.clocked`, the easel's copy of `Tally.clocked`, kept to take differences
- `Hand.unreported`

`flush()` then works backward to "time that wasn't hand time" by
subtraction (`away = now - s.clock - hand`, time.rs:108) and uses that to
decide on rests and reports. For this to work, every verb that touches the
canvas has to remember to call `time::flush(st, force)` at the right time
and in the right order relative to its own `s.clock = now`. `git grep` on
main finds 14 flush call sites, 3 `waited`/`begin_rested` calls and 7
places that assign `s.clock`.

Evidence that this is fragile: `varnish` (api.rs:1723-1742) has no flush.
Hand time owed from earlier `b:stroke`s in the same chunk is put on the
clock only at the chunk's end, so it lands after the varnish dried the
canvas. The effect is small, but it is exactly the ordering bug this
design invites. The review-r6 fix (finding 2, `unreported`) was also a
patch on top of the same inference.

**Code-judo fix:** have the engine own the split and let the easel derive
the rest.
1. `Canvas` keeps two accumulators: hand minutes (from `hand_pass`) and
   idle minutes (`wait`/`dry`/a glaze's drying).
2. The canvas puts owed hand time on the clock at a grain it is given
   (`set_hand_time(slice, grain)`), inside `drag`, `touch`, `work` and
   `stipple`.
3. `Studio.clock` becomes a function (`canvas.clock() - clock0`).
4. Sittings read the idle accumulator: a jump of `REST_MIN` or more starts
   a sitting.

That deletes `flush`, `Hand.clocked`, `Hand.unreported`, `waited`,
`begin_rested` and every `s.clock = …` write except undo's. The verbs go
back to one line each, and a new verb can't forget to flush.

### M2. High: the slice-and-batch paint loop is duplicated in `run_plans` and `stipple`, spliced in without re-indenting
*main · crates/paint/src/handling.rs:806-931, stipple.rs:503-608 · verified*

Both passes got the same roughly 40-line scaffold:
- a per-tile ledger pass into `tile_secs` with a fresh `Piles`
- a hand-time order override
- `tally::batches`
- per batch: sort the tile ids, hand out stroke ids, build offsets, take
  `surf()`, apply the crop filter, run `run_ordered` and union `dirty`
- `wet.touch`, then `hand_pass` between batches

In both files the new `for (bi, (order, bsecs)) in batches…{` wraps the old
body without re-indenting it (handling.rs:855, stipple.rs:555), so the
closing `}` pairs are hard to read. The two copies have also drifted:
"sweep down" is `tile_order(Order::Sweep(FRAC_PI_2), …)` in handling.rs:849
but a hand-written `sort_by_key(|&i| (i / tw, (i % tw) % 2, i))` in
stipple.rs:548. The `dirty` union written as `Some(match … { None => r, Some(…) => … })`
appears twice more even though `bristle::grow` already does this.

**Fix:** one engine helper, for example
`Canvas::paint_tiles(order, tile_secs, ids_per_tile, tile_rect, slice, paint_tile: impl Fn(Surf, usize, u32) -> Bounds + Sync)`.
It owns batching, id assignment, the crop filter, the scheduler, the dirty
union and the `hand_pass` between slices. Each pass keeps only its planning
and its `paint_tile` closure. Also add one `sweep_down(tw, th)` order that
both passes use. This removes about 60 lines, keeps the two passes from
drifting further and gives `sliced` one owner.

### M3. High: the `order_set` flag. An order the painter asked for can still be overridden (`ruler`)
*main · crates/paint/src/handling.rs:141-143, 207-216, 254-257, 846-851; easel api.rs:943 · verified by reading*

`order_set: bool` sits next to `order: Order` so that hand time can tell a
default from a request. Only `Handling::order()` sets it. `ruler()` assigns
`self.order = Order::Scatter` directly, so `work(…, {ruler=true})` with hand
time on gets its scatter silently replaced by a sweep. The review-r6 fix
(finding 3) was meant to prevent exactly this. A hidden bool also makes
`Order::Passages` mean two different things: `order="passages"` is kept,
while the default `Passages` becomes a sweep.

**Fix:** remove the flag and use `order: Option<Order>` (None means the
handling's default), resolved in one place:
`fn resolve_order(asked: Option<Order>, hand: bool) -> Order`. `ruler()`
then sets `Some(Scatter)`, and no future preset can skip the flag. Add a
test: `ruler()` with hand time on keeps its scatter.

### M4. Medium: the ledger is split across layers, with two palettes
*main · handling.rs:812, stipple.rs:505, easel time.rs:157-165, api.rs:447-451, 1640-1651, 1723-1742, draw_pencil.rs:69 · verified*

The tally.rs module doc says counting happens "where the engine plans
marks", but only strokes, touches and a pass's trips are counted in the
engine. The easel counts held-brush loads and reloads (`time::trip`),
wipes (`tally_mut().wipe()`), pencil lines and a glaze's brushing. For the
glaze it computes the area itself from `m.data` and `m.f.scale`
(api.rs:1647).

This split causes three problems:
1. **Two palettes.** Every `work` and `stipple` starts a fresh
   `Piles::default()` (handling.rs:812, stipple.rs:505), while held brushes
   use the sitting's `Hand.piles`. The same sky color counts as a new
   20-second mix in every pass, and a pass's piles never reach the
   sitting's palette. That contradicts notes/time.md ("a new sitting
   starts with a clean palette").
2. **Varnish isn't priced.** `varnish` calls `c.glaze` with no tally,
   although `pace::GLAZE_MM2_S` says "a glaze or varnish".
3. **Rust paintings get part of a ledger.** They count strokes but no
   loads, wipes or glazes.

**Fix:**
- Put `Piles` on the `Canvas` next to the tally, with
  `Canvas::new_sitting()` to clear it. Passes and held brushes then dip
  into the same palette.
- `Canvas::glaze` prices its own area.
- `Held` records its pending trips and wipes (colors only), and
  `Canvas::drag`/`touch` fold them into the tally. `Held::load` already
  sees every load.

The easel's `time::trip`, the wipe hook and the glaze-area code go away,
and `tally_mut()` can become `pub(crate)`.

### M5. Medium: tally.rs mixes unrelated jobs, duplicates the drying-stage rule and mixes units
*main · crates/paint/src/tally.rs:285-344, drying.rs:311-322 · verified*

- `Canvas::stages()` (tally.rs:329-344) copies `drying_at`'s
  classification line for line (the `1e-3` volume threshold,
  `0.5 * GEL`, `sub < 1.0`). Two copies of the definition of "open" will
  drift. **Fix:** add `fn stage_at_index(&self, i) -> Stage` in drying.rs
  and have both `drying_at` and `stages` call it. Move `stages` and
  `stage_shares` to drying.rs, and move `mm_per_unit()` to canvas.rs.
- Units within one API: `hand_owed()` returns seconds, `clock_hand()`
  returns minutes, `hand_slice` is stored in minutes as f32 and
  `hand_slice_secs()` returns seconds as f64. The brief lists minutes vs
  seconds as an invariant. Name the units (`hand_owed_secs`,
  `clock_hand_min`) or pick seconds for the ledger and minutes only at
  `wait`.
- `touch_secs(w_mm)` ignores its argument (`let _ = w_mm;`), so
  `mark_mm` is computed for nothing. Remove the parameter.

### M6. Medium: broadleaf.rs grows to 2000 lines. The painter's layer for bare wood belongs in its own module, and `angular` is a bool pretending to be a knob
*main · crates/paint/src/broadleaf.rs:571-640, 912, 963, 1052, 1062, 1395-1629 · verified*

`WoodStroke`, `subdivide`, `polylen`, `is_fine`, `drawn`, `wood_strokes`
and `twig_mass` (about 240 lines, plus about 130 lines of their tests)
decide what a painter draws: detail budgets, crown-edge preference and
stroke plans. That is a different concern from growing the tree, so move
them to `broadleaf/wood.rs`. `straighten` (Douglas-Peucker) is generic
geometry.

`angular` is documented as "0 smooth .. 1", but 4 of its 5 uses are
`> 0.0` switches: the anti-curl clamp, twig spread `lo`, twig zig sign and
the `subdivide` choice. So lime (0.5) gets the oak's full twig behavior,
and only `straighten`'s epsilon scales. Either make it continuous (for
example `lo = lerp(0.45, 0.7, angular)`) or name the switch
(`angular: bool` plus `straighten: f32`). `Tree` copies `angular` and
`twig_w` from `Species` just so `wood_strokes` can branch on them.

Duplicate helpers: `polylen` (broadleaf.rs:1438) is identical to
`tally::path_len` (tally.rs:161). `plan_stroke` (draw_trees.rs) and
`straighten` each write the same arc-length loop again. graphite.rs
(`arclen`), rock.rs (`cumlen`) and outline.rs (`line_len`) already have
their own. Add one `polyline::{length, arclen}` and use it everywhere.

### M7. Low: `settle_film` copies `settle_for`'s setup
*main · crates/paint/src/surface.rs:183-270 vs 292-387 · verified*

The band radii and wavelengths (`r1, r2, lam1, lam2`, computed
identically), the `ADD_EPS_UM` clean-up, the "only approximately
conservative: make the total exact" f64 rescale and the height write-back
with `surf_gen += 1` are all copied. **Fix:** extract
`struct Bands { r1, r2, lam1, lam2 }::at(px_mm)`,
`fn rescale_to_total(add, out)` and `fn raise(&mut self, old, out)`. Each
function then shows only its own physics.

### M8. Low: smaller boundary smells
*main · verified*
- `run_plans` gets an 11th positional argument, `sliced: bool`
  (handling.rs:781). Once M2 lands it belongs in the helper's inputs.
- Stipple `Plan.want` starts as the sentinel `[0.0; 3]` and is filled
  later (stipple.rs:474, 496). Set it where the color is computed, or make
  it an `Option`.
- `look`: `wet` is one more independent bool, and it silently turns off
  `value` (`if v.value && !v.wet`, look.rs:973). A small `Tint` enum
  (`None | Value | Stages`) states that exclusion in the type.
- `draw_trees::lay_wood` passes pressure as `{1, 1}` and puts the real
  profile in `swell` knots. That works, but it is a detour through two
  parameters. A `pressure` knot list (or a `Gesture::pressure_knots`) would
  say what it means.

---

## r6-wet

### W1. High: the layered film is parallel "total + part" arrays edited through raw pointers. It needs a `Layer` type
*r6-wet · crates/paint/src/wet.rs:171-243, 273-306; bristle.rs:361-387, 598-812, 1480-1683; drying.rs:226, 342, 436-462, 493-528 · verified*

The branch adds `top/tlat/thide` next to `vol/lat/hide`, `mid/midx`,
per-bristle `tip/tlat/thide` and 5 more raw pointers on `Surf`. Totals and
parts are stored together (`vol` includes `top` and `mid`; `b.vol`
includes `b.tip`), so the invariants are kept up by hand wherever paint
moves:
- clamps: `body() = (vol - top - mid).max(0.0)`,
  `br.tip = br.tip.min(br.vol)` (three sites), `t.min(v)` in `film_over`
- every clearing site in drying.rs had to learn to zero `top` together
  with `vol` (three places)
- the 6-argument `mix_into(&mut v, &mut lat, &mut hide, v, &lat, hide)`
  is called 13 times in bristle.rs
- pickup and plough depend on the position of each part in `[top, mid, body]`

bristle.rs gains about 460 lines, and about 200 of them are film-layer
bookkeeping (`body/add/lay/settle_mid/stir/add_body/take_column/take`,
`Mid`, `NO_MID`) that belongs with `Wet`.

**Code-judo fix:** add `#[derive(Clone, Copy)] struct Layer { v: f32, lat: Latent, hide: Prop }`
with `mix(&mut self, other: Layer)`, `take(&mut self, v) -> Layer` and
`split(k)`. Then:
- `Wet` stores disjoint parts (`body: Vec<Layer>`, `top: Vec<Layer>`),
  with `vol(i)` derived (or cached through one setter).
- `Bristle { res: Layer, tip: Layer }`
- `whole(&body, &top)` and `film_over(&body, &top, under, coats, cover)`
  replace the 4-argument and 9-argument versions.
- `take`/`take_column` return `[Layer; 3]`, and the pickup and plough
  loops iterate over them.
- `Surf` needs 2 pointers instead of 6.

Put the layer operations in wet.rs, where the layers are defined.
bristle.rs keeps the bristle mechanics and shrinks back toward its
pre-branch size. All the clamps go away, because no part can be larger
than a total that is itself a sum.

### W2. Medium-high: `mid/midx` keeps per-stroke state in two canvas-wide buffers
*r6-wet · wet.rs:192-198, bristle.rs:680-730, 794-800 · verified (memory arithmetic from the struct)*

`mid` and `midx` are "never seen between strokes" (wet.rs:195), yet they
take 8 bytes per pixel for the canvas's whole life. That is about 57 MB at
3200 × 2240, copied with every `Canvas` clone (undo snapshots, `look`).
With them, the branch adds 52 bytes per pixel, not the 44 the notes give
(`notes/wet.md:209`: top 4, tlat 28, thide 12, mid 4, midx 4). The state
is also encoded twice: `mid > 0` and `midx` both mean "set aside", and a
`NO_MID` sentinel covers the gap between them.

**Fix:** keep the set-aside volume in the stroke-local `Mid { i, v, lat, hide }`,
and either store only `midx: Vec<u32>` (u32::MAX means none) or drop the
per-pixel buffer for a stroke-local map keyed by pixel (measure first).
Correct the memory figure in notes/wet.md either way.

### W3. Medium: `exchange` grows to 356 lines and 16 parameters, with its physics policy written into the pixel loop
*r6-wet · crates/paint/src/bristle.rs:1326-1683 · verified*

`exchange` goes from 275 to 356 lines and from 15 to 16 parameters
(`mid` added). Eight new per-bristle formulas are computed inline:
- a hunger × stiffness factor
- `cushion`, `glance`, `drag_in`, `stir` and `keep`
- the pickup split `if dep.is_some() { 1.0 - 0.3 * wet } else { cushion }`
- the plough's stiffness gate

Their justifications are stacked parenthetical comments ("… and for a
moving bristle that only glances…"), which is how special cases pile up.
`dep: Option<f32>` stands for both "touch vs drag" and "deposit". The
function now branches on it 7 times, up from 5.

**Fix:**
1. A pure `fn contact(tool, br, reach, seg, rb, full, wet, mode) -> Contact { hunger, push_k, cushion, drag_in, stir, keep, pick_through }`,
   computed once per bristle step. It can be unit-tested and it documents
   the knobs in one place.
2. `enum Mode { Drag, Touch { dep } }`
3. A `StrokeCtx { id, clip, lim, wts, mids, bounds }` in place of the six
   per-stroke arguments.

The pixel loop keeps only the transfer mechanics.

### W4. Medium: PAINTCK8 splits `Wet` across two places in the file
*r6-wet · crates/paint/src/checkpoint.rs:181-184, 254-258, 318-321, 406-409 · verified*

The film's body is written in the wet block. Its surface layer is
appended after the hand-time block, and the reason is merge order ("7 is
hand time … merged first"). The format refuses older versions anyway, so
nothing has to be appended. The layout now has a seam that each future
version will copy, and the drawing-corruption test has to compute an
offset through it (`film = 300*200*(1+LAT+3)*4`).

**Fix:** `Wet::write`/`Wet::read`, in one place and in one order (with W1,
a list of layers). Consider rejecting `top > vol` or non-finite values on
read, as the hand-time block already rejects non-finite values.

### W5. Low-medium: the three study binaries copy their measuring code, and the copies have drifted
*r6-wet · paintings/src/bin/study_wet.rs:206-285, study_wet_control.rs:39-193, study_wet_lab.rs:35-104 · verified*

`Img` (`at`/`l`/`column`/`line`), `width`, `median`, `rect` and `field`
are copied, and the copies no longer match:
- `study_wet`'s `Img::at` bounds-checks and `study_wet_control`'s doesn't
- `width` returns `Option` in one and NaN in the other
- one `median` drops non-finite values and the other doesn't

A measurement taken in one study doesn't mean the same thing in another.
`Img::line` also has a no-op `t * len as f32 / len as f32`.

**Fix:** move them to `paintings/src/study.rs`, next to `figures`,
`rocks` and `trees`, which is where code shared by the paintings already
lives.

### W6. Low: test counters in the hot loop
*r6-wet · crates/paint/src/bristle.rs:803-804, 1556-1560, 1648-1652, 2335-2353 · verified*

`#[cfg(test)] static MID_MOVES` are global atomics incremented inside
`exchange`, in the pickup and plough loops. They add no cost in release,
but they are hidden global state shared by parallel tests (the test only
checks deltas, and those can only grow) and two more `#[cfg(test)]` forks
inside the busiest function in the crate. **Fix:** once W1 is in, check
that the conservation test covers set-aside paint through the layers
themselves. For example, have `settle_mid` return a count that the stroke
reports, or test `take`/`take_column` on `Layer` directly.

---

## Not re-reported
The five issues fixed after the earlier review (notes/round6.md,
notes/advice/astra_r6.md). Two of those fixes are criticized above only as
signs of structural problems: finding 2's `unreported` in M1 and finding
3's `order_set` in M3, where the fix is incomplete for `ruler`.

## Verdicts

**main: changes requested.** Behavior is well tested and deterministic by
construction (the ledger is counted before tiles are split, and
`batches` is pure). But the quality bar isn't met:
- **M3 is a real hole, with a small fix:** use `Option<Order>`.
- **M2 duplicates a 40-line scaffold into two hot paths:** extract one
  `paint_tiles` helper.
- **M1 spreads hand time over 14 flush sites and four copies of the
  clock:** the engine-side hand/idle split would delete most of the easel
  side.

M4, M5 and M6 are the next layer down: one palette, one stage rule and
moving the bare-wood painter layer out of broadleaf.rs.

**r6-wet: changes requested before merge.** The physics may well be right
(conservation is tested per moment). But the two-layer film is
implemented as parallel "total + part" arrays through raw pointers, with
invariants kept by clamps at every site. It also keeps per-stroke state
in 8 bytes per pixel of canvas memory. Put in the `Layer` type (W1) and
shrink `mid` (W2) before more features build on this representation.
Group the serialization (W4) while the checkpoint version is still being
changed anyway.
