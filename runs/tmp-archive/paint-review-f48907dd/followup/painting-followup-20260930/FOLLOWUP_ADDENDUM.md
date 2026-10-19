# Follow-up review: M3 profiling synthesis and proposed implementation plan

Date: 2026-09-30. This supplements, rather than replaces, the earlier issue ledger.

## Recommendation

Approve a versioned engine 3 for **new paintings**, preserve engines 1/2 for historical execution, and reprioritize performance around the measured exchange kernel. Do not require the earlier broad optimization/refactoring list to precede the kernel work or prepared-panel support.

The other reviewer's supplied profile is better evidence of the target-machine bottleneck than my earlier static prioritization. Snapshots, persistence and full-frame preparation should not remain the lead strategy for the profiled replay workloads. Retain a small live end-to-end measurement because replay deliberately omits snapshots and live deadlines.

Accept approximately 1.4x exact and 2–3x versioned improvement as **planning estimates to validate**, not proven implementation-independent ceilings or guaranteed release gains. A dependency DAG bounds scheduling of its particular operations and dependencies; it does not bound every possible exact kernel optimization. Time-box further exact investigations rather than postponing engine 3 to chase an unproven large exact gain.

## Evidence boundary

The pasted synthesis reports native reproduction of ten prior witnesses and N1/N2 on embedded Lua 5.5. I did not receive the profiler XML, experimental patch, DAG implementation or clean benchmark receipts. I have not independently rerun those native results.

For this follow-up I reread the archived target source, inspected the previous deliverables, and ran two isolated float32 arithmetic controls in Python. They illustrate source-level pitfalls in proposed optimizations. They are **not native easel reproductions and do not establish that the unseen experimental patch contains either mistake**.

The source excerpts and their SHA-256 identities are in `SOURCE_EXCERPTS.md`; executable controls are in `arithmetic_controls.py`, with output in `arithmetic-controls.json`. No production source was modified.

## Two checks before calling Phase 2 exact

### A. Plough-source cure is not generally loop-invariant

In `crates/paint/src/bristle.rs:1399–1408`, each accepted bilinear transfer reads the source latent mixture, hiding properties and cure, then calls `Surf::take(i, m)` and `Surf::add(j, ...)`.

However, `Surf::take` at lines 615–620 sets source cure to zero when the remaining source volume is below `1e-5`, provided current-engine cure updates and drying state are enabled. Consequently, a previous transfer can change the cure observed by the next transfer.

If the reported three hoisted loads are latent mixture, hiding properties and cure, an unconditional cure hoist needs correction or a proof excluding this case. The experiment may already account for it; its patch was not supplied.

The control uses source volume `1.03e-5`, source cure `0.1`, and four equal transfers totaling `1.44e-6`. The first transfer crosses the bare-film threshold. Subsequent baseline transfers carry cure zero; a naive hoist carries 0.1. Into already-wet targets, the latter produces target cure about `3.5987e-5` instead of zero. Current RGB need not expose this difference.

Acceptance: a native engine-2 test covering the threshold, nonzero source cure, allocated drying state and multiple accepted destinations. Preserve transfer order and the exact threshold behavior for legacy engines. Do not silently “repair” its physics in the exact branch.

### B. A geometrically local contact filter is not automatically bit-local

`contact_level` in `bristle.rs:38–49` composes horizontal/vertical medians and a box blur. A dirty rectangle needs the composed filter support, proper global edge conditions and complete height invalidation.

Additionally, `surface.rs:157–190` computes the blur with floating-point rolling sums initialized at the starts of rows/columns. Reinitializing those sums at a cropped halo changes their rounding history, even when the mathematical stencil is identical.

The isolated control compared 40 interior pixels, all with full radius-three halos. The full-row and locally restarted computations differed at all 40, with maximum absolute difference `3.0517578125e-5`. This is a numerical illustration, not a native contact-cache benchmark.

Acceptance: compare cache output against the legacy full-frame implementation, including cached/uncached paths and subsequent strokes. Either preserve the legacy arithmetic recurrence, retain the necessary full scans, or put changed arithmetic in engine 3. A fixed-capacity median also needs a justified maximum radius or a dynamic fallback: radius depends on physical size and resolution. Keeping a sorted fixed array does not itself eliminate element shifting.

## Exactness receipts: amend Phase 0, not only Phase 2

Capture baseline continuation-state digests **before** the full overnight golden run, using a separately identified instrumentation-only build. A final PNG plus a height dump is not a complete state oracle. Baseline and candidate both need the same digest scope.

At minimum distinguish canvas-state digests from full session continuation. Include future-affecting wet composition, film, cure, stroke IDs, clocks, hand-time debt, brush loads/bend state, RNG/identity state and supported Lua continuation. Canonicalize ordering and float bit patterns; do not hash pointer values or uninitialized struct padding. Exclude purely derived cache bytes from the canonical session identity only after verifying that rebuilding the caches preserves the promised continuation.

Add short continuations after replay, live execution, reopen/checkpoint restore and failed chunks. These are not interchangeable test modes: live snapshot retention is precisely part of R2's failure mechanism.

Keep the baseline binary, source/dependency/build identity, inputs, dimensions and engine metadata. Repeated fresh-process baselines should expose known nondeterministic cases rather than canonizing one realization. HEAD goldens establish regression against HEAD; they do not prove reproduction of an older historical original.

Resolve the reported 38-versus-59-log scope explicitly. Use the 38 current studio logs as the first gate, and include every remaining **supported** historical log before claiming all-log compatibility. Unsupported historical versions need an explicit status, not a silently substituted compatibility render.

Run clean A/B measurements without concurrent experiments, reporting aggregate elapsed time, CPU time, representative/tail chunk latency and maximum latency. Do not average per-chunk speedup ratios unweighted. Keep profiling and final acceptance binaries identifiable. Live request timing includes snapshot through acknowledgement, separately from the replay body's timings.

## Engine 3: define behavior before parallel execution

Implement a deterministic single-thread engine-3 reference first. Give its logical operations stable IDs, brush ownership, reload decisions, RNG inputs and simulated timestamps. These can intentionally differ from engine 2, but they must not depend on execution tile size, worker count, machine load or completion order.

Partition-independent idle drying is necessary but insufficient. Writing `D(a+b,S) = D(b,D(a,S))` for pure drying does not imply `D(t,Paint(S)) = Paint(D(t,S))`. Painting at the start and at the end of a fifteen-minute interval generally produces different states. Therefore “put several tiles in every fifteen-minute batch” is a chosen approximation until operation timestamps and intervening material evolution have been defined.

Fix R4/D5 under versioning. Decide whether to use chronological events, supported lazy local aging, or an explicitly specified fixed integration scheme. Do not derive physical time from CPU elapsed time. Local lazy aging must also account for any spatial coupling; it is not automatically valid for settling or watercolor transport.

The new scheduler must preserve both surface read/write dependencies and mutable brush/reservoir dependencies. Tighter direction-aware footprints must conservatively cover actual contact, pickup, displaced/bilinear plough targets, and any relevant neighboring reads. `Surf` has unsafe Send/Sync implementations whose safety currently relies on disjoint pixel sets. Missing footprint coverage could therefore cause a data race, not just a changed aesthetic result.

Gate the parallel implementation against the engine-3 serial reference across worker counts and execution partitions. Compare physical state and continuations, not only PNGs. Retain a serial fallback for dependency-dense cases.

The existing engine marker is a useful dispatch mechanism, not automatic version isolation. Route changed drying, planning, batching, support behavior and Lua dialect deliberately. A global prelude fix can affect old logs even while the canvas remains engine 1/2. Full D1/D2/D3 refactors can be deferred; a minimal immutable engine/dialect/medium/support identity cannot be omitted.

If measured 2–3x remains inadequate, open a separate cost–fidelity investigation for a versioned brush-exchange representation. Compare pickup, load depletion, wet mixing, ploughing and stroke relief explicitly. Do not lower coverage/resolution/bristle counts or change the painter's guidance invisibly to achieve the performance target.

## Deferrals to change

### Bring N4 and an operational N5 mitigation forward

N4's finalization guard is relevant independently of filesystem failure. Include `time::flush`, global bookkeeping and subsequent fallible state changes in the documented transaction outcome. A rollback failure must not leave a silently usable session.

The source has a 600-second Lua-hook deadline and a 720-second harness `do` budget; replay disables the live deadline. The reported 712-second replay therefore is **not proof** that a live call timed out. It does show that the workload operates near these limits, especially with contention. Native work does not continuously return to Lua hooks.

At minimum, distinguish an unknown outcome, block blind re-execution or further mutation until reconciliation, and surface in-flight/committed status keyed to the request. Cooperative cancellation needs polling inside substantial native work. A longer timeout is only an operational mitigation.

A full R3 journal protocol can be staged, but acknowledge its current behavior honestly: witness failure after primary-log sync can leave advanced state and refuse subsequent service. Failing closed detects the inconsistency; it does not provide rollback, a receipt or recovery.

### Keep prompt isolation in the release scope

N11 (reader capability scoping) should not disappear while N12 is deferred. A semantic review system may take time; meanwhile, disable/quarantine automatic free-text inheritance for neutral launches or mark it explicitly as an intentional conditioning channel. A schema alone does not prove semantic neutrality.

Tag material observations by engine, medium, support/paper and material-box revision. Oil-engine-2 experience should not silently become engine-3 or watercolor advice. Keep intended technical teaching separate from unintended composition prescriptions.

N13 remains relevant to performance work: activity counts, coverage, speed and look frequency should not become hidden completion/reward targets. Define finished/continue/budget-paused/infrastructure-failed states separately.

### R1/R2 may be staged, but not described as solved by tostring

These are separate iterator-key and transient weak-metatable issues. They can be lower priority than the measured hotspot, but known nondeterminism limits replay claims. A narrower, enforced new Lua dialect can be a practical intermediate fix. Preserve explicit historical compatibility and record exceptions instead of claiming universal exactness.

### Kernel locks and the idle daemon

Acquire the lifetime daemon lock before replay or socket replacement; all cooperating processes must use the same stable lock-file inode. Do not unlink/recreate an actively used lock file and assume ownership remains unified. Different output resources require appropriately keyed locks rather than one accidental system-wide bottleneck.

An old daemon at zero CPU is not by itself stale or harmful. Verify session ownership, health and resident memory before stopping it; do not use age or command-line substring matching as the ownership test.

## Prepared panel and watercolor

Prepared panel is plausibly a small vertical slice: use the existing absence of linen, real setup/ground metadata, medium-aware finishing, and the full replay/rollback/view/export path. It need not wait for every scheduler refactor. The `stiff≈0.2` source comment is an existing model parameter, not a calibrated general law for chalk-glue. Defaulting off the linen-specific crack effect is not a claim that real panel paintings never crack.

The 36-GiB machine makes a **bounded** eight-pigment prototype straightforward from a capacity-planning perspective. At 2400×1920, sixteen float32 pigment channels take 294.912 MB; adding two water fields yields 331.776 MB. Twenty fields total are 368.64 MB, and duplicating those fields is 737.28 MB. These are decimal array payloads, not peak process RSS. My earlier capacity concern should be demoted, not used to block that prototype.

Still specify layer retention. One extra full-frame eight-pigment deposited layer costs 147.456 MB. A fixed number of channels is bounded; an indefinitely growing wash stack is not. Total pigment mass per component does not encode the order of separate glazes. Decide whether old layers remain individually liftable, become a bounded layered representation, or are retired under an explicit approximation.

Curtis et al. use an ordered set of glazes and an empirical shallow-water model, not simply one indefinitely accumulated mixture. Their model also uses adaptive steps and iterative relaxation. Grid parallelism is promising but not a guarantee of cheap full-sheet waits; benchmark those waits at target resolution early. Test water/pigment balance, rewetting, lifting, active-domain edges, continuation and paper-specific effects.

The supplied weeks estimates are planning hypotheses, not validated delivery promises. Use an early full-resolution single-paper prototype and measured integration milestones to narrow them.

Primary external references consulted:
- Lua 5.5 Reference Manual: `https://www.lua.org/manual/5.5/manual.html`, load, string.dump, pointer formatting. The manual warns that binary chunk consistency is not checked; reject binary input at every actual loading boundary, including reader-function loads, not just by deleting string.dump.
- Rust Reference, code generation: `https://doc.rust-lang.org/reference/attributes/codegen.html`. Inlining attributes are not a replacement for inspecting the resulting code and measuring it.
- Curtis et al., Computer-Generated Watercolor, SIGGRAPH 1997, §§3–5: `https://grail.cs.washington.edu/projects/watercolor/paper_small.pdf`.

## Amended execution order

| Stage | Scope | Gate |
|---|---|---|
| 0 | Frozen baseline, early state digests, clean hotspot/live measurements | Traceable inputs and repeatable scoped goldens |
| 1 | Small reproduced bugs, N4, N11, single-writer locks, honest unknown outcomes | Failures do not masquerade as unchanged/finished states |
| 2 | Measured exact kernel work, with cure/blur controls ported to native tests | Full-state regression gate; no unintended legacy behavior changes |
| 3 | Engine-3 serial semantics, then dependency-safe parallel scheduler | Worker/tile independence within v3 and preserved legacy paths |
| Parallel panel | Minimal support/preparation identity and complete panel workflow | No linen-specific leakage; replay/rollback/export pass |
| Early watercolor spike, then implementation | One bounded paper/palette and full-resolution waits; expand papers after calibration | Measured memory/time, mass accounting, continuation and honest layer semantics |

**Decision to hand the implementation agent:** proceed with the versioned performance change. Use target-machine profiling to rank optimization work. Preserve old behavior where promised and make all intended numerical/dialect changes explicit. Check the cure hoist and rolling-blur arithmetic before accepting “exact” micro-wins. Bring failure-outcome and prompt-isolation mitigations forward, without turning the project into a prerequisite-heavy general framework rewrite.
