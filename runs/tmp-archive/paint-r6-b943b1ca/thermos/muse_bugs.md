# Thermo-nuclear review, Round 6 (muse, bugs)

This review stopped early after a provider error. I read the full diffs of both
change sets. I didn't finish a test run: the one build I started in a scratch
worktree was cut off. Everything marked "verified" was checked by reading the
code at the lines cited. I found no high-severity issues.

## Findings (prioritized)

### 1. Medium: `varnish()` bypasses the hand clock that `glaze()` and `dry()` now use (main)
- **Where:** crates/easel/src/api.rs, `varnish` (~L1723–1740), compared with `glaze` (~L1638–1662) and `dry` (~L1671–1678).
- **What's wrong:** Round 6 wired every finishing verb into `crate::time`. `glaze` and `dry` call `flush(.., true)` before drying and then update `s.clock`. `glaze` also counts its brushing with `tally_mut().glaze(mm2)`. `varnish` still calls `c.dry(); c.glaze(..)` directly. It never flushes, never updates `s.clock` and never counts the varnish's brushing as hand time.
- **Why it matters:** With hand time on, any hand time still owed (under `GRAIN_MIN`, left over from `b:stroke`/`b:touch`) goes on the clock after the varnish dried everything. The ledger then records strokes that happened after the drying, and the owed time ages paint that is already dry. Brushing a whole canvas with varnish costs 0 s, while `glaze()` over the same area costs minutes. The drying still gets reported once, but only because the chunk-end `flush` catches it indirectly: the test `queries_after_a_finish_consume_its_drying_once` covers the report, not the order or the ledger.
- **Fix:** Make `varnish` follow the `glaze` pattern: flush first → `c.dry()` + `c.glaze(..)` → `tally_mut().glaze(whole canvas mm²)` → update `s.clock` and call `time::waited` → flush again.
- **Status:** verified (read); impact on pixels suspected to be negligible, impact on the ledger and sitting accounting verified.

### 2. Medium (memory/docs): r6-wet adds 52 bytes/pixel, not 44 (r6-wet)
- **Where:** crates/paint/src/wet.rs `Wet` on r6-wet: `top` f32 (4) + `tlat` [f32; 7] (28; mixbox `LATENT_SIZE = 7`) + `thide` [f32; 3] (12) + `mid` f32 (4) + `midx` u32 (4).
- **What's wrong:** notes/wet.md and notes/round6.md say "44 bytes more per pixel (~300 MB at 3200)". The 44 leaves out `mid` and `midx`, which are allocated for every pixel even though they're only used during a stroke. At 3200×2240 (7.17 M px) the real cost is about 373 MB. On top of that, every `Canvas::clone` (easel undo snapshots, `Snap`) now copies all of it.
- **Why it matters:** The project watches memory at 3200px (a Form alone is ~190 MB). Combined with the easel's undo ring, the budget is understated by about 25%.
- **Fix:** Correct the notes to 52 B/px. Better: move `mid`/`midx` out of `Wet` into the per-stroke `Vec<Mid>` (a pixel→index map local to the stroke, or a sparse map), because they're always 0 between strokes. That drops 8 B/px and the undo snapshots no longer carry them.
- **Status:** verified (struct fields read; byte count computed).

### 3. Low: the PAINTCK8 surface-film block isn't validated on read (r6-wet)
- **Where:** r6-wet crates/paint/src/checkpoint.rs `read_state` (the new version-8 block): `c.wet.top = get_all(r, n)?`, plus `tlat` and `thide`. `get_all` (L72–76) doesn't check the values.
- **What's wrong:** The same commit series validates the hand-time ledger (`is_finite`) and the drawing (a NaN guide is refused, and a test covers it). The surface film is accepted as-is: NaN, negative or `top > vol` all load silently. The invariant the branch's own test checks (`0 ≤ top ≤ vol`, finite) isn't enforced at the trust boundary.
- **Why it matters:** A corrupt or truncated-then-padded checkpoint would load and spread NaN through `film_over` and `whole()` into drying rates, instead of being refused like every other block.
- **Fix:** After reading, refuse the file unless every `top` is finite, `>= 0` and `<= vol + ε`, and every `tlat`/`thide` value is finite. Add a case to the existing "corrupt checkpoint is refused" test.
- **Status:** verified (read).

### 4. Low: the plough reads a stiffness that ignores the set-aside film (r6-wet)
- **Where:** r6-wet bristle.rs `exchange`, plough: `let stiff = crate::wet::whole(v, *sf.top.add(i), *sf.hide.add(i), *sf.thide.add(i))[1];`
- **What's wrong:** During a stroke, part of `v` can be `mid` (an earlier surface film set aside). `whole()` treats `vol − top` as body, so it credits the `mid` volume with the body's stiffness. Where a fluid glaze-like film was set aside over a stiff body (or the reverse), the plough's `PLOUGH_STIFF` factor is wrong for that part while the stroke is under way.
- **Why it matters:** This is small and local. It only affects pixels a stroke has laid over an earlier surface film. It doesn't break conservation (the column is moved as a whole).
- **Fix:** Include `mid` with its `Mid.hide` in the mix (volume-weighted over the three parts), or document the approximation.
- **Status:** verified (read); visual impact suspected small.

### 5. Low (devex hygiene): stray `crates/easel/tests/hand_time.rs-e` in the main checkout (main)
- **Where:** untracked file `crates/easel/tests/hand_time.rs-e` (a BSD `sed -i -e` backup).
- **Why it matters:** It isn't compiled, because Cargo only picks up `*.rs`. But it's an easy thing to `git add -A` by accident, and it holds stale replay hashes.
- **Fix:** Delete it. Use `sed -i ''` on macOS.
- **Status:** verified (`ls`).

## Checked and found sound (not reported as bugs)
- The easel `root()` lookup order (`EASEL_ROOT` → cwd ancestors → build dir) and the canonicalize fallback.
- Hand-time slicing: stroke ids are allocated per batch over all of the batch's tiles before the crop filter, so a crop and a whole render get the same ids. The ledger is counted on the whole canvas before tiling, so it doesn't depend on thread count. With one batch (hand time off), the ids are the same as before.
- `tally::batches` edge cases: an empty order, zero-second tiles, no slice.
- PAINTCK7: its hand-time block round-trips and its values are validated.
- `settle_film`: the total volume is rescaled exactly and the peak minimum is capped by the film laid.
- `wood_strokes` and `drawn`: parents are always drawn. `plan_stroke` handles a tip whose twig is dropped (the earlier fix is correct).
- r6-wet conservation: `lay`, `add`, `take`, `take_column` and `settle_mid` keep volume and moments, with `mid` settled to 0 at every stroke's end. The `conservation` test covers pickup and plough through set-aside paint.
- The `lift_off` trail stays ≤ the p=1 trail, so the footprint and scheduler bounds still hold.

## Not finished (suspected, not checked)
- I didn't run the determinism, replay or golden tests on either change set.
- I didn't trace whether `look --mode wet` combined with `--dried` shows stages consistent with the dried picture.

## Verdict
- **main:** Sound. The one real gap is that `varnish()` isn't integrated with hand time (finding 1). Fix it before relying on timesheets for finished paintings. Otherwise it's safe as merged.
- **r6-wet:** The engine changes look conservative and careful. Before merging, correct the memory claim (or move `mid`/`midx` out of `Wet`) and validate the PAINTCK8 block. Finding 4 is minor.
