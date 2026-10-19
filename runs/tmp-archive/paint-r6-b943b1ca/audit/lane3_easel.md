# Lane 3 audit: easel and paintings

Scope: `crates/easel` (45 unit tests in `src/*`, `tests/hand_time.rs` with 5 tests, `tests/determinism.rs` with 1) and `paintings/src` (7 tests in `run.rs`, 3 in `run/source.rs`). Checkout `[local path redacted] at `9e7dc94`. Read-only: `git status` is clean.

## Baseline

All 61 tests pass on main, so no product bugs came up:

- `cargo test --release -p easel`: 45 + 1 + 5 passed.
- `cargo test --release -p paintings --lib`: 10 passed.
- Default test profile, `cargo test -p easel --test hand_time existing_logs_replay_unchanged`: passed. The debug branch uses the same hash as the release branch.

Timings for single hand_time tests, `--release`, run alone on a shared machine:

| Test | Time |
|---|---|
| `existing_logs_replay_unchanged` | 125 s |
| `a_strict_log_is_deterministic` | 7 s |
| `hand_time_is_the_same_at_any_thread_count` | 5 s |
| `an_old_overrunning_log_replays_unchanged` | 2 s |
| `a_strict_log_is_held_to_its_sittings_on_replay` | 1 s |

Common validation prefix (the numbered validation lines below assume it):
`export TMPDIR=[local path redacted] export TMP=$TMPDIR TEMP=$TMPDIR CARGO_TARGET_DIR=$TMPDIR/target-lane3; timeout 600 ...`

## Candidates

### 1. Merge `hand_time_is_the_same_at_any_thread_count` into `a_strict_log_is_deterministic` (high confidence)

- **Where:** `crates/easel/tests/hand_time.rs:86` (merge target at `:139`).
- **What it can detect:**
  - hand-time slicing that depends on thread count (same printout and PNG at 1 and 4 threads);
  - the sky taking more than one slice (`sky > 15.0`);
  - `rest(3)` starting sitting 2.
- **Non-test callers of the seam:** `easel run`, the real CLI, spawned as a subprocess. The shared seam is `time::verb` and `flush`.
- **Stronger remaining proof:** `a_strict_log_is_deterministic` replays the same `PROGRAM` with only `sitting{hours=..}` added (`PROGRAM.replace("hand=true}", "hand=true}; sitting{hours=1.5}")...`). It runs at 1, 4 and 4 threads and asserts that printouts and PNGs are equal and that the output holds `sitting 2`. The strict path only adds `at_easel` refusals, which never fire in that program, so it paints through the same slicing code. The one unique assertion (`sky > 15.0`) moves over as is.
- **History:** added by `c486929` ("thread counts"). The strict twin came later in `cffbc16` as a copy of `PROGRAM` for the strict header.
- **Deletion unlocked:** one test and two subprocess replays (about 5 s). No production code.
- **Risk:** low. The non-strict hand-time slicing would then be checked for thread determinism only through a strict log. The two share `verb`/`flush`, and strictness only gates `at_easel`.
- **Validation:** `cargo test --release -p easel --test hand_time a_strict_log_is_deterministic`

### 2. Rewrite `existing_logs_replay_unchanged` (medium confidence; owner call on the l5_near case)

- **Where:** `crates/easel/tests/hand_time.rs:50`.
- **What it can detect:** any pixel change in the 160px replay of `paintings/lua/example.lua` in both profiles, and of `notes/loops/l5_near.lua` in release only. In practice it is a pixel tripwire for the whole engine plus the Lua API.
- **Why it's suspect:**
  - The expected values come from the renderer under test: copied FNV hashes of a run.
  - The name and doc promise more than the test shows ("replay byte for byte as they did before hand time existed"). `git log -L` shows five re-records after it was added: `fc5e9f6` (relief default), `b8b2598` (varnish settle), `2c1a8c0` (clip= fix), `5e63e1b` (blunt tips) and `3e2c6ca` (glaze floor). Every hash change was intended and re-recorded. The doc is now a changelog.
  - The contract it names ("hand time off leaves logs unchanged") is owned in-process by `time::tests::hand_time_off_takes_no_time_and_changes_nothing` (`crates/easel/src/time.rs:441`). That test asserts equal bits with and without `hand_time(false)` and clock 0.
  - When the l5_near hash moved for the clip= fix, the bug's contract got its own regression, `draw_edges::tests::edges_lose_and_the_clip_mask`, and the hash was just re-recorded.
- **Non-test callers:** `easel run`. Nothing else replays `example.lua`, which is the README's worked example (`crates/easel/README.md:34`).
- **Stronger remaining proof:** the engine-level refactor tripwire is `paint::tests::scene_matches_golden` (`crates/paint/src/tests.rs:138`). Hand-time-off is covered by the test above, and cross-thread and cross-process determinism by candidate 1's target and `tests/determinism.rs`. The only unique coverage left is "example.lua still runs through the Lua API, pixel-exact".
- **Proposed action:**
  - Keep the example.lua case as the single end-to-end replay tripwire.
  - Rename it (for example `example_log_replays_as_recorded`) and replace the changelog doc with one line saying it is a deliberate tripwire, re-recorded on intended changes.
  - Move the l5_near release-only case out of the default run (delete, or `#[ignore]` as a benchmark). It is the slowest test in the lane (125 s alone under load), plain `cargo test` never runs it (`cfg!(debug_assertions)`), and it was re-recorded three of five times.
- **Deletion unlocked:** about 20 lines of doc and the l5_near replay. No production code.
- **Risk:** medium. The project uses byte-identical replay as refactor proof (`notes/workflow.md:465`, Cargo.toml `[profile.release]` comment), so Alice may want l5_near kept as an opt-in check. Don't delete without her call.
- **Validation:** `cargo test -p easel --test hand_time existing_logs` and `cargo test --release -p easel --test hand_time existing_logs`

### 3. Rewrite `an_old_overrunning_log_replays_unchanged` without its PNG hash (medium confidence)

- **Where:** `crates/easel/tests/hand_time.rs:107`.
- **What it can detect:**
  - The printout: a legacy (non-strict) log is not refused, overruns are only reported, and there are three sittings with their clock values. This is the real, independent contract, described in the module docs (`time.rs`: "In a log from before, an overrun is only reported").
  - The PNG hash `0x7758_7315_17fd_5b9a`: any pixel change, the same tripwire as candidate 2.
- **Evidence:** the doc says the hash was "recorded with the easel of commit 82fd8fb" (`:104`). It was re-recorded in `5e63e1b` (blunt tips, not a sittings change), and its printout did not change then. So the hash fires on brush physics and says nothing about sittings.
- **Non-test callers:** `easel run`, and `program_is_strict` in `main.rs::run`.
- **Stronger remaining proof:** candidate 2's tripwire (and `scene_matches_golden`) cover pixels. The printout assertion stays.
- **Proposed action:** drop the `fnv(&png)` assertion and fix the stale commit reference. Keep the printout, including its exact clock strings: they document the legacy timing.
- **Deletion unlocked:** one golden hash to re-record per engine change (there are four today: `golden_scene.txt`, example, l5_near and overran).
- **Risk:** low.
- **Validation:** `cargo test --release -p easel --test hand_time an_old_overrunning`

### 4. Rename or fold `soft_shadow_masks_have_no_rings` (high confidence on the defect; action is small)

- **Where:** `crates/easel/src/depth.rs:427`.
- **What it can detect:** only that `v:cast_shadow{soft=2}` returns a mask with `area() > 100`, that `v:contact_shadow{reach=0.5, from=stone}` is 0 at one sky point and above 0.1 at one point beside the stone, and that both bindings parse their options.
- **Why it's suspect:** the name promises more than the test checks. The soft cast shadow `sh` is never checked for rings or falloff. The "no ring" comment covers one sample of the contact shadow.
- **Non-test callers:** the Lua methods `cast_shadow` and `contact_shadow` (`depth.rs:214` and `:228`), used by `paintings/lua/depth.lua`.
- **Stronger remaining proof:** the engine owns the ring and falloff contract in `paint::scene::tests::soft_shadows_fall_off_without_rings` (`crates/paint/src/scene.rs:1847`). It checks penumbra widening with distance and with `soft`, plus a monotone, step-free contact profile.
- **History:** added with the whole depth API in `0a9e997`, one day after the engine test (`ef2a9d4`).
- **Proposed action:** rename it to what it guards (for example `shadow_verbs_take_their_options`), or fold its four asserts into `passes_keep_behind_what_is_in_front` (`:343`), which already builds the same `SETUP` world. No ring claim at the binding layer.
- **Deletion unlocked:** one session setup if folded. No production code.
- **Risk:** very low.
- **Validation:** `cargo test --release -p easel depth::`

### 5. Merge `drying_for_a_finish_is_not_time_at_the_easel` into `queries_after_a_finish_consume_its_drying_once` (medium confidence)

- **Where:** `crates/easel/src/time.rs:538` (merge target at `:511`).
- **What it can detect:**
  - After `varnish()`, the drying is reported and never reported as an overrun (`!out.contains("at the easel")`).
  - `sittings == 2`.
  - The new sitting is 0 with hand time off, and between 0 and 2 minutes with it on.
- **Negative control check:** I replayed the same log with hand time on (scratch `lane3/varnish.lua`). The varnish waits "5.6 days" (clock 14.76 goes to 8114.35 min, sitting 1.15 min), so drying counted as easel time would print an overrun. The control is real, not vacuous.
- **Overlap:**
  - The merge target loops the same `for on in [false, true]` over the same canvas, `work` and `varnish()` setup (it adds `coverage=4`). It already asserts `sittings == 2`, a single `varnish: waited` and `sitting >= 0`.
  - `varnish_is_hand_time_after_the_rest` (`:554`) pins the hand-on sitting exactly to the varnish's brushing.
  - Unique left over: "no overrun line" and "sitting == 0 with hand time off".
- **Non-test callers:** `time::verb` with `Verb::Jump { rest: IfPainted, .. }` from `varnish`.
- **History:** added in `d3e35c6` (drying not hand time). The merge target is from `7b79afb` (review r6 finding 2), both on 2026-09-24, one after the other.
- **Proposed action:** add the two unique assertions to the merge target and delete this test.
- **Deletion unlocked:** one test (three sessions).
- **Risk:** low.
- **Validation:** `cargo test --release -p easel time::`

### 6. Merge `undone_entries_round_trip_whatever_the_code_holds` into `undone_code_round_trips_marker_like_lines` (low-medium confidence)

- **Where:** `crates/easel/src/edit.rs:244` (merge target at `crates/easel/src/main.rs:569`).
- **Why it's suspect:** a private parser (`undone_entry` and `parse_undone`) is tested separately for the same finding that the server-boundary test owns. Both were added in the same commit, `b913cf0` ("review 4 session #1").
  - The first two cases (a long string or a comment holding `--@ undone` header look-alikes) repeat the server test's chunk.
  - The server test also covers `undo` → `undone K` → `redo` → `edit --undone`.
  - Of the rest: the unicode case is reachable in production. The trailing-blank-lines case is not: `Session::run` trims (`let src = src.trim_end()`), and `splice` inserts go through `run`, so archived code never ends in blank lines.
- **Non-test callers:** `keep_undone` (from the `undo` handler in `main.rs` and `edit` in `edit.rs`) and `undone_entries`.
- **Proposed action:** add the unicode and `[==[ .. ]==]` blank-line cases to the server test's chunk, then delete the edit.rs round-trip test. Keep `old_undone_files_still_read` (`edit.rs:267`): it has a distinct legacy-format contract.
- **Risk:** low. The only loss is the unreachable trailing-blank case.
- **Validation:** `cargo test --release -p easel undone`

## Test hygiene finding (not a value candidate, high confidence)

`cffbc16` (Sittings enforced) committed 10 scratch files from `paintings/src/run.rs` tests:

- `paintings/run_early_43085/p.rs`
- `paintings/run_keep_test_43085/*.ckpt`
- `paintings/run_names_43085/*` (including a PNG)
- `paintings/run_refresh_43085/*.ckpt`

The scratch base is `std::env::var_os("TMPDIR").map(PathBuf::from).unwrap_or_else(|| root().join("target"))` (`run.rs:742`, `:785`). An empty or relative `TMPDIR` resolves against the package directory. The code is also duplicated inline in `last_stage_keeps_its_state` rather than calling `scratch()`.

Proposed action: `git rm` those four directories and make one `scratch()` helper fall back to `root().join("target")` unless `TMPDIR` is absolute. Relatedly, the look tests write to the hard-coded `root().join("target/easel-look-test")` (`look.rs`), ignoring `CARGO_TARGET_DIR`.

## Retained false positives (looked suspect, still valuable)

- `session.rs` `Session::checkpoints()` is a `#[cfg(test)]` accessor (`session.rs:222-225`), used only by `edit_a_chunk_in_place_from_a_checkpoint`. It guards the documented memory bound (about 50 MB per checkpoint, `edit::CHECKPOINTS`), which pixels can't observe. Keep.
- `run.rs` `die` and `stop_here` switch to panics under `cfg!(test)` (`run.rs:189`, `:198`). This hook lets the stage and checkpoint CLI be tested in-process instead of through subprocesses. Keep.
- `undo_restores_canvas_and_brush` has a list of 14 verb names ("no module shadows another"). It is an inventory, but a regression for a real shadowing bug (`9ed3790`: terrain renamed because it shadowed `relief()`). Keep.
- `the_clock_advances_by_the_hand_time_of_known_verbs` computes its expected value from `paint::tally::pace` and `stroke_secs`. The easel's contract is putting the engine's price on the clock, not the price itself, so this is the right oracle.
- `dropping_a_leading_twig_keeps_the_limb_end_a_tip` calls the private `plan_stroke` directly. It is a test-first regression (`decd006`), and tip pressure can't be read cheaply from pixels. Keep.
- The structure-tool tests (`a_fir_grows_into_a_drawn_outline`, `a_rock_grows_from_a_drawn_outline`, `an_oak_grows_into_a_drawn_crown`, `a_group_and_errors`, `a_wood_has_rows_and_masks`) mostly assert `area() > 0`. They are the only owners of the Lua binding surface (option parsing, method existence, error text naming valid choices). The engine owns the growth itself.
- `object_keyed_tables_replay_the_same_in_every_process` (determinism.rs) overlaps with `object_keys_walk_in_creation_order`. But ASLR across processes is a distinct risk that the in-process heap-padding trick can't fully reach. Keep.
- The session rollback tests (`replay_is_exact_and_failures_roll_back`, `rollback_restores_tables_and_upvalues_exactly`, `live_session_without_undo_still_rolls_back`, `gmatch_iterators_roll_back`) overlap in shape, but each pins a separate review finding (undo depth 0, upvalues and metatables, gmatch state). Keep.
- The look tests' exact JPEG sizes (`(1120, 749)`, `(1040, 936)`) are asserted numbers, but their messages derive them from the documented enlargement rule. Keep.
- The `paintings/src/run.rs` tests (`stage_fingerprint_model`, `stale_ok_refreshes_with_ckpt`, `stop_and_resume_names` and the rest) are all behavioral CLI and staleness-model contracts, each tied to a painter-reported issue (mountains #4/#5/#18, winter #2/#20, coast #19). No candidates there.

## Summary

- **Merges:** 3 (candidates 1, 5 and 6).
- **Rewrites:** 3 (candidates 2 and 3 drop copied golden hashes and stale docs; candidate 4 fixes a name that promises more than it checks).
- **Hygiene:** 1 (10 committed scratch files).
- **Totals:** no deletions of production code and no failing tests.
