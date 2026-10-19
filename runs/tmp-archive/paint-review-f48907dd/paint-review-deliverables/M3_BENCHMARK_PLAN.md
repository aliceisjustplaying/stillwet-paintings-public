# M3 Pro performance and numerical-validation plan

This is an implementation specification, **not a report of M3 measurements**. The supplied project could not be compiled or run natively in this review environment. Backlog owners are P01–P13; correctness dependencies remain binding.

## 1. Define the metric before choosing the optimization

Optimize the painter’s critical path: time from submitting a material operation to obtaining its **committed, usable result**, and then the observation needed for the next decision. Also report total replay throughput and time-to-first-ready after reopening, but do not substitute either for interactive latency.

The current `Session::run` timer starts after snapshot creation and ends before global bookkeeping, collection and persistence (`session.rs:246–293`). The current replay path omits snapshots/deadlines. Therefore preserve four separate modes:

| Mode | Include | Do not hide |
|---|---|---|
| Live, already-open session | Queue, snapshot, execution, finalization, collection, commit, reply | Expensive “read-only” or failed chunks and persistence overhead |
| Reopen/cold process | Startup, full replay, pool/cache initialization and readiness | First-use memory allocations and compilation/build provenance |
| Warm replay | Actual replay of unchanged source with stated cache conditions | Different thread policy, missing transaction work or reduced fidelity |
| Painter loop | Tool response and latest image delivered through the pinned harness | Image transform/upload/context handling beyond native look time |

Each result records commit/input identity, engine/dialect/box/support, binary/compiler/flags, fixture seed, physical size, simulation resolution, thread budget, concurrent process roles and environment. Keep telemetry outside the painter-visible prompt and tools unless an explicit operational fact is necessary.

## 2. Preserve the actual pathological case

Source: `painting-sources/studios/paint-studio-c766c5/paintings/lua/painting.lua`.

Chunk 90 starts at line 1037. Its material operations include:

```lua
wfree = wallmask - objall
pwallF = pile{{"raw umber",3.2},{"smalt",1.2},{"red earth",0.4},{"lead white",1.0}}
work(wfree, {hand="scumble", pile=pwallF, clip=true, coverage=4.5, fill=true, seed=1161})
work(wfree, {hand="scumble", pile=pwallF, clip=true, coverage=3.0, fill=true, seed=1162})
blend(wfree, {seed=1163, coverage=3.0, pressure={0.34,0.34}})
blend(wfree, {seed=1164, coverage=1.6, pressure={0.30,0.30}})
```

The setup is 500 mm wide, aspect 1.25, hence 2400×1920 at the fixed live width. Do not benchmark the two `work()` calls over a newly blank wall and describe that as the original case. The prefix through chunk 89 defines masks, paint history, globals, brush/palette state, surface relief and clocks.

Create an immutable fixture with the full source digest and source/build/box provenance. Establish the prefix outside a microbenchmark’s timed interval, but include it in a separate reopen measurement. A reduced or serialized fixture is acceptable only after proving its continuation equals the full prefix. A native Canvas checkpoint alone does not preserve the Lua session. Do not fork a live multithreaded daemon as an unexamined shortcut.

The quoted 574-second result remains user-supplied. Because the matching source also includes blends, instrument each operation and the whole chunk. Record whether the original profiler’s “chunk” meant the entire logged chunk or a narrower unit before comparing aggregates.

## 3. Required spans and counters

Use stable operation/request IDs and nested spans with exclusive-time accounting. Counters must not consume the paint RNG, alter reduction order, allocate per pixel or impose a contended atomic increment in every bristle contact. Aggregate locally and sample where necessary.

| Owner | Phase spans | Useful counters |
|---|---|---|
| Client/server | Queue, auto-open, replay startup, request decode, reply | Bytes, request outcome, queue depth, active process roles |
| Transaction | Lua/native snapshot, rollback, finalization, GC | Cloned bytes, dirty tiles, heap/native retained bytes, rollback reason |
| Handling | Placement, mask rejection, plan construction, logical reload/tally | Candidate count, accepted count, mask area, path vertices, largest/median footprint |
| Scheduler | Broadphase, graph build, execution, joins | Candidate comparisons, edge count, ready width, critical path, per-job work skew |
| Bristles | Contact-cache build, path preparation, exchange/rasterization | Bristles, path steps, raster/contact visits, footprint area, scratch capacity/allocations |
| Fill | Pre-pass film capture, bare-pixel scan, cell accumulation, fill marks | Copied/scanned pixels, active cells, generated marks, map allocations |
| Material time | Absorption/leveling/gel/settlement/flow steps | Active pixels/tiles, events/substeps, largest radius, full-frame fallback count |
| Persistence | Serialize, validate, append, fsync, witness/receipt | History bytes read/rewritten, commit latency, durable sequence |
| Observation/media | Native look, encode, read/resize, context handling | Original/delivered dimensions and bytes, crop/mode, image hash, frames retained |

Measure process RSS/peak resident memory, allocation count/bytes where feasible, paging/compression pressure and CPU time. Use Instruments or another verified native profiler to determine whether hot loops are compute-, allocation-, cache- or bandwidth-bound. CPU utilization alone does not distinguish those cases.

## 4. Fixture matrix

The JSON fixture plan is a specification for an engine-side benchmark harness; it is not an already implemented runner.

| Fixture | Purpose | Essential variations |
|---|---|---|
| F01 — real chunk 90 | Preserve the tail case | Full chunk; each work/blend; live vs replay; original physical setup |
| F02 — sparse masks | Expose wasted full-frame planning | Empty, 1%, disconnected islands, soft edges, full mask; same variant compared old/new |
| F03 — fill | Attribute clone/scan/repair work | Fill on/off for diagnosis; within each variant keep exact inputs; hand-time drying during pass |
| F04 — contact surface | Expose median/filter and dirty-cache work | Local height changes, global settlement, small vs large physical support, flat vs rough ground |
| F05 — geometry/scheduling | Expose broadphase and critical path | Short strokes plus one long outlier, dense overlaps, nonoverlap, shared brush across distant marks |
| F06 — resolution | Separate physical and pixel scaling | 600/1200/2400 grids at fixed physical size; do not call lower resolution an equivalent speedup |
| F07 — supported limits | Validate resource rejection/cancellation | Long paths, high counts, native output, large aspect ratio, malformed finite/range inputs |
| F08 — history length | Expose repeated whole-log cost | 10/100/1000/10000 valid chunks; status, tiny commit, note, reopen |
| F09 — rollback | Expose memory and cleanup | Failure before/after native marks, finalization failure, commit failure and cancellation |
| F10 — concurrent roles | Tune the actual Mac | One painter; painter+check; painter+finish; two painters; media encoding contention |
| F11 — panel | Prevent physical-scale regression | Prepared panel and linen controls at fixed size; 60/440/500 mm diagnostic cases where supported |
| F12 — watercolor | Establish feasibility before launch | Local wash, whole wet support, rewetting islands, multiple components, very long dry wait |

For F07, begin with small bounded limits in a sandbox fixture. Do not discover the machine’s memory limit by crashing the active studio. For F08, construct valid histories through a controlled fixture/import path; do not manually edit a production log/witness or include repeated 2400px live snapshot creation in setup while claiming to measure only status.

Golden coverage includes all 38 extant logs and available earlier representative logs at release boundaries, but unsupported historical engines must be marked unavailable rather than executed through an unlabeled compatibility renderer. The compact archive lacks some necessary binaries/original outputs; the implementation machine’s original checkout/complete history supplies those or the gate remains explicitly pending.

## 5. M3 execution policy

Record machine model, installed RAM, macOS, native architecture, power connection, Low Power Mode state, thermal state and other sustained CPU/GPU jobs. Do not change power policy mid-comparison. Run native ARM binaries, not accidentally translated builds. Build provenance is part of numeric reproducibility.

Benchmark workers 1, 2, 4, 6, 8, 10 and 12 for representative and tail cases. Start with one daemon, then test concurrent roles. The current harness strips `RAYON_NUM_THREADS`; fix explicit configuration first so preopen and auto-reopen use the same policy. Preserve the minimal child environment—do not inherit every secret/config variable just to restore one tuning knob.

Rayon supports explicit pool size; its default consults the environment or logical CPU count, and the global pool is initialized only once [S2]. Configure before work begins, and verify the effective value in the daemon. A local pool can be useful when ownership demands it, but accidentally nesting independent pools can worsen contention.

Apple describes asymmetric performance/efficiency cores and QoS-informed scheduling [S1]. That supports measuring per-role QoS and task granularity; it does **not** justify claiming six workers are pinned to six P cores. Do not mark every background replay as user-interactive. Keep enough small independent jobs to balance mixed cores, without inventing dependencies or breaking brush/pixel order. Compare a native scheduling experiment only when profiling shows Rayon’s task distribution is actually limiting this workload.

Admit jobs through a machine budget that includes CPU and estimated peak memory. A background check/finish should not silently take another full pool and a second large canvas snapshot while a painter is waiting. Choose policy according to the intended objective: minimum interactive tail latency, total paintings/hour, or an explicit compromise. Record both metrics so a throughput improvement does not hide worse responsiveness.

## 6. Memory arithmetic before watercolor allocation

All figures below are **array-payload calculations in decimal MB**, not measured RSS. Vector headers, allocator overhead, alignment, Lua state, masks, brushes, geometry, images, caches, stacks and process runtime are additional. Lazy arrays may not exist yet. Confirm actual `size_of`/capacity in the compiled build.

For N pixels, one f32 channel costs `4N` bytes. At 2400², N=5,760,000 and one channel is 23.04 MB. At the actual 2400×1920 tail case, one channel is 18.432 MB.

The inspected oil state has 20 bytes/pixel in RGB/height/film and `(32 + 4L)` in wet arrays, where `L = mixbox::LATENT_SIZE`. Lazy drying state adds six f32 values/pixel; a populated contact cache adds another f32. Thus the selected payload is `(80 + 4L)N` with both lazy additions present, before drawing and other storage. For an illustrative L=7 build this is 108 bytes/pixel: 622.08 MB at 2400² or 497.664 MB at 2400×1920. Confirm L in the locked dependency rather than treating this illustration as a native RSS measurement.

| Watercolor component scenario | 2400×2400 payload | Actual 2400×1920 payload |
|---|---:|---:|
| One f32 field | 23.04 MB | 18.432 MB |
| Eight pigments × mobile/deposited pairs (16 fields) | 368.64 MB | 294.912 MB |
| Same pigment fields with a full rollback copy | 737.28 MB | 589.824 MB |
| One additional dense eight-pigment dry wash | 184.32 MB | 147.456 MB |

These pigment rows exclude surface/paper water, support, optics, velocity, scratch, Lua, brushes and masks. A dense full-frame mask itself can cost another channel. An unbounded sequence of component-resolved dry washes is therefore a representation problem, not something solved by simply adding threads.

Declare bounds for live pigments, active washes, historical liftable deposits, active tiles, path/plan buffers and concurrent processes. Include transient decode and transaction copies in admission. Copy-on-write helps sparse edits but cannot eliminate the need to preserve old state during a transaction that changes the whole support. Budget that worst case honestly.

A lower simulation grid may be an acceptable explicit capability tradeoff if recorded and calibrated. It must not be silently selected because the machine is busy, nor combined with an enlarged display image and represented as the same physical-resolution simulation.

## 7. Build and compiler experiments

The current Cargo release profile already uses optimization level 3, one codegen unit and no incremental compilation. Keep that exact profile as the reference. Add a separate profiling profile only in the implementation checkout, for example:

```toml
# Proposed addition, not present in the supplied tree.
[profile.profiling]
inherits = "release"
debug = 1
strip = "none"
```

Then, **on the M3**, a candidate symbolized build can be produced with:

```sh
# Preserve the project's fixed-Lua-hash C configuration and selected material-box features.
cargo build --locked --release -p easel
RUSTFLAGS="-C force-frame-pointers=yes -C target-cpu=native" \
  cargo build --locked --profile profiling -p easel
```

These are separate binaries, not an instruction to replace the released binary in a live studio. Benchmark native tuning, explicit ThinLTO and possibly fat LTO separately. Rust documents target-cpu and LTO options; Cargo documents inherited custom profiles [S4]. Check supported targets on the installed compiler instead of assuming a particular Apple CPU string exists.

Changes in compiler, libm, C Lua build, vectorization or reduction order can alter results. Keep binary hashes and independently expected goldens. Do not enable fast-math, unsafe target features or panic-abort as an unexplained performance tweak. SIMD or Metal candidates must either preserve the declared numeric behavior or become explicit versioned alternatives. A GPU rewrite is not the first bet for ordered, irregular bristle pickup; reconsider only after profiling and a standalone fidelity test justify it.

## 8. Repetition, statistics and acceptance

Use warm-up appropriate to each mode, then paired baseline/candidate runs with randomized/interleaved order to reduce thermal and temporal bias. Long tail cases may need fewer full repetitions than cheap kernels; report the actual sample count and all observed values. Never report a confident p99 from five samples. Use the complete corpus distribution or a sufficiently large repeated population for tail estimates, and distinguish per-fixture variability from cross-workload percentiles.

Report absolute times, ratios, medians, dispersion, maximum, sample count and environment. Keep failures/timeouts in the result set as outcomes; do not exclude the slowest failed runs to improve the average. Include peak RSS and bytes cloned/scanned/allocated alongside seconds. Quantify instrumentation overhead with the same build/input.

For exact optimizations, acceptance requires identical logical operations and complete state under the declared platform/build policy. For a versioned numerical change, publish the intended difference and independent physical/perceptual tests, not just a revised image golden. A performance “win” from fewer fills, a simpler brush or lower resolution is a quality/configuration change and needs a different label.

Adopt regression thresholds after the first baseline. A reasonable provisional review rule is to investigate any >5% typical-latency or >10% tail-latency regression in otherwise stable paired measurements; these are proposed guardrails, not measured noise bands. Seek a substantial tail/brush improvement, with 2× as a stretch hypothesis rather than a promised milestone. The Mac’s actual RAM and baseline pressure determine absolute memory budgets.

Use three test tiers: fast unit/property/adversarial fixtures per change; selected full-state and worst-case performance cases on the M3 for relevant merges; full historical/current corpus plus new-medium material cases at milestone/releases. Keep an independent serial/reference path and do not regenerate expected results automatically after a failure.

## 9. Primary technical references

These references support external API/model facts, not the local code findings or an asserted speedup. Retrieved during this review on September 30, 2026. The actual project’s locked dependency versions remain authoritative for implementation.

**[S1] Apple: asymmetric multiprocessing and QoS.** WWDC20, “Explore the new system architecture of Apple silicon Macs,” especially the transcript’s AMP/QoS discussion. Apple’s energy guide also describes QoS for work prioritization.  
`https://developer.apple.com/videos/play/wwdc2020/10686/`  
`https://developer.apple.[opaque token redacted].html`

**[S2] Rayon: ThreadPoolBuilder.** Explicit thread count, defaults, initialization and thread-start hooks.  
`https://docs.rs/rayon/latest/rayon/struct.ThreadPoolBuilder.html`

**[S3] Lua 5.5 reference manual.** `load` mode behavior and binary-code warning; `string.format` pointer conversion. This does not replace testing the custom embedded runtime.  
`https://www.lua.org/manual/5.5/manual.html`

**[S4] Rust compiler and Cargo profiles.** Target CPU, LTO, debug/frame-pointer/numeric-build considerations and custom profile inheritance.  
`https://doc.rust-lang.org/rustc/codegen-options/index.html`  
`https://doc.rust-lang.org/cargo/reference/profiles.html`

**[S5] Curtis et al., “Computer-Generated Watercolor,” SIGGRAPH 1997 project page.** An empirical graphics model and useful research starting point, not a source of universal calibrated material coefficients. The project page was consulted; the linked PDF was not newly analyzed in this review.  
`https://grail.cs.washington.edu/projects/watercolor/`

**[S6] Arches Aquarelle manufacturer description.** Specific product texture/sizing claims and qualitative behavior, not measured coefficients for this simulator.  
`https://arches-papers.com/arches-range-of-papers/watercolor-and-wet-techniques/arches-aquarelle/`

**[S7] Python fcntl documentation.** Unix file-lock API for a shared lock helper; do not assume a separate shell `flock` program exists on a stock Mac.  
`https://docs.python.org/3/library/fcntl.html`
