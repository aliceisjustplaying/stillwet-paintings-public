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
cl1 = pile{{"ultramarine blue", 0.8}, {"permanent alizarin", 0.6}, {"burnt sienna", 0.3}, {"lead white", 0.6}, turps=0.3}
cloud = poly({{340,322},{400,306},{470,312},{540,296},{620,300},{700,288},{780,300},{860,296},{960,326},{965,370},{900,366},{830,374},{760,362},{700,366},{664,352},{626,362},{580,372},{520,366},{460,378},{400,372},{340,368}}, true)
work(cloud, {hand="broad", pile=cl1, coverage=1.2, fill=true, clip=true})
print("sky and cloud laid")

--@ chunk 3
halo_p = pile{{"deep cadmium", 1}, {"lead white", 0.6}, {"rose madder", 0.15}, turps=0.3}
core_p = pile{{"pale cadmium", 1}, {"lead white", 1.4}, turps=0.3}
halo = ellipse(646, 406, 120, 44)
core = ellipse(646, 402, 26, 19)
work(halo, {hand="broad", pile=halo_p, coverage=1.0, fill=true, edge="lost"})
work(core, {hand="body", pile=core_p, coverage=1.5, fill=true, edge="soft"})
print("sun laid")
