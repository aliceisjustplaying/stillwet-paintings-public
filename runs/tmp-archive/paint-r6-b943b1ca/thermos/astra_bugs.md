(•̀ᴗ•́) Reviewed Round 6 main (`d5c53f0`) and r6-wet (`7a1340f`). Two medium-severity findings follow. No changes were made to the main checkout.

## 1. Long hand-timed passes repaint already-covered areas after they gel

**Severity:** Medium · **Change set:** main · **Status:** Verified by code trace; already disclosed as an untested ceiling in `notes/time.md:308–310`, not a new discovery.

**Location:** `crates/paint/src/handling.rs:928–930`, interacting with `handling.rs:614–616,644` and `crates/paint/src/drying.rs:519`.

The new inter-slice `hand_pass(bsecs)` calls can bake the first slices before the covering pass reaches `fill_gaps`. Baking clears their wet volume. The fill predicate treats `wet.vol[i] < FILL_BARE` as bare even when the pixel was covered by this pass and its paint merely set. Consequently, a sufficiently long pass adds unnecessary fill strokes over its earlier, already-covered passages. This changes paint thickness, appearance and billed hand time according to which slices gelled, rather than where the brush actually left gaps.

**Concrete fix:** Preserve a pass-local coverage/deposit measure across inter-slice baking and use it for gap detection. Alternatively, fill each slice before aging it while retaining deterministic stroke IDs. Add a regression with fast-drying paint where early slices gel before the pass ends; fully covered cells must not become fill candidates merely because they baked.

## 2. The plough substitutes body stiffness for reserved-film stiffness

**Severity:** Medium · **Change set:** r6-wet · **Status:** Verified by a focused executable test.

**Location:** `crates/paint/src/bristle.rs:1601–1602`; reservation is established at `bristle.rs:683–690`.

The plough calculates stiffness using `whole(vol, top, hide, thide)`. During a stroke, `vol` also includes the reserved middle film, whose properties live in `mid[midx]`. The two-layer calculation incorrectly assigns that middle volume the body's stiffness. This can make a thick stiff film behave like fluid paint while a new stroke crosses it, or make a fluid film behave like stiff paint over a stiff body.

**Evidence:** An isolated `exchange` test used equal total volume and equal volume-weighted stiffness, with pickup and deposit disabled. A homogeneous column moved **2.6394005 coats**; a column containing nine coats of reserved stiff paint over one coat of fluid body moved **0.26393986 coats**. The assertion failed as expected. Test and output are retained in `[local path redacted] and `[local path redacted]

**Concrete fix:** Compute stiffness from all three volumes: body `vol − top − mid`, surface `top` and reserved `mid`, using the reserved record's properties. Add the equal-weighted-stiffness regression alongside the existing pigment-conservation test; conservation alone does not detect this incorrect movement rate.

## Validation and verdicts

- Main's two impasto/varnish tests passed (`main-impasto-tests.log`).
- r6-wet's existing conservation test passed. All ten tally tests passed across bounded runs; the initial grouped run timed out and the remaining tests passed separately (`tally-tests.log`, `ledger-test.log`, `slices-test.log`, `touches-test.log`). Logs are under `[local path redacted]
- Post-audit PR lookups returned no matching PRs for main or r6-wet, so there were no attached review discussions to incorporate (`main-prs.json`, `prs.json`).
- **Main:** Address the known long-pass fill defect before relying on hand-timed, multi-hour covering passes. The focused varnish checks passed.
- **r6-wet:** Fix reserved-film stiffness before merging; the measured tenfold plough discrepancy undermines the intended stiffness-dependent wet-paint behavior.
