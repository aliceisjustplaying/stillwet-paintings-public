# Painting engine: revised adversarial-review roadmap

**Review date:** September 30, 2026  
**Target:** the user’s M3 Pro, 12 cores (6 performance + 6 efficiency); installed RAM and power/thermal conditions still need measurement.  
**Inputs:** `paint-reviewer-20260930.zip`; current claude-paint `4ec3169b3131f211653ad91af685fc7089543ef4`, previously reviewed claude-paint `f97d5c043537fb66a057b8248a4d93624e0b565b`, stillwet `f8c0a476d10aa1c2f5ff9ffc82c0c8c852d3d3b7`.  
**Status:** review, bounded probes and implementation plan. No production fixes or new medium implementation were made.

## 1. What to change about the existing plan

Keep the original plan’s strongest boundaries: explicit persistence outcomes, committed activity, exact input receipts, owned output directories, versioned oil behavior, shared immutable world data, pigment-preserving watercolor state and full-support simulation. Keep **all R1–R25**; none is declared repaired merely because the newer compatibility patch exists.

Make five changes to the order and scope.

**Performance is a parallel critical workstream starting now, not cleanup after panel or watercolor.** Establish an M3 end-to-end baseline immediately and remove exact, avoidable work while the execution boundary is repaired. In particular, measure the live snapshot and persistence costs that replay timings do not include. Do not spend the first optimization cycle on `look()` just because it is visible to the painter.

**The transaction boundary needs more than the original persistence fix.** Single-writer daemon ownership, finalization errors, cancellation, unknown commit outcomes and idempotent recovery belong in one design. A tool that reports “an error changes nothing” must establish that contract across native execution, Lua state, clocks, brushes and storage—not only across ordinary Lua exceptions.

**Prompt isolation needs capability and provenance enforcement, not only text filtering.** The reader lacks the painter’s scoped filesystem tools; compaction can promote arbitrary tool text into authoritative clock facts; ordinary-language composition instructions pass the inherited-record validator. These are concrete boundary failures or risks. They do not establish that any historical painter was actually influenced.

**Treat tile layout as current paint semantics until it is explicitly separated.** Reloading, held-brush randomness, ordering and hand-time accounting depend on tiles. Retiling or skipping planner candidates can change paint. Extract a stable logical operation stream before treating the scheduler as freely interchangeable.

**Ship a generic prepared-panel oil vertical slice, and investigate watercolor feasibility early.** Bruegel is an optional intentional artist profile, not an intrinsic property of a panel. A small watercolor prototype may run in parallel once basic state/time contracts are available; do not wait for every gallery repair to learn that the chosen pigment representation exceeds the Mac’s memory. Conversely, do not launch production painters on unvalidated new media.

This handoff contains **72 work items**, not 72 newly demonstrated bugs: 25 inherited findings, 22 independent defects/risks/assurance gaps, 13 performance tasks and 12 architecture/feature tasks. Detailed implementation and acceptance criteria are in `FINDINGS_AND_TASKS.md`; `BACKLOG.json` contains the same items and an acyclic dependency graph.

## 2. What was actually verified

The archive contains current and previously reviewed source, 38 extant studios plus early source folders, 159 selected text session logs, launch copies, three review/medium documents and prior probe receipts. Its own handoff explicitly omits native binaries, Git history, standalone finished paintings and original embedded-image payloads supplied only in the complete companion. The audit inspected the active engine/easel/harness/runner/viewer/gallery boundaries, diffed the current versus reviewed snapshots, and sampled actual studio/launch evidence. It did not line-by-line prove every historical program, visually inspect omitted images or replay all 38 paintings.

### Executed here

| Check | Result | Scope |
|---|---:|---|
| Painter harness Node tests | 31 passed, 1 skipped | The skipped case needs the real easel binary. |
| Studio viewer tests | 7 passed | Supplied Python tests. |
| Round-19 runner tests, supported subset | 25 passed, 1 deselected | The omitted real-process watchdog test needs unavailable `lsof`. |
| New harness witnesses | 5 reproduced | Forged clock provenance, journal heading composition, newest-image size policy, stripped thread environment, `..draft.md` false rejection. |
| New runner/gallery witnesses | 5 reproduced | Composition record accepted, timeout counted as recovery, current `look` image skipped, white-reserve image discarded, sampled dedup misses a real change. |
| Source corpus inventory | 38 logs, 4,321 chunks | Exact markers counted once per current studio; no replay or timing inference. |
| Archive integrity | 4,198 original entries unchanged | Byte comparisons against the original ZIP; not a semantic audit of every file. |
| Pointer-format control | 8 distinct results in 8 fresh processes | System Lua 5.4 with production prelude; **not** the project’s embedded Lua 5.5. |

Source bytes were not changed. Unix executable modes lost during ordinary Python ZIP extraction were restored from the archive’s recorded modes before the supported runner tests. Initial runner failures caused by those extraction modes and missing `lsof` are retained as environmental evidence, not counted as project defects.

### Not executed here

Rust/cargo, the compiled easel, a real painter/provider session and M3 hardware were unavailable. Consequently, the prior Rust results remain **historical receipts**, new native findings are source-backed unless explicitly labeled otherwise, and every proposed speedup remains unmeasured. No deployment, production export, hostile bytecode, destructive memory-exhaustion test or real-process kill was run. The full reproduction commands and boundaries are in `EVIDENCE_INDEX.md`.

## 3. Most consequential independent findings

### Execution and replay

**N3: daemon startup is not a single-writer protocol.** `open()` probes, removes a socket and spawns; `serve()` replays before binding. There is no lifetime session lock around that sequence. Concurrent opens can leave two servers with independent live states and a shared log. A socket pathname is not sufficient writer ownership. See `crates/easel/src/main.rs:410–433, 486–492`.

**N4–N5: “failed means unchanged” is broader than the implementation’s guard.** `time::flush` and fallible global bookkeeping sit outside the guarded execution path; the client can also time out while its detached server continues native work. An unknown outcome is not the same as a rollback. Fix these with R3, not as isolated error-message changes. See `session.rs:235–293`, `main.rs:425–433, 517–521` and `harness/painter/easel-client.ts`.

**N1–N2: deterministic traversal does not close every Lua surface.** Default pointer formatting can become a seed or branch input, and the visible loader setup does not establish a text-only `load` policy. The actual embedded Lua must be tested. The Lua manual documents pointer formatting and warns about hostile binary chunks; the supplied control only demonstrates the relevant standard-library behavior in Lua 5.4. See the evidence qualifications and primary reference [S3] in the benchmark document.

**N6: the checker validates current appearance, not the entire future.** Its live reference is RGB plus height. Wet composition, cure, film, brush load, clock, RNG and Lua state can differ while the current picture matches. Keep the image comparison, but add continuation-state equivalence and receipts that state exactly what was checked. A canvas checkpoint is not a full Lua session checkpoint.

**N7: checkpoint corruption is still a resource and semantic risk.** The pixel limit permits 2^30 pixels, and large buffers can be allocated before a truncated read fails. Some physical values/flags are not fully validated. Add checked byte budgets, precise representation-aware validation and integrity metadata before extending the format for watercolor.

**N15: the compatibility patch does not reproduce original painting semantics.** Its own comments say old target colors are now raw paint, `pal`/`aim` no longer select mixtures and output is not pixel-identical. That is an honest compatibility renderer, not a historical oracle. Never derive old goldens from its output and then claim historical preservation. See `crates/easel/src/legacy/mod.rs:15–37`.

### Painter and reader exposure

**N8: compaction fabricates authority from arbitrary tool text.** The production summary function accepted a successful `read` containing `day 9999, 99:99`, and also accepted clock text from failed `paint`. It then described this as the latest painting time printed by the easel. Clock facts must come from structured committed state, not regex scanning text.

**N9: journal content can impersonate generated summary sections.** The bounded witness preserved injected headings next to real summary sections. Delimit and attribute self-authored memory; do not make it indistinguishable from authoritative session state. Preserve actual brief constraints rather than silently retaining only a long brief’s tail. This is a text-composition finding, not evidence of model obedience.

**N11: “reader isolation” currently means prompt hygiene, not scoped read/write capabilities.** Its extension clears inherited system additions but does not constrain built-in filesystem tools. Give it a bounded evidence root and one allowed output, enforced by tools rather than instructions.

**N12: “material-only” is not enforced by names and code regexes.** The real validator accepted: “Always put a tall arch at the center of the picture. Keep the brightest patch on the left.” Preserve useful material learning, but give observations a schema, evidence and semantic review. Record deliberate chain learning as such.

**N13: activity is not completion and must not become a reward.** Actual committed counters fix R13’s alias bug, but deciding that a painter is done because one sitting adds no marks remains a proxy. Add explicit lifecycle outcomes; do not encourage gratuitous marks, avoiding looks, lowering coverage or artificially drying paint to satisfy an infrastructure metric. No actual reward-hacking behavior was established by this audit.

### Delivery and orchestration

**N14: a timed-out health probe is declared successful recovery.** This was reproduced through the production decision function with only the subprocess mocked. Require a valid successful response, not merely absence of a usage-limit phrase.

**N17: current `look` tool images are unrecognized by the gallery parser.** The synthetic current-format event decoded correctly but was marked `skip` because the parser expects shell render/peek plus `read(path)` history. The current gallery’s published manifest stops at round 18, so this is specifically an integration gate for later/current sessions—not evidence that all published old clips are broken.

**N18–N19: timelapse selection discards valid painting evidence.** Mostly white views are filtered as “not the painting,” which is incompatible with reserved watercolor paper. Hashing every 997th image byte also necessarily misses some small changes. Use observation metadata and exact content identity; keep editorial selection separate from the audit archive.

**N16/N21/N22** cover gapped look filenames overwriting observations, a false rejection of `..draft.md`, and cleanup selecting processes by command-line substrings. These are smaller but actionable and have explicit tests in the backlog.

## 4. Performance: the priority is less work, not simply more threads

### Start from the supplied numbers, but do not overinterpret them

The source inventory independently confirms exactly **4,321 chunk markers across 38 current painting logs**, each numbered contiguously from one. The user reports 12.3 hours of replay, `work()` accounting for 68%, the slowest 5% of chunks accounting for 41%, and a typical look around 0.1 seconds. **Those timing measurements were not independently reproduced.** They are enough to prioritize brush-pass and tail-latency work, not enough to prescribe a speedup or a particular thread count.

The matching source is **chunk 90** in:

`painting-sources/studios/paint-studio-c766c5/paintings/lua/painting.lua:1037–1044`

It contains the quoted scumble passes with coverage 4.5/3.0 and seeds 1161/1162 **plus two `blend()` calls**, at coverage 3.0/1.6. The setup is 500 mm wide with aspect 1.25. At the fixed 2400px live width that is 2400×1920 pixels. The source confirms the workload, not the quoted 574-second attribution. Benchmark the complete chunk, each work pass and each blend separately; retain the preceding state and RNG context.

Conditional Amdahl arithmetic illustrates the leverage. If the 68% share represents the workload being optimized, doubling only that component yields about **1.52× overall**; quadrupling it yields about **2.04×**; eliminating it entirely cannot exceed **3.125×**. Halving the reported 41%-of-time tail component alone yields about **1.26× overall**. These are calculations from supplied percentages, not measurements or promises; the components overlap and their gains cannot simply be multiplied.

### Ordered optimization portfolio

| Order | Work | Why it comes here | Semantics policy |
|---|---|---|---|
| 1 | P01/P09: phase timing, effective thread configuration, CPU/RAM admission | Without these, replay/live cost and background contention are conflated. | No paint behavior changes. |
| 2 | P02/P06/R7: move rollback snapshots, reuse geometry/scratch, remove permanent leaks | Concrete unnecessary copying/allocation with relatively local owners. | Full-state exactness required. |
| 3 | P04/P05: relevant-region fill bookkeeping and contact-surface rebuilds | Full-frame scans/copies are visible directly in hot paths. | Exact ordering/halos first; approximations separate. |
| 4 | P07/P03/P08: logical operation stream, sparse placement and better dependency scheduling | Potentially high leverage, but current tile/RNG semantics make naive changes unsafe. | Extract legacy semantics; version changed planning. |
| 5 | P10/P12: log/journal and checkpoint memory traffic | Helps long sessions, small calls, reopen and future larger material state. | Preserve durability and integrity contracts. |
| 6 | P11/P13: compiler/SIMD experiments and bounded media processing | Useful measured refinements, not substitutes for removing algorithmic waste. | Numerical/build policy and machine budget apply. |

The implementation does **not** warrant a universal cost law of exactly area × coverage × resolution. Candidate count depends on the full frame and gap formula; brush work depends on prepared path length, bristle count, pixel footprint, contact/raster loops and overlaps; fill/contact rebuilds add other terms. Measure these counters instead of fitting all calls to one formula.

Do not parallelize neighboring bristles or reorder overlaps merely because Rayon exists. Paint pickup and reservoir state are ordered dependencies, even when some marks do not overlap on the canvas. Preserve floating reduction order for exact paths. Do not introduce fast-math, change `coverage`, skip fills, reduce bristles, lower the simulation grid or suppress looks and call that the same painting faster.

On the M3, benchmark 1/2/4/6/8/10/12 workers and important concurrent-job combinations. Six Rayon workers are **not** a reservation of the six performance cores. macOS scheduling and QoS matter; throughput and latency may favor different settings. Keep Rayon unless evidence favors a platform-specific change; do not start with an engine-wide GCD or Metal rewrite. Apple’s AMP guidance and Rayon’s explicit thread-pool behavior are primary references [S1–S2].

The detailed fixtures, counters, memory arithmetic, build experiments and decision rules are in `M3_BENCHMARK_PLAN.md`.

## 5. The new execution contract

Implement one coordinated boundary rather than a sequence of patches that leave incompatible promises.

1. A session has one kernel-locked writer and an immutable identity. A client request has a stable ID and names the expected session generation.
2. Preflight validates resource limits and supported API/dialect before expensive work when this can be done without changing observable Lua semantics.
3. A transaction owns all rollback state: native material, brushes/palette, Lua heap/metatables, clocks, RNG/identity state, view/setup state and activity. Native work polls a cancellation token.
4. Finalization remains within the transaction. There is one documented durable commit point and a recoverable receipt. Acknowledged work survives reopen; uncommitted work does not leak into later state.
5. After a lost reply, the client queries the same request ID. It never assumes an error means unchanged, and never blindly repeats non-idempotent marks.
6. All observation, summary and activity facts reference committed structured state. Printed text is data, not an authority channel.

The existing witness is a local integrity device, not a signature or defense against coordinated edits to all state. Preserve that documented scope. A new append journal can avoid repeated full-history copies, but an mtime-only replacement weakens the existing detection contract. Agree on that contract before implementing P10.

Do not attempt to catch process OOM as if it were a normal Rust panic. Prevent excessive allocation and bound native work; crash recovery comes from the durable record. Do not enable `panic=abort` while relying on panic unwinding for rollback.

## 6. Architecture for oil panel and watercolor

### One session, one selected medium

Resolve session identity before Lua registration: behavior engine, Lua dialect, medium, box/material revision, support/preparation revision, physical setup seed, numerical/build identity and save-format version. These are distinct fields, not a palette-owned integer carrying every meaning.

Use an explicit selected medium state at the painting boundary. Share geometry, masks, observation metadata and immutable support data where their contracts agree. Keep oil and watercolor loading/exchange/time logic separate. Do not force every pixel through a trait object or a giant struct with mostly unused optional arrays.

Separate `SupportSpec`, `PreparationSpec`, physical dimensions, simulation grid and `ViewSpec`. A view is read-only: cropping, squinting, mirroring, encoding and rendering at a different display size do not alter the simulation domain or advance time. Seeded support microstructure is immutable and can be shared; wetness, deposited pigment and evolving material state are not preset data.

### Prepared-panel milestone

Implement one generic prepared rigid panel using the existing oil solver where appropriate, with intentional support/ground/absorption differences. No linen weave or default linen-oriented cracking should leak into it. Run the full blank-studio path first: setup, brushwork, drying, rollback, reopen, checker, viewer and optional finish. Then add an artist profile as a separate intentional brief.

Retain the older roadmap’s historical-material questions as research tasks rather than settled engineering facts. Palette selection must not silently substitute unavailable historical pigments. The panel capability should not depend on a claim to faithfully simulate one historical painter’s complete working method.

### Watercolor feasibility milestone

Begin with one sized paper, a small fixed component palette and ordered washes. Preserve **surface water, paper water, mobile pigment and deposited pigment identities**. Keep velocity/history only when the selected solver needs it. Define exact capacity/retirement/refusal behavior before loading a full artist palette; do not accumulate one permanent dense channel set for every historical wash.

Reuse brush geometry only. Water loading, capillary feeding, deposition, pickup, clean-water addition and lifting require their own exchange model and brush-reservoir accounting. Pigment that can be lifted later must not already have been reduced to RGB. Reuse existing optical code as a starting point only after calibrating mass/thickness to its inputs.

Give simulation time one owner. Persist all solver progress needed for exact continuation. Identical-log replay should be exact under the declared platform/build policy; split waits should agree within an explicitly chosen physical tolerance. Arbitrary source-chunk splitting is not automatically equivalent because the current engine seeds by chunk. Require equivalent logical operations, seeds and timestamps when asserting that invariant.

Simulate the full physical support with active wet tiles/frontiers and valid halos. Water may enter the viewed crop from outside it. Drying one island must not retire another wet region. Long waits need inactive/dry fast paths; they must not blindly execute millions of microsteps.

### Several papers, without pretending a texture swap is physics

After one preset is correct and affordable, add generic sized hot-press, cold-press and rough papers. Keep texture, sizing, absorption/permeability, capillary capacity and retention conceptually separate, even if early calibration ties some parameters together. Test paper-dependent changes using the same wash, not different paintings.

Use controlled cases for edge accumulation, granulation, backruns, glazing and pigment-dependent lifting. Record actual measured/implemented behavior and uncertainty. Curtis et al. provide a useful empirical graphics-model starting point, not universal physical coefficients [S5]. Arches’ own product descriptions distinguish textures and sizing, but do not supply validated simulation constants [S6]. Avoid brand-accurate claims until the model has corresponding calibration.

Watercolor finishing must use watercolor drying/rendering, not inherited month-sized oil waits, varnish or crack defaults. Keep painter-seen, as-painted and postprocessed finished artifacts distinct. Reserved paper is valid painting content and must survive the gallery.

## 7. Implementation order and parallel work

The phases below are **release milestones**, not a ban on prototyping or a requirement that every task in a phase wait for every other task. JSON dependencies identify prerequisite contracts; deliver small schemas before later complete features when needed.

| Phase | Main work | May run in parallel | Exit gate |
|---|---|---|---|
| A — Baseline and trustworthy boundaries | P01/P09; R1–R3/R6; N1–N5/N8/N11/N14/N20/N22; R9–R12/R15/R24; output ownership R16/R17; D1/D11 contracts | Benchmark instrumentation, runtime fixes, input/reader isolation and safe publication owners | Single-writer, clear commit outcomes, bounded execution, scoped tools and reproducible inputs established for affected production paths. |
| B — Exact CPU/memory improvements | P02–P08/P10–P12, R7, N7/N10/N16/N21; observation schema/current-tool adapter N17 | Independent geometry/scratch, snapshot ownership, fill/contact profiling, journal work | Measured improvements on unchanged inputs with full-state equivalence and bounded RSS; no hidden quality degradation. |
| C — New time/support boundaries and oil panel | D2–D5/D10/D12, R4/R5/R8, N6/N15 | Shared-world extraction, panel vertical slice, checker strengthening | Versioned numerical behavior; panel completes real launch-to-view/check/finish flow at target size. |
| D — Publication and archival fidelity | R14/R18–R23/R25, N18/N19, P13 | Can begin before panel; only its affected publishing paths are gated | Atomic owned outputs, exact source/version provenance, valid media, no observation loss, correct lock/manifest/viewer generations. |
| E — Watercolor feasibility | D6/D7/D9 | A bounded prototype may start while panel work finishes, using settled identity/time contracts | Water/pigment conservation, lifting/rewetting, exact continuation, failed-work rollback, active-domain correctness and measured M3 affordability. |
| F — Multiple calibrated papers and release | D8 plus end-to-end material docs and release tests | Paper trials and palette calibration once the prototype is stable | Characteristic effects and preset differences demonstrated; no unsupported physical claims; complete clean-room painter and gallery path. |

A practical first implementation batch is: add instrumentation and immutable benchmark receipts; fix scoped reader tools and forged summary facts; introduce single-writer/request-outcome contracts; repair durable transactions and runtime determinism; then land move-only rollback, owned caches and scratch reuse. Those changes address real failures without waiting for a full medium rewrite.

Do not collapse all of this into one “refactor architecture” pull request. Assign one regression owner per contract. Keep source extraction, numerical changes, performance claims and prompt text changes separately reviewable. Re-run the relevant smaller tier per change and the full corpus at milestone/release boundaries.

## 8. Release gates and what not to claim

**Gate T — trustworthy execution.** Fault injection covers each persistence/finalization step, cancellation races and replay startup. Repeated opens never create multiple writers. Unsupported Lua/metatable/loader behavior is refused predictably. Failed work restores the complete documented state, or the session refuses to continue; an uncertain commit is visibly uncertain.

**Gate E — equivalence and historical provenance.** Same-log, same-declared-build live/replay/restore agrees in physical state and supported Lua continuation. Thread-count changes and execution partitioning do not change the logical stream’s outcome. Historical faithful replay uses independent old references, not newly generated compatibility images. Pixel-only checks retain an explicitly narrower label.

**Gate P — M3 performance.** Compare identical fixtures, power/thermal conditions and process budgets. Report median, tail, maximum, peak RSS, allocation/memory traffic and throughput. The initial target is a substantial brush/tail improvement—2× is a useful stretch target to test, not an asserted result. A purported gain that lowers fidelity, weakens durability or leaks memory does not pass. Final numeric budgets are set from Phase A and the actual installed RAM.

**Gate I — input integrity.** Actual registered capabilities and provider-facing prompt construction match the pinned contract; readers cannot access arbitrary paths; inherited records preserve provenance and do not masquerade as neutral observations when they contain compositional instruction. Artist style and chain learning remain intentional, recorded inputs. Behavioral influence claims require controlled model experiments beyond these code probes.

**Gate M — material correctness.** Finite state, nonnegative physical masses, declared conservation/removal ledgers, valid time advancement, rewet/lift continuation and full-support transport all pass. Paper/ground presets have real parameter distinctions and calibration evidence. Negative latent color coordinates are not confused with negative physical mass.

**Gate O — outputs.** Export/build/manifest operations preserve unrelated data and prior valid generations. Images and clips are traceable to their session/commit/view. Empty or failed encoding is not success. Observation archives are not filtered by whiteness or editorial similarity.

The important result is not merely fewer failing tests. It is a smaller set of explicit, testable contracts: what was given to the painter, what it actually committed, which material state continues, how that state is replayed, and how much work the M3 performs to produce it.

## 9. Handoff map

- `AGENT_START_HERE.md`: implementation rules and first batch.
- `FINDINGS_AND_TASKS.md`: all 72 items with evidence, source anchors, owner, repair, tests, dependencies and compatibility notes.
- `BACKLOG.json`: the same items for programmatic ingestion; all remain `planned`.
- `M3_BENCHMARK_PLAN.md` / `BENCHMARK_FIXTURES.json`: fixtures, measurement protocol, memory budget and primary technical references; fixture execution remains to be implemented.
- `EVIDENCE_INDEX.md` / `REVIEW_COVERAGE.md`: executed versus inherited evidence, exact scope and limitations.
- `probes/` / `evidence/`: bounded new witnesses and test receipts.
- `prior-review/`: the original three documents and original evidence, retained without relabeling their results as new execution.
