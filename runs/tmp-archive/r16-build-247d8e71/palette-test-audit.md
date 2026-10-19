Scope: crates/paint/src/palette.rs and wet.rs only.
History: fdfb0ff imports the original engine; f933116 adds explicit piles and tube drying. Automatic matching intentionally removed by task, not behavior-preserving cleanup.
Deletion candidates (all palette.rs unless noted):
- smooth_targets_make_no_seams: asserts search recipe continuity; callers handling/stipple, now being removed by sibling agents. No remaining matching contract. Unlocks ramp_steps/blue_ramp.
- probe_contrast_aims: ignored assertion-free search diagnostic; same callers/history; no remaining contract.
- contrasting_aims_stay_in_family: asserts search hue constraints; same callers/history; obsolete with solver.
- aim_hits_reachable_targets: asserts search accuracy/cache consistency; same callers/history; obsolete with solver/cache.
- tint_round_trips_over_white: inverse tint/aim accuracy; Paint tint/glaze/aimed intentionally removed, no remaining contract.
- matched_marks_disappear: tests Canvas::aim mark matching; removed API, not explicit paint physics. Unlocks graded_field and dab fixtures (only internal callers).
- greens_are_mixed_closer: tests optimizer superiority of expanded palette, no remaining optimizer. Tube-box inventory retained separately.
- wet.rs::aimed_reaches_targets_made_by_the_same_model: inverse solver roundtrip, obsolete with aimed/tint/glaze/solve removal.
Migration candidates:
- glazes_stay_glazes: retain forward glaze physics using explicit tube piles, remove unreachable-target optimization checks and old Handling.color pipeline.
- mixture_to_paint_preserves_scattering: retain scattering transport (including brush deposition) with prescribed proportions, not searched target colors.
Remaining proof: explicit pile drying test, tube inventory, scattering preservation/deposition, forward thin-film glaze physics, all wet film tests. Removal API doctests own distinct external compile contracts, no production test seams. Baseline all nine compile-fail tests failed because snippets compile successfully, palette-api-red.log.
Risks: downstream compile failures until sibling matching callers and Marks re-export migrate; final cargo test -p paint --doc and cargo test -p paint --lib, plus git diff --check.

Validation completed in the shared checkout:
- cargo test -p paint --doc: 9 API doctests pass (4 unrelated ignored). palette-shared-final-doc.log.
- cargo test -p paint --lib palette::: 4 pass. palette-shared-final-physical.log.
- cargo test -p paint --lib wet::: 3 pass. palette-shared-final-wet.log.
- cargo test -p paint --lib: 159 pass, 1 fails, 7 ignored. Failure tests::fixture_matches_golden at tests.rs:150 (actual bd44205f7017f77e vs expected e669ea7957b9f84d). Outside ownership; not updated. palette-full-lib.log.
- git diff --check scoped to both owned files: passes.
- Manual owner review: explicit pile eval, remix normalization, Mixture paint/laid, wet deposition and forward KM unchanged except removing Mixture.error. judge_under and weighted_median retained as observation, not target matching. No aliases or replacement solver left. No autoreview skill available in this runtime; performed manual diff review.
- Net LOC: palette production/docs -281, tests -260; wet production/docs -34, tests -24 (split at first cfg(test)).
- No commits. Initial stale lib.rs Marks/Aim re-exports were resolved by concurrent owners; shared focused checks now compile and pass.
