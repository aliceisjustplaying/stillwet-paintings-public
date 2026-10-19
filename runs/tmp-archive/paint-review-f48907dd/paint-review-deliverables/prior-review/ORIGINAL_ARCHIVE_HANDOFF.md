# Painting projects: reviewer handoff

Start with [the combined implementation roadmap](reviews/implementation-plan.md). It puts all 25 reviewed defects and the associated simplifications in one order: execution and studio guarantees, oil on prepared panel for Pieter Bruegel the Elder, then watercolor. The roadmap is a proposal; the supplied production code has no changes from this review.

The compact `paint-reviewer-20260930.zip` is the starting point for a reviewer. It contains current source, painter inputs, historical painting programs, text transcripts and review evidence. The `paint-complete-20260930.zip` companion includes everything in the reviewer pack plus full Git history, original image-bearing painter logs and 36 finished PNGs from rounds 16–20. Full Git history alone is about 714 MiB, so the complete archive exceeds the requested 100 MB target.

## What the projects do

`claude-paint` is a Rust oil-paint simulator with a Lua easel, a painter-agent harness and a session viewer. Painters make marks through simulated brushes, pigments and drying on linen; successful chunks form replayable Lua painting logs. `stillwet` builds the gallery and archives the painters' inputs, words and session views. Its separate data folder supplies painting metadata and finished media.

The review covers these snapshots:

| Project | Revision | Main boundaries |
|---|---|---|
| claude-paint | `f97d5c043537fb66a057b8248a4d93624e0b565b` | Engine, live/replayed easel, painter harness, viewer, studio export |
| stillwet | `f8c0a476d10aa1c2f5ff9ffc82c0c8c852d3d3b7` | Gallery, input extraction, timelapses, deployment and sync |

A legacy-replay update landed after the review. The included current claude-paint snapshot is `4ec3169b3131f211653ad91af685fc7089543ef4`, which restores tools and models needed by older logs. That update has not received this review. `repos/claude-paint/` contains the current snapshot; `repos/claude-paint-reviewed/` preserves `f97d5c0` for the findings' source links. Reconcile the current changes before applying a finding's repair. The complete Git bundle contains both revisions.

## Source map

Paths below are relative to this folder.

| Owner | Entry points | Why inspect it |
|---|---|---|
| Material simulation | `repos/claude-paint/crates/paint/src/{canvas,style,bristle,pigment,palette,checkpoint}.rs` | Surface/material state, brush contact, optics, drying and saved state |
| Scene geometry | `repos/claude-paint/crates/paint/src/scene.rs`, `crates/easel/src/world.rs` | Shadow traversal and duplicated world construction; the second path is also under `repos/claude-paint/` |
| Easel contract | `repos/claude-paint/crates/easel/src/{api,session,main}.rs`, `prelude.lua` | Tool registration, snapshots, replay, Lua invariants and persistence; the Lua file is in that same `src/` folder |
| Painter inputs/tools | `repos/claude-paint/harness/painter/`, `notes/round19/runner/`, `notes/research/` | System prompt, extensions, exposed tools, copied launch logic and materials; both notes paths are under `repos/claude-paint/` |
| Actual historical launches | `runs/{r16,r17,r18,r18g,r19,r20}/` | Copied scripts, briefs, reader guidance, sitting records and final replies |
| Actual painter studios | `painting-sources/studios/paint-studio-*/` | `BRIEF.md`, notes, journals, Lua logs and saved source versions |
| Session viewer/export | `repos/claude-paint/studio/{studio,export_static}.py` | Live/replayed logs, derived streams and output ownership |
| Gallery/archive | `repos/stillwet/{build,inputs_extract,looks,add_painting}.py`, `deploy.sh`, `sync-studio.sh` | Rendering caches, document versions, encoders, manifests and locks; both shell scripts are in that same repo folder |

## Reading and next work

[The implementation roadmap](reviews/implementation-plan.md) is the working document. Begin its execution, studio-input and output-ownership packages together. Each package names the defect, the smallest repair or extraction, dependencies and observable completion conditions. Panel follows those execution/studio guarantees; watercolor reuses the support and session boundaries established for panel. Preserve the logged engine behavior of historical oil paintings.

[The original review](reviews/review.md) supplies finding details, reproduced results and prompt-exposure evidence. [The earlier medium proposal](reviews/mediums-plan.md) supplies additional design and material research. They are supplemental references; follow the combined roadmap for sequencing. Evidence lives in `evidence/`, and report links point to files included in this pack.

The prompt review distinguishes recorded exposure from demonstrated influence. No earlier-painter research was found in the current Hopper studio. Historical notes do include technical names, URLs and some procedural/composition guidance; that establishes potential steering, without proving the painter read each source or that it affected the result. Review the actual brief, notes, session text and captured images when checking a particular painter.

## Painting sources and conversations

All 38 extant studios and eight earlier round 14/15 source folders are under `painting-sources/studios/`. `repos/claude-paint/archive/sources/` contains the repository's 21 selected earlier programs. Additional historical programs are readable under `painting-sources/historical/`: [the index](painting-sources/historical-index.json) maps each original Git reference and file path to its exact source blob. This avoids requiring a Git checkout to read paintings from deleted worktrees. Engine revisions for rebuilding those paintings remain in the complete companion's Git bundles.

The handoff contains **159 selected session logs**. Selection covers every session referenced by the gallery manifests and round sitting records, every JSONL in the 38 studio session directories and surviving early painting directories, and archived round session copies. This includes recorded interrupted or unlisted sittings. It excludes unrelated development chats. Some historical paths refer to a moved session; `MANIFEST.json` records both the referenced path and its surviving copy.

`sessions-text/` retains every parsed record and all text, including reasoning, tool calls/results and final replies. Only image payloads are replaced with explicit pointers to `sessions-original/` in the complete companion. Those original JSONL files are copied byte for byte and contain the embedded images. These are the recorded logs; they cannot reconstruct every private or transformed provider input beyond what was captured.

`runs/*/run/studios.json` maps round/lane names to studios. `data/stillwet-data/manifest.json` describes published paintings through round 18; later round 19/20 results are in their run folders. Existing absolute paths in archival records describe the original machine. Use the original-to-relative mappings in `MANIFEST.json` to find corresponding packaged files.

## Source and Git restoration

The `repos/` folders in the compact pack contain the current tracked source/text files. They have no `.git` directory. Generated build caches, native executables, runtime sockets and standalone image/video/checkpoint assets are omitted. The complete companion preserves tracked assets in Git history and adds the 36 selected round 16+ finished PNGs under `painting-finals/`. Earlier standalone final PNGs and timelapse clips are not included.

For normal code work, extract the complete archive and clone its bundles from that extracted folder:

```sh
git clone history/claude-paint.bundle restored/claude-paint
git clone history/stillwet.bundle restored/stillwet
```

The bundles contain all retained Git references and their complete reachable history, including archive tags. To materialize every reference, including nonstandard refs and stashes, make a mirror clone with `git clone --mirror history/claude-paint.bundle history/claude-paint.git` (and likewise for stillwet). Local hooks/config, unreachable objects and temporary Git garbage are outside the handoff.

The root Cargo workspace contains `paint` and `easel`. Build and test the restored current checkout with `cargo build --release -p easel` and `cargo test --workspace`. The default easel enables developer replay/finishing; `--no-default-features` is the restricted painter build, with its material box selected by feature. Historical paintings require their own recorded engine/tag, as described in `repos/stillwet/DEPLOY.md`.

Harness tests are under `repos/claude-paint/harness/painter/test/`; viewer tests are `repos/claude-paint/studio/test_studio.py`. Python gallery scripts declare their dependencies inline for `uv run`. Build dependencies must be installed on the receiving machine; their package caches are not bundled. A full gallery build additionally requires the omitted earlier media. Reproduce output bugs in synthetic destinations before running a mutating gallery/export command.

The standalone proof scripts retain their original constants as evidence. Before rerunning `evidence/easel-replay-probes.py`, point `BASE` to a new local scratch folder containing `light-functions.lua`, and `EXE` to your rebuilt developer easel. `engine-probe.rs` is a Rust probe linked against the `paint` library. Recorded receipts are available without executing either probe.

`MANIFEST.json` lists source paths, sizes and SHA-256 hashes, transcript mappings, revisions and companion-only assets. Historical test receipts describe the reviewed snapshots; none proves that a proposed fix, panel or watercolor feature is implemented.
