# Stage 2 (exact kernel) report

Worktree `wt-kernel`, branches stacked on **4ec3169** (the golden base). Scratch: `lane-kernel/`.
Note: `main` moved to **587e0e1** (stage/round-21 merges) while this ran. That diff doesn't touch `crates/paint` (`git diff --stat 4ec3169 main -- crates/paint` is empty), and `git merge-tree --write-tree main perf/kernel-inline` reports a clean merge. The goldens are for 4ec3169, so after a rebase the digests prove only that 4ec3169 behavior is unchanged. They don't cover main's newer easel changes.

| # | branch | commit | label |
|---|---|---|---|
| 1 | feat/state-digest | 0865bfc | new feature (instrumentation, no engine change) |
| 2 | test/kernel-traps | 64f6f4b | tests only |
| 3 | perf/kernel-inline | afe4114 | behavior-preserving (verified bit-identical) |
| 4 | — | — | not done, reasons below |

## 1. feat/state-digest (0865bfc)

- `easel run <log> --state-digest <file>`: one line per chunk, `chunk N secs=… canvas=… brushes=… nbrushes=… studio=…`. The format is byte-for-byte the golden patch's (wt-exp-golden.patch). The helpers `fnv1a` and `state_digest_line` are in crates/easel/src/main.rs, with a doc comment covering scope and gaps. The option is also listed in the usage strings and the module doc. `Held` derives `Debug` (crates/paint/src/bristle.rs, `pub struct Held`).
- Format parity with the golden binary: easel.digest (sha256 1ded1e15…) replayed paint-studio-3cab71 → `digest_identical=y png_identical=y` (lane-kernel/replay/digest/summary.txt).
- Test: `cargo test -p easel --test determinism state_digests_are_the_same_in_every_replay` (crates/easel/tests/determinism.rs:98) → ok. It replays a 3-chunk log (ground, broad pass + `wait(30)`, filbert strokes) at RAYON_NUM_THREADS=1 and 4 and checks that both runs write the same digests (with `secs=` dropped). It also checks the line shape, `nbrushes` 0 → 1 and that the canvas digest changes from chunk to chunk.

### Coverage against the ledger
Covered: the canvas surface (px, height, film), the wet state (vol, lat, hide, stroke/touched ids, cover, dirty box, stroke counter), clocks (canvas clock, per-pixel cure/lev/seen/sub/srate/th, tacky box, studio clock/clock0), hand time (tally, slice), engine, drawing, held brushes (the full `Held` Debug text: tool and every bristle), RNG state, seed, the chunk and call counters, `canvas{}` setup and the palette piles. Sources: crates/paint/src/checkpoint.rs:101-179 and crates/easel/src/api.rs:31-57.

Missing, and material for a "full continuation" claim:
- **Lua state**: globals, user tables and **masks** (mask userdata live in Lua, not in `Studio`). A chunk that builds a mask and uses it in a later chunk isn't covered until the use shows up on the canvas.
- `Studio.style` (an `Rc<Style>`; only the `setup` string is hashed) and `Studio.view` (the world view that `visible=`/`behind=`/`at=` resolve against).
- The brush digest is Debug text: float Debug is shortest-round-trip (exact apart from NaN payloads), but a field added to `Held`/`Bristle`/`Tool` changes every brush digest. It also counts brushes Lua dropped but hasn't collected yet (Weak upgrade), which ties it to GC timing (deterministic per process so far).
- Left out on purpose (same as checkpoints): `wet.floor` (reset per stroke id before it's read, bristle.rs:1327-1330) and the contact cache `base` (derived from height and rebuilt on `surf_gen`).
- A mismatch says "canvas differs" but not which field.

**Proposed v2** (a new flag or `--state-digest-v2`; v1 stays as it is for the goldens): a per-component canvas digest (px / height / film / wet / clock / drawing / tally) so a mismatch names the field; a canonical binary brush serialization instead of Debug; a hash of the Lua globals as `easel globals` lists them plus mask contents; the style and view; and a header line with the binary, engine and log identity.

## 2. test/kernel-traps (64f6f4b)

`mod kernel_traps` in crates/paint/src/bristle.rs:2081, 4 tests, `cargo test -p paint --lib kernel_traps` → 4 passed. **They also pass on main 4ec3169**: I cherry-picked with `-n` onto a detached 4ec3169 → `test result: ok. 4 passed`, then reset.

- Trap A, transfer (`a_plough_transfer_rereads_the_source_cure_after_each_take`, :2122): a native `Surf` on an engine-2 canvas with drying state allocated (after `wait`). The source has vol 1.03e-5 and cure 0.1; four wet destinations get m = 1.44e-6/4 each, in the same read, take, add order as the plough. Asserts the carried cures are `[0.1, 0, 0, 0]` and the destination cure bits are `[first, 0, 0, 0]` (a hoisted cure would give 3.6e-5 to all four).
- Trap A, kernel (`ploughing_films_at_the_threshold_leaves_the_recorded_cure`, :2166): a real `Canvas::drag` of an empty filbert (pickup 0, push 1, so it only ploughs, bilinearly to 4 destinations) through a random field: half the pixels are films of 1.0-1.05e-5 coats with cure 0.1, the rest thick. It pins the FNV hashes of every pixel's vol and cure bits, recorded on main (7536 films ploughed bare). **Mutation check**: hoisting the cure out of the destination loop makes this test fail (`vol=b496350c… cure=f0a74dcc… zeroed=7513` vs the recorded `vol=216de608… cure=322c7a06… zeroed=7536`).
- Trap B, medians (`a_running_median_over_a_crop_with_its_window_is_bit_identical`, :2193): the running median over a crop holding each output's window, or reaching the row ends, equals the full row bit for bit.
- Trap B, blur (`a_box_blur_over_a_crop_is_not_bit_identical`, :2215): documents that it **doesn't** match. `surface::box_blur` over a crop with a full radius-r halo differs from the full frame in 1370 of 1600 interior pixels (by up to 7.6e-5, stderr of the test run). The test asserts that it differs and that it stays within 1e-3.

## 3. perf/kernel-inline (afe4114)

The inline2 kernel changes only: `Clip::at` gets `#[inline(always)]` (bristle.rs:711), and the plough reads `lat`/`hide` of the source once before its destination loop (bristle.rs:1393). The **cure is still read per destination**. No PAINT_DUMP and no profiling profile: the profile was only needed for symbolized traces, and a release build doesn't need it.

- Tests: `cargo test -p paint -p easel` → all pass (easel unit 51, boxes 5, delivery 2, determinism 3, session_integrity 7, smoke 1; paint lib 171 + 7 ignored, including the 4 trap tests; curved_drag_nan 2, ground_grain 1). Log: lane-kernel/test-inline.log.
- Binary: lane-kernel/bin/easel.inline (sha256 6b81717f…), which is this branch plus feat/state-digest (stacked).

### Verification vs goldens (lane-kernel/verify.sh, replay.sh; per-studio output in lane-kernel/replay/inline/)
Every studio with a `done` marker (10 of 38 when the queue ran dry) was replayed sequentially, smallest first, in 9142 s total, within the 3 h cap. None were skipped for budget. paint-studio-520026 was still running in the golden job.

| studio | chunks | digest identical | PNG identical | golden wall s | branch wall s | wall ratio | golden user s | branch user s | instructions golden/branch | cycles golden/branch |
|---|---|---|---|---|---|---|---|---|---|---|
| paint-studio-2564f4 | 30 | y | y | 238.5 | 326.8 | 0.73x | 373 | 408 | 1.009x | 0.96x |
| paint-studio-3cab71 | 17 | y | y | 322.9 | 361.4 | 0.89x | 421 | 423 | 1.092x | 1.03x |
| paint-studio-11997b | 36 | y | y | 377.1 | 534.3 | 0.71x | 549 | 628 | 1.029x | 0.94x |
| paint-studio-1def1a | 81 | y | y | 452.3 | 444.6 | 1.02x | 547 | 530 | 1.079x | 1.05x |
| paint-studio-2a634e | 155 | y | y | 616.7 | 717.1 | 0.86x | 751 | 774 | 1.086x | 1.02x |
| paint-studio-4fb403 | 120 | y | y | 715.7 | 523.9 | 1.37x | 703 | 578 | 1.087x | 1.17x |
| paint-studio-3be9e8 | 94 | y | y | 760.1 | 889.0 | 0.86x | 859 | 896 | 1.083x | 1.00x |
| paint-studio-497bcf | 184 | y | y | 1073.5 | 955.8 | 1.12x | 1510 | 1494 | 1.024x | 1.01x |
| paint-studio-358aea | 192 | y | y | 1383.8 | 1606.2 | 0.86x | 1818 | 1937 | 1.023x | 0.97x |
| paint-studio-3f743e | 189 | y | y | 2335.7 | 2775.5 | 0.84x | 3574 | 3865 | 1.024x | 0.96x |
| **total** | | | | 8276 | 9135 | 0.91x | 11104 | 11534 | 1.042x | 0.99x |

**All 10: digests identical (all chunks, `secs=` dropped) and PNG identical.** No mismatch.

**About the timings:** the "wall ratio" column (golden / branch) is **not a speed measurement**. The golden run was recorded at another time under other load, and my replays shared the machine with the golden job and other lanes' builds. Retired instructions don't depend on load: they are down 1-8% per studio (golden/branch 1.009-1.092x, about 4% in total). For an honest speed number I ran a **paired, alternating A/B** on 3cab71 under the same load: main + state-digest (easel.digest) vs easel.inline (lane-kernel/ab/summary.txt).

| run | main+digest | inline |
|---|---|---|
| 1 | 329.4 s, 4.863e12 instr | 275.5 s, 4.446e12 instr |
| 2 | 304.3 s, 4.863e12 instr | 263.3 s, 4.445e12 instr |

→ **1.18x wall** (mean 316.9 vs 269.4 s) and 8.6% fewer instructions (1.094x). All 4 PNGs are sha1 2d1f224f…, the same as golden/paint-studio-3cab71/painting.png, and all 4 digest files are identical. This agrees with the earlier clean chunk-5 A/B (1.21x, debug/clean-ab.log). Studios with only 1-2% fewer instructions (2564f4, 497bcf, 358aea, 3f743e) will likely gain less than 3cab71; that's an inference, not measured paired.

## 4. Median-pass localization: not done

- Exactness is feasible: the medians are bit-local (test above), but the blur has to stay full-frame. Its rolling sums restart per row and column, and the recurrence carries rounding from any changed value to the end of the row/column. So even a "whole rows and columns" recompute only saves the part before the first changed pixel.
- **The payoff is too small.** In the tail profile (profile/tp3.xml, chunks 88-90, 741 s CPU / 661 s wall), the median pass (`contact_level` closure) is 15.38 s of CPU (2.1%) and box_blur is about 24 s. Both already run in parallel over rows, so localizing the medians saves ≤2.3% of wall time even if they were serial, and in practice less.
- **Risk**: it needs a complete dirty rect of `height` at every `surf_gen` bump (surface.rs:236, :333, stipple.rs:749, crack.rs:1357). A missed rect is a silent divergence that only a full-corpus replay would catch.
- My recommendation: leave it for engine 3, where the contact level can be redefined with a local-exact filter.

## Open
- Rebase the three branches onto main 587e0e1 (the merge is clean) and rerun the tests. Replays should then be checked against goldens re-recorded at 587e0e1, or the 4ec3169 goldens should be accepted as the reference for crates/paint only.
- 28 studios had no `done` marker when verification ran. Rerun `lane-kernel/verify.sh lane-kernel/bin/easel.inline inline <budget>` as more finish (it skips studios already in summary.txt).
- Digest v2 (above) before engine 3's full-state gate.
- The last line of verify.sh's log ("no studio fits the remaining budget 1659s; queue: ") actually means the queue was empty; none were skipped.

Worktree left detached at `main` (587e0e1).
