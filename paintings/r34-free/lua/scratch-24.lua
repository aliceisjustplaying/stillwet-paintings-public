-- easel session "scratch": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box every
--@ engine 5

--@ chunk 1
canvas{aspect=1.3333333333333333, ground={{apply="knife", pile={{"lead white", 3}, {"yellow ochre", 1}, {"raw umber", 0.4}}, texture=0.1, um=40}}, linen={24, 22}, seed=5, size=600}

--@ chunk 2
wkL = pile{{"cerulean blue", 0.8}, {"permanent alizarin", 0.3}, {"lead white", 1.4}, turps=0.4, name="wkL"}
wkM = pile{{"ultramarine blue", 0.8}, {"permanent alizarin", 0.5}, {"lead white", 0.9}, turps=0.4, name="wkM"}
wkD = pile{{"Prussian blue", 0.5}, {"ultramarine blue", 0.7}, {"permanent alizarin", 0.3}, {"lead white", 0.5}, turps=0.3, name="wkD"}
wr = rect(0, 452, 1000, 298)
work(wr, {hand="broad", coverage=1.4, fill=true, angle=0.02, piles={
  {wkL, function(x,y) return clamp(1 - (y-452)/50, 0, 1) end},
  {wkM, function(x,y) return clamp(1 - math.abs(y-580)/130, 0, 1) end},
  {wkD, function(x,y) return clamp((y-600)/150, 0, 1) end}}})
wait(5760)
ovalS = ellipse(566, 480, 50, 16)
seaLil = pile{{"rose madder", 0.3}, {"cerulean blue", 0.5}, {"lead white", 1.4}, turps=0.35, name="seaLil"}
work(ovalS, {hand="body", pile=seaLil, coverage=1.0, fill=true, clip=true, edge="soft", load=0.8})
wait(8640)
print(drying(566,480))
