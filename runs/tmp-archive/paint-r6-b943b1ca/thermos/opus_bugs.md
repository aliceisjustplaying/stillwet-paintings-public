# Thermo-nuclear review of Round 6: bugs (opus)

Scope: `2c5a658..main` (crates, paintings) and `main...r6-wet`. I read every
hunk of both diffs, plus the code each one calls into (drying `wait`/`bake`,
`fill_gaps`, `tile_order`, `next_stroke_ids`, `footprint`, the easel's
session and snapshots). I ran three probes in a scratch worktree of main (a
test module added only there, release build, 240–480 px canvases). No
tracked file in the main checkout was touched. The five issues fixed after
the earlier review are not re-reported; their fixes read correctly.

There are no GitHub PRs for these branches (`gh pr list --state all` is
empty), so there was no bot or reviewer discussion to fold in.

## Findings, by priority

### 1. [Medium · main · verified] With hand time on, a long pass lays fill dabs over its own paint once that paint has set
- **Where:** `crates/paint/src/handling.rs:644`: `fill_gaps` counts a pixel as bare when `stroke[i] <= before || vol[i] < FILL_BARE`. Its inputs come from `handling.rs:848-930` (`run_plans` slices the pass and calls `hand_pass` → `Canvas::wait` between slices) and `drying.rs:435` (`bake`: every film with `cure >= GEL` sets and its `wet.vol` is cleared).
- **What's wrong:** hand time slices a long `work` and ages the paint between slices. Paint from the early slices can pass the gel point (about 1–2 h for thin paint, `drying.rs:41-46`, `rate`) and bake before the pass ends. Baked paint has `vol = 0`, so the fill look afterwards reads every set pixel of the pass as a gap and dabs fresh paint into it.
- **Evidence (probe, hand off vs `set_hand_time(Some(15.0))`, same handling, filbert, `fill` on):**
  - 480 px, filbert 5 over the whole canvas, 502 min of hand time: **1 fill dab off vs 353 on**. Before the fill, 11% of the pass was setting or tacky.
  - 240 px, filbert 3, 15 h: 262 vs 2331 dabs.
  - Shorter passes are barely affected: 291 min gave 58 vs 64; 335 min gave 10 vs 24.
- **Why it matters:** hand time is meant to make the paint age realistically. Instead, in exactly the long passes it was built for, it stamps a scatter of fresh dabs over set paint (a different surface film, a different drying age). The hand-time tests all use `fill(false)` (`tally.rs:382, 434, 468, 499`), so none of them sees it.
- **Fix:** judge a gap by "no paint from this pass", not by "no wet paint". Either:
  - snapshot `film` when the pass starts and use `bare = stroke[i] <= before || (vol[i] < FILL_BARE && film[i] <= film0[i] + ε)`, or
  - run the look-and-fill per slice, before that slice's `hand_pass`. That is also closer to a painter filling a passage while it is wet.
- **Test:** a hand-timed pass longer than the gel time lays about the same number of fill dabs as the same pass with hand time off.

### 2. [Low · main · verified mechanism, small measured effect] With hand time on, a crop render keeps a different clock from the whole render
- **Where:**
  - `handling.rs:632-699`: fill dabs are planned only from the pixels the canvas holds.
  - `handling.rs:951-955`: with `color_over`, `finish_plan`'s `want` is judged from `stroke_under`, which reads pixels outside a crop's window.
  - Both of these feed `tally.stroke`, `piles.trip` (`handling.rs:826-834`) and then `clock_hand`.
- **What's wrong:** `tally.rs:11-14` admits that the ledger differs in a crop because of fill dabs. With hand time on, though, the ledger is the clock: `clock_hand` waits `secs − clocked`, so a crop ages its paint by a different amount than the whole render does. Two more paths add to the drift: out-of-window `color_over` targets can choose different piles (reload vs remix, 2.5 s vs 22.5 s), and the difference accumulates chunk by chunk.
- **Evidence:** a probe with a filbert-18 sky, `fill` on and a 160×150-unit crop gave a whole-render clock of 76.013 min and a crop clock of 76.003 min (1654 vs 1653 strokes). The effect is small per pass, but it isn't bit-exact and it grows with fine brushes and many passes. This affects `--full --crop`, the easel's `look --scale` crop sessions, and any Lua that branches on `clock()` or `timesheet()`.
- **Fix:** keep the clock free of window-dependent marks. Options:
  - bill fill dabs from a whole-canvas estimate (for example, dabs per cell of the mask's bounding box times the pass's measured gap rate), or
  - count fill dabs in the ledger but not in `secs`.
  - For piles, key the dip on the color asked for without the look (`(hd.color)(x, y)`).
- **Test:** hand on, fill on, `color_over`: crop and whole render end with bit-equal `clock()` and `tally()`.

### 3. [Low · main · verified] Every covering verb starts with an empty palette, so hand time overbills pile mixing
- **Where:** `handling.rs:812` and `stipple.rs:505` create `Piles::default()` on every `run_plans`/`stipple` call. `work` alone makes up to three of them: the pass, `fill_gaps` and `cut_in_edges`. The easel keeps its piles per sitting (`time.rs:50-51, 83`) but uses them only for held brushes.
- **What's wrong:** the first dip of every `work` or `stipple` counts as a new pile (`REMIX` + `RELOAD` = 22.5 s), even when the same color was mixed seconds earlier by the previous call or by a held brush. A `work` with `cut_in` bills a second remix of the same color.
- **Why it matters:** hand time drives both the paint's ageing and the sitting overruns. A painting built from a few hundred covering calls picks up roughly one to two hours of phantom mixing (for example, 300 calls × 22.5 s ≈ 1.9 h).
- **Fix:** keep one `Piles` on the canvas (checkpointed with the tally) and let `sitting{}`/`rest()` clear it, or pass the easel's `Hand::piles` into the engine.

### 4. [Low · main · verified] Under hand time, `ruler()` loses its random order
- **Where:** `handling.rs:215` sets `self.order = Order::Scatter` without setting `order_set`. `handling.rs:848-851` then replaces any order with `order_set == false` by a top-down sweep when hand time is on.
- **What's wrong:** the review fix "an order asked for is kept" covers `order()`/`sweep()` but not the ruler preset, whose documented behavior is "in random order" (`handling.rs:204`). With hand time on, ruler passes (Lua `ruler=true`, `api.rs:942-943`) become sweeps.
- **Fix:** set `self.order_set = true` in `ruler()`, or treat any order that differs from the `new()` default as asked for.

### 5. [Low–Medium · r6-wet · verified] The two-layer film costs 52 bytes a pixel, not 44, and the idle 8 of them are copied into every snapshot
- **Where:** `r6-wet:crates/paint/src/wet.rs:190-198` adds these per-pixel fields: `top` f32 (4), `tlat` 7×f32 (28, `mixbox::LATENT_SIZE = 7`), `thide` 3×f32 (12), `mid` f32 (4) and `midx` u32 (4). That is 52 B/px.
- **What the notes say:** `notes/wet.md:209` and `notes/round6.md` §3 say 44 B/px, "about 300 MB at 3200 × 2240".
- **Actual cost:**
  - About 373 MB at 3200 × 2240 (7.17 Mpx × 52 B).
  - `mid`/`midx` are always zero between strokes (`notes/wet.md` §7), yet `Wet` derives `Clone`. The easel keeps a full canvas clone per undo or checkpoint snapshot (`crates/easel/src/session.rs:146`), so each session holds up to undo + checkpoints + 1 copies of the whole +52 B/px.
  - At the easel's default width (1000 × 667 at 3:2) that is about 35 MB per snapshot, roughly half a GB per session at the default ring. A 3200 `look --scale` session scales the same way.
- **Fix:**
  - Correct the figure in `notes/wet.md` and `notes/round6.md`.
  - Take `mid`/`midx` out of the cloned state: give `Wet` a manual `Clone` that leaves them empty and let `surf()` allocate them lazily (they are per-stroke scratch), or keep them in a canvas-level scratch buffer that isn't cloned or checkpointed.

### 6. [Low · r6-wet · verified] The dirty-tip layer does nothing in strokes made with pointed brushes
- **Where:** `r6-wet:crates/paint/src/bristle.rs:930-932`: `feed` calls `fold_tip(1.0)` on every bristle. Line 1093 gives `feed_k = tool.point * …`, which is greater than 0 for every round and rigger (`point: 1.0`, lines 175 and 218). Line 1200 calls `feed` once per step.
- **What's wrong:** for pointed tools, whatever a bristle picks up is folded into its reservoir on the very next step. So `TIP_RUN` and "what it picked up goes down first" (`notes/wet.md` §6) never apply to a round's or rigger's strokes. Their pickup mixes straight into the load, which is pass 2's behavior. Touches are unaffected because `touch_on` doesn't feed.
- **Fix:** in `feed`, average and share only the reservoir part: take `rv = vol − tip`, scale `rv` by `(1 − k)`, mix the share into it, then set `vol = rv + tip`, leaving the tip (and `tip ≤ vol`) intact. Add the round-brush analogue of `touches_of_one_load_dirty_as_they_go` for a drag.

### 7. [Low · r6-wet · verified] Merging r6-wet into main conflicts on the recorded hashes, and neither side's value is right
- **Where:** `git merge-tree --write-tree main r6-wet` reports conflicts in `crates/easel/tests/hand_time.rs` (the `existing_logs_replay_unchanged` hashes) and `crates/paint/tests/golden_scene.txt`.
- **What's wrong:** main re-recorded these for the varnish settle (`43dc652`) and the branch re-recorded them for the wet engine. The merged engine has both changes, so it matches neither recorded hash. The branch's A/B evidence and panels also predate the varnish fix.
- **Fix:** after merging, re-record the golden in debug and the replay hashes in both profiles (`PRINT_HASHES=1`), and name both intended changes in the comment. Taking either side of the conflict leaves the test red.

### 8. [Low · r6-wet · verified, test only] The conservation test's "moves through set-aside paint" check can pass because of other tests
- **Where:** `r6-wet:crates/paint/src/bristle.rs:804`: `MID_MOVES` is a process-global static. Lines 2335-2354 assert that the deltas are over 100.
- **What's wrong:** cargo runs tests on parallel threads in one process, and every wet-on-wet test that sets a film aside increments the same counters. The assertion meant to show that the test exercised the set-aside path can therefore pass on other tests' activity, which weakens the regression guard for the §7 conservation fix.
- **Fix:** make the counters `thread_local!`. The test's `drag` and `touch` calls run `exchange` inline on the test's own thread, so a thread-local count sees only that test. Or have a test-only field on the canvas count them.

## Checked and found sound (no finding)
- **Hand time off leaves output unchanged:**
  - `run_plans` with `slice = None` gives one batch holding every tile, with ids assigned in tile-index order as before, and `rng` is consumed exactly as before.
  - `stipple` computes the same ids and order.
  - `flush` puts nothing on the clock (`hand_owed` is 0 with hand time off).
- **Stroke ids per slice:** they sit above the wait's watermark, and ids are allocated before the crop filter.
- **Checkpoints:** the PAINTCK7 ledger and slice round-trip, and PAINTCK8 appends after them with the corrupt-offset test updated. `mid` is always 0 between strokes (every `exchange` caller settles it, with no early return in between).
- **Clock bookkeeping:**
  - `flush`'s "away" accounting counts finishing-verb drying exactly once.
  - `glaze` and `wait` update `s.clock` before `flush`, so their time isn't reported twice.
  - `rest(math.huge)` falls through to `dry()` instead of hanging.
- **`settle_film`:**
  - It is only reached after `dry()`.
  - It conserves volume through the same global rescale `settle` uses.
  - It keeps `PEAK_FILM_UM` on the peaks and caps pools at `POOL_MAX`.
  - A sub-epsilon `add` yields `t = 0` and no division by zero.
- **Easel `root()`:** `EASEL_ROOT`, then cwd ancestors, then the build path. The fallback outside any checkout behaves as before, and the socket, log and `current` file all resolve against the same root per process.
- **Bare trees:**
  - `drawn` iterates no `HashMap` (lookups only).
  - The sort is total with an index tiebreak.
  - `subdivide` carries `own` correctly.
  - Every species sets `twig_len` and `angular` explicitly, so the oak's `twig_len` 1.8 → 1.1 doesn't leak into other species.
- **r6-wet layer bookkeeping:**
  - `add`/`lay`/`stir`/`add_body`/`take`/`take_column`/`settle_mid` each keep `body = vol − top − mid` consistent.
  - The tip handling in `load`/`wipe`/`exchange`/ghost keeps `tip ≤ vol`.
  - `bake` composites the surface over the body and clears `top`.
  - Lift-off's longer trail (`p + 0.6·lift·(1 − p) ≤ 1`) stays inside `footprint`'s `bend·0.6` pad, so the unsafe tile scheduling stays sound.
- **Determinism:** no new parallel float reductions, time seeds or `HashMap` iteration in either change set. The tests for 1 vs 4 threads cover hand time.
- **Paths:** no absolute paths or real names added.

## Verdict
- **main:** safe as merged for existing logs; with hand time off, output is unchanged byte for byte. Hand time itself has one real correctness bug: long passes fill over their own set paint (finding 1). It also has two accuracy issues in the clock (findings 2 and 3) and one order leak (finding 4). The varnish, relief, root and bare-tree changes are clean. Fix finding 1 before relying on hand time for the benchmarks.
- **r6-wet:** the layer and conservation logic holds up under a line-by-line read. Before merging, fix the memory figure and the idle snapshot copies (finding 5) and make the tip survive `feed` or document that it doesn't (finding 6). Expect the hash conflict (finding 7) and re-record both profiles. Finding 8 is a small test-hygiene fix.
