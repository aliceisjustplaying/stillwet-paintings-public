-- easel session "scratch": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box friedrich
--@ engine 7

--@ chunk 1
canvas{aspect=1.3333333333333333, ground={{apply="knife", pile={{"red earth", 3.5}, {"yellow ochre", 4.0}, {"lead white", 2.5}}, texture=0.25, um=45}, {apply="knife", pile={{"lead white", 7.0}, {"yellow ochre", 2.0}, {"raw umber", 0.6}}, texture=0.2, um=35}, {apply="brush", pile={{"lead white", 14.0}, {"yellow ochre", 0.7}, {"raw umber", 0.25}, {"vermilion", 0.06}}, texture=0.35, um=30}}, linen={15, 13}, seed=1818, size=800}

--@ chunk 2
-- Scratch Trial 1: Compare sky gradations (thinner=0.35 vs medium=0.15) and dark rock underpaint (thinner=0.45 vs turps=0.45 vs tube body)
-- Left strip (x=100..350): Sky gradation with thinner=0.35, coverage=1.4
p_zen_thin = pile{{"smalt", 5.0}, {"Prussian blue", 0.35}, {"rose madder", 0.35}, {"lead white", 1.2}, thinner=0.35, oil="walnut", name="zen_thin"}
p_mid_thin = pile{{"pale smalt", 5.0}, {"lead white", 7.0}, {"Naples yellow", 1.2}, thinner=0.35, oil="walnut", name="mid_thin"}
p_hor_thin = pile{{"lead white", 7.0}, {"Naples yellow", 4.0}, {"yellow ochre", 1.5}, {"vermilion", 0.45}, {"rose madder", 0.40}, thinner=0.35, oil="walnut", name="hor_thin"}

work(rect(100, 80, 220, 420), {
  hand = "broad",
  piles = {
    {p_zen_thin, function(x, y) return clamp(1 - (y - 80) / 180, 0, 1) end},
    {p_mid_thin, function(x, y) return clamp(1 - math.abs(y - 280) / 150, 0, 1) end},
    {p_hor_thin, function(x, y) return clamp((y - 260) / 200, 0, 1) end}
  },
  angle = 0,
  coverage = 1.4,
  load = 0.8,
  fill = true,
  clip = true
})

-- Middle strip (x=360..610): Sky gradation with medium=0.15 (no thinner), coverage=1.6, followed by 1 pass of blend and stipple transition
p_zen_med = pile{{"smalt", 5.0}, {"Prussian blue", 0.35}, {"rose madder", 0.35}, {"lead white", 1.5}, medium=0.15, oil="walnut", name="zen_med"}
p_up_med  = pile{{"smalt", 4.0}, {"pale smalt", 3.5}, {"lead white", 4.0}, {"rose madder", 0.25}, medium=0.15, oil="walnut", name="up_med"}
p_mid_med = pile{{"pale smalt", 4.5}, {"lead white", 7.5}, {"Naples yellow", 1.4}, medium=0.15, oil="walnut", name="mid_med"}
p_hor_med = pile{{"lead white", 7.0}, {"Naples yellow", 4.5}, {"yellow ochre", 1.5}, {"vermilion", 0.45}, {"rose madder", 0.40}, medium=0.15, oil="walnut", name="hor_med"}

work(rect(360, 80, 220, 420), {
  hand = "broad",
  piles = {
    {p_zen_med, function(x, y) return clamp(1 - (y - 80) / 140, 0, 1) end},
    {p_up_med,  function(x, y) return clamp(1 - math.abs(y - 210) / 120, 0, 1) end},
    {p_mid_med, function(x, y) return clamp(1 - math.abs(y - 330) / 120, 0, 1) end},
    {p_hor_med, function(x, y) return clamp((y - 320) / 160, 0, 1) end}
  },
  angle = 0,
  coverage = 1.6,
  load = 0.85,
  fill = true,
  clip = true
})
blend(rect(365, 85, 210, 410), {angle = 0, coverage = 0.6})

-- Right strip (x=640..880): Compare dark rock/oak underpaint recipes
-- Patch A (y=100..210): thinner=0.45 (solvent-limited thin wash)
p_dark_thinner = pile{{"raw umber", 4.0}, {"bone black", 2.5}, {"Prussian blue", 0.6}, {"yellow ochre", 1.0}, thinner=0.45, name="dark_thinner"}
work(rect(640, 100, 200, 100), {hand="body", pile=p_dark_thinner, coverage=1.5, load=0.8, fill=true, clip=true})

-- Patch B (y=230..340): turps=0.45 (evaporates on application, fuller pigment deposit)
p_dark_turps = pile{{"raw umber", 4.0}, {"bone black", 2.5}, {"Prussian blue", 0.6}, {"yellow ochre", 1.0}, turps=0.45, name="dark_turps"}
work(rect(640, 230, 200, 100), {hand="body", pile=p_dark_turps, coverage=1.5, load=0.8, fill=true, clip=true})

-- Patch C (y=360..470): unthinned tube body with walnut oil
p_dark_body = pile{{"raw umber", 4.0}, {"bone black", 2.5}, {"Prussian blue", 0.6}, {"yellow ochre", 1.0}, oil="walnut", name="dark_body"}
work(rect(640, 360, 200, 100), {hand="body", pile=p_dark_body, coverage=1.5, load=0.85, fill=true, clip=true})

print("Scratch trial 1 laid")
