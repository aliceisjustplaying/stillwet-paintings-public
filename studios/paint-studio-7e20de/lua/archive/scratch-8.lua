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
shb = pile{{"bone black",0.8},{"raw umber",0.8},{"ultramarine blue",0.5},{"green earth",0.3}}
shbt = pile{{"bone black",0.8},{"raw umber",0.8},{"ultramarine blue",0.5},{"green earth",0.3}, thinner=0.6}
shg5 = pile{{"bone black",0.7},{"ultramarine blue",0.4},{"raw umber",0.5}, medium=0.5}
local E = poly({{200,120},{260,120},{200,500},{80,500}}, true)
work(E, {hand="body", pile=shb, coverage=1.6, fill=true, edge="soft", angle=1.9, length={15,40}})
local F = poly({{420,120},{480,120},{420,500},{300,500}}, true)
work(F, {hand="scumble", pile=shbt, coverage=1.2, fill=true, clip=true, angle=1.9})
local G = poly({{640,120},{700,120},{640,500},{520,500}}, true):soften(6)
work(G, {hand="glaze", pile=shg5, coverage=0.6, fill=true, clip=true, angle=1.9})
local Hm = poly({{850,120},{900,120},{850,500},{740,500}}, true)
work(Hm, {hand="body", pile=shbt, coverage=1.4, fill=true, edge="soft", angle=1.9, length={15,40}})
wait(20*24*60)
print(drying(200,300), drying(420,300), drying(640,300), drying(850,300))

--@ chunk 4
local I = poly({{560,120},{610,120},{575,330},{500,330}}, true):blur(8)
work(I, {hand="scumble", pile=shbt, coverage=1.4, fill=true, clip=I, angle=1.75,
  load_at=function(x,y) return lerp(0.9, 0.4, smoothstep(120,330,y)) end})
local J = poly({{560,360},{610,360},{590,560},{520,560}}, true):blur(3)
work(J, {hand="scumble", pile=shbt, coverage=1.4, fill=true, clip=J, angle=1.7, tool="filbert 5"})
wait(20*24*60)

--@ chunk 5
shbt = pile{{"bone black",0.8},{"raw umber",0.8},{"ultramarine blue",0.5},{"green earth",0.3}, thinner=0.6}
local K = poly({{120,300},{220,300},{200,540},{60,540}}, true):blur(3)
work(K, {hand="scumble", pile=shbt, coverage=1.4, fill=true, clip=K, angle=1.8})
local L2 = poly({{760,300},{860,300},{860,540},{720,540}}, true):blur(3)
work(L2, {hand="scumble", pile=shbt, coverage=1.4, fill=true, clip=L2, angle=1.8})
blend(L2:shrink(2), {angle=1.8})
wait(20*24*60)
