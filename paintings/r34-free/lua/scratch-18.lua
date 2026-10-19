-- easel session "scratch": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box every
--@ engine 5

--@ chunk 1
canvas{aspect=1.3333333333333333, ground={{apply="knife", pile={{"lead white", 3}, {"yellow ochre", 1}, {"raw umber", 0.4}}, texture=0.1, um=40}}, linen={24, 22}, seed=5, size=600}

--@ chunk 2
zen = pile{{"ultramarine blue", 1}, {"cerulean blue", 1}, {"lead white", 1.0}, turps=0.5}
blu2 = pile{{"cerulean blue", 1}, {"lead white", 1.3}, {"permanent alizarin", 0.3}, turps=0.5}
lil = pile{{"rose madder", 1}, {"ultramarine blue", 0.4}, {"lead white", 1.6}, turps=0.5}
pch = pile{{"pale cadmium", 1}, {"rose madder", 0.4}, {"lead white", 1.5}, turps=0.5}
gold = pile{{"cadmium yellow", 1}, {"lead white", 1.5}, turps=0.5}
sky = rect(0, 0, 1000, 425)
work(sky, {hand="broad", coverage=1.5, fill=true, piles={
  {zen, function(x,y) return clamp((120 - y)/120, 0, 1) end},
  {blu2, function(x,y) return clamp(1 - math.abs(y-110)/110, 0, 1) end},
  {lil, function(x,y) return clamp(1 - math.abs(y-220)/110, 0, 1) end},
  {pch, function(x,y) return clamp(1 - math.abs(y-330)/100, 0, 1) end},
  {gold, function(x,y) return clamp((y-360)/90, 0, 1) end}}})
wait(4320)
print(drying(200,60), drying(500,200), drying(500,350))

--@ chunk 3
gTop = pile{{"ultramarine blue", 0.7}, {"permanent alizarin", 0.4}, {"burnt sienna", 0.1}, medium=0.8, name="gTop"}
print(gTop)
gM = rect(0, 0, 1000, 130)
work(gM, {hand="glaze", pile=gTop, coverage=1.0})
print("glaze laid on dry sky top", drying(200,60))
