(・_・) Reviewed both maintenance change sets. Three findings below; verification used source inspection and small in-memory arithmetic probes, not Rust tests or end-to-end renders.

## Findings

### 1. Minor — main: conservation can still cross its bounds

**Location:** `crates/paint/src/surface.rs:130–154` (also inherited by r6-wet).

`conserve_total` stops after eight pinning rounds. The last round recalculates `k`, then applies it without checking whether that stronger correction carries additional unpinned pixels past their bounds. This contradicts the exact-bound guarantee at `surface.rs:352–356`.

**Verified at helper level:** A float32 arithmetic probe with 1,024 pixels, `add[i] = 0.5`, `out[i] = 0.5 + 0.5*i/1023`, lower bound `0.5` and upper bound `1` leaves two pixels below the lower bound. The minimum is `0.499633193`. All initial output values satisfy the bounds. Reachability from an actual `settle_film` scene remains **suspected**, not demonstrated.

**Why it matters:** The four-pixel regression at `surface.rs:499–518` does not exercise exhaustion of the iteration cap, so it cannot establish the advertised guarantee.

**Fix:** Continue until no additional pixels are pinned, with explicit handling of an exhausted free set. Add a regression requiring more than eight rounds.

### 2. Minor — r6-wet: checkpoint validation trusts an invalid total volume

**Location:** `crates/paint/src/checkpoint.rs:252,313–317`.

The new surface-film validation checks that surface volume is finite but does not check that total wet volume is finite and nonnegative. Total volume is read without validation at line 252. Consequently, `vol = +infinity, top = 0` passes the new predicate. So does `vol = -0.000001, top = 0` because of the absolute tolerance.

**Verified:** Source inspection and direct evaluation of the predicate confirm both cases. This is a residual validation gap, not a newly introduced parser regression.

**Why it matters:** Accepted state violates the layer invariant and reaches arithmetic such as `take_column`'s volume division and body multiplication (`crates/paint/src/film.rs:465–475`), where infinite totals can produce NaNs. The new corruption test only varies the surface block (`checkpoint.rs:412–441`).

**Fix:** Require `vol.is_finite() && vol >= 0.0` before the surface comparison. Add corruption tests for invalid total volumes alongside the surface-block tests.

### 3. Minor — r6-wet: shared line measurements use a resolution-dependent averaging width

**Location:** `paintings/src/study.rs:83–90`.

`dx` and `dy` are the displacement per sample, with magnitude approximately `1/s`, not a unit direction. The cross-line offset then multiplies them by `j/s`, applying the resolution conversion twice. The claimed averaging band in canvas units therefore shrinks as resolution increases.

**Verified:** For a 32-unit vertical line at `s = 3.2` with `band = 0.8`, the outer sample is only `0.196078` units from the center instead of `0.625` units. Those arguments occur in the contour measurement at `paintings/src/bin/study_wet_control.rs:202–205`.

**Why it matters:** Preview and full-resolution edge metrics average different physical neighborhoods. The extraction preserves a preexisting measurement defect rather than correcting it.

**Fix:** Compute a unit normal from the geometric segment length, independently of the sample step. Offset along that normal by `j/s`. Test horizontal, vertical and diagonal profiles at multiple resolutions.

## Verdicts

**main:** No verified blocker; fix the bounded-conservation helper before claiming exact bounds.

**r6-wet:** No verified blocker; address checkpoint validation and measurement scaling, plus the inherited conservation finding.
