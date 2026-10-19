-- easel session "scratch": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box every
--@ engine 5

--@ chunk 1
canvas{aspect=1.3333333333333333, ground={{apply="knife", pile={{"lead white", 3}, {"yellow ochre", 1}, {"raw umber", 0.4}}, texture=0.1, um=40}}, linen={24, 22}, seed=5, size=600}

--@ chunk 2
sandA = pile{{"rose madder", 0.4}, {"yellow ochre", 0.5}, {"ultramarine blue", 0.2}, {"lead white", 1.0}, turps=0.3}
sandB = pile{{"burnt sienna", 0.5}, {"ultramarine blue", 0.5}, {"permanent alizarin", 0.3}, {"lead white", 0.6}, turps=0.3}
sandC = pile{{"burnt sienna", 0.8}, {"raw umber", 0.3}, {"bone black", 0.2}, {"lead white", 0.3}, turps=0.2}
sandR = rect(0, 448, 1000, 302)
work(sandR, {hand="broad", coverage=1.3, fill=true, piles={
  {sandA, function(x,y) return clamp(1 - (y-450)/90, 0, 1) end},
  {sandB, function(x,y) return clamp(1 - math.abs(y-560)/110, 0, 1) end},
  {sandC, function(x,y) return clamp((y-580)/120, 0, 1) end}}})
print("sand base trial laid")

--@ chunk 3
glA = pile{{"pale cadmium", 1}, {"lead white", 1.6}, turps=0.2}
glB = pile{{"lead white", 1}, {"cadmium yellow", 0.4}, {"rose madder", 0.2}, turps=0.2}
col = poly({{622,448},{672,448},{700,540},{600,540}}, true)
b = brush("flat", 6)
work(col, {hand="scumble", pile=glA, coverage=0.7, clip=true, scale_at=function(x,y) return 0.6 + (y-448)/160 end, load=0.35})
print("glitter trial laid")
