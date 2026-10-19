-- easel session "scratch": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box friedrich
--@ engine 8
--@ knife-skim
--@ limbs-join-nearest
--@ blend-feather
--@ brush-skim
--@ blend-at-masks
--@ glaze-film
--@ liquid-film-levels
--@ rag-lift
--@ full-palette-refuses
--@ drain

--@ chunk 1
canvas{aspect=1.4, ground={{apply="knife", pile={{"lead white", 2}, {"red earth", 1}, {"yellow ochre", 1}}, texture=0.35, um=90}, {apply="brush", pile={{"lead white", 8}, {"yellow ochre", 0.25}, {"raw umber", 0.08}}, texture=0.4, um=45}}, linen={15, 13}, seed=6, size=1050}

--@ chunk 2
wD = pile{{"bone black",1},{"Prussian blue",0.35},{"raw umber",0.4},{"lead white",0.7},{"green earth",0.3}}
fg1 = pile{{"lead white",1.6},{"cobalt blue",0.6},{"smalt",0.4},{"raw umber",0.22},{"Naples yellow",0.12},{"rose madder",0.04}}
work(rect(0,500,1000,214), {hand="broad", pile=fg1, clip=true, coverage=2, fill=true, angle=0})
lead = poly({{0,560},{1000,540},{1000,640},{0,680}})
work(lead, {hand="body", pile=wD, clip=true, coverage=2.2, fill=true, angle=-0.02, tool="filbert 5"})
wait(6*24*60)
edgeG = pile{{"lead white",2},{"cobalt blue",0.6},{"green earth",0.45},{"Prussian blue",0.05},{"smalt",0.2}}
edgeG2 = pile{{"lead white",1.3},{"cobalt blue",0.6},{"green earth",0.5},{"Prussian blue",0.08},{"raw umber",0.1}}
reflW = pile{{"bone black",0.6},{"Prussian blue",0.25},{"raw umber",0.25},{"lead white",1.4},{"green earth",0.4},{"cobalt blue",0.3}}
ripple = pile{{"lead white",2},{"cobalt blue",0.5},{"bone black",0.15},{"green earth",0.1}}
-- variants of wall + reflection at different x ranges
local function bank(x) return 560 - x*0.02 end
-- A: wall 6 tall, reflection body, then blend lower half
local wallA = poly({{0,bank(0)},{300,bank(300)},{300,bank(300)+6},{0,bank(0)+6}})
work(wallA * lead, {hand="detail", piles={{edgeG,1},{edgeG2,0.6}}, clip=true, coverage=3, fill=true, angle=0, tool={kind="filbert", width=2.5}})
local reflA = poly({{0,bank(0)+6},{300,bank(300)+6},{300,bank(300)+14},{0,bank(0)+14}})
work(reflA * lead, {hand="detail", pile=reflW, clip=true, coverage=3, fill=true, angle=0, tool={kind="filbert", width=2.5}})
blend(poly({{0,bank(0)+9},{300,bank(300)+9},{300,bank(300)+18},{0,bank(0)+18}}), {angle=0})
-- B: wall + reflection as horizontal broken strokes (rigger/round)
rb = brush{kind="round", width=2.2, point=0.5}
for i=1,14 do
  local x0 = 330 + (i-1)*22 + rand(-4,4)
  local y = bank(x0) + 8 + rand(0, 6)
  rb:reload(reflW, rand(0.3,0.6))
  rb:stroke({{x0, y}, {x0 + rand(10,25), y + rand(-0.5,0.5)}}, {pressure={0.4,0.2}})
end
work(poly({{330,bank(330)},{650,bank(650)},{650,bank(650)+6},{330,bank(330)+6}}) * lead, {hand="detail", piles={{edgeG,1},{edgeG2,0.6}}, clip=true, coverage=3, fill=true, angle=0, tool={kind="filbert", width=2.5}})
-- ripples: long thin light streaks across the water
for i=1,10 do
  local y = 590 + i*7 + rand(-3,3)
  local x0 = rand(0, 800)
  rb:reload(ripple, rand(0.2,0.4))
  rb:stroke({{x0,y},{x0+rand(40,120), y+rand(-1,1)}}, {pressure={0.15,0.05}, shake=0.3})
end
-- brash: small light fragments with dark reflections
litW = pile{{"lead white",6},{"Naples yellow",0.14}}
tb = brush{kind="round", width=2.5, point=0.3}
for i=1,12 do
  local x = rand(50, 950); local y = rand(580, 640)
  tb:reload(litW, 0.6)
  tb:touch(x, y, {pressure=rand(0.3,0.7), drag={rand(2,6), rand(-0.5,0.5)}})
end
