-- easel session "scratch": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box every
--@ engine 5

--@ chunk 1
canvas{aspect=1.3333333333333333, ground={{apply="knife", pile={{"lead white", 3}, {"yellow ochre", 1}, {"raw umber", 0.4}}, texture=0.1, um=40}}, linen={24, 22}, seed=5, size=600}

--@ chunk 2
-- rebuild the scratch: a yellow block over a warm sky (like the painting's right side), dried
skyVio = pile{{"permanent alizarin", 0.4}, {"ultramarine blue", 0.4}, {"rose madder", 0.3}, {"lead white", 1.0}, turps=0.4, name="skyVio"}
skyGld = pile{{"cadmium yellow", 0.8}, {"pale cadmium", 0.4}, {"rose madder", 0.2}, {"lead white", 1.1}, turps=0.4, name="skyGld"}
blk = poly({{725,330},{1000,330},{1000,420},{725,420}}, true)
work(blk, {hand="broad", coverage=1.5, fill=true, clip=true, piles={
  {skyGld, function(x,y) return clamp((y-355)/50, 0, 1) end},
  {skyVio, function(x,y) return clamp((365-y)/35, 0, 1) end}}})
wait(4320)
print(drying(850,380), drying(900,350))

--@ chunk 3
-- the repair: a warm gold band continuing the sun's glow, a rose cloud above, feathered left
deepG = pile{{"deep cadmium", 0.8}, {"cadmium yellow", 0.4}, {"lead white", 0.8}, turps=0.3, name="deepG"}
paleG = pile{{"pale cadmium", 0.6}, {"rose madder", 0.2}, {"lead white", 1.4}, turps=0.3, name="paleG"}
roseC = pile{{"rose madder", 0.8}, {"permanent alizarin", 0.3}, {"lead white", 1.1}, turps=0.3, name="roseC"}
violC = pile{{"permanent alizarin", 0.5}, {"ultramarine blue", 0.5}, {"rose madder", 0.3}, {"lead white", 0.8}, turps=0.3, name="violC"}
fixR = poly({{700,330},{1000,324},{1000,420},{700,420}}, true)
work(fixR, {hand="broad", coverage=1.4, fill=true, clip=true, edge="soft", piles={
  {paleG, function(x,y) return clamp((x-700)/300, 0, 1) end},
  {deepG, function(x,y) return clamp((y-392)/24, 0, 1) * clamp(1 - (x-700)/300, 0, 1) end},
  {roseC, function(x,y) return clamp(1 - math.abs(y-360)/22, 0, 1) end},
  {violC, function(x,y) return clamp((350-y)/20, 0, 1) end}}})
print("repair laid", drying(850,380))

--@ chunk 4
wait(2880)
print(drying(850,380), drying(900,350), drying(760,395))

--@ chunk 5
paleG2 = pile{{"pale cadmium", 0.6}, {"rose madder", 0.35}, {"lead white", 0.9}, name="paleG2"}
deepG2 = pile{{"deep cadmium", 0.9}, {"cadmium yellow", 0.3}, {"lead white", 0.6}, name="deepG2"}
roseC2 = pile{{"rose madder", 0.8}, {"permanent alizarin", 0.2}, {"lead white", 0.8}, name="roseC2"}
fix2 = poly({{760,334},{1000,330},{1000,412},{760,412}}, true)
work(fix2, {hand="body", coverage=1.2, fill=true, clip=true, edge="soft", piles={
  {paleG2, function(x,y) return clamp(1 - math.abs(y-362)/30, 0, 1) end},
  {deepG2, function(x,y) return clamp((y-384)/24, 0, 1) end},
  {roseC2, function(x,y) return clamp(1 - math.abs(y-342)/14, 0, 1) end}}})
wait(2880)
print(drying(850,380), drying(900,350))

--@ chunk 6
print(drying(646,500), drying(650,580), drying(300,600))
veilV = pile{{"ultramarine blue", 0.4}, {"permanent alizarin", 0.4}, {"rose madder", 0.2}, {"lead white", 0.5}, medium=0.6, name="veilV"}
print(veilV)
lowP = poly({{560,520},{700,520},{730,650},{520,650}}, true)
work(lowP, {hand="glaze", pile=veilV, coverage=0.8, clip=true})
print("veil over lower bricks", drying(640,580))
