Paint removal audit

Scope: crates/paint except canvas.rs. Other owners edit easel and canvas.

Deletion candidate: src/tests.rs::palette_mixes_what_it_can. Detects inverse-search gamut fit, normalization and determinism. Production callers were Handling mixed presets and Stipple mixed paths, all explicitly requested removed. No remaining search proof needed because matching is removed, not refactored. Explicit pile mixing/drying contracts remain owned by palette tests. History: fdfb0ff imported engine and f933116 added explicit hand piles. Deletion unlocks removal of Palette::mix/error; risk is accidentally losing physical mixing coverage, controlled by remaining palette/spectral/wet tests. Validation cargo test -p paint.

Fixture migration: tests.rs fixture retains rendering fingerprint and cross-thread determinism contracts; upper passage becomes explicit lead-white/cobalt-blue proportions, no target search. Regenerate golden only after recording intended mismatch. Ground-grain diagnostic/ignored comparison becomes explicit lead-white/bone-black pile at original medium. Existing paint pipeline boundary remains, no test seams added.

Fill: handling owner adds test-first default-off behavioral regression. bristle loaded_passage_covers retains independent coverage/bare-ground contract and must explicitly request fill(true), with sparse/dry controls fill(false).

Communication brief: maintainer needs removal summary, evidence of focused tests, commit and downstream API consequences. Do not claim workspace validation. Cite source/test names and persisted logs. Keep concise; routine handoff self-review sufficient.

Final review cleanup: Canvas::judge_under and weighted_median in palette.rs had no remaining callers (only definitions/internal call across repository Rust); former Canvas::aim/stroke_under callers removed. Delete dead matching-support observation machinery; Canvas::under remains the general observation primitive. Reviewer independently identified this leftover.

Additional matching solver: spectral::fit_shape, solve3 and spectral::tests::fitted_shapes_hit_their_color. This explicit Newton solver modifies K/S until an RGB target is reached; it has no production callers, only its matching-contract test. History efa5748 introduced fitted masstone shapes for study section F; 7a7a570 introduced independent physical spectral module. Remove fitting algorithm/test, retain RGB basis conversion, spectral curve input, fixed mixtures and forward layering with their existing boundary tests. New external API compile-fail doc protects removal of fit_shape, would fail on restored method, no seam. Baseline failure captured in paint-spectral-api-red.log (snippet compiled successfully). Focus validation cargo test -p paint --doc and spectral::tests.

Final validation receipts:
- paint-suite-final.log: cargo test -p paint passes 159 unit tests, 2 curved-drag integration tests, 1 normal ground-grain test and 10 compile-fail API doctests; 7 unit/3 integration/4 example docs ignored. Includes concurrent canvas owner's local glaze regression, but canvas.rs not owned or committed here.
- paint-ground-grain-explicit-pile.log: explicitly ran changed ignored thin_blend_bares_ground; passed across three seeds (4775 parallel bare pixels vs 4145 style). Threshold unchanged. Removed stale old example counts from test documentation.
- paint-golden-before-update.log records expected explicit-pile migration mismatch; paint-golden-update.log records regeneration; final regular suite validates bd44205f7017f77e without UPDATE_GOLDEN.
- All ten owned Rust files parsed by rustfmt --emit stdout with skip_children=true; formatting output not applied wholesale to preserve existing compact style. Scoped git diff --check passed.
- Downstream easel api.rs:802 still calls sty.glaze(0.9); change to sty.glaze(). No other live easel references to removed matching methods found. No easel edits, no workspace checks.
- Physical false positives retained intentionally: spectral RGB basis conversion and CIE color matching functions are representations, not inverse recipe search; pigment scattering/appearance calibration are physical material formulas. Explicit weighted mixtures, remix jitter and forward spectral/KM layering remain. Canvas::under remains general observation; special matcher judge_under removed.

Commit: 725ca09 Remove engine color matching and make passage filling opt-in. Exactly 11 owned files; canvas.rs and all easel/notes changes excluded. No push.
LOC split (source/docs before test modules versus test modules/fixtures): production/docs +141 -889 (net -748); tests/fixtures +60 -627 (net -567). Total +201 -1516, net -1315. Test-only conditional imports at file tops counted with source/docs.
Independent read-only final review found no blockers after spectral solver and palette helper cleanup. Existing canvas glaze integration tests retained; no duplicate integration seam added.
