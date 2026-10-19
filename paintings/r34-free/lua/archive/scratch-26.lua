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
wait(5760)
cTop = pile{{"rose madder", 0.3}, {"ultramarine blue", 0.2}, {"lead white", 1.2}, {"pale cadmium", 0.15}, turps=0.4, name="cTop"}
cMid = pile{{"ultramarine blue", 0.8}, {"permanent alizarin", 0.5}, {"lead white", 0.9}, turps=0.4, name="cMid"}
cLow = pile{{"Prussian blue", 0.4}, {"ultramarine blue", 0.8}, {"permanent alizarin", 0.3}, {"lead white", 0.4}, turps=0.3, name="cLow"}
PATHENV = poly({{628,440},{664,440},{722,650},{520,650}}, true)
seaCoatM = rect(0, 452, 1000, 298) - PATHENV
work(seaCoatM, {hand="broad", coverage=1.2, fill=true, clip=true, angle=0.02, edge="soft", piles={
  {cTop, function(x,y) return clamp(1 - (y-452)/60, 0, 1) end},
  {cMid, function(x,y) return clamp(1 - math.abs(y-560)/120, 0, 1) end},
  {cLow, function(x,y) return clamp((y-580)/140, 0, 1) end}}})
wait(5760)
muteP = pile{{"ultramarine blue", 0.7}, {"permanent alizarin", 0.4}, {"Prussian blue", 0.15}, {"lead white", 0.9}, turps=0.3, name="muteP"}
muteM = rect(0, 640, 320, 110):blur(14) * rect(0, 452, 1000, 298)
work(muteM, {hand="broad", pile=muteP, coverage=1.1, fill=true, clip=true, edge="soft", load=0.9, angle=0.02})
wait(8640)
print("strip on scratch", drying(120,683))

--@ chunk 3
darkV = pile{{"Prussian blue", 0.4}, {"ultramarine blue", 0.9}, {"permanent alizarin", 0.3}, {"lead white", 0.35}, turps=0.3, name="darkV"}
fadeM = rect(120, 610, 260, 140):blur(40) * rect(0, 452, 1000, 298)
work(fadeM, {hand="broad", pile=darkV, coverage=1.2, fill=true, clip=true, edge="soft", load=0.9, angle=0.02})
wait(8640)
print("fade on scratch", drying(300,680))
