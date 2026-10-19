# paint-review working notes (2026-09-30)

Scratch dir: [local path redacted]
Repo: [local path redacted] @ 4ec3169 (clean). stillwet @ f8c0a47.
Machine: M3 Pro 6P+6E, 36 GiB, macOS 27.0, cargo 1.97.1.
Experimental worktree (throwaway, instrumented): wt-exp/ (detached at 4ec3169). NOT prod.

## Receipts

- baseline/c766c5-run.log: `easel run` of paint-studio-c766c5 (172 chunks), HEAD release binary sha f53fd5e7…
  Perturbed windows (my builds/experiments) listed in baseline/NOTES.txt. Needs a clean rerun.
- profile/attach-early.trace (+tp.xml): Time Profiler attached during chunks ~5-8.
  mean running threads 0.89 on 12 cores; exchange 80% self, Clip::at 17% self; drag_on 98% inclusive.
- profile/launch-1to5.trace (+tp2.xml), symbolized build (wt-exp profile.profiling debug=1):
  line-level: plough block bristle.rs:1357-1408 ≈40%, Clip::at (not inlined) 17%, pass-1 weights ~10%.
- debug/dump-1to5.txt + dag.py + retile.py: per-stroke rects and secs, chunk 5.
  broad pass 698 strokes 3x3 tiles: measured parallelism 1.10x; exact stroke-level DAG max 1.3x;
  even ideal overlap-only DAG (bbox footprints, random order) max 3.3x; blend pass 1.0x -> 1.9x max.
  fill pass (7x6 tiles): 4.0x measured, 5.6x possible.
- A/B (wt-exp): #[inline(always)] on Clip::at + hoist plough loads → chunk 5: 69/70 s vs base 91/128 s
  (noisy, background jobs running). PNG bit-identical to HEAD build. Needs clean rerun.
- probes: all 5 harness witnesses + all 5 runner/gallery witnesses reproduce on actual checkouts.

## Findings so far

1. 97% of replay CPU is bristle::exchange (drag_on). Everything the review lists as P02/P04/P05/P06/P10/P12
   (snapshots, fill scan, contact cache, path prep, persistence, checkpoint) is ≤2% combined in these chunks.
2. The pass is effectively serial: tiles sized 2×(largest stroke reach) → 3x3 or 2x3 grids for broad/blend;
   adjacent tiles overlap; one brush per tile → chains. Not fixable exactly; ceiling ~1.3x exact.
3. Exact per-pixel wins exist: Clip::at not inlined; plough loop reloads invariants. ≥1.3x on chunk 5.
4. Parallelism for NEW paintings needs a versioned change (engine 3): brush-tile size decoupled from reach,
   stroke-level DAG with tighter footprints, parallel-friendly order. Ceiling with bbox footprints ~3x on broad;
   tighter footprints (per-segment) should raise it.
5. Memory: 36 GiB installed. Watercolor 600-700 MB estimates are a non-issue on this machine.
6. Stale daemon: [local path redacted] serve wet, pid 22778, up 1d13h.

## Pending
- attach-c90.trace: profile of chunks 88-90 (tail case).
- dump-full: per-pass structure of the whole c766c5 painting.
- clean baseline rerun; clean A/B of inline1.
- live-vs-replay overhead measurement (easel open/do).
- corpus golden PNGs at HEAD (12 h) before any exact optimization lands.

## Update (after reviewer follow-up, ~15:30 UTC)

- Reviewer trap A (cure hoist) CONFIRMED in source (bristle.rs:615-620 take() zeroes cure; :1401 re-read per target). Experiment corrected: only lat/hide hoisted.
- Reviewer trap B (rolling-sum box blur) CONFIRMED (surface.rs:163-173, 181-187). Exact localization limited to the median passes.
- Clean A/B (debug/clean-ab.log, idle machine, paired): HEAD 50.35/53.43 s vs inline2 41.36/44.13 s on chunk 5 → 1.21x. PNG identical.
  => clean HEAD chunk 5 ≈ 52 s; the 75.5 s in baseline/ was perturbed. All baseline/ timings are perturbed; golden/ is the clean run.
- Instrumentation-only binary easel.golden (HEAD + --state-digest + Held: Debug; wt-exp-golden.patch) sha 974abe90…
  golden PNG == HEAD PNG on chunks 1-5; inline2 per-chunk canvas-state digests == golden (debug/golden-1to5.digest vs inline2-1to5.digest).
- Full experimental diff saved: wt-exp-experiments.patch (PAINT_DUMP instrumentation + inline2 kernel changes + profiling profile).
- Corpus scope: 38 studio logs = 4321 chunks (paintings, tier 1). 59 committed .lua = notes/lab etc., 625 chunks (tier 2).
- Overnight tier-1 run launched detached (nohup) at 15:29 UTC: golden/run_corpus.sh, MANIFEST.txt, progress.log; per studio: painting.png, surface.f32, digest.txt, run.log (time -l).
- Killed orphaned delivery-test daemon pid 22778 (session 'wet', target/tmp/dl-22775, ppid 1). Left alone: studio daemons 11997b, 919cfd and one under [local path redacted]
- Reviewer follow-up zip: followup/ (addendum, source excerpts, arithmetic controls). Consistent with my source checks.

## RESUME HERE (for the next session)

Scratch dir: [local path redacted] (reuse it; don't make a new one)
Decisions made by [local account redacted] (2026-09-30): engine 3 for new paintings = YES; overnight goldens = YES; no prod code was written.
No changes in [local path redacted] (HEAD 4ec3169, clean). All experiments live in wt-exp/ (git worktree, detached; remove with `git worktree remove` when done).

Running detached (nohup, survives session end): golden/run_corpus.sh — tier-1 goldens of the 38 studio logs.
  Progress: golden/progress.log. Per studio: golden/<studio>/{painting.png,surface.f32,digest.txt,run.log,stdout.txt,done}.
  Idempotent: rerun the script to resume if it died. Binary: wt-exp/target/release/easel.golden (instrumentation-only).
  Tier 2 (not started): the 59 committed .lua logs under notes/ (625 chunks), same command.

Key files:
  COMMS_BRIEF.md, NOTES.md (this), paint-review-deliverables/ (review 1), followup/ (review 2 addendum + controls)
  baseline/c766c5-run.log (perturbed timings), profile/tp*.xml + tp_summary.py, debug/dag.py retile.py passes.py, debug/dump-full.txt
  debug/clean-ab.log (1.21x, PNG identical), debug/golden-1to5.digest == debug/inline2-1to5.digest
  wt-exp-experiments.patch (PAINT_DUMP instrumentation + inline2 kernel changes), wt-exp-golden.patch (digest only)

Plan (no dates): 0 receipts → 1 small reproduced bugs (+N4, N11, unknown-outcome, single-writer lock) → 2 exact kernel (time-boxed; port the two arithmetic controls to native tests) → 3 engine 3 (hand-order/timing rule first, serial reference, then parallel scheduler) ∥ panel → watercolor spike.
First action next session: check golden/progress.log, then start stage 1 on a branch, smallest PRs first.

## Stage 1 decisions ([local account redacted], 2026-09-30)
- N8 follow-up: YES, easel reports its clock in structured form (e.g. `easel status --json`); harness reads that instead of parsing text. Queue after the easel lane.
- N12 follow-up: YES to the ledger's structured record format; declare record inheritance an intentional non-neutral experimental condition; maybe an LLM transcript check later.
- N9 brief cap: pending; largest studio BRIEF.md is 2,911 bytes vs the 60,000-char cap.
- N14 fatal errors: pending; recommendation: stop at once on auth/config errors (401/403, bad model id), retry the rest every 30 min up to 24 h.
- (later) N18: add "renders outside out/ are diagnostics" rule. N12: pattern gate warns + passes (flags file), structured record format to be designed (lane-record-design/DESIGN.md). N14: stop at once on auth/billing/unknown-model/malformed-request probe errors; retry outages/timeouts/5xx/529; usage limit keeps waiting.
- Merge order stillwet: fix/R23-encoder-failure (contains N17/N18/N19), then fix/R20-R21-kernel-lock, then fix/R16-owned-dist.
- N18/N19 scope ([local account redacted]): the old harness (painter ran render binaries via bash + peek) is de facto archived: legacy sessions must film exactly as on main. New selection rules apply only to current `look`-tool sessions. The out/ rule goes.
- Structured records ([local account redacted]): 1 drop prescription/placement observations, but be smart (precise, low false positives; ambiguous -> warn); 2 keep not telling the painter notes are inherited; 3 keep tube-name-only mixing observations.
- Queued ([local account redacted] OK): after golden run, replay the 38 logs with merged easel-lane binary and compare per-chunk digests to goldens.
- Runner scope correction ([local account redacted]): round 19 runner is archived; do NOT merge fix/N11, fix/N12, fix/N14 or feat/records-* (they edit notes/round19). Next round = r21; its runner (only copy: [local path redacted] = r20 + lines 80-82) is imported as notes/round21/runner and fixes are ported there (lane-r21). Harness fixes (harness/painter) are fine: r21 checks out tag round-21, not yet cut.
- [local account redacted]: "we really need a better system" for runners (rounds' runners live outside git, drift). Revisit after stage 1.
- N5 ([local account redacted]): run to completion on client loss; keep receipts for the whole session; outcome query harness-only.
- 2026-09-30T19:04:48Z golden driver (run_corpus.sh) stopped for the r21 stream; the in-flight log finishes on its own; rerun golden/run_corpus.sh to resume (skips done).
