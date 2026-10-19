# Verification: easel findings #3–#9

Revision: `08f632434fd03bf7e85129539f7e184a91db9056` (checked with `git rev-parse HEAD`; working tree clean).
No repo files were edited. The `target/release/easel` build was current (`cargo build --release -p easel` reported `Finished ... 0.04s`). It was copied to `[local path redacted] and every probe ran against that copy with `EASEL_ROOT=[local path redacted] Every probe that could hang ran under `timeout`, and each stuck server was killed with `kill -9`.

Canvas used for probes that need one: the `CANVAS` constant from `crates/easel/src/session.rs:584`. It is saved as `easel/canvas.lua`, and computing it takes about 34 s.

---

## #3 Tiny grid spacing stalls the easel: CONFIRMED (P2 is right)

**Code**
- `look.rs:74-77`: grid spacing is only checked for `> 0`:
  `if s.is_nan() || s <= 0.0 { return Err("--grid step: want > 0 units".into()); }`
- `look.rs:257-266`: an `f32` counter drives the loop:
  `let mut k = (ua / st).ceil(); while k * st <= ub { ... k += 1.0; }`. Lines 269/276 (rows) and the label loops at 290/311 have the same shape.
- The painter can reach it. The `look` tool accepts `grid: Type.Union([Type.Boolean(), Type.Number()])` (`harness/painter/easel-tools.ts`), and `lookArgs` forwards it as `--grid <n>` (`harness/painter/easel-client.ts:91`).

**Arithmetic.** The canvas is always 1000 units wide (`notes/easel_guide.md`: "The canvas is always 1000 units wide"). With `st = 1e-6`, the loop needs `k` to reach 1e9. But an `f32` stops changing under `k += 1.0` at 2^24 ≈ 1.68e7, where `k*st ≈ 16.8 < 1000`, so the loop never ends.

**Probe** (session `p3`, after the canvas):
```
look --grid 5          -> look-0001.png (1000x667, 0.02s)   rc 0
look --grid 0.000001   -> rc=124 (timeout 15)
status                 -> rc=124, and again rc=124 after 10 s more
```
The server stayed wedged until `kill -9`. It runs outside any chunk, so the Lua instruction hook (`session.rs:205`) never applies.

**Severity.** P2 is right. The painter can trigger it with one ordinary tool argument, and the studio is dead until the process is killed. The harness doesn't bound its opening `status` probe (review #11), so the painter's tool call hangs too. There's no data corruption, so not P1.

**Fix** (about 10 lines, 1 file). In `draw_grid`, compute the line count from the output resolution and skip or raise lines closer than about 2 output px: `if st * ppu < 2.0 { st = nice_step(2.0 / ppu) }`. Or reject `--grid` below that in `View::parse` with a clear message. Then loop over an integer range, `for i in i0..=i1` with `i0 = (ua/st).ceil() as i64`, and apply the same bound to the label loops.

**Test.** A `look.rs` unit test calling `look()` with `grid = Some(1e-6)` on a small canvas, asserting it returns (either an error or a sane PNG) within the test.

---

## #4 Tiny outline features allocate without bound: CONFIRMED, worse than stated (P1 is defensible)

**Code**
- `crates/paint/src/outline.rs:433-445` (`knots_ln`):
  `loop { x += mean * (sigma * rng.normal()).exp().clamp(0.3, 3.0); if x >= total - mean * 0.4 { break; } s.push(x); }`. It has no iteration or size cap.
- Callers: `outline.rs:1061` (facets, `ch.facet * scale`) and `outline.rs:1081` (lobes, `ch.lobe * scale * size`, where `size` is 1.0 or 0.32).
- The Lua binding accepts any positive lobe: `draw_outline.rs:53-55`, `if l <= 0.0 { ch.lobe = 0.0; } else { ch.lobe = l / scale; ...`. It accepts any positive `size`: `draw_outline.rs:42`, `Some(s) if s > 0.0 => s`.

**Arithmetic.** For lobes, `mean ≈ 0.32 * lobe` in canvas units, and the smallest step is `0.3 * mean`. The review describes astronomical knot counts, but the bigger problem is `f32` stagnation. Once `ulp(x)/2` exceeds the step, `x` stops advancing while `s.push(x)` keeps appending, so the loop runs forever and memory grows without limit. With `lobe=1e-4`, the steps are 1e-5 to 1e-4, and `x` stalls around `x ≈ 1000`. The probe outline is 3191 units long, so it never reaches the exit. The zero-mean case is reachable too, without underflow tricks: `size=1e-45` with `char="broken"` (facet 0.045) gives `0.045 * 1e-45 = 0`. I derived that case from the arithmetic and did not run it.

**Probe.** I ran `easel serve p5` in the foreground under `/usr/bin/time -l` so I could get its memory use. The sandbox blocks `top` and `ps rss` for other processes.
```
do 'o = outline{{100,100},{900,100},{900,600}, char="soft"}; print(o)'
   -> outline(1 line(s), closed, length 3191, 64 strokes, 3 corners, scale 481)   ok
do 'o2 = outline{{100,100},{900,100},{900,600}, char="soft", lobe=1e-4}'  -> rc=124 (timeout 6)
status -> rc=124
after kill -9 at ~10 s:   10.14 real   9088352256 maximum resident set size
```
That's about 9 GB in about 10 s, from a lobe of 1e-4 units, not only extreme values. (An earlier run printed "the easel closed without answering"; that came from my own `kill -9` landing before the client printed, not from a crash. `server.log` shows no panic.)

**Severity.** P1 is defensible. The painter can reach it through `paint` with a plausible-looking small `lobe=`. The Lua deadline can't stop it, and it eats the shared machine's memory at roughly 1 GB/s, which puts other studios and runs at risk, not just this painting. If the lanes use "P1 = painting integrity" strictly, it's a high P2. Either way it outranks #3.

**Fix** (about 15 lines in `crates/paint/src/outline.rs`, optionally 3 in `draw_outline.rs`). In `knots_ln`, clamp `mean` to at least `total / MAX_KNOTS` (for example `MAX_KNOTS = 100_000`), and break if `x` stops increasing (`let nx = x + d; if nx <= x { break }`). In the binding, reject `lobe`/`edge` below about a tenth of a pixel, and `size` below about 1 unit, with a message.

**Test.** A `paint` unit test: `Outline` with `ch.lobe = 1e-9` and with `scale = 1e-45` plus `broken`, asserting it returns and every knot vector has at most `MAX_KNOTS + 2` entries.

---

## #5 Failed chunks change table traversal order: CONFIRMED, including canvas divergence (P1 is right)

**Code**
- `heap.lua:77-85`: a changed table is cleared and refilled in place:
  `for i = 1, m do rawset(t, keys[i], nil) end` / `for k, x in next, copy do rawset(t, k, x) end`.
  Setting a key to nil never shrinks the hash part, so a table the failed chunk grew keeps its larger node array. The keys come back at different positions.
- `prelude.lua:39-46`: tables whose keys are all booleans, numbers or strings return `nil` from `ordered()`, which means "walked by Lua's own `next`", so traversal follows the internal layout.
- Native order is deliberate: the test `plain_tables_keep_lua_order` (`session.rs:730`) pins it. So forcing sorted order would change the replay of existing logs.
- The existing rollback test only checks that values come back, not order: `session.rs:653-660`, `assert(things[1] == 1 and things[3].x == 3 ...)`.

**Probe 1** (order only; sessions `p5a` with a failed chunk and `p5b` without):
```
C1: t = {}; for i = 1, 30 do t["k"..i] = i end
C2 (p5a only): for i = 1, 200 do t["x"..i] = i end; for i = 1, 200 do t["x"..i] = nil end; error("stop")
    -> "(the chunk failed and changed nothing)"
C3: print keys in pairs order
p5a: k15 k16 k5 k25 k26 k19 k2 k27 k10 k1 ...
p5b: k24 k9 k14 k6 k5 k8 k7 k11 k30 k21 ...
easel run p5a.lua (replay of p5a's own log): k24 k9 k14 k6 k5 ...   (= p5b, ≠ live p5a)
```

**Probe 2** (painted result; session `p5c`): canvas, then C1, then the failing C2, then
`local y, i = {}, 0; for k in pairs(t) do i = i + 1; y[k] = 20 * i end; pencil("2B"):rule({100, y.k1}, {900, y.k1}, {pressure=0.8})`
```
live: k1 row 200 ... ok · chunk 3
easel check -> "replay DIFFERS from the live canvas: a chunk depended on state from a failed chunk (e.g. a table it changed); ..."  rc=1
```
So a live painting diverges from its saved program after a valid failed chunk, and the easel told the painter "changed nothing". Live `easel check` would catch it, but the runner doesn't use it: `scripts/check_painting` only compares two replays (lines 3-14: "runs `easel check`: a second replay in a fresh session"). See review #20.

**Severity.** P1 agreed. It silently breaks the core invariant (the log is the painting), it's triggered by ordinary code (`pairs` over a string-keyed table after a chunk that errored), and production can't detect it.

**Fix.** Restoring the exact layout from Lua isn't possible: the node-array size and the `lastfree` pointer aren't observable or settable through the public API. Even matching iteration order afterward wouldn't guarantee that later insertions behave the same. Realistic options:
1. **Rebuild from the log after any restore that changed a table.** `restore` already returns `changed` (`heap.lua:95`). If it's above 0, build a fresh `Session` and replay `self.log` (the existing reopen path). Exact, and about 20-30 lines in `session.rs`/`main.rs`, but it costs one replay per such failure (minutes for long paintings). A cheaper variant marks the session "tainted" and forces a reopen before the next chunk.
2. **A small C helper in the vendored Lua** that reallocates a table's parts to the snapshot's recorded sizes and reinserts in the recorded order. It needs the sizes captured at snapshot time. Riskier; it relies on Lua internals.
3. Sorted order for all tables would work for new paintings but breaks `plain_tables_keep_lua_order` and existing replays, so it needs a log-format version flag.

Option 1 is the minimal safe fix.

**Test.** Extend `rollback_restores_tables_and_upvalues_exactly` with C1/C2/C3 above. Assert that the live session's `pairs` order after the failed chunk equals a `Session::replay` of `s.log`, and add a canvas variant compared with the `check` input.

---

## #6 Failed chunks can permanently damage pencil methods: CONFIRMED (P2 is right)

**Code**
- `draw_pencil.rs:87` (`let methods = lua.create_table()?`) and `:204-205` (`let meta = lua.create_table()?; meta.set("__index", methods)?`). These are captured by the Rust closures `pencil` (`:218`, `let m1 = meta.clone();`) and `chalk`, and are not reachable from globals.
- `heap.lua:44-45`: `if info.what ~= "C" and info.nups > 0 then`. The snapshot doesn't walk C-function upvalues or Rust captures, so until some pencil sits in a global these tables aren't snapshotted. There's no `__metatable` protection: `print(getmetatable(pencil()).__metatable)` prints `nil`.

**Probe**
```
p6:  do 'local p = pencil(); getmetatable(p).__index.line = nil; error("stop")'  -> "changed nothing"
     do 'local p = pencil(); print("line method:", p.line, "rule:", p.rule)'
       -> line method: nil   rule: function: 0x...
p6b (control, `keep = pencil()` committed first): the same mutation is rolled back -> line method: function
p6e: failing chunk adds getmetatable(pencil()).__index.twice = ...; next chunk print(pencil():twice())
       live: "live: 2" ok · chunk 1
       easel run p6e.lua -> "chunk 1 failed: ... attempt to call a nil value (method 'twice')"
```
So besides losing methods, the painting can become impossible to replay or reopen.

**Scope check.** Userdata metatables are protected: `getmetatable(outline{...})` returns `false`, and a failed attempt to override `__tostring` had no effect. The other Rust-created tables (`form.rs:384` `body`, `world.rs:178`, `api.rs:472`, `depth.rs:189`) are either set as globals or returned fresh, so they're reachable roots. `grep create_table` turned up no other captured-but-unreachable Lua table.

**Severity.** P2 agreed. It needs unusual code (editing a shared metatable), but the outcome is an unreplayable log or silently missing methods.

**Fix** (about 3-8 lines). Set `meta.set("__metatable", false)` in `draw_pencil.rs`, which matches the userdata behavior. That alone blocks `getmetatable(p).__index` access. Alternatively, pass `meta`/`methods` to `snap` as extra roots (`session.rs:198-199` already passes `strings`).

**Test.** A session test: failing chunk mutates `getmetatable(pencil()).__index`, then the next chunk asserts `pencil().line` is a function. Or, with the `__metatable` fix, assert that `getmetatable(pencil()) == false`.

---

## #7 Finalizers break replay and bypass the deadline: CONFIRMED, and weak tables are affected too (P2 is right)

**Code**
- `session.rs:199`: `let snap = if !self.replay { Some(self.snap()...) } else { None };`. In live mode the snapshot's copies keep references to every value that was reachable before the chunk, and `snap` stays alive through
- `session.rs:220`: `let _ = self.lua.gc_collect();` (collection runs while the snapshot is still held). Replay has no snapshot, so garbage is collected one chunk earlier.
- `session.rs:207`: `self.deadline.set(None);` runs before the `gc_collect` at `:220`, so finalizers that run there have no time limit. `collectgarbage` is removed (`session.rs:99`), but `setmetatable` with `__gc`/`__mode` is still allowed.

**Probe: finalizer timing** (`p7`)
```
1 x = setmetatable({}, {__gc = function() fin = true end})   ok
2 x = nil                                                    ok
3 assert(not fin, "finalizer already ran")                   ok (live: fin = nil)
4 print(fin)                                                 live: fin = true
easel run p7.lua -> "chunk 3 failed: ... finalizer already ran"   rc=1
```
**Probe: weak table, not in the review** (`p7c`)
```
1 w = setmetatable({}, {__mode = "v"}); x = {}; w[1] = x   2 x = nil   3 assert(w[1] ~= nil)
live: chunk 3 ok;   easel run p7c.lua -> "chunk 3 failed: ... weak entry gone"
```
**Probe: deadline** (`p7b`): `do 'setmetatable({}, {__gc = function() while true do end end})'` returned rc=124 (timeout 15), and `status` then returned rc=124. The chunk itself finished; the hang is in the post-chunk collection, where `deadline` is `None`, so the hook at `session.rs:~116-122` always returns `Continue`. I didn't wait out the 600 s `CHUNK_LIMIT` (`session.rs:29`); by the code, collection is never bounded.

**Live vs replay.** Yes: shown above, a committed live program then fails on replay or reopen. Every reopen replays, so the painting can't be reopened.

**Real-world reach.** `rg '__gc|__mode'` over `paintings/` and the `paint-studio-*` studios found only copies of `prelude.lua` (its private weak cache). No painting log uses them.

**Severity.** P2 agreed. The effect is severe (an unreplayable painting, or a wedged server), but it needs features no painter has used so far.

**Fix.** Two parts, about 15-25 lines.
1. Bounded collection: move `self.deadline.set(None)` (`:207`) to after the `gc_collect` at `:220`, and set a short deadline around `restore` and `Drop`'s collect. In Lua 5.4+, a hook error inside `__gc` becomes a warning, so a looping finalizer gets interrupted.
2. Determinism: reject `__gc` and `__mode` for painters. In `prelude.lua`, wrap `setmetatable` to error when `rawget(mt, "__gc")` or `rawget(mt, "__mode")` is present. Because `__mode` is read on every GC cycle, also have `heap.lua`'s `snap` walk (which already visits every reachable metatable, `heap.lua:39-40`) fail the next chunk if a reachable metatable has gained `__gc`/`__mode`. A weak table that lives and dies inside one chunk remains a theoretical gap, because GC timing differs with snapshot allocations. Also drop `snap` before `gc_collect` on success, so successful chunks collect the same way replay does (a smaller fix, but not enough alone).

**Test.** The `p7` and `p7c` programs as session tests: a live `Session` then `Session::replay` of its log must both succeed, or `setmetatable(..., {__gc=...})` must error. Add a looping-`__gc` test with `chunk_limit` set to 1 s, asserting `run` returns.

---

## #8 Replacement `math.random` mishandles integer bounds: CONFIRMED (downgrade to P3)

**Code** (`api.rs:1076-1081`)
```rust
lua.create_function(move |_, (a, b): (Option<i64>, Option<i64>)| {
    let r = s1.borrow_mut().rng.f() as f64;
    (Some(m), None) => Value::Integer(1 + ((r * m as f64).floor() as i64).min(m - 1)),
    (Some(m), Some(n)) => Value::Integer(m + ((r * (n - m + 1) as f64).floor() as i64).min(n - m)),
```
`rng.f()` has 24 bits of resolution: `crates/paint/src/rng.rs:29`, `(self.next_u64() >> 40) as f32 / (1u64 << 24) as f32`.

**Probe** (release build, `p8`)
```
random(0)          0 0 0 0 0 0          (stock Lua 5.4+: a random integer)
random(-5)         -5 -5 ...            (stock: "interval is empty" error)
random(5,1)        1 1 ...              (stock: error)
random(min,max)    9223372036854775807 × 6   (n - m + 1 wraps to 0 in release; panics under overflow checks)
random(0,2^40)     892882583552 ...; odd draws in 2000: 0   (only multiples of 2^16 are reachable)
random(1.5)        1 ...                (stock: "number has no integer representation")
```
The last two go beyond the review. Every case is deterministic, so live and replay agree; this can't cause divergence.

**Severity.** P3, not P2. Real logs only use small, ordered bounds: `rg -o 'math\.random\([^)]*\)'` over the paintings gives `math.random()` ×272, `math.random(2, 4)` ×12, `(3, 5)` ×10 and so on. None use zero, negative, reversed or wide bounds. The debug-build panic sits under `catch_unwind` (`session.rs:206`) and becomes a failed chunk.

**Fix** (about 15 lines, `api.rs`). Error when `m < 1` in the one-argument form (or treat 0 as a full-range integer, like stock Lua), and when `n < m`. Compute the width as `(n as i128 - m as i128 + 1) as u128`, and draw with `rng.next_u64()` plus rejection sampling (or `u128` multiply-shift) instead of the `f32`. Reject non-integral floats. Caution: changing the generator for *valid* ranges changes existing replays. Keep today's `f32` formula for `1 ≤ n - m + 1 ≤ 2^24` and use the new path only for wider or invalid ranges.

**Test.** `api` unit tests: `random(-5)`, `random(5,1)` and `random(1.5)` error; `random(min,max)` doesn't panic under test overflow checks; a golden sequence for `random(2,4)` under a fixed seed stays unchanged.

---

## #9 A failed optional look can hide a committed chunk: CONFIRMED (downgrade to P3)

**Code** (`main.rs:676-690`)
```rust
"do" => match self.s.run(payload) {
    Ok(ran) => {
        let note = self.save_log()?;                 // :678 committed and saved
        ...
        if self.frames { ... self.look(&[], Some(p))?; }        // :685
        if args.iter().any(|a| a == "--look") {
            out.push_str(&self.look(&[], None)?);               // :688
```
**Probe** (`p9`)
```
do 'x = 1' --look   -> "no canvas yet: the first chunk is canvas{...}"   rc=1
status              -> "1 chunks · 2400px · no canvas yet"
log                 -> --@ chunk 1 / x = 1
```
**Reach.** The painter harness never passes `--look` and never turns frames on. It calls `atEasel(studio, ["do", "-"], p.lua, signal)` (`harness/painter/easel-tools.ts:28`), and `grep -- '--look\|frames on'` over the harness and runner found nothing. Only a direct CLI user with `--look` or `frames on` is affected. With a canvas present, look errors are limited to things like PNG write failures.

**Severity.** P3 rather than P2: correct in substance, but off the production path.

**Fix** (about 6 lines, `main.rs`). After the commit, catch look/frame errors and append them to `out` (for example `"look failed: {e}\n"`), still returning `Ok(out)` with the `ok · chunk n` receipt.

**Test.** A `main.rs` server-handler test: `do "x = 1"` with `--look` and no canvas returns `Ok`, the output contains `ok · chunk 1` and a look-failure line, and the log has 1 chunk.

---

## Summary

| # | Verdict | Review severity | My severity | Live ≠ replay? | Minimal fix (size) |
|---|---|---|---|---|---|
| 3 | CONFIRMED (reproduced: `look --grid 0.000001` and every later `status` time out) | P2 | P2 | No (server wedge) | Bound line count by output px and use an integer loop (~10 lines, `look.rs`) |
| 4 | CONFIRMED, worse than stated (`lobe=1e-4` → ~9 GB RSS in 10 s; `f32` stall, not just huge counts) | P1 | P1 (host-level OOM; at least a high P2) | No | Cap knots and add a progress check in `knots_ln`, plus minimum `lobe`/`edge`/`size` in the binding (~15-18 lines) |
| 5 | CONFIRMED (pairs order differs from the log's replay; `easel check`: "replay DIFFERS from the live canvas") | P1 | P1 | **Yes**, and silent in production | Replay the log (or force a reopen) when `restore` changed >0 tables (~20-30 lines); exact layout restore isn't possible from Lua |
| 6 | CONFIRMED (method removed through failed chunk persists; added method makes replay fail) | P2 | P2 | **Yes** (replay error) | `__metatable=false` on the pencil meta, or snapshot it as a root (~3-8 lines) |
| 7 | CONFIRMED, plus weak tables (`__mode`) diverge too | P2 | P2 | **Yes** (replay or reopen fails) | Keep the deadline through collection, reject `__gc`/`__mode`, drop the snapshot before collecting (~15-25 lines) |
| 8 | CONFIRMED, plus 24-bit resolution and float truncation | P2 | **P3** | No (deterministic) | Validate bounds, overflow-safe wide path, keep the old formula for small ranges (~15 lines) |
| 9 | CONFIRMED (`do 'x=1' --look` rc=1 but status shows 1 chunk) | P2 | **P3** (the harness never uses `--look` or frames) | No | Report post-commit look errors inside the `Ok` reply (~6 lines) |

Scratch: probes and session logs are in `[local path redacted] (`root/paintings/lua/p*.lua`, `serve5.time`).
