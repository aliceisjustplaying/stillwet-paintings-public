# Evidence index and reproduction boundaries

## Reading the evidence

`evidence/` contains this review’s executed receipts and inventory. `prior-review/evidence/` contains the earlier reviewer’s original receipts and probes, copied unchanged. Source references in the detailed ledger are relative to the original ZIP; an original `evidence/...` anchor therefore resolves under `prior-review/evidence/` in this delivery. No historical receipt has been relabeled as a new execution.

The container supplied Node 22, Python and a system Lua 5.4 shared library, but not Rust/cargo, a built easel or M3 hardware. Node/Python tests and production-function witnesses were executable. Native Rust findings still need tests in the project’s real build. No provider session or model-influence experiment was run.

## Executed tests

Use a fresh extracted archive. Preserve its Unix executable modes; ordinary `zipfile.extractall` can omit them. Set paths as appropriate:

```sh
ROOT=/absolute/path/to/paint-reviewer-20260930
CP="$ROOT/repos/claude-paint"
HANDOFF=/absolute/path/to/paint-review-deliverables
```

| Receipt | Command / scope | Recorded result |
|---|---|---|
| `evidence/harness-tests.txt` | From `$CP`: `node --experimental-strip-types --test harness/painter/test/*.test.ts` | 31 passed, 1 skipped; real-easel test unavailable. |
| `evidence/studio-tests.txt` | From `$CP`: `python -m pytest -q studio/test_studio.py` | 7 passed. |
| `evidence/runner-tests-supported.txt` | From `$CP/notes/round19/runner`: `python -m pytest -q test_r19_chains.py -k 'not test_the_watchdog_finds_a_real_process_in_a_studio'` | 25 passed, 1 deselected; unavailable `lsof`. |
| `evidence/runner-tests.txt` | Initial full runner attempt before executable-mode restoration | Environmental failures retained; not counted as project defects. |

The supported baseline has 63 passing tests in total, one skipped test and one deselected test. These counts are not comprehensive engine coverage. Inspect the receipt if tests or dependencies differ in the implementation checkout.

## New bounded witnesses

```sh
node --experimental-strip-types "$HANDOFF/probes/harness-probes.mjs" "$CP"
python "$HANDOFF/probes/runner-gallery-probes.py" "$ROOT"
python "$HANDOFF/probes/lua-pointer-control.py" "$CP"
```

The scripts print JSON receipts and assert current problematic behavior. They create temporary files only, import supplied production functions, and do not modify production source. Python gallery probes require Pillow and the modules imported by the supplied runner/gallery. The Lua control requires `liblua5.4`.

| Receipt / finding | What was actually reproduced | What was not established |
|---|---|---|
| `harness-probes.json`: N8 | The real summary helper accepts a clock from `read` text and from a failed paint result. | No model was shown the summary. |
| `harness-probes.json`: N9 | Forged journal headings remain in constructed summary text. | No claim of actual instruction obedience or access escalation. |
| `harness-probes.json`: N10 | One synthetic 2,000-character image block remains despite a 1,000-character budget. | Synthetic data is not a valid PNG; no provider token/billing limit was tested. |
| `harness-probes.json`: P09 | A fake child invoked through the production easel client sees no inherited `RAYON_NUM_THREADS=6`. | No actual Rayon pool was run or tuned. |
| `harness-probes.json`: N21 | A contained `..draft.md` path is rejected by the production path helper. | Ordinary symlink escapes are already checked; this is not evidence of a general painter sandbox escape. |
| `runner-gallery-probes.json`: N12 | The actual record validator accepts direct composition advice, including a tall central arch and brightest patch on the left. | Passing validation does not prove that a painter followed it. |
| `runner-gallery-probes.json`: N14 | Mocked `TimeoutExpired` in the real recovery decision returns availability. | No real provider outage was induced. |
| `runner-gallery-probes.json`: N17 | A valid synthetic PNG in a current `look` event is decoded but classified as skipped by the production parser. | Original session image payloads were not available for a full historical gallery rebuild. |
| `runner-gallery-probes.json`: N18 | A mostly white, nonblank image yields no frame writes through the production filter and a counting-sink encoder. | No real ffmpeg process ran; this does not test codec behavior. |
| `runner-gallery-probes.json`: N19 | Two images differing at an unsampled pixel have exactly equal `[::997]` byte slices. | This is a loss-of-information witness, not a cryptographic hash collision. |
| `lua-pointer-control.json`: N1 | Eight fresh system Lua 5.4 processes, loading the production prelude with a dummy ID callback, produce eight distinct pointer-bearing strings. | Project uses embedded Lua 5.5 and a custom allocator. This control alone does not prove its full live/replay behavior. |

## Inventory and source integrity

`source-chunk-inventory.json` lists source path, SHA-256, marker count and contiguity for each of 38 current `paint-studio-*/paintings/lua/painting.lua` logs. Total: **4,321** exact `--@ chunk N` markers. Early logs are not double-counted. This confirms the population size, not replay duration or the reported 68% / 41% timing shares.

`archive-integrity.json` records the original ZIP SHA-256 and a byte comparison of all 4,198 extracted original file entries. No original entry’s bytes changed. Restored executable modes and added test caches are not code edits. This verification does not mean all 4,198 files received a line-by-line semantic review.

`referenced-source-index.json` records hashes, sizes and line counts for source files used by task anchors. `BENCHMARK_FIXTURES.json` pins the full source and exact chunk 90 of the c766c5 workload. Its full prefix through chunk 89 must be established before measuring the original continuation. The matched chunk also contains two `blend()` calls; the quoted 574 seconds was not independently timed.

## Prior review receipts retained

The earlier review supplied native Lua replay probes, drying and shadow probes, and a studio/gallery proof log. They are preserved in `prior-review/evidence/`, alongside `prior-review/reviews/{implementation-plan,review,mediums-plan}.md`. Consult their own commands, engine identities and limitations. The current compatibility patch was source-diffed; its existence does not validate or invalidate every earlier numeric result. Re-run relevant probes before closing R1–R25.

## Native and operational work deliberately not attempted

No hostile binary chunk was executed, no unbounded allocation was requested, no live daemon race was induced, no process outside a controlled fake child was terminated, no production export/deployment ran, and no native speedup was measured. Checkpoint corruption, transaction fault injection, scheduler equivalence and medium physics are implementation-machine acceptance work. For M3/compiler/Lua/material background, use the primary references and bounded claims in `M3_BENCHMARK_PLAN.md`.
