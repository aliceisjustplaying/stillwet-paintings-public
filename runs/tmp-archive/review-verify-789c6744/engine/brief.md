Brief: engine verification report
- Objective: let the parent agent (then [local account redacted]) decide per finding: real? reachable by painters through the easel? right priority? fix cost and golden/replay churn.
- Audience: the orchestrating agent merging several verifier reports; technical; has already read the review; has not seen my probes.
- They need to learn: where I disagree with the review. #36 IS reachable (f:lit/f:shadow soft=0). #41 breaks View, not only trace. #32 depends on incidence and ray-origin distance; the review's exact center-ray repro did not reproduce. #35 only panics in debug/test builds; the release (painter and replay) builds wrap deterministically. #40 zeroed allocation is lazy, so the risk is an abort, not RSS exhaustion. #31 is unreachable, so P3.
- What would mislead: implying replays diverge from #10 (they don't; it's deterministic), or overstating #32 and #33 reach.
- Form: markdown; one section per finding (verdict, evidence with file:line and probe output, reachability, severity, fix and test, golden impact); summary table last.
- Style: US spelling, no Oxford comma, a receipt for every claim. Self-review instead of a full comms-review (internal report, the next reader is technical, cheap to correct).
