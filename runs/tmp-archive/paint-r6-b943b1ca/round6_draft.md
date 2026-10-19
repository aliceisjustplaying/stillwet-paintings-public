# Round 6, night 1 (2026-09-24): what happened while you slept

Read this first. Everything here waits for your eye; the critic panels are
diagnostic only (they name defects, they don't decide).

## Decisions waiting for you (in order of payoff)
1. **Relief strength**: `notes/round6/relief/` (README + sheets). Pick off
   / vlow 0.06 / low 0.12 / current 0.2; the winner becomes the Friedrich
   default. My pick for you to check: vlow or low.
2. **Merge r6-wet?** (real wet-on-wet; changes how every painting looks).
   Evidence: `notes/round6/wet/` and the branch's `notes/wet/`.
3. **Merge r6-oak?** (bare trees: connected, angular, tapering; changes
   the `trees_in` study, not the benchmarks). Evidence: branch
   `notes/oak/p2_*.jpg`.
4. **Lab studies**: `notes/lab/` (A old way, B new way, C third try for
   foliage and bare tree). Which look good to you?

## What's on main now (all tests pass; benchmarks render byte-identical)
- **Hand in time** (merged from r6-time, opt-in): every stroke, touch and
  palette trip costs hand time (Fitts and steering laws, tapping rate,
  reload and mixing estimates); with `canvas{..., hand=true}` the paint
  ages while the hand works, long passes in 15-minute slices; `sitting{}`,
  `rest()`, `timesheet()`; `easel look --mode wet` shows open, setting,
  tacky and dry. Existing logs replay unchanged. Notes: `notes/time.md`;
  guide: `crates/easel/README.md` "Hand time and sittings". For scale:
  l5_near is about 73 hours of hand time (53 in the fir wood), l3_green 52.
- **Easel root fix**: the easel finds its checkout from the working
  directory (`EASEL_ROOT` overrides). Worktrees with a copied `target/`
  were writing logs, renders and the default session into main, and one
  lab painter's `easel undo` hit another's session (nothing lost).
- **Lab study pairs** (notes only) and the relief sheets.
- Tests pass on the M3 Pro in debug (the golden is recorded in debug; a
  `--release` run reports a golden mismatch by design).

## 1. Relief A/B
The relief lighting makes the canvas weave grid and the ridge creases: at
0.2 the green sky is covered in embossed diagonal creases and tree holes
get raised outlines; at 0.06 they're nearly gone; off looks like a print.
It does NOT make the knife-cut hatching, pale rims around objects, the fog
rectangle in the near wood or the pale halos in the green tree's holes:
those are identical at every strength. So Astra was right that relief isn't
the whole plateau, but it is the "grooves".

## 2. The lab
TODO table + my eye

## 3. Wet-on-wet (branch r6-wet)
TODO

## 4. Bare trees (branch r6-oak)
TODO

## 5. What the panels said, across everything
TODO
