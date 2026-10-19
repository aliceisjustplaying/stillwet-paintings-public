# Test audit: implement the approved batch

Worktree: [local path redacted] (branch test-audit, from main).
Work only there; commit in small coherent commits; do not push, do not
merge. Scratch: export TMPDIR=TMP=TEMP=[local path redacted]
Other agents share the machine: wrap cargo in `timeout`.

Method: [local path redacted] (test-audit
skill; its "Edit shape" and "Validation" apply; validation here = cargo).
Evidence for every item (read the relevant section before editing):
lane1_core.md, lane2_motifs.md, lane3_easel.md, lane4_cross.md in
[local path redacted]

Approved by Alice, do exactly these:
1. `git rm` the committed test scratch dirs paintings/run_*_43085/ and fix
   the cause in paintings/src/run.rs: one `scratch()` helper used by all
   tests (including `last_stage_keeps_its_state`), falling back to
   root()/target unless TMPDIR is an absolute path (lane 3, hygiene).
2. draw_outline.rs:237: call `o.o.is_open()` instead of the inline copy
   (lane 4 #1). Keep both tests.
3. Move `tests::strokes_bow_unless_ruled` into `handling::tests`, calling
   `hand_trace` directly; delete `hand_trace_for_test` (lane 1 #2 / lane 4 #2).
4. Replace `#[cfg(test)] Session::checkpoints` with a direct field read in
   its one test; keep the `cp.len() <= 4` assertion (lane 4 #3).
5. Delete `the_coil_has_a_nan_point`; fix the stale module doc and
   notes/workflow.md:451-453 (lane 1 #1).
6. Merge `crack::tests::crop_origin_doesnt_move_the_local_field` into
   `crop_cracks_like_the_whole`, keeping its history comment and making the
   end-to-end crop not start on a cell boundary (lane 2 #1). Move the
   `#[cfg(test)] crack::raster` wrapper into the tests module (lane 2/4).
7. Delete the equal-heights block in
   `outline::tests::lobes_are_continuous_at_joins_and_the_seam` (lane 2 #3).
8. Merge `hand_time_is_the_same_at_any_thread_count` into
   `a_strict_log_is_deterministic` (move `sky > 15.0`) (lane 3 #1). Merge
   `drying_for_a_finish_is_not_time_at_the_easel` into
   `queries_after_a_finish_consume_its_drying_once` (its two unique
   assertions) (lane 3 #5).
9. Rename `depth::tests::soft_shadow_masks_have_no_rings` to what it
   checks (lane 3 #4); drop the two no-op `let _ =` lines (atmos.rs:1549,
   scene.rs:1837); fix the stale comment at outline.rs:1405.
10. `existing_logs_replay_unchanged`: keep the example.lua case in the
    default run, renamed (e.g. `example_log_replays_as_recorded`) with a
    one-line doc (a deliberate tripwire, re-recorded on intended changes);
    move the l5_near case into its own `#[ignore]` opt-in test with a doc
    line saying how to run it. Check any notes that cite the old name.
11. `an_old_overrunning_log_replays_unchanged`: drop the PNG hash
    assertion; keep the printout; fix the stale commit reference.
12. Delete `Worley::f1_3` (production and its tests' uses; keep the rest
    of the worley test); update notes/atmosphere.md:32.
13. Delete the ignored probes `probe_patch` (bristle.rs) and
    `probe_laid_thickness` (wet.rs), and any helper only they use.

Not approved (leave): edit.rs undone merge; rock grisaille; everything
under "retained".

Before finishing: a regression-style check for items that merged tests:
show (briefly, in scratch) that the merged test still fails when the
behavior it absorbed breaks, at least for #6 and #8. Then
`cargo test --workspace`, `cargo test --release -p easel --test hand_time`
(and once with `-- --ignored` for the new opt-in l5_near test), clippy
clean, `git diff --check`. Report `git diff --numstat main` split into
production vs tests.

Final reply: per item done/skipped (with why), test results, LOC split,
commits. US English, no Oxford comma. Never write the user's real name or
an absolute home path into committed files; the user is "Alice".
