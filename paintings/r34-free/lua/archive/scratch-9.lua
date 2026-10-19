-- easel session "scratch": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box every
--@ engine 5

--@ chunk 1
canvas{aspect=1.3333333333333333, ground={{apply="knife", pile={{"lead white", 3}, {"yellow ochre", 1}, {"raw umber", 0.4}}, texture=0.1, um=40}}, linen={24, 22}, seed=5, size=600}

--@ chunk 2
dkA = pile{{"rose madder", 0.4}, {"ultramarine blue", 0.5}, {"burnt sienna", 0.3}, {"lead white", 0.5}, turps=0.2, name="dkA"}
dkB = pile{{"ultramarine blue", 0.6}, {"burnt sienna", 0.7}, {"permanent alizarin", 0.4}, {"bone black", 0.1}, {"lead white", 0.15}, turps=0.15, name="dkB"}
dkC = pile{{"burnt sienna", 0.8}, {"ultramarine blue", 0.6}, {"bone black", 0.3}, {"permanent alizarin", 0.2}, turps=0.1, name="dkC"}
fgR = rect(0, 452, 1000, 298)
work(fgR, {hand="broad", coverage=1.2, fill=true, angle=0.03, piles={
  {dkA, function(x,y) return clamp(1 - (y-455)/50, 0, 1) end},
  {dkB, function(x,y) return clamp(1 - math.abs(y-560)/120, 0, 1) end},
  {dkC, function(x,y) return clamp((y-580)/140, 0, 1) end}}})
wait(1440)
print(drying(300,500), drying(300,600), drying(300,700))

--@ chunk 3
wait(1440)
print(drying(300,500), drying(300,600), drying(300,700))

--@ chunk 4
wait(1440)
print(drying(300,500), drying(300,600), drying(300,700))

--@ chunk 5
shineLil = pile{{"rose madder", 0.5}, {"ultramarine blue", 0.3}, {"lead white", 1.3}, turps=0.2, name="shineLil"}
shineGold = pile{{"pale cadmium", 0.6}, {"rose madder", 0.3}, {"lead white", 1.2}, turps=0.2, name="shineGold"}
band1 = rect(0, 455, 1000, 60)
work(band1, {hand="scumble", pile=shineLil, coverage=0.5, fill=false, load=0.35, clip=true})
print("scumble trial laid")
