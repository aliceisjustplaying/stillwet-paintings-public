# Easel limits validation

Worktree: [local path redacted]
Branch: fix/easel-limits

- 29b3dbf: outline generation has a progress check and hard knot cap; Lua rejects size below 1 unit and positive lobe below 0.5 units. Tests: tiny_lobes_and_facets_end and tiny_lobes_and_sizes_are_refused. Engine regression hung before the engine fix under a 20-second timeout; binding regression failed before its validation checks while the engine fix remained installed. Both passed after repair.
- 6524da8: grid rendering rejects spacing below one output pixel and uses integer counters. Test: grids_finer_than_a_pixel_are_refused. Original implementation plus regression timed out with exit 124 at 60 seconds; repaired implementation passed all five look tests.
- dc6c43c: math.random validates integral bounds and empty intervals, supports random(0) and wide intervals with overflow-safe arithmetic and rejection sampling, preserves the old f32 formula for intervals up to 2^24 wide. Test: math_random_keeps_old_draws_and_refuses_empty_ranges. Golden sequence captured from unchanged implementation: 4 4 3 2 2 3 85 32 34 0 3 0.080516815. Regression failed before repair because random(5,1) returned success; passes after repair.

cargo test --workspace exited 0 after disk space recovery: 220 passed, 14 ignored, 0 failed. Full output: workspace-resumed.log. Earlier interrupted run failed an integration test while the machine was out of disk space.

Old-vs-new replay comparison used the verification binary from 08f6324 and the release build in this worktree, with 1800-second timeouts on every replay. Four supported painting logs (replay_list.txt entries 1, 2, 5 and 10) successfully replayed with both binaries and have byte-identical PNGs. The other six historical logs failed identically on obsolete canvas style/hand options before reaching painting code. Three paths disappeared during cleanup; these were retried using notes/amnesia{3,4} copies in the assigned worktree and failed identically on canvas style. No supported painting output changed in these comparisons. No goldens regenerated.

Detailed per-replay output and PNGs: replay/1-{old,new}.log through replay/10-{old,new}.log; retry logs: replay/easel{3_free,3_near,4_free}-{old,new}.log. Misleading 'png DIFFERS' lines from the shell script for failed replays mean PNGs were absent, not differing rendered output.

No files outside the assigned source areas edited. Git worktree clean after commits. No unresolved fix decisions; six old-format logs could not be used as rendered-output comparisons.
