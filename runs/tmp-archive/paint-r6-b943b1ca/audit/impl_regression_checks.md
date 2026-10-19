# Regression checks for merged tests (items 6 and 8)

Mutants were applied in scratch copies (`mutants/`, from `git archive`), never in the worktree.

## #6 crop_cracks_like_the_whole (absorbed crop_origin_doesnt_move_the_local_field)
Log: mutants_crack.log
- orig: pass
- A (local-field grid anchored to the crop corner, both axes): FAIL "crop differs from whole by 0.025319844"
- B (x anchored to the canvas, y to the crop): FAIL "crop differs from whole by 0.015207469"
- New precondition assert: the crop's origin is not on a cell boundary (n = 3 px at 0.3 mm/px)

## #8a a_strict_log_is_deterministic (absorbed hand_time_is_the_same_at_any_thread_count)
Log: mutants_time.log
- threads (handling.rs slice length times rayon::current_num_threads): FAIL, printouts differ at 1 vs 4 threads
- handoff (set_hand_time always None): FAIL "a sky takes more than one slice: 0 min" (the moved assert)

## #8b queries_after_a_finish_consume_its_drying_once (absorbed drying_for_a_finish_is_not_time_at_the_easel)
Logs: mutants_time_drying.log, mutants_time_dryon.log
- drying (a rest's new sitting starts before the jump: s.hand.begin(now - jumped)):
  main: only the deleted test failed (t.sitting == 0, got 7539); merged: FAIL on the new hand-off `sitting == 0` assert
- dryon (the same mutation with hand time on only):
  main: only the deleted test failed ("5.6 days at the easel"); merged: FAIL on the new `!out.contains("at the easel")` assert
- (The first two mutants, overrun and sitting, in mutants_time.log targeted Rest::IfPainted and left s.clock alone. No test caught them on main or on the branch, so they were bad mutants: varnish uses Rest::IfLong.)
