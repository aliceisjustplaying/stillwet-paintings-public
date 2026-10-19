-- easel session "scratch": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box every
--@ engine 7
--@ width 4800

--@ chunk 1
canvas{aspect=1.5, ground={{apply="knife", pile={{"lead white", 8}, {"yellow ochre", 0.3}}, texture=0.25, um=110}, {apply="brush", pile={{"lead white", 3}, {"red earth", 1.2}, {"raw umber", 1.0}, {"yellow ochre", 0.6}}, um=22}}, linen={16, 14}, seed=4417, size=900}

--@ chunk 2
gd = pile{{"raw umber",1},{"bone black",0.6},{"ultramarine blue",0.3},{"green earth",0.3},{"lead white",0.04}}
gm = pile{{"raw umber",1},{"green earth",0.5},{"bone black",0.35},{"ultramarine blue",0.15},{"lead white",0.12},{"yellow ochre",0.15}}
gw = pile{{"raw umber",0.8},{"yellow ochre",0.6},{"red earth",0.15},{"lead white",0.22},{"green earth",0.2}}
gf = pile{{"lead white",1},{"green earth",0.4},{"raw umber",0.45},{"Prussian blue",0.1},{"bone black",0.18},{"yellow ochre",0.2}}
work(rect(40,40,920,560), {hand="body", angle=0.05, coverage=2.2, fill=true, clip=true,
  piles={{gf, function(x,y) return smoothstep(300,80,y) end},
         {gm, function(x,y) return math.max(0, 1 - math.abs(y-300)/260) end},
         {gd, function(x,y) return smoothstep(300,560,y) end},
         {gw, function(x,y) return (x>500 and x<800 and y>200 and y<420) and 0.6 or 0 end}}})
wait(30*24*60)
print(drying(300,300))

--@ chunk 3
shadg = pile{{"bone black",0.7},{"ultramarine blue",0.4},{"raw umber",0.5}, medium=0.78}
-- A: stripe, mask softened 4, glaze clip
local A = poly({{200,120},{260,120},{200,500},{80,500}}, true):soften(4)
work(A, {hand="glaze", pile=shadg, coverage=1.5, fill=true, clip=true, angle=1.9})
-- B: stripe, mask blurred 20 (graded edge), glaze clip
local B = poly({{380,120},{440,120},{380,500},{260,500}}, true):blur(20)
work(B, {hand="glaze", pile=shadg, coverage=1.5, fill=true, clip=B, angle=1.9})
-- C: stripe, load graded along its length (heavier near top 'feet')
local C = poly({{560,120},{620,120},{560,500},{440,500}}, true):soften(6)
work(C, {hand="glaze", pile=shadg, coverage=1.5, fill=true, clip=true, angle=1.9,
  load_at=function(x,y) return lerp(0.9, 0.25, smoothstep(120,500,y)) end})
-- D: stripe, two glaze coats
local Dm = poly({{760,120},{820,120},{760,500},{640,500}}, true):soften(6)
work(Dm, {hand="glaze", pile=shadg, coverage=1.5, fill=true, clip=true, angle=1.9})
work(Dm, {hand="glaze", pile=shadg, coverage=1.5, fill=true, clip=true, angle=1.9, seed=77})
print(drying(200,300))

--@ chunk 4
wait(20*24*60) print(drying(200,300), drying(500,300))
