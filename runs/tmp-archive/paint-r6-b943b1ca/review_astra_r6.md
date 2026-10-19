(・_・) Round 6 review

## Findings

1. **Major — r6-wet — Deferred surface paint is treated as body paint during exchange. Verified by code inspection.**
   **Location:** `crates/paint/src/bristle.rs:663–698`, with affected operations at `707–777` and `1497–1586`.

   `lay` saves the previous surface film in `Mid` and clears `top`, but leaves its volume in `vol`. Until settlement, every calculation of body volume as `vol - top` includes that reserved paint without its pigment or properties. `stir` and `add_body` therefore mix using an inflated body volume. Pickup and ploughing can remove that volume using the body's pigment, while `settle_mid` later restores the saved pigment at the original pixel without tracking those transfers.

   For example, start with one coat of dark body and one coat of light surface, then lay one coat of a third pigment. After reservation, stirring that new coat fully into the body mixes it against two coats of dark, not one. Settlement then subtracts the reserved coat from the mixture's effective volume and restores the light coat. Total volume can remain correct while pigment amounts are wrong. This happens on the ordinary lay-then-stir path, not just at a crop boundary.

   **Fix:** Represent the reserved film explicitly in all mixing and transport operations, including updating its remaining volume when picked up or ploughed. Alternatively, settle it before further exchange using a conservation-preserving model. Add per-pigment/property moment conservation tests across canvas and brush, including a third stroke over two different wet colors. The existing `top <= vol` assertion cannot detect this defect (`wet.rs:685–704`).

2. **Major — main — Checkpoint resume silently disables hand time. Verified by serialization inspection.**
   **Location:** `crates/paint/src/canvas.rs:200–205`; `crates/paint/src/checkpoint.rs:96–161,218` on main.

   The new `tally` and `hand_slice` fields are absent from checkpoint serialization. Loading constructs a default canvas, leaving an empty ledger and `hand_slice=None`. A checkpoint of a hand-timed painting therefore resumes with different behavior: subsequent covering passes no longer age the paint between slices. Even explicitly re-enabling hand time cannot recover the prior ledger or pending time. The format-7 additions on r6-wet serialize only the new film arrays and do not repair this (`r6-wet:checkpoint.rs:269–273`).

   **Fix:** Serialize the hand-time setting and the complete tally, including `clocked`, under an updated format. Test a nonzero ledger with pending hand time, round-trip it and compare continued painting and clock advancement against uninterrupted execution.

3. **Major — main — Clock queries repeatedly consume the same finishing interval as a new sitting. Verified by control-flow inspection.**
   **Location:** `crates/easel/src/time.rs:99–114`; `crates/easel/src/api.rs:1735–1740`.

   `varnish()` dries the canvas without synchronizing the studio clock. In `flush`, an unreported interval greater than 0.5 minutes deliberately leaves that clock behind; an interval of at least two hours also starts a sitting at the newer canvas time. A second flush sees the same interval and starts another sitting. Thus, after varnishing paint that needs at least two hours to dry, `timesheet(); timesheet()` within the same chunk increments sittings repeatedly and can return a negative sitting duration because `s.clock < s.hand.start`. Chunk-end synchronization occurs only afterward (`session.rs:230–241`).

   **Fix:** Consume and synchronize implicit drying time exactly once, before clock or timesheet queries return. Preserve any reporting requirement separately from the clock state. Add a same-chunk regression covering varnish followed by repeated queries.

4. **Major — main — Hand time overrides an explicitly requested scatter order. Verified by code inspection.**
   **Location:** `crates/paint/src/handling.rs:836–845`.

   When slicing is enabled, both `Order::Scatter` and `Order::Passages` are replaced with a downward sweep. This contradicts the explicit-order guarantee in `notes/time.md:51–53` and the adjacent code comment. With drying between batches, order changes which passage remains wet when later marks arrive, so this changes painting behavior rather than merely scheduling.

   **Fix:** Distinguish an unspecified default order from an explicit selection. Apply the downward-sweep substitution only to the default and test explicit scatter with multiple timed batches.

5. **Minor — r6-oak — Disabling twigs also disables requested tip pressure and release on some limbs. Verified by code inspection.**
   **Location:** `crates/easel/src/draw_trees.rs:301–306,332–339`.

   `wood_strokes` can append a leading twig while recording the limb-only length in `own` (`crates/paint/src/broadleaf.rs:1573–1581`). With `twigs=false`, `lay_wood` correctly truncates to `own`, but then clears terminal status because `m != s.pts.len()`. The exposed limb endpoint consequently ignores the requested tip pressure and release ramp. Otherwise equivalent limbs without appended twigs retain them.

   **Fix:** Preserve `s.tip` when truncating an appended twig. Test `twigs=false` on a merged leading-twig stroke with explicit tip pressure and release.

## Verification and limits

Reviewed the three scoped change sets and their design notes. Findings above are verified by source inspection, not custom runtime reproductions. No tracked files were edited and no commits were made.

In a separate r6-wet scratch worktree, ran the debug-profile command `timeout 180 cargo test -p paint --lib wet::tests::wet_on_wet -- --test-threads=2`: **5 passed, 0 failed, 2 ignored**. These passing tests do not establish pigment conservation through deferred settlement. Full suites, golden-scene validation and 3200px memory measurements were not run.

## Verdicts

- **main: fix before merge** of further dependent work; repair checkpoint continuity, finishing-clock accounting and explicit ordering (findings 2–4).
- **r6-wet: needs rework** of deferred-film bookkeeping before merge (finding 1), plus the checkpoint repair in finding 2.
- **r6-oak: fix before merge** for the narrow tip-handling defect in finding 5.
