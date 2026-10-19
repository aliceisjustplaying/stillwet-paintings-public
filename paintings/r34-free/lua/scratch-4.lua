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
-- cloud banks: three irregular masses, dusky violet on top, rose underneath
cA = poly({{330,330},{380,316},{450,322},{520,310},{600,318},{612,340},{560,346},{480,342},{400,352},{340,350}}, true)
cB = poly({{560,312},{640,292},{720,286},{800,298},{880,292},{960,320},{958,336},{880,330},{800,338},{720,330},{650,344},{600,336}}, true)
cC = poly({{760,352},{820,344},{880,350},{920,358},{860,366},{800,364}}, true)
cl1 = pile{{"ultramarine blue", 0.6}, {"permanent alizarin", 0.5}, {"lead white", 0.8}, turps=0.4}
cl2 = pile{{"rose madder", 0.8}, {"lead white", 1.2}, {"pale cadmium", 0.3}, turps=0.4}
work(cA + cB + cC, {hand="broad", pile=cl1, coverage=0.9, fill=true, edge="soft"})
work(cA + cB, {hand="broad", pile=cl2, coverage=0.5, fill=true, edge="soft", at=nil})
-- the sun: a light veil, blended into the sky, then a pale core
halo_p = pile{{"pale cadmium", 1}, {"lead white", 0.8}, {"deep cadmium", 0.3}, {"rose madder", 0.1}, turps=0.5}
core_p = pile{{"pale cadmium", 1}, {"lead white", 1.8}, turps=0.3}
halo = ellipse(646, 404, 110, 40)
work(halo, {hand="broad", pile=halo_p, coverage=0.8, fill=true, edge="lost"})
blend(halo, {})
core = ellipse(646, 402, 20, 15)
work(core, {hand="body", pile=core_p, coverage=1.2, fill=true, edge="soft"})
print("sky, cloud and sun laid")

--@ chunk 3
seaD = pile{{"ultramarine blue", 0.7}, {"Prussian blue", 0.25}, {"permanent alizarin", 0.3}, {"lead white", 0.5}, turps=0.2}
sandMid = pile{{"yellow ochre", 0.6}, {"rose madder", 0.5}, {"ultramarine blue", 0.3}, {"lead white", 0.9}, turps=0.3}
sandDark = pile{{"burnt sienna", 0.6}, {"ultramarine blue", 0.8}, {"permanent alizarin", 0.5}, {"lead white", 0.3}, {"bone black", 0.2}}
sea = rect(0, 424, 1000, 22)
work(sea, {hand="broad", pile=seaD, coverage=1.2, fill=true, edge="soft"})
sand = rect(0, 444, 1000, 306)
work(sand, {hand="broad", coverage=1.3, fill=true, piles={
  {sandMid, function(x,y) return clamp(1 - (y-470)/60, 0, 1) end},
  {sandDark, function(x,y) return clamp((y-500)/150, 0, 1) end}}})
print("sea and sand laid")
