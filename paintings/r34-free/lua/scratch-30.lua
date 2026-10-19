-- easel session "scratch": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box every
--@ engine 5

--@ chunk 1
canvas{aspect=1.3333333333333333, ground={{apply="knife", pile={{"lead white", 3}, {"yellow ochre", 1}, {"raw umber", 0.4}}, texture=0.1, um=40}}, linen={24, 22}, seed=5, size=600}

--@ chunk 2
zen = pile{{"ultramarine blue", 1}, {"cerulean blue", 1}, {"lead white", 1.0}, turps=0.5, name="zen"}
blu2 = pile{{"cerulean blue", 1}, {"lead white", 1.3}, {"permanent alizarin", 0.3}, turps=0.5, name="blu2"}
lil = pile{{"rose madder", 1}, {"ultramarine blue", 0.4}, {"lead white", 1.6}, turps=0.5, name="lil"}
skyS = rect(0, 0, 1000, 125)
work(skyS, {hand="broad", coverage=1.5, fill=true, piles={
  {zen, function(x,y) return clamp((120 - y)/120, 0, 1) end},
  {blu2, function(x,y) return clamp(1 - math.abs(y-60)/60, 0, 1) end},
  {lil, function(x,y) return clamp(1 - math.abs(y-110)/50, 0, 1) end}}})
thinM = rect(300, 20, 140, 40)
work(thinM, {hand="broad", pile=blu2, coverage=0.45, fill=true, clip=true, edge="soft"})
print("sky with thin patch, scratch fresh", drying(360,40), drying(200,60))

--@ chunk 3
wait(5 * 1440)
print("thin sky after 5 days", drying(360,40), drying(200,60), drying(600,60))
