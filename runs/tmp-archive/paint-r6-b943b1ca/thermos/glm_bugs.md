# Thermos review — Round 6, reviewer glm (bugs)

Scope: everything merged since `2c5a658` on main, and the unmerged `r6-wet`
branch. Method: read both diffs in full against the surrounding code, read
`notes/time.md`, `notes/wet.md`, `notes/varnish.md`, `notes/round6.md` and
`notes/advice/astra_r6.md` (the five findings already fixed there are not
re-reported), then ran the test suites of both change sets in my own
worktree, plus two throwaway experiments for the findings below.

## What checked out clean

- All tests pass on both change sets in a debug build: `cargo test -p
  paint --lib` (178 passed on r6-wet, 174 on main), `cargo test -p easel`
  (40 unit + 3 integration on both), including the conservation test
  `a_third_stroke_over_two_wet_colors_conserves_paint`, the thread-count
  and crop ledger test, the hand-time checkpoint/sitting tests, and the
  two replay-hash tests.
- The two-layer film's layering invariant (`top + mid <= vol`) is
  maintained everywhere I traced it: `Surf::lay` sets aside at most what
  was `top`; `take`/`take_column` subtract what they return; `stir` and
  `settle_mid` move volume between layers without touching `vol`
  (crates/paint/src/bristle.rs, r6-wet).
- `midx` can only be dereferenced while `mid > 0`, which only happens
  inside the stroke that pushed the record; `mid` is settled to 0 at every
  stroke end (`settle_mid` in `drag_on` and `touch_on`), so checkpoints
  (which don't store it) can't restore a dangling index.
- Hand time units check out end to end: `pace` prices seconds, `Tally.secs`
  is seconds, `flush`/`hand_owed` convert to minutes, `SLICE_MIN` is
  minutes and `batches()` compares against seconds via
  `hand_slice_secs()` (crates/paint/src/tally.rs, crates/easel/src/time.rs).
- The planned-stroke and stipple rewrites keep the old single-batch id
  allocation bit for bit when hand time is off (`batches` returns one
  batch; `in_batch` sorted equals the old index order), so old logs still
  replay unchanged unless a change means to alter them.
- `settle_film` (crates/paint/src/surface.rs:272) conserves volume by
  construction (`out = kept + gain`, then an exact global rescale) and its
  physics constants reuse the same `level_band`/`rheology` units as
  `settle` (both scale `h` by 1e-6 at the call).
- The golden scene and the replay hashes were re-recorded with stated
  reasons on main (varnish fix `b65ca7c`, relief `ea754e0` says the golden
  is unaffected and it isn't in the diff, oak/broadleaf changes are not in
  the golden scene's subject).

## Findings

### 1. `ruler()` bypasses the "an order asked for is kept" guard (main) — medium-low, verified

`crates/paint/src/handling.rs:207-216`. The Round 6 review fix for hand
time added `order_set` and only honors an explicitly asked-for order
(`Handling::order`, line 254, sets `order_set = true`; `sweep` routes
through it). `ruler()` — the preset for "a priming coat laid with a
straightedge, or for comparison" — sets `self.order = Order::Scatter`
directly and leaves `order_set` false. With hand time on, `run_plans`
(crates/paint/src/handling.rs:848) then silently replaces the ruler
preset's scatter with the default sweep-down.

Measured: a full-canvas pass at slice 1.0 min dries with a top/bottom cure
ratio of 2.40 through `ruler()`, 2.26 through the untouched default
(both are the sweep), and 1.27 through `.order(Order::Scatter)` (kept).
So `work(m, {ruler=true})` under hand time loses the one thing the preset
asks for, in the paint's age and therefore in the look.

Fix: in `ruler()`, replace the direct assignment with
`self.order(Order::Scatter)` (one line), or set `self.order_set = true`.

### 2. The wet branch's memory claim understates by ~18% (r6-wet) — low, verified

`r6-wet:notes/wet.md:209` ("Costs: 44 bytes more per pixel (about 300 MB
at 3200 × 2240)", repeated in `notes/round6.md:102`). The new `Wet` fields
are per pixel: `top` 4 B + `tlat` 7×4 = 28 B (`LATENT_SIZE` is 7,
mixbox-2.0.0/src/lib.rs:53) + `thide` 12 B + `mid` 4 B + `midx` 4 B =
**52 B/px**, about **373 MB at 3200 × 2240** (and ~380 MB at the Friedrich
3:2 canvas's 3200 × 2286). The 44 B figure assumes a 5-float latent. The
checkpoint's version-8 block (crates/paint/src/checkpoint.rs) stores
`top + tlat + thide` but not `mid`/`midx`, so a saved checkpoint is 44 B/px
bigger — perhaps that is where the 44 came from — but the live cost is the
one that matters for the 3200 px memory budget. Fix: correct the two notes
to 52 B/px and ~370–380 MB.

### 3. The hand ledger is not exactly crop-stable for aimed marks, beyond the one documented exception (both change sets) — low, suspected mechanism, verified code path

`crates/paint/src/tally.rs:14` promises "the ledger is the same at any
thread count and (but for the fill dabs, which look at the pixels a crop
holds) in a crop." The fill dabs are not the only crop-dependent input any
more: the new palette-trip pricing classes each dip as a reload (2.5 s) or
a remix (22.5 s) by the asked-for color, and for aimed work that color is
sampled from the canvas — `Handling` strokes via `stroke_under`
(crates/paint/src/handling.rs:958, 964) and stipples via `judge_under`
(crates/paint/src/stipple.rs:482). Both look at the held window and clamp
out-of-window samples to the window edge (`Frame::index` clamps,
crates/paint/src/canvas.rs:72), so in a `look --scale` crop session the
dips of whole passages priced off-window can flip between remix and
reload and the hand time differs from a whole render. The paint those
strokes would lay was already crop-divergent (acknowledged in
`finish_plan`'s comment); what is new is that the *ledger* equality claim
is now only approximately true. A probe I ran (half-dark/half-light field
with an aimed stipple, window edges aligned with the field boundary)
happened not to flip a pile decision, so I mark this suspected; the
mechanism is unambiguous in the code.

Fix: one clause in the tally doc — aimed dips (`color_over`, the look
under a stroke) are the other crop-dependent input — or price trips from
the color function's asked-for value where one exists.

### 4. Merging r6-wet will fail the replay tests until their hashes are re-recorded a third time (r6-wet) — low, verified

`r6-wet` last merged main before the varnish change (`git merge-base main
r6-wet` is `dc79ebb`; the varnish merge is `d5c53f0`, and r6-wet's
crates/paint/src/surface.rs has no `settle_film`). The branch re-recorded
`crates/easel/tests/hand_time.rs:49-51` (example.lua 0x320d_6b54_187c_5dda
debug, 0xd849_86a8_fec3_2707 and l5_near 0x3469_6b94_de88_8ed6 release)
and `crates/paint/tests/golden_scene.txt` (3aaebce2192970b5) against an
engine without the varnish fix, which by main's own measurement moves 1
and 8 pixels of those replays by 1/255 at 160px (`43dc652`). So a merge of
r6-wet as it stands fails `existing_logs_replay_unchanged` and
`scene_matches_golden` until both are re-recorded against the merged
engine — a third re-record that should be done deliberately (the branch's
`PRINT_HASHES=1` helper exists for exactly this), not discovered as a red
test.

### Notes, not defects

- The engine's palette state (`tally::Piles`) is fresh per `work`/`stipple`
  call, so every pass's first dip is a remix even for a color mixed in the
  previous pass; a painter's palette persists across a sitting. This
  inflates the palette-trip share of hand time, which
  `notes/advice/astra_r6.md` §1 already criticizes as a calibration
  question, not a correctness bug. Worth a line in `notes/time.md`'s
  issues list if it is a deliberate choice.
- The known open issues in `notes/wet.md` §4 (one-mixture bristle,
  squeegeeing spent hog, resolution-dependent badger edge) are documented
  and not re-reported.

## Verdicts

- **main** (hand time and sittings, easel root, bare trees, relief
  default, varnish fix): sound. No blocking defect found; all tests pass;
  determinism, replay, conservation and units invariants hold. One gap in
  the merged review fix (finding 1) and two doc-accuracy nits.
- **r6-wet** (two-layer wet film, plough, dirty tip, lift-off, PAINTCK8):
  sound. The layering machinery is careful and the conservation test is
  genuinely adversarial (mid-film pickup and plough counted by the test).
  Nothing blocks a merge for correctness; before merging, re-record the
  replay hashes and the golden (finding 4), and correct the memory note
  (finding 2).
