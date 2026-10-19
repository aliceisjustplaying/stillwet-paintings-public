# Comms brief: synthesis of the adversarial review + my measurements

Objective: [local account redacted] decides (a) whether to accept my reordering of the review's plan, (b) the one
open policy question (may new paintings differ from what the current engine would paint, i.e.
an "engine 3", in exchange for parallel speed), (c) whether to run the overnight jobs I propose.

Audience/context: [local account redacted], owner of claude-paint/stillwet, technical, reads in chat, just handed me
a 72-item review and three goals: bugs, oil-on-panel + watercolor, speed (most important). She
asked for synthesis, no prod code yet. She dislikes filler and wants receipts.

Knowledge model: she knows the codebase and the review; she does not yet know: the pass is
single-threaded (0.9 threads on 12 cores), 97% of time is bristle::exchange, the review's perf
items P02/P04/P05/P06/P10/P12 are ≤10% combined, exact speedups cap ~1.4x, engine-3 retiling caps
~2-3x on broad/blend, the physics volume (bristles × steps × capsule) is the real cost, all 10 new
review witnesses reproduce here, N1/N2 confirmed on the embedded Lua 5.5, chunk 90 measured 712 s
(perturbed), 36 GiB RAM makes the memory budget a non-issue, Plausible is fine.

Source meaning to preserve: measured vs estimated vs user-supplied; perturbed timings flagged;
"exact" means bit-identical output; engine 3 = versioned behavior change for new paintings only.

Form: chat reply, sectioned, receipts inline (file:line, numbers, paths). No Oxford comma, US
spelling. Kaomoji first. Concise but complete; this is the deliverable of the session.

Style: direct, no flattery, no generic wrap-up. End with the decisions I need from her.
Review: substantive → self-review against objective before sending (comms-review light).
