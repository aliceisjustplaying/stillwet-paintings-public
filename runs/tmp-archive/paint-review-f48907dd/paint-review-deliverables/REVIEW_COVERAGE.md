# Review coverage and confidence

## Method

This review reconciled the three existing planning/review documents with independent source inspection. It compared current and previously reviewed claude-paint snapshots, traced painter-facing tool and compaction paths, inspected launch/reader/runner copies, inspected gallery/viewer/export boundaries, counted the current source corpus, and executed supported baseline tests plus bounded production-function probes. Detailed source ranges and confidence labels live with each finding rather than in a separate unsourced assertion list.

“Source-confirmed” means the stated code path or missing contract is visible in the supplied snapshot. It does not mean every predicted runtime consequence has been reproduced. “Prior reproduction” means the archive includes an earlier receipt. “Reproduced here” means the described bounded probe ran in this container. “Design requirement” and “performance opportunity” are not confirmed bugs or measured speedups.

## Areas inspected

| Area | Representative files / boundaries | Main conclusions and limits |
|---|---|---|
| Original plan and newer patch | `reviews/`; `HANDOFF.md`; current/previous engine diff; `legacy/` | Retained all 25 earlier findings; examined new compatibility behavior rather than assuming the old review covers it. |
| Lua session and transactions | `crates/easel/src/session.rs`, `prelude.lua`, `api.rs`, `main.rs`, time/check code | Snapshot and rollback, weak roots, loader/pointer surfaces, finalization, clock, RPC deadline, commit and reopen contracts. Native witnesses remain pending. |
| Native painting hot paths | `crates/paint/src/handling.rs`, `bristle.rs`, `sched.rs`, `surface.rs`, `drying.rs`, `canvas.rs` | Full-frame planning/fill/contact work, path allocation, tile-defined semantics, conservative dependencies, wait partitioning and memory layout. No native profile was executed. |
| Persistence and check | Session log/witness, checkpoint decode, replay/live check | Unknown outcomes, single-writer ownership, resource caps, history scaling and appearance-versus-continuation equivalence. |
| Masks, caches and scene | `mask.rs`, `noise.rs`, `scene.rs`, easel `world.rs` | Coordinate compatibility, lifetime leaks, shared immutable data, rebuild cost and bounded shadow traversal. |
| Painter harness | `harness/painter/` extension, easel client, summary, image context, tests and documentation | Actual scoped tools, environment propagation, prompt and journal composition, clock provenance, hard image policy and dependency startup contract. |
| Runner and reader | `notes/round19/runner/`; copied `runs/r16`–`runs/r20` launches/readers/briefs | Pinned inputs, validator packaging, record authority, image evidence, activity/completion proxies, recovery and cleanup ownership. Historical launch variants were sampled, not all replayed. |
| Viewer and gallery | `studio/`; stillwet `looks.py`, input/export/build/deploy/sync paths | Current-look parsing, white-reserve loss, sampled dedup, bounded image memory, subprocess success, versioned export and filesystem ownership. No production deployment. |
| Historical corpus | 38 canonical current painting sources, available early programs and selected text logs | Exact 4,321-chunk inventory; located real c766c5 chunk 90 and prefix. Did not execute each program or visually judge omitted images. |
| New media architecture | Existing medium plan, current oil state/support/time/finish assumptions | Proposed explicit session identity, support/preparation separation, generic panel, pigment-preserving watercolor, multiple paper parameters and release gates. No claim of a calibrated new material model. |

## Important negative findings and non-findings

The engine already uses Rayon. “Add multithreading” is not a useful primary recommendation. Neither a GCD rewrite nor GPU/Metal is justified without first measuring and removing avoidable work.

Current painter filesystem tools already resolve and check real paths. The reader’s unscoped built-in capabilities are a different path; do not apply that finding indiscriminately to the painter. The `..draft.md` witness is an over-rejection issue, not an escape exploit.

The gallery’s inspected Markdown parser disables raw HTML. This review does not claim a demonstrated raw-HTML XSS. Symlink/export ownership findings are separate filesystem issues.

The newer supported runner already has the corrected painting-tool list. The stale README and copied launch variants remain separate concerns; do not describe every launcher as broken in the same way.

The compatibility module openly documents non-pixel-identical rendering. The defect would be treating that output as faithful historical evidence, not the mere existence of a best-effort migration tool.

Artist references and chain records are not inherently contamination. They may be deliberate experimental inputs. The boundary issues concern provenance, capability scope, unacknowledged compositional steering and misleadingly authoritative summaries. No behavioral study established actual reward hacking or quantified model influence.

No actual six-P-core affinity, achieved speedup, RSS peak, watercolor physical fidelity or brand-accurate paper coefficient is asserted. A synthetic control, an array-size calculation and a primary-source modeling suggestion have different evidentiary strength.

## Explicit omissions

This is not a formal verification, exhaustive dependency CVE audit, mathematical proof of the oil solver, full unsafe-code/Miri audit, or independent check of every optical/chemical coefficient. Not every historical launcher/program received line-by-line inspection. Historical image payloads and native binaries were absent; no full golden-image gallery or 38-painting replay was recreated. The test suite’s skipped real-easel and deselected real-process tests remain pending. Rust sanitizer/property/fuzz/concurrency runs, crash durability on macOS, provider-visible end-to-end capability tests, actual M3 benchmarks and new-medium calibration are specified work, not completed validation.

These limits do not erase the concrete reproduced boundary failures or source-backed optimization opportunities. They determine the acceptance tests required before marking tasks complete.
