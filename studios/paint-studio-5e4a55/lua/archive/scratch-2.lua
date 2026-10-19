-- easel session "scratch": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
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
canvas{aspect=0.8, ground={{apply="knife", pile={{"lead white", 10}, {"yellow ochre", 0.4}, {"raw umber", 0.15}}, texture=0.25, um=120}}, linen={18, 15}, seed=4417, size=480}

--@ chunk 2
rock = pile{{"raw umber",2},{"Prussian blue",0.6},{"bone black",0.5},{"red earth",0.5}, name="rock"}
water = pile{{"lead white",6},{"cobalt blue",0.5}, name="water_white"}
bright = pile{{"lead white",1}, name="white"}
lipc = pile{{"lead white",3},{"yellow ochre",0.6},{"green earth",0.6}, name="lip"}
mist = pile{{"lead white",2},{"cobalt blue",0.15}, thinner=0.6, name="mist"}
work(rect(50, 50, 400, 400), {hand="broad", pile=rock, coverage=2, angle=1.5, clip=true})
-- lip band
local lipm = ribbon({{120,140},{250,128},{380,138}}, 14)
work(lipm, {hand="body", pile=lipc, coverage=1.5, angle=0, clip=true})
-- dry drags
local fl = brush{kind="flat", width=16, stiffness=0.6}
for i=1,30 do
  if i%2==1 then fl:reload(water, rand(0.2,0.35)) end
  local x = rand(125, 375)
  local y0 = 135 + rand(-3,6)
  local len = rand(120, 280)
  fl:stroke({{x, y0}, {x+rand(-2,2), y0+30}, {x+rand(-8,8), y0+len}}, {pressure={rand(0.3,0.55), 0.05}, orient="across", ramps={0.02,0.7}})
end
print(drying(200,200))

--@ chunk 3
-- foam at base, around y 400
local foam_m = ellipse(250, 415, 170, 35):soften(12)
work(foam_m, {hand="scumble", pile=mist, coverage=0.9})
work(foam_m:shrink(10), {hand="scumble", pile=water, coverage=0.5})
local sr = brush{kind="round", width=12, stiffness=0.3, point=0.2}
for i=1,30 do
  if i%6==1 then sr:reload(water, 0.5) end
  local x, y = 250 + randn(0, 70), 410 + randn(0, 10)
  sr:stroke({{x-8, y+rand(-2,2)}, {x, y-rand(2,6)}, {x+8, y+rand(-2,2)}}, {pressure={0.4,0.2}})
end
blend(foam_m, {angle=0})
-- mist veil rising
work(ellipse(250, 370, 150, 40):soften(25), {hand="scumble", pile=mist, coverage=0.6})

--@ chunk 4
work(rect(520, 50, 430, 400), {hand="broad", pile=rock, coverage=3, angle=1.5, clip=true, fill=true})
local fl = brush{kind="flat", width=16, stiffness=0.6}
for i=1,30 do
  if i%2==1 then fl:reload(water, rand(0.2,0.35)) end
  local x = rand(600, 850)
  local y0 = 135 + rand(-3,6)
  local len = rand(120, 280)
  fl:stroke({{x, y0}, {x+rand(-2,2), y0+30}, {x+rand(-8,8), y0+len}}, {pressure={rand(0.3,0.55), 0.05}, orient="across", ramps={0.02,0.7}})
end
-- foam with soft round body strokes, short horizontal arcs, then blend
local foam_m = ellipse(725, 415, 170, 35)
work(foam_m, {hand="body", pile=water, tool={kind="round", width=10, stiffness=0.3}, length={12,30}, angle=function(x,y) return rand(-0.4,0.4) end, coverage=1.2, curve={0.5, 0.2}})
blend(foam_m:soften(15), {angle=0})
-- mist with glaze hand
work(ellipse(725, 360, 170, 45):soften(30), {hand="glaze", pile=mist, coverage=1})

--@ chunk 5
fallgray = pile{{"lead white",3},{"cobalt blue",0.3},{"raw umber",0.4},{"yellow ochre",0.1}, name="fallgray"}
work(rect(50, 500, 430, 430), {hand="broad", pile=rock, coverage=3, angle=1.5, clip=true, fill=true})
-- step 1: gray broken vertical strokes
local fl = brush{kind="flat", width=14, stiffness=0.6}
for i=1,26 do
  if i%2==1 then fl:reload(fallgray, rand(0.25,0.4)) end
  local x = rand(130, 380)
  local y0 = 580 + rand(-3,6)
  fl:stroke({{x, y0}, {x+rand(-3,3), y0+40}, {x+rand(-8,8), y0+rand(160,260)}}, {pressure={rand(0.25,0.45), 0.1}, orient="across", ramps={0.02,0.6}})
end
local fm = poly({{120,575},{390,575},{400,850},{110,850}}):soften(10)
blend(fm, {angle=math.pi/2})
-- step 3: light dry drags
for i=1,18 do
  if i%3==1 then fl:reload(water, 0.2) end
  local x = rand(130, 380)
  local y0 = 582 + rand(-3,10)
  fl:stroke({{x, y0}, {x+rand(-2,2), y0+50}, {x+rand(-6,6), y0+rand(100,250)}}, {pressure={rand(0.15,0.35), 0.03}, orient="across", ramps={0.02,0.7}})
end
-- step 4: accents
local rd = brush{kind="round", width=5, point=0.5}
for i=1,7 do
  rd:reload(bright, 0.6)
  local x = rand(140, 370)
  rd:gesture({{x, 585, 0.6}, {x+rand(-2,2), 620, 0.5}, {x+rand(-4,4), rand(650,720), 0.0}}, {wobble=1.5})
end

--@ chunk 6
glow = pile{{"lead white",5},{"chrome yellow",1.2},{"yellow ochre",0.8}, name="glow"}
amber = pile{{"yellow ochre",3},{"red earth",1},{"lead white",1}, name="amber"}
deeprust = pile{{"red earth",3},{"raw umber",2},{"yellow ochre",1}, name="deeprust"}
rust = pile{{"red earth",3},{"yellow ochre",1.5},{"vermilion",0.4}, name="rust"}
gold = pile{{"chrome yellow",2},{"yellow ochre",2},{"lead white",0.6}, name="gold"}
palegold = pile{{"chrome yellow",1},{"lead white",2},{"yellow ochre",0.5}, name="palegold"}
local bg = rect(520, 500, 440, 440)
work(bg, {hand="broad", piles={{glow, function(x,y) return math.max(0, 1 - (x-520)/250) end},{amber, function(x,y) return 0.5 end},{deeprust, function(x,y) return math.max(0,(x-650)/300) end}}, coverage=3, angle=0.3, clip=true, fill=true})
blend(bg:shrink(5):soften(20), {angle=0.3})
-- foliage mass
local fm = ellipse(760, 640, 160, 90):roughen(25, 60, 3)
work(fm, {hand="body", pile=deeprust, coverage=1.2, length={10,25}, angle=function(x,y) return rand(0, 3.14) end})
stipple(fm, {pile=rust, width=14, coverage=0.7, cluster={0.6, 30}, feather=0.5, drag={5, 1.0}})
stipple(fm:offset(-10) * ellipse(720, 610, 120, 60), {pile=gold, width=12, coverage=0.5, cluster={0.6, 25}, feather=0.5, drag={4, 1.0}})
stipple(ellipse(700, 600, 80, 40):roughen(15,40,4), {pile=palegold, width=10, coverage=0.3, cluster={0.7, 20}, feather=0.7, drag={4, 1.0}})

--@ chunk 7
birch = pile{{"lead white",8},{"yellow ochre",0.15}, name="birch"}
bshadow = pile{{"lead white",3},{"smalt",1},{"raw umber",0.6},{"cobalt blue",0.2}, name="birch_shadow"}
lent = pile{{"bone black",1},{"raw umber",1}, name="lenticel"}
-- trunk body: lit side light, shadow side gray. trunk axis from (600,940) to (630,500)
local function axis(t) return lerp(600,630,t), lerp(940,500,t) end
local trunk = ribbon({{600,945},{612,760},{622,620},{630,500}}, {24, 22, 20, 17})
work(trunk, {hand="body", pile=bshadow, tool={kind="flat", width=10, stiffness=0.6}, angle=-1.5, length={30,70}, coverage=2, clip=true})
-- light side: left 60%
local lit = ribbon({{596,945},{608,760},{618,620},{627,500}}, {14,13,12,10})
work(lit, {hand="body", pile=birch, tool={kind="flat", width=8, stiffness=0.6, lay=3}, angle=-1.5, length={30,70}, coverage=1.5, clip=true})
-- lenticels: short horizontal dark dashes
local rd = brush{kind="round", width=3, point=0.7}
for i=1,22 do
  if i%4==1 then rd:reload(lent, 0.6) end
  local t = rand(0,1)
  local x, y = axis(t)
  local w = lerp(12, 8, t)
  local x0 = x + rand(-w, w*0.3)
  rd:stroke({{x0, y}, {x0 + rand(4, 10), y + rand(-1,1)}}, {pressure={0.5, 0.1}})
end
