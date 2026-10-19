-- easel session "scratch": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box every
--@ engine 5

--@ chunk 1
canvas{aspect=1.3333333333333333, ground={{apply="knife", pile={{"lead white", 3}, {"yellow ochre", 1}, {"raw umber", 0.4}}, texture=0.1, um=40}}, linen={24, 22}, seed=5, size=600}

--@ chunk 2
-- Sky trial: graded broad strokes, thinned lay-in, on the buff ground
zen = pile{{"ultramarine blue", 1}, {"cerulean blue", 1}, {"lead white", 1.0}, turps=0.5}
mid = pile{{"cerulean blue", 1}, {"lead white", 1.5}, {"permanent alizarin", 0.15}, turps=0.5}
hor = pile{{"cadmium yellow", 1}, {"lead white", 1.5}, turps=0.5}
warm = pile{{"deep cadmium", 1}, {"lead white", 0.6}, turps=0.5}
sky = rect(0, 0, 1000, 450)
b = brush("filbert", 22)
work(sky, {hand="broad", coverage=1.5, piles={
  {zen, function(x,y) return clamp((260 - y)/260, 0, 1) end},
  {mid, function(x,y) return clamp(1 - math.abs(y-170)/170, 0, 1) end},
  {hor, function(x,y) return clamp((y-120)/260, 0, 1) end},
  {warm, function(x,y) return clamp((y-300)/150, 0, 1) end}}})
print("sky laid")
