-- easel session "scratch": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box every
--@ engine 5

--@ chunk 1
canvas{aspect=1.3333333333333333, ground={{apply="knife", pile={{"lead white", 6}, {"red earth", 1}, {"raw umber", 1}}, texture=0.3, um=120}}, linen={18, 16}, seed=4127, size=600}

--@ chunk 2
le_body = pile{{"lemon chrome",3},{"cadmium yellow",0.7}}
work(rect(50,50,300,200), {hand="body", pile=le_body, coverage=2.5, fill=true, clip=true})
wait(15*24*60)
coat = pile{{"bone black",1},{"ultramarine blue",1},{"burnt sienna",1}}
coat2 = pile{{"bone black",0.6},{"ultramarine blue",1},{"Prussian blue",0.3},{"burnt sienna",0.6},{"lead white",0.2}}
rim = pile{{"orange chrome",1},{"yellow ochre",1},{"Naples yellow",1}}
rimcool = pile{{"ultramarine blue",1},{"lead white",1},{"bone black",0.2}}
local fig = poly({{120,80},{180,80},{200,240},{100,240}}, true)
work(fig, {hand="body", tool="filbert 8", piles={{coat,1},{coat2,0.4}}, coverage=2.4, fill=true, clip=true, angle=math.pi/2, length={20,50}})
local b = brush{kind="round", width=3, point=0.8}
b:load(rim, 0.7)
b:gesture({{122,85,0.2},{115,150,0.7},{104,235,0.3}}, {wobble=0.5})
b:reload(rimcool, 0.6)
b:gesture({{180,85,0.2},{188,160,0.6},{198,235,0.2}}, {wobble=0.5})
local fig2 = poly({{250,80},{300,80},{320,240},{230,240}}, true)
work(fig2, {hand="body", tool="filbert 8", piles={{coat,1},{coat2,0.4}}, coverage=1.5, fill=false, clip=true, angle=math.pi/2, length={20,50}})

--@ chunk 3
local b = brush{kind="round", width=3.5, point=0.7, lay=2.5}
b:load(rim, 1)
b:gesture({{124,95,0.5},{117,150,0.9},{106,225,0.5}}, {wobble=0.6})
wait(24*60)
print(drying(150,150))
b:reload(rim, 1)
b:gesture({{252,95,0.5},{243,150,0.9},{234,225,0.5}}, {wobble=0.6})
b:reload(rimcool, 1)
b:gesture({{299,95,0.4},{307,160,0.8},{317,230,0.4}}, {wobble=0.6})

--@ chunk 4
wall_mid = pile{{"burnt sienna",1},{"raw umber",0.8},{"yellow ochre",0.3}}
work(rect(400,50,300,250), {hand="body", pile=wall_mid, coverage=2.5, fill=true, clip=true})
wait(15*24*60)
glowp = pile{{"Naples yellow",2},{"lead white",1.5},{"cadmium yellow",0.4},{"orange chrome",0.15}, name="glowp"}
local cx, cy = 550, 175
for i,R in ipairs({110, 80, 55, 32}) do
  stipple(ellipse(cx,cy,R,R*0.8):soften(R*0.4), {pile=glowp, width=5, coverage=0.5, pressure={0.15,0.35}, feather=1, cluster=0.2, seed=i})
end
bulbcore = pile{{"lead white",3},{"Naples yellow",1},{"cadmium yellow",0.2}}
local b = brush("filbert", 7)
b:load(bulbcore, 1)
b:touch(cx, cy, {pressure=0.9, drag={0,4}})

--@ chunk 5
wall_lit = pile{{"raw sienna",1},{"yellow ochre",1},{"burnt sienna",0.4},{"lead white",0.35}}
local cx, cy = 550, 175
local function n(x,y) local d=math.sqrt((x-cx)^2+((y-cy)*1.2)^2); return math.max(0,1-d/120) end
local m = ellipse(cx,cy,125,105):soften(25)
work(rect(400,50,300,250)*m, {hand="scumble", tool="filbert 10", piles={{glowp, function(x,y) return 3*n(x,y)^2 end},{wall_lit, function(x,y) return 0.4+n(x,y) end},{wall_mid, function(x,y) return math.max(0,0.6-n(x,y))*1.5 end}}, coverage=1.6, angle=function(x,y) return math.atan(y-cy,x-cx) + math.pi/2 end, seed=5})
blend(ellipse(cx,cy,100,85), {angle=0.5})
local b = brush("filbert", 7)
b:load(bulbcore, 1)
b:touch(cx, cy, {pressure=0.9, drag={0,4}})

--@ chunk 6
work(rect(400,320,300,250), {hand="body", pile=wall_mid, coverage=2.5, fill=true, clip=true})
wait(15*24*60)
glowsc = pile{{"Naples yellow",2},{"lead white",1.5},{"cadmium yellow",0.5},{"orange chrome",0.2}, medium=0.25, name="glowsc"}
local cx, cy = 550, 445
local function n(x,y) local d=math.sqrt((x-cx)^2+((y-cy)*1.2)^2); return math.max(0,1-d/130) end
work(ellipse(cx,cy,135,115), {hand="scumble", tool={kind="filbert", width=12, stiffness=0.4}, pile=glowsc, coverage=2, load_at=function(x,y) return 0.05 + 0.7*n(x,y)^2 end, pressure={0.15,0.4}, dips={3,0.5,0.6}, angle=function(x,y) return math.atan(y-cy,x-cx) + math.pi/2 end, hug=false, seed=7})
local b = brush("filbert", 7)
b:load(bulbcore, 1)
b:touch(cx, cy, {pressure=0.9, drag={0,4}})

--@ chunk 7
work(rect(50,320,300,250), {hand="body", pile=wall_mid, coverage=2.5, fill=true, clip=true})
wait(15*24*60)
g1 = pile{{"raw sienna",1},{"yellow ochre",1.2},{"Naples yellow",0.8},{"lead white",0.4}, name="g1"}
g2 = pile{{"Naples yellow",2},{"yellow ochre",0.6},{"lead white",0.8},{"cadmium yellow",0.2}, name="g2"}
g3 = pile{{"Naples yellow",2},{"lead white",1.6},{"cadmium yellow",0.4}, name="g3"}
local cx, cy = 200, 445
work(ellipse(cx,cy,95,75), {hand="body", tool="filbert 8", pile=g1, coverage=1.6, edge="lost", angle=function(x,y) return math.atan(y-cy,x-cx)+math.pi/2 end, length={15,35}, seed=1})
work(ellipse(cx,cy,60,48), {hand="body", tool="filbert 7", pile=g2, coverage=1.8, edge="lost", angle=function(x,y) return math.atan(y-cy,x-cx)+math.pi/2 end, length={12,28}, seed=2})
work(ellipse(cx,cy,30,24), {hand="body", tool="filbert 6", pile=g3, coverage=2, edge="lost", angle=function(x,y) return math.atan(y-cy,x-cx)+math.pi/2 end, length={10,20}, seed=3})
local b = brush("filbert", 7)
b:load(bulbcore, 1)
b:touch(cx, cy, {pressure=0.9, drag={0,4}})

--@ chunk 8
work(rect(50,50,300,250), {hand="body", pile=wall_mid, coverage=2.5, fill=true, clip=true})
wait(15*24*60)
local cx, cy = 200, 175
local function n(x,y) local d=math.sqrt((x-cx)^2+((y-cy)*1.25)^2); return d end
-- one wet pass, graded piles by distance, radial strokes
local m = ellipse(cx,cy,130,104)
work(m, {hand="body", tool="filbert 8", piles={
  {wall_mid, function(x,y) return clamp((n(x,y)-80)/50,0,1)*2 end},
  {g1, function(x,y) local d=n(x,y); return math.max(0, 1-math.abs(d-85)/45) end},
  {g2, function(x,y) local d=n(x,y); return math.max(0, 1-math.abs(d-45)/35) end},
  {g3, function(x,y) return math.max(0, 1-n(x,y)/35)*2 end}},
  coverage=2.2, fill=true, hug=false, angle=function(x,y) return math.atan(y-cy,x-cx)+math.pi/2 end, length={12,30}, seed=4})
blend(ellipse(cx,cy,150,120):blur(30), {angle=0.3})
local b = brush("filbert", 7)
b:load(bulbcore, 1)
b:touch(cx, cy, {pressure=0.9, drag={0,4}})

--@ chunk 9
local cx, cy = 855, 175
local function dd(x,y) return math.sqrt((x-cx)^2+((y-cy)*1.25)^2) end
work(rect(720,50,270,250), {hand="body", tool="flat 9", piles={{wall_lit, function(x,y) return 2*math.max(0,1-dd(x,y)/200)^1.5 end},{wall_mid, function(x,y) return 0.4 + math.min(1,dd(x,y)/200) end}}, coverage=2.5, fill=true, clip=true, angle=math.pi/2})
wall_glow = mix{{wall_lit,0.7},{g1,0.3}, name="wall_glow"}
wait(15*24*60)
local m = ellipse(cx,cy,115,92)
work(m, {hand="body", tool="filbert 8", piles={
  {wall_lit, function(x,y) return clamp((dd(x,y)-75)/40,0,1)*2 end},
  {g1, function(x,y) local d=dd(x,y); return math.max(0, 1-math.abs(d-70)/40) end},
  {g2, function(x,y) local d=dd(x,y); return math.max(0, 1-math.abs(d-38)/30) end},
  {g3, function(x,y) return math.max(0, 1-dd(x,y)/30)*2 end}},
  coverage=2.2, fill=true, hug=false, pressure={0.4,0.8}, angle=function(x,y) return math.atan(y-cy,x-cx)+math.pi/2 end, length={12,30}, seed=4})
local b = brush("filbert", 7)
b:load(bulbcore, 1)
b:touch(cx, cy, {pressure=0.9, drag={0,4}})

--@ chunk 10
local cx, cy = 855, 520
local function dd(x,y) return math.sqrt((x-cx)^2+((y-cy)*1.25)^2) end
work(rect(720,395,270,250), {hand="body", tool="flat 9", piles={{wall_lit, function(x,y) return 2*math.max(0,1-dd(x,y)/200)^1.5 end},{wall_mid, function(x,y) return 0.4 + math.min(1,dd(x,y)/200) end}}, coverage=2.5, fill=true, clip=true, angle=math.pi/2})
wait(15*24*60)
-- outer: dry-brush scumble ring, sparse
local ring = ellipse(cx,cy,120,96):blur(12) - ellipse(cx,cy,50,40):blur(8)
work(ring, {hand="scumble", tool={kind="filbert", width=9, stiffness=0.7}, pile=g1, coverage=1.2, load=0.25, pressure={0.15,0.35}, dips={4,0.25,0.5}, angle=function(x,y) return math.atan(y-cy,x-cx)+math.pi/2 end, hug=false, seed=8})
local m = ellipse(cx,cy,70,56)
work(m, {hand="body", tool="filbert 7", piles={
  {g1, function(x,y) return clamp((dd(x,y)-35)/30,0,1)*1.5 end},
  {g2, function(x,y) local d=dd(x,y); return math.max(0, 1-math.abs(d-32)/22) end},
  {g3, function(x,y) return math.max(0, 1-dd(x,y)/25)*2 end}},
  coverage=2.0, fill=false, hug=false, pressure={0.3,0.7}, angle=function(x,y) return math.atan(y-cy,x-cx)+math.pi/2 end, length={10,24}, seed=4})
local b = brush("filbert", 7)
b:load(bulbcore, 1)
b:touch(cx, cy, {pressure=0.9, drag={0,4}})
