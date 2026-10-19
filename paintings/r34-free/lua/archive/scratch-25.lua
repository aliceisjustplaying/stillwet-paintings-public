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
seaVio = pile{{"ultramarine blue", 0.8}, {"permanent alizarin", 0.5}, {"rose madder", 0.2}, {"lead white", 0.7}, name="seaVio"}
work(ellipse(566, 480, 50, 16), {hand="body", pile=seaVio, coverage=1.5, fill=true, clip=true, edge="soft", load=1.0})
wait(8640)
print("blob on scratch", drying(566,480))

--@ chunk 3
wait(5760)
print("blob on scratch", drying(566,480))

--@ chunk 4
wait(4320)
print("blob on scratch", drying(566,480))

--@ chunk 5
coverOv = ellipse(566, 480, 80, 30):blur(14)
work(coverOv, {hand="broad", coverage=1.5, fill=true, clip=true, edge="soft", load=1.0, angle=0.02, piles={
  {cTop, function(x,y) return clamp((482 - y)/16, 0, 1) end},
  {cMid, function(x,y) return clamp((y - 478)/16, 0, 1) end}}})
print("feathered sea cover laid on blob (scratch)", drying(566,480))

--@ chunk 6
wait(8640)
print(drying(566,480))
