# Start here: implementation-agent handoff

## Goal and authority

Implement the revised roadmap against the supplied `paint-reviewer-20260930.zip` snapshot. The goal is trustworthy committed painting, substantially lower measured M3 Pro latency, and a clean path to oil on prepared panel plus watercolor on materially distinct papers. This handoff is a review and specification, **not a patch or a claim that all native findings have been reproduced**.

Read `REVISED_ROADMAP.md` first, then the relevant items in `FINDINGS_AND_TASKS.md`. `BACKLOG.json` is the machine-readable task ledger. Every item remains `planned`. There are 72 work items: R1–R25 inherited findings; N1–N22 independent defects, risks or assurance gaps; P01–P13 performance tasks; D1–D12 architecture and feature tasks. Do not report this as 72 proven bugs.

The implementation target is current claude-paint **4ec3169b3131f211653ad91af685fc7089543ef4** and stillwet **f8c0a476d10aa1c2f5ff9ffc82c0c8c852d3d3b7**. The previously reviewed source is **f97d5c043537fb66a057b8248a4d93624e0b565b**. The archive has no Git history or native binary; obtain the actual working checkout and missing historical artifacts on the implementation machine before asserting faithful historical replay. Do not silently use the new compatibility renderer as an old-engine oracle.

## First implementation batches

**Batch 1 — baseline and trustworthy inputs, in parallel.** Deliver P01 instrumentation and the F01 real-tail fixture specification as executable tests on the M3. Independently repair N8 clock provenance, N9 summary attribution and N12 inherited-record policy. Capture actual tool schemas and prompt construction for R9/N20. Measure the native state size and installed RAM. Report live latency separately from replay, and keep telemetry outside painter-visible reward feedback. Counted corpus size is 38 logs / 4,321 chunks; runtime percentages are user-supplied, not a baseline measured in this audit.

**Batch 2 — transaction ownership and failure semantics.** Co-design N3 single-writer ownership, N4 complete finalization guard, R3 persistence outcomes and N5 request identity/cancellation. Implement bounded native work R6 after its rollback boundary is real. Add fault injection at every transition. A timeout must be `unknown/pending` until reconciled, not a fabricated rollback. Preserve a session that can be recovered safely or refuse further mutation. Do not use `panic=abort` while promising panic rollback.

**Batch 3 — exact early performance wins.** After phase timings identify the hot parts, implement P06 geometry/scratch reuse, P04 equivalent fill bookkeeping, P05 equivalent contact-cache/filter work, R7 owned caches and P02 move-only rollback. These are separate changes with independent goldens. P04/P05 and conservative P08 graph acceleration are not blocked on completing the entire logical-stream refactor. Keep current logical marks, reloads and ordering intact. Do not change coverage, resolution, bristle count or material physics to meet an “equivalent speedup” target.

**Batch 4 — explicit machine policy and history cost.** Repair thread configuration propagation and ownership in P09; benchmark 1/2/4/6/8/10/12 workers plus concurrent check/finish/painter roles. Six workers do not imply six pinned P cores. Limit both CPU and memory admission. With durable outcome contracts in place, remove repeated whole-history validation/rewriting in P10 without weakening corruption detection. Reproduce N1/N2/R1/R2 in the actual embedded Lua build; the supplied Lua 5.4 control is not that proof.

**Batch 5 — stable semantics and panel vertical slice.** Define immutable versioned session identity D1 and separate support, preparation, physical geometry and simulation grid in D2/D3. Extract current logical operation semantics P07 before semantics-changing retiling/planner work. Repair time behavior R4/D5 and extend N6 beyond image-only checks. Ship one generic prepared-panel oil workflow D4 end to end. Treat optional artist briefs as explicit inputs, not hidden properties of panel physics.

**Batch 6 — watercolor feasibility, then production.** A bounded prototype may start early using the agreed D1/D2/D5 contracts; it does not wait for every gallery defect. First demonstrate water/mobile/deposited pigment storage and transport within the M3 memory budget (D6/D9). Then implement medium-specific brush exchange, distinct paper parameters and calibrated observation/finishing (D7/D8/D10). Keep full-support transport independent of view crops. Do not replace pigment identity with already mixed RGB. Fix N17–N19 gallery observation loss before evaluating watercolor from timelapses.

These batches express integration order, not a requirement to serialize all owners. Detailed dependencies in the JSON are acyclic contract prerequisites. They do not mean a large later feature must be finished before its small foundational schema can land. Mark contracts explicit when splitting a ticket.

## Rules for every change

Start from a failing witness or a measured phase cost. Label the change **behavior-preserving**, **intentional/versioned behavior change**, or **new feature**. Give each change a small reviewable diff; include tests and measured receipts. Never refresh all golden outputs just because the new implementation disagrees.

For an exact optimization, compare complete relevant physical state and supported continuation, not only a final PNG. Include brush reservoirs, clocks, masks, wet state, RNG and supported Lua state. Preserve deterministic arithmetic where that is the declared contract. Prove independence before parallelizing shared paint or brush exchange. A scheduler footprint must conservatively cover all reads and writes, not only visible pigment deposition.

Separate historical evidence from new results. The scripts in `probes/` assert **the presence of the old defect**, so a fix should intentionally make that witness fail until it is converted into a positive regression test. Do not invert an assertion without adding the new contract. Never run destructive OOM, race, process-kill or deployment tests against live studios; use owned temporary test roots and bounded limits.

Preserve provenance and legal notices. Generic material documentation must not accidentally prescribe composition or reward-seeking behavior, but intentional artist briefs and legitimate chain learning are not automatically contamination. Keep the original source documents and launch records as evidence rather than silently rewriting history.

## Definition of done

For each accepted item, update the ledger with commit, actual platform/build, reproduction, regression test, measured effect where relevant and remaining limitations. Ship when the applicable T/E/P/I/M/O gates in the main roadmap pass. A panel-only release need not wait for production watercolor, but it must not claim watercolor completion. A benchmark improvement must not hide worse tail latency, memory growth, durability loss or reduced fidelity.

Deliver the working code, migration/version notes, new tests, reproducible M3 receipts and an updated issue ledger. The review itself provides no completed implementation items.
