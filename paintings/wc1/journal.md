- day 1, 09:00: ## Sitting 1 — setup & trials
  Paper: cold-press 1056x704 seed 4127. Subject: evening estuary at low tide — blue sky, grey-violet cloud bank, warm glow at horizon (y≈330), headland left, mud flats with bright channels, posts & small boat.
  
  Trials (scratch, cold-press dry paper):
  - Brush release is strongly front-loaded: a single long stroke dumps most of its load in the first ~200 cells regardless of pressure ramp (0.1→1.0 made no visible difference). Width-80 brush with 500µL emptied in one 1056 stroke.
  - Even rows: segments of ~60–70 cells, topping up the brush to a fixed load each segment (width 60, 8µL water, 0.08 cerulean) gave a fairly even band. 20µL/segment gave blobby blooms at each segment start.
  - Pre-wetting via drop{} grid: 22µL r85 → surface water 2.9, flood: pigment travels across the whole wet area and piles at the wet boundary; colors don't stay put. 8µL r80 per drop (spacing ~118x95) → surface water 1.16, workable ~6s, colors mostly stay but blue still migrated into unpainted wet band and made a dark front against the yellow band (reads like a cloud bank).
  - Segment rows over 1056 width × 4 rows ≈ 1.7s per colour group with dur 0.03/segment.
- day 1, 09:00: ## Painting — campaign log
  - Sky (t 0–15s): drop grid 5µL r80 (y 10..300, spacing ~118x95), then 9 rows (y 5..335 step 40) width-80 brushes, steady() segment top-up 6µL each 25 cells, speed 3500. Mixes per row interpolated: cerulean+ultramarine 0.07 each top → ultramarine+rose 0.025/0.05 mid → pyrrol 0.03 + naples 0.02 peach → indian-yellow 0.03 gold. Result: soft cloudy blue top, violet-grey band, golden glow. Good. Hypothesis: the whole bands blend because of the light pre-wet.
  - Headland: outline steady width 26 water 4 then fill rows step 10 same brush immediately; ultramarine .05 rose .04 cerulean .006 raw umber .006. Dry paper. Reads well, crisp at top, granulating.
  - Flats: pre-wet drops 5µL, rows y 372..704 gold→peach→rose→blue. The blue lower part then mostly covered.
  - Mud banks: rows step 13, width 34, water 5, burnt-umber .03-.07 + ultramarine .03-.05 + rose .02 + burnt sienna var + raw umber .01, on dry flats. Result: too heavy & warm, top edge one hard straight line at y≈420. Channel shape good.
  Scratch observation: on dry paper, quick steady rows of same mix next to each other merge well; edges where the row ends make a hard, slightly ragged edge.
- day 1, 09:02: - Scratch sheet broke at painting t≈160s: a big trial chunk timed out ("easel didn't answer"), afterwards every scratch call returns "File exists (os error 17)", even with new_scratch. Lesson: keep chunks small (< ~30 rows of steady() across the full width); the painting itself still works. Trials now must be done cautiously on the painting.
  - Clouds in glow: wet streak (water only, width=thick) then broken dabs of ultramarine .055/rose .045/burnt sienna .012, 1.8µL, width .35–.6·thick: reads as soft cumulus bars with crisp bumpy tops. Good.
  - Boat (indian red hull, buff interior, sepia+ultramarine gunwales), posts (sepia .25 + ultramarine .2 + rose .03, multiple parallel passes, naples/buff/cad orange rim cap) — read well at this scale.
- day 1, 09:04: ## Handoff — end of sitting 1 (t≈280s, sheet dry)
  Title: "Low Water, Evening Glow". Finished for now.
  
  What's on the sheet: blue sky graded through violet cloud bars to a gold horizon glow; violet headland left, faint far spit right; flats in peach/gold with glow-sheen streaks; two mud banks split by a winding pale-blue channel; posts receding along the left bank, a red dinghy on the right bank with a rope to a stake; cobalt pools in the foreground; reed tufts along the bank edges; four gulls.
  
  Unresolved passages:
  - Foreground pools are flat, saturated cobalt (cobalt .4 + buff .3 + rose .12, width 12–16, 2µL); a rose .03/ultramarine .012 glaze over them barely registered. A warmer glaze (rose .06, pyrrol .03, naples .08, burnt sienna .02, width 12, 2.2µL) on the small bottom-left pool turned it a dull, stripy tan. Not fixed. I've left them blue as sky reflections.
  - The bank tops are fairly straight and banded, and the horizontal row strokes show as stripes in the far flats (y 400–480).
  - The pinkish sheen bars (x≈380–470 y 562, x≈690–790 y 572, x≈940–1050 y 562) read as flat rectangles.
  - Headland base is a hard straight line; the faint reflection glaze below it (ultramarine .02 / rose .018 / naples .01, width 12, 3µL) softens it a little.
  - Unsigned.
  
  Practical lessons (hypotheses unless noted):
  - OBSERVED: brush release is front-loaded. For even coverage, top the brush up to a fixed small load every 10–25 cells (my steady()/topup helpers). Width 80, 6µL per 25 cells at speed 3500 makes a smooth wash; width 34, 5µL per 25 cells for mud.
  - OBSERVED: pre-wetting with a drop grid of 5µL r80 (~118×95 spacing) gives soft wet-in-wet sky bands that keep their place. 22µL floods, and the pigment runs to the wet boundary.
  - OBSERVED: opaque mixes need heavy loads to show over dark mud. Buff-titanium/naples at 0.1–0.15 disappear; at 0.6–0.8 they show as light. Over pale ground, buff 0.16 + naples 0.06 gives a misty veil.
  - OBSERVED: thin dark lines need sepia .25–.35 + ultramarine .2–.25. Sepia .15 at width 2 vanished on the mud.
  - FAILED: a big scratch trial chunk (≈50 full-width rows of steady() plus waits) timed out. After that every scratch call returned "File exists (os error 17)", even with new_scratch. For the rest of the sitting I ran trials in hidden corners of the painting. Keep chunks small; if scratch breaks again, don't keep retrying it.
  - Clouds: a water-only streak, then broken dabs (ultramarine .055, rose .045, burnt sienna .012, 1.8µL) give bumpy-topped cloud bars with soft bottoms.
