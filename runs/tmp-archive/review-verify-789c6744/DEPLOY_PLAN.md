## STATUS (updated)
- All 7 fix branches merged into fix/integrate (worktree [local path redacted] no conflicts.
- All suites pass there: cargo workspace (paint 167, easel 44, ...), harness 28/1 skipped, runner 25, studio 6, clips ok.
- Engine fixes gated by `--@ engine 2` in new logs (Alice: no per-round branches; old logs replay as engine 1).
- Past-painting sweep running (bg task 'sweep'): old=08f6324 easel vs new=integrate easel on 38 paint-studio-*/paintings/lua/painting.lua
  -> [local path redacted] ("<studio> <old md5|FAIL> <new md5|FAIL>").
- Next: if sweep identical -> fast-forward main to fix/integrate, push, kickstart viewers, sync by hand, deploy dry-run, deploy.
- Morning report items: branches->tags plan (tag round-19/round-20, point r19 runner at main/tag); rebuild cost after failed chunks;
  6 historical logs don't replay on current main (obsolete canvas{style=}) - pre-existing; reader gate untested live; human-approval option.

# Overnight plan (Alice asleep: "once all fixed please commit push deploy")

Branches (worktrees under [local path redacted] fix/harness (done, verified), fix/runner (done, verified),
fix/easel-replay, fix/easel-limits, fix/engine, fix/studio, fix/clips (running).

1. When each fixer finishes: review diff, run its tests.
2. fix/studio: MUST adopt the existing export folder [local path redacted] (no marker yet), or
   sync-studio.sh (launchd, every minute, runs ../claude-paint/studio/export_static.py dist/studio from the MAIN checkout)
   and stillwet/deploy.sh break. Resume the fixer with that instruction if it doesn't handle it.
3. Merge all fix/* into main in [local path redacted] resolve conflicts; cargo test --workspace, harness node
   tests, runner pytest, studio tests, clip tests.
4. git push origin main.
5. Restart live viewers so they load the new studio.py:
   launchctl kickstart -k gui/$(id -u)/art.stillwet.studio.public ; ...studio.tailnet
6. Run one sync by hand (stillwet/sync-studio.sh) and check the log; then stillwet/deploy.sh --dry-run, then ./deploy.sh.
   Check https://stillwet.art/studio/ answers 200.
3b. REPLAY SWEEP (Alice: "it depends if it breaks past paintings"; new runs will be r21): build the easel (replay build,
   default features) at 08f6324 and at the merged tip; replay every [local path redacted] with
   both; compare PNGs pixel-exact. A fix that changes any past painting (or rejects code it used) does NOT go to main:
   main = replay-identical fixes only; r21-base = main + painting-changing fixes (push it, report which paintings changed
   and how much). Likely painting-changing: engine drying sync, world far-thin-body depth, reflections.
7. Do NOT move r19-base / r20-base (painter experiment bases): painters' easels and harness come from r19-base
   (r19_chains.py:76-78, 747). Tell Alice the fixes reach painters only when she moves a base branch.
## DONE 2026-09-30 10:18: main 661c757 pushed (+tags round-19, round-20); viewers restarted; sync adopted dist/studio; stillwet deployed (live).

## Next (Alice, 2026-09-30): Space Bunny paints a Hopper, AFTER fixes
- Wait for fix-globals, fix-oldlogs, prep-archive; review; merge into main; tests; push.
- Tag round-21 at that main; detached worktree [local path redacted] at round-21 (no branch).
- Copy [local path redacted] (without run/) to [local path redacted] set BASE=claude-paint-r21, BRANCH="round-21".
- `uv run r20_chains.py --dry --only NEW` first; then nohup:
  NEW_PROVIDER=opencode-go NEW_MODEL=space-bunny-free NEW_THINKING=max uv run r20_chains.py --only NEW > run/new-hopper-space-bunny.out
  (space-bunny thinking map goes to max: r19_chains.py BUN lane comment.)
