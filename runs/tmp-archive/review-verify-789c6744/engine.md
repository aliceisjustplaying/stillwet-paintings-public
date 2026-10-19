# Engine findings: verification of #10, #31–#41 and the two frame-contract items

Revision: `08f632434fd03bf7e85129539f7e184a91db9056` (checked with `git rev-parse HEAD`). No repo files were changed.

Probes are in `[local path redacted] with output in `.../engine/out/*.txt`. The probe crate depends on `crates/paint` by path. Its dev profile has overflow checks on, like the workspace `[profile.test]`; its release profile has them off, like `[profile.release]`. Unless noted, probes ran in release.

Reachability rules used below:
- **Painter-reachable** means a painter's Lua can trigger the path through `crates/easel/src`.
- **Engine-only** means only paint-crate tests or the public Rust API reach it.

## What changes from the review

- **#36 is painter-reachable.** The review says no caller passes zero softness. But `f:lit{soft=0}`, `f:shadow{soft=0}` and `f:lit_at(x, y, 0)` pass it straight through. The shadow mask then leaves the core shadow unpainted. I recommend raising it to P2.
- **#41 is worse than described.** A thin distant body disappears from the painter's `View` itself (`view.at` returns `Ground`), not only from mirror traces.
- **#32 depends on geometry.** The mechanism is real, but the review's exact case (a center ray at 300 m) hit in my probe. Misses need oblique incidence and a ray origin (the water point, for mirrors) at least about 150 m from the body. When those hold, misses are common.
- **#31 is engine-only** (no caller of `form_of`), so it should be P3 by the review's own definition.
- **#35 only panics in debug and test builds.** The painter and replay builds are release builds and wrap deterministically. It is reachable through `canvas{seed=}` values ≥ 5.95e17 and water ripple seeds near `u32::MAX`. I recommend P3.
- **#40's allocation is lazy.** A 192 MiB zeroed request peaked at about 2 MB RSS. At the cap, the risk is an allocation-failure abort rather than memory exhaustion. It stays P3 and engine-only.
- **#10 is deterministic.** It is a fidelity defect that affects real hand-timed paintings, not a live-versus-replay divergence.

---

## #10 P2: Fresh overpaint keeps stale drying state until a wait — CONFIRMED

**Code.** Cure is diluted only in `absorb`, which runs from `wait`/`dry`:
- `crates/paint/src/drying.rs:258`: `self.absorb();` (inside `wait`)
- `crates/paint/src/drying.rs:464`: `p.cure *= p.seen.min(v) / v;`

Brush contact reads the stored cure directly, with no absorb:
- `crates/paint/src/bristle.rs:1217`: `sum_tack += wt * crate::drying::feel(*sf.vol.add(i), p.cure, p.sub).1;`
- `crates/paint/src/bristle.rs:1284`: `let fl = if sf.dry.is_null() { 1.0 } else { crate::drying::fluid((*sf.dry.add(i)).cure) };`

**Probe** (`p10.rs`, `p10c.rs`):
1. Lay a blue band and wait until it is `Setting` (175 min).
2. Drag fresh red over it.
3. Clone the canvas; call `wait(0)` on one copy only.
4. Make the same empty-brush blending drag on both, then `dry()` both.

```
after red dab: stale stage Setting
after wait(0): Open, clock 175 vs 175
after dry(): differ in 6236 channels, max 0.1794248
```

In the control run without the blending drag, `wait(0)` changes nothing (`after dry(): differ in 0 channels, max 0`). So the difference comes entirely from the brush reading stale cure. The existing zero-wait test (`drying.rs:688`, `b.wait(0.0);`) paints fresh bands only, not aged overpaint.

**Reachability: painter-reachable, and in normal use.** The easel keeps hand time on (`time.rs:99`, `c.set_hand_time(Some(SLICE_MIN));`).
- Marks only reach the clock once a minute is owed: `time.rs:25` `pub const GRAIN_MIN: f64 = 1.0;` and `time.rs:70` `Verb::Marks => flush(st, false),`. So consecutive `b:stroke`/`b:touch` calls within a minute of hand time read stale cure.
- A `work` pass ages the paint only between 15-minute slices (`time.rs:22` `pub const SLICE_MIN: f32 = 15.0;`). Within a slice, later marks over earlier fresh-on-setting paint are stale too.
- The `drying(x, y)` query is a `Verb::Query`, which flushes first (`time.rs:57`). So the easel's stage report is never stale; only brush contact is.
- Live and replay run the same code, so this is deterministic and does not cause replay divergence.

**Severity.** P2 is right. It changes real paintings, visibly (up to 0.18 linear RGB in the probe), whenever a painter works into setting paint.

**Fix sketch (~15 lines).** Compute effective cure where it is read, instead of absorbing on every mark. Wherever `wet.stroke[i] > mark || wet.touched[i] > mark`, use `cure * seen.min(v) / v`. Apply this at `bristle.rs:1217` and `:1284`, and in `stage_at_index` (`drying.rs:374`). Brush reads use only `cure`; the `th` and `lev` recomputation in `absorb` matter only at the next wait. So this matches what an immediate `wait(0)` would give.

**Test.** `p10.rs` becomes a `drying.rs` unit test: an aged film, fresh overpaint, then a blending drag with and without a prior `wait(0)` must give bit-identical `px`/`height`/`film` after `dry()`.

**Golden impact:**
- `crates/paint/tests/golden_scene.txt`: none. Its fixture never sets hand time or waits before `dry()` (`tests.rs` fixture), so `clock.px` stays empty and the brush takes the `sf.dry.is_null()` branch.
- `crates/easel/tests/r19_default_box.golden`: possible. Chunk 3 has `wait(120)`, then strokes and a glaze. Run the tests to see.
- Replays of existing hand-timed paintings will change, so `check_painting` baselines for past paintings would drift.

## #31 P2: `World::form_of` compares incompatible depths — CONFIRMED (engine-only; should be P3)

**Code.** `scene.rs:703`: `form.add(&self.bodies[b].sdf, self.bodies[b].spot.at[2]);`. This uses `Form::add` (`form.rs:643`, `self.add_at(s, &|_, _, _| dist)`), which decides occlusion by each solid's own projection-local `z` and reports the constant anchor distance. `View::new` does it correctly: `scene.rs:834` `form.add_nearest(&p, &move |x, y, z| spot.world([x, y, z])[2]);`.

**Probe** (`p31.rs`): body A has its foot at 10 m and is 1 m deep (front at 9.5 m); body B has its foot at 9.8 m and is 0.2 m deep (front at 9.7 m).

```
form_of: part 2 (1 = A, front 9.5 m; 2 = B, front 9.7 m), dist 9.800
view.at: Body(0) dist 9.500
```

`form_of` picks the farther body and reports the anchor distance. `view` is correct.

**Reachability: engine-only.** `grep -rn form_of` finds only the definition (`scene.rs:699`) and mentions in `notes/scene.md`. The easel's view form is `View::form` (`world.rs:202`, `FormU { src: v.0.clone(), ... }`), which is built with `add_nearest`.

**Severity.** P3. By the review's own definition, P3 covers "an engine API that the current painter tools do not call".

**Fix (~3 lines).** Use `form.add_nearest(&body.sdf, &move |x, y, z| spot.world([x, y, z])[2])`. It needs the view-clipping `Placed` wrapper only if proxies should be clipped by the ground.

**Test.** `p31.rs`'s layout, asserting that `form_of`'s part and dist match `view.at`.

**Golden impact:** none.

## #32 P2: Minimum ray steps skip thin bodies — PARTIALLY CONFIRMED

**Code.** `scene.rs:628`: `t += dist.max(0.002 + 0.001 * t);`. Here `t` is measured from the **ray origin**. For mirrors, that origin is the water point: `scene.rs:972` `w.trace(add(p, r, 0.01), r, w.backdrop)`.

**Probes.** First, the review's case: a ray from the eye through the center of a 10 cm block at 300 m, at normal incidence. It **hit** (`pscene.txt`: `trace hit z=Some(299.95078)`). With exact box distances, sphere tracing lands on the face.

Second, oblique rays with a recentered spot (to separate this from #41), starting 0.8·Z to Z−0.5 m before the body (`p32.txt`; the printed label "240..0" is a label bug):

```
block depth 0.1 at 300 m, incidence 20°, ...: 161/161 miss
block depth 0.05 at 300 m, incidence 45°, ...: 133/161 miss
block depth 0.1 at 600 m, incidence 45°, ...: 315/323 miss
block depth 0.05 at 150 m, incidence 45°, ...: 69/80 miss
block depth 0.1 at 300 m, incidence 0°, ...: 0/161 miss
```

Rays that start only 20 m away always hit, because the minimum step is then about 2 cm.

**Reachability: painter-reachable** through `v:mirror` and `v:reflections` (`world.rs:215`, `:225`), which call `View::mirror` then `World::trace`. The miss needs:
- a body thinner along the ray than about `0.001·t` m;
- a reflecting water point ≥ ~150 m from the body;
- non-normal incidence.

Water under a body at the shoreline reflects from roughly halfway between the viewer and the body. For a body 300 m out, `t` is about 150 m and the minimum step about 15 cm. A thin fence or wall seen obliquely in a distant reflection would get gaps.

**Severity.** P2 is arguable. I'd put it at P3 unless the studios actually place thin bodies with distant water. The affected bodies are usually a few canvas units thick at that range.

**Fix (small to medium).** Cap the minimum step by a per-body thickness bound, or drop the distance-proportional term and raise the step budget. When a step overshoots and `dist` flips sign, bisect. Return "budget exhausted" separately from "miss", as the review says.

**Test.** `p32.rs` as a unit test: no misses for 5–10 cm blocks at 150–600 m and 0–70° incidence.

**Golden impact:** no golden uses a world (the only easel test that mentions `world` is `session_integrity.rs`, not a golden). Existing paintings that use reflections would render differently.

## #33 P3: Distant bounding intersections lose small bodies to rounding — CONFIRMED (for distances beyond the default reach)

**Code.** `scene.rs:219–226`, all in f32:

```rust
let c = dot(q, q) - r * r;
let disc = b * b - c;
```

**Probe** (`p33.rs`: a verbatim f32 copy of `span`, over 400 rays that all pass through the body):

```
cube 0.3 m at 1000 m: 0/400 None, 24/400 shorter than half the chord
cube 0.3 m at 2000 m: 124/400 None, 155/400 shorter than half the chord
cube 0.3 m at 5000 m: 138/400 None, 128/400 shorter than half the chord
cube 0.3 m at 600 m: 0/400 None, 0/400 shorter than half the chord
```

Spans are noisy in both directions: a center ray at 5 km gives length 2.83 m against a true chord of 0.62 m.

**Reachability: painter-reachable but outside default settings.**
- `|q|` is the distance from the ray origin to the body. Mirror traces are capped at `w.backdrop`, which defaults to 600 m (`scene.rs:294`, `backdrop: 600.0,`), and no failures appear at 600 m. A painter can raise it with `world{backdrop=}` (`world.rs:355`).
- Shadow rays start at the receiving surface, next to the caster, so `|q|` stays small.
- At 1 km and beyond, #32's minimum step (≥ 1 m) already dominates for small bodies.

**Severity.** P3 is right.

**Fix (~6 lines).** Compute `span` in f64, or use the stable closest-approach form: `disc = r² − |q − b·d|²`.

**Test.** `p33.rs`'s sweep, asserting no `None` for rays through the center at up to 20 km.

**Golden impact:** none.

## #34 P3: Public tube mutation leaves palette caches stale — CONFIRMED (engine-only)

**Code.** `palette.rs:275`: `pub tubes: Vec<Tube>,` sits beside the private caches `lat` and `scat`, which only `Palette::new` fills (`palette.rs:294–297`). `eval` indexes the caches: `palette.rs:430` `lat[k] += self.lat[i][k] * w;`.

**Probe** (`pmisc.txt`):

```
#34 pile before [0.8631573, ...] after-mutation [0.8631573, ...] clone [0.8999998, 0.0, 0.0]
index out of bounds: the len is 14 but the index is 14
```

**Reachability: engine-only.** A grep for `tubes.(push|extend|insert|remove|retain|clear)`, `tubes[..].x =` and `tubes.iter_mut` over `crates/` finds nothing. Callers only read, for example `handling.rs:1212`: `pal.tubes.iter().position(...)`.

**Severity.** P3 is right.

**Fix (~20 lines).** Make `tubes` private with a `tubes()` accessor, updating the read sites in `handling.rs`, `stipple.rs`, `canvas.rs:526` and `easel/tests/{boxes,painter}.rs`. Mutation, if it is needed at all, goes through `with(...)` or `new(...)`.

**Golden impact:** none.

## #35 P2: High seeds fail differently across build profiles — CONFIRMED (should be P3)

**Code:**
- `style.rs:178`: `let s = seed * 31 + k as u64;`
- `bristle.rs:404`: `seed: i as u64 * 7919 + seed,`
- `scene.rs:136`: `self.sz = Fbm::new(seed + 1, 3, 1.0);`
- Others: `handling.rs:1393` `seed + 4`, `canvas.rs:277` `seed + 1` and `surface.rs:470–482` `seed + 3..19`.

Separately, the external `noise` crate adds octave offsets unchecked (`noise-0.9.0/.../fractals.rs:30`, `sources.push(source.set_seed(seed + x as u32));`). So any `Fbm` seed within about 6 of `u32::MAX` also panics in debug.

**Probe** (`p35.rs`):

```
== dev (overflow checks)
Style::oil().prepare seed=i64::MAX: PANIC  (style.rs:178:21 attempt to multiply with overflow)
Held::new seed=u64::MAX: PANIC            (bristle.rs:404:27 attempt to add with overflow)
Water::ripple seed=u32::MAX: PANIC        (noise-0.9.0 fractals.rs:30:38)
== release
all four: ok
```

**Reachability:**
- **Canvas seed (painter-reachable):** `api.rs:1130` `let seed = o.get::<Option<u64>>("seed")?.unwrap_or(1);`. A Lua integer allows up to `i64::MAX`, and anything ≥ `u64::MAX/31` ≈ 5.95e17 overflows.
- **Water ripple seed (painter-reachable):** `world.rs:376` `r.get::<Option<u32>>(4)?` is passed to `Water::ripple`.
- **Brush seeds:** these come from `auto_seed` → `mixseed`, which spans the full u64 range (`api.rs:1307`). `bristle.rs:404` overflows only when the seed is within about `7919·n` of `u64::MAX`, with probability around 1e-15.
- **Build profiles:** painter and replay builds are `cargo build --release -p easel` (`scripts/export_r16_studio:112`, `scripts/replay_easel:2`). There the arithmetic wraps and is deterministic, so live and replay agree. Only `cargo test` or debug runs of such a program would panic. The easel turns a panic into a failed chunk, per the comment at `drying.rs:695–696`.

**Severity.** P3. There is a real inconsistency between build profiles, but production and replay behavior is deterministic and needs unusual painter-chosen seeds.

**Fix (~10 sites).** Use `wrapping_mul`/`wrapping_add` at each site. This is bit-identical to current release output, so **no golden or replay change**. For the `noise` crate, fold seeds away from the top of the range before calling `noise::Fbm::new`, for example `seed.min(u32::MAX - 16)` or `seed & !0xF`. That changes output only for those rare seeds.

**Test.** Under the test profile: high seeds at `Style::prepare`, `Held::new` and `Water::ripple`, and release output equal for a normal seed.

## #36 P3: Zero softness makes shadow membership NaN — CONFIRMED, and painter-reachable (raise to P2)

**Code.** `form.rs:162`: `crate::smoothstep(-soft * 0.5, soft * 0.5, self.direct - soft * 0.5)`. With `soft = 0` and `direct = 0` (anywhere in shadow), `smoothstep` computes `0/0`.

**Reachability: painter-reachable, which the review missed.** The easel passes any softness through unvalidated:
- `easel/src/form.rs:253`: `lit_at` ... `lit(soft.unwrap_or(0.12))`
- `form.rs:287`: `f:lit{soft=}`
- `form.rs:295`: `f:shadow{soft=}`, whose mask is `1.0 - s.shade.lit(soft)`

The view's form is the same `FormU` (`world.rs:202`).

**Probe** (`p36.rs`, `p36b.rs`: a lit sphere, the mask `f:shadow{soft=0}` would build, then `work` over it):

```
Shade::default().lit(0) = NaN
shadow{soft=0} mask: 1994 NaN of 40000
non-finite pixels after work+dry: 0
center-shadow sample raw 1.380 one 0.133 zero 1.380
```

`work` treats NaN like 0. So `f:shadow{soft=0}`, which a painter would naturally use for a hard shadow, leaves the core shadow unpainted. That is exactly the region it should cover, and nothing reports an error. No repository program uses `soft=0` (a grep for `lit{...soft=0` / `shadow{...soft=0` / `lit_at(..., 0)` finds nothing).

**Severity.** P2. A natural painter request gives a silently wrong mask. The fix is trivial.

**Fix (~3 lines).** In `Shade::lit`: `if soft <= 0.0 { return (self.direct > 0.0) as u8 as f32 }`. Optionally reject negative `soft` in the easel.

**Test.** `lit(0)` is finite, and `shadow{soft=0}` equals 1 wherever `direct == 0`.

**Golden impact:** none.

## #37 P3: Singular shape paths silently omit filled geometry — CONFIRMED (engine-only)

**Code.** `shape.rs:156–158` `pub fn path(self) -> Option<Path> { self.pb.finish() }`. Meanwhile `ribbon` and `add` push only to `self.parts` (`shape.rs:127`, `:134`, `:143`).

**Probe** (`pmisc.txt`):

```
#37 ribbon.path() is_some = false
#37 ribbon.paths().len() = 3
#37 merged rect+rect: path() bounds Some(Rect { left: 0.0, top: 0.0, right: 10.0, bottom: 10.0 })
```

The added rectangle at (50, 50) is dropped.

**Reachability: engine-only.** A grep for `\.path()` in `crates/` finds no callers.

**Severity.** P3 is right.

**Fix.** Deprecate or remove `path()`, or document it as "the builder path only".

**Golden impact:** none.

## #38 P3: NaN and negative-infinity waits bypass validation — CONFIRMED (engine-only)

**Code.** `drying.rs:252–253`:

```rust
let dt = minutes.max(0.0);
assert!(dt.is_finite(), ...)
```

`f32::max` returns the non-NaN operand, so NaN becomes 0.

**Probe** (`pmisc.txt`):

```
#38 wait(NaN): accepted, clock 0
#38 wait(-inf): accepted, clock 0
#38 wait(inf): PANIC
```

**Reachability: engine-only.**
- Lua `wait` rejects these values first: `api.rs:1334` `if !(0.0..=MAX_WAIT_MIN).contains(&minutes)`, which is false for NaN and negatives.
- Hand time calls `wait((secs / 60.0) as f32)` with finite owed seconds (`tally.rs:347`).
- A zero wait is harmless given #10's fix. Without that fix, it is exactly the `absorb` that #10 shows changes later strokes.

**Severity.** P3 is right.

**Fix (2 lines).** Move the check before the clamp: `assert!(minutes.is_finite(), ...)`, then `let dt = minutes.max(0.0);`. Finite negatives still clamp to 0.

**Test.** Extend `an_infinite_wait_does_not_dry` to cover NaN and −inf.

**Golden impact:** none.

## #39 P3: Checkpoints accept invalid paint payloads — CONFIRMED (engine-only)

**Code.** `checkpoint.rs:240–251` loads `px`, `height`, `film`, `vol`, `lat`, `hide` and `cover` with `get_all` and no value checks. By contrast, geometry, scale, linen and clock are checked (`checkpoint.rs:209–229`, `:263`), and the pencil drawing is checked (`graphite.rs:443–446`, `v.is_finite() && (0.0..=1.0).contains(&v)`).

**Probe** (`p39.txt`):

```
NaN color accepted; pixel[0] = [NaN, 0.47932023, 0.32314324]
-inf wet volume accepted
```

**Reachability: engine-only.** `read_state`/`write_state` appear only in `checkpoint.rs`, `drying.rs:739–752` and `tally.rs:458–459` (tests). Nothing in `crates/easel`, `scripts`, `harness` or `notes/*/runner` uses them.

**Severity.** P3 is right.

**Fix (~20 lines).** Validate finiteness, and ranges where they are defined (`vol ≥ 0`, `cover ∈ [0,1]`, clock `Px` fields finite), before building the canvas. Keep `stroke` and `touched` as raw bits (`checkpoint.rs:250–251`, `f32::to_bits`).

**Test.** Corrupt one value in each field; each load must be rejected with `InvalidData`.

**Golden impact:** none.

## #40 P3: Tiny truncated checkpoints can request enormous allocations — CONFIRMED (impact narrower than stated)

**Code.** `checkpoint.rs:211` allows up to `1 << 30` pixels. `checkpoint.rs:72` `let mut bytes = vec![0u8; n * 4];` is allocated before `read_exact`. The first request (`checkpoint.rs:240`, `get_all(r, n * 3)`) is 12 GiB at the cap. If earlier reads succeed, later ones are larger: `lat`, at `n * LAT` with `LAT = mixbox::LATENT_SIZE` (`wet.rs:27`), and the drawing's `n * 5`.

**Probe** (`p39 trunc`: a 136-byte file declaring 16384×1024 pixels, a 192 MiB first request, which is safe):

```
file bytes: 136
rejected: failed to fill whole buffer
2064384  maximum resident set size
```

`vec![0u8; n]` uses a zeroed allocation (calloc) and was never touched, so RSS stayed near 2 MB. At the 12 GiB cap, the realistic outcome is:
- a lazy virtual reservation that fails fast with an `Err`; or
- on hosts that refuse the reservation (strict overcommit or an address-space limit), a process **abort** via `handle_alloc_error`, not an `Err`.

I did not attempt the 12 GiB case: macOS does not enforce `ulimit -v`.

**Reachability: engine-only** (no callers; see #39).

**Severity.** P3 is right.

**Fix (~5 lines).** Read with `r.take(n * 4).read_to_end(&mut bytes)` and compare lengths, so the buffer grows only as data arrives. Optionally add a total-size budget or a length preflight for `File` readers.

**Test.** A truncated file declaring the maximum geometry returns `Err` quickly.

**Golden impact:** none.

## #41 P2: Absolute projected depth erases thin scene geometry — CONFIRMED, and it affects the painter's view, not only reflections

**Code.**
- `scene.rs:458`: `Spot { x, y, s: self.scale_at(w[2]), z: -w[2] * ZK, at: w }`, with `ZK = 1000.0` (`scene.rs:73`).
- At 600 m the body's local z is about −6e5, where one f32 step is 0.0625 units. A 0.1 m body at `s ≈ 2.0` units/m is 0.2 units deep, about 3 f32 steps.

**Probes** (`pscene.txt`, `pscene3.txt`; "recenterd" is a typo in the probe label):

```
#41: Z=600 depth=0.1 recenter=false | ... dist(front)=0.0121 | trace hit z=None | conservative hit z=Some(599.9634) | view.at center: Ground
#41: Z=600 depth=0.1 recenter=true  | ... trace hit z=Some(599.95)
4x1x0.1 m block at 600 m, recenterd false: Ground dist 772.55
4x1x0.1 m block at 600 m, recenterd true: Body(0) dist 599.95
4x1x0.05 m block at 1000 m, recenterd false: Ground dist 1287.58
4x1x0.05 m block at 1000 m, recenterd true: Body(0) dist 999.97
4x1x0.3 m block at 600 m, recenterd false: Body(0) dist 599.84
```

A 4 m wide, 0.1 m deep block at 600 m, inside the default 600 m backdrop and far short of `far: 20000.0`, is **absent from the view**: `view.at` at its center returns `Ground`. Setting the spot's `z` to 0 restores it. Bodies 0.3 m deep survive at 600–1000 m.

**Reachability: painter-reachable.** `w:spot_at`/`w:spot` build the `Spot` (`world.rs:269–271`); `w:place` places it; `w:view()` (`world.rs:318`) builds `View::new`. That view feeds `v:at`, `v:what`, `v.form`, `v:bodies_mask`, shadows and contact. So a distant sign, sail, board fence or wall slab modeled as a thin block can vanish from every view query, not only from reflections.

**Severity.** P2 is right.

**Fix (medium, ~20–40 lines plus scene tests).** Give each spot a near-zero local depth origin (`z: 0.0`), since `View` already orders bodies by world depth through `add_nearest` (`scene.rs:834`). Also fix #31, the other consumer that relied on `ZK` ordering.

Caveat: `Spot.z` is exposed to Lua (`world.rs:119`, `f.add_field_method_get("z", ...)`) and flows into `s:p(...)`'s z. Programs that read `s.z` or hard-code z coordinates would change meaning. Scene unit tests in `scene.rs` may need tolerance updates.

**Test.** `pscene3.rs`'s view check: a 5–10 cm block at 600–1000 m must be `Body` at its center.

**Golden impact:** no goldens use a world. Replays of existing world paintings will differ slightly, since every body's local coordinates change.

## Frame-contract item A: mask arithmetic zips mismatched buffers — CONFIRMED (engine-only)

**Code.** `mask.rs:123–135`: `self.data.par_iter_mut().zip(&o.data)` in `mul`, `union` and `subtract`, with no frame check.

**Probe** (`pmask.txt`):

```
4x4 ones * 2x2 zeros -> [0.0, 0.0, 0.0, 0.0, 1.0, ... 1.0] (sum 12)
2x2 zeros ∪ 4x4 ones -> [1.0, 1.0, 1.0, 1.0]
```

This is silent truncation, and it also ignores differences in scale and origin.

**Reachability: engine-only.** Every easel mask is built on the canvas frame (`api.rs:450–451`, `frame(st)` = `canvas.frame()`; `world.rs:319`, `current_frame`). The canvas can be set up only once (`api.rs:1114`, `"the canvas is already set up"`), so all masks in a session share one frame.

**Severity.** Hardening, P3.

**Fix.** `assert_eq!(self.f, o.f)` or `debug_assert!` in the three ops. `Frame` derives `PartialEq` (`canvas.rs:38`). Alternatively, resample.

**Golden impact:** none.

## Frame-contract item B: depth layer same-dimension shortcut ignores scale and origin — CONFIRMED by reading (engine-only)

**Code.** `scene.rs:1232`: `let cov = if l.mask.f.w == f.w && l.mask.f.h == f.h { l.mask.data.clone() } else { ...sample... }`. A layer mask with the same pixel dimensions but a different `scale`, `x0`/`y0` or crop window is copied unresampled.

**Reachability: engine-only**, for the same reason as item A: easel layer masks come from `frame(st)` (`depth.rs:310`, `layer_args`).

**Severity.** Hardening, P3.

**Fix (1 line).** Compare whole frames: `l.mask.f == f`.

**Golden impact:** none.

---

## Summary

| # | Verdict | Reachable from easel Lua | Review severity → mine | Fix size | Changes rendering or goldens |
|---|---|---|---|---|---|
| 10 | Confirmed | Yes: strokes within a 1-min grain, and within a 15-min `work` slice, over setting paint | P2 → P2 | ~15 lines (effective cure at read sites) | Yes: hand-timed paintings; r19 easel golden possibly; paint golden no |
| 31 | Confirmed | No (`form_of` has no caller) | P2 → **P3** | ~3 lines | No |
| 32 | Partially confirmed (the review's center-ray case hits; oblique rays from ≥150 m miss) | Yes: `v:mirror`/`v:reflections` | P2 → P3 (P2 if thin bodies near distant water are common) | Small to medium | Reflections in world paintings; no goldens |
| 33 | Confirmed at ≥1–2 km | Only with raised `world{backdrop=}` | P3 → P3 | ~6 lines (f64) | No |
| 34 | Confirmed | No | P3 → P3 | ~20 lines (private `tubes`) | No |
| 35 | Confirmed (debug and test builds only) | `canvas{seed ≥ 5.95e17}`, ripple seed near `u32::MAX`; release wraps deterministically | P2 → **P3** | ~10 sites of `wrapping_*` | No (bit-identical in release) |
| 36 | Confirmed | **Yes**: `f:lit{soft=0}`, `f:shadow{soft=0}`, `f:lit_at(x, y, 0)`; the shadow mask drops the core shadow | P3 → **P2** | ~3 lines | No |
| 37 | Confirmed | No | P3 → P3 | Doc or deprecate | No |
| 38 | Confirmed | No (Lua `wait` range check) | P3 → P3 | 2 lines | No |
| 39 | Confirmed | No (checkpoint unused outside tests) | P3 → P3 | ~20 lines | No |
| 40 | Confirmed; the zeroed allocation is lazy, so the risk is an abort, not RSS | No | P3 → P3 | ~5 lines (`take` + `read_to_end`) | No |
| 41 | Confirmed; also removes thin bodies from `View` | **Yes**: `w:place` + `w:view()` and every view query | P2 → P2 | Medium (spot z origin; touches Lua-visible `s.z`) | World-painting replays shift; no goldens |
| Frame A (mask zip) | Confirmed | No (single canvas frame) | Hardening → P3 | 3 asserts | No |
| Frame B (depth shortcut) | Confirmed by reading | No | Hardening → P3 | 1 line | No |
