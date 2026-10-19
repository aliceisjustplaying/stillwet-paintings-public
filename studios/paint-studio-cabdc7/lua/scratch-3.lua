-- easel session "scratch": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box friedrich
--@ engine 5

--@ chunk 1
canvas{aspect=1.4, ground={{apply="knife", pile={{"red earth", 3}, {"yellow ochre", 2}, {"lead white", 1}}, texture=0.35, um=45}, {apply="knife", pile={{"lead white", 6}, {"yellow ochre", 1}, {"raw umber", 0.5}}, texture=0.5, um=40}, {apply="brush", pile={{"lead white", 8}, {"yellow ochre", 0.4}, {"raw umber", 0.3}}, um=55}}, linen={14, 16}, seed=11, size=1200}

--@ chunk 2
-- scratch rehearsal 3: broken as a number
local sDeep  = pile{{"smalt", 2}, {"Prussian blue", 0.45}, {"bone black", 0.3}, {"lead white", 0.4}, turps=0.55}
local sMid   = pile{{"pale smalt", 2}, {"smalt", 1}, {"lead white", 1.2}, {"raw umber", 0.15}, turps=0.5}
local sPale  = pile{{"pale smalt", 1.5}, {"lead white", 2}, {"Naples yellow", 0.12}, turps=0.45}
local sGlow  = pile{{"lead white", 3}, {"Naples yellow", 1}, {"red earth", 0.22}, turps=0.4}
local sGlowG = pile{{"lead white", 2}, {"Naples yellow", 1}, {"red earth", 0.15}, medium=0.45}
local sWTop  = pile{{"lead white", 1.6}, {"Naples yellow", 0.5}, {"pale smalt", 0.5}, turps=0.5}
local sWMid  = pile{{"pale smalt", 1}, {"raw umber", 0.5}, {"lead white", 0.6}, {"Prussian blue", 0.15}, turps=0.5}
local sWLow  = pile{{"raw umber", 1}, {"Prussian blue", 0.4}, {"bone black", 0.35}, {"lead white", 0.15}, turps=0.5}
local sFar   = pile{{"raw umber", 1}, {"bone black", 0.5}, {"Prussian blue", 0.25}, turps=0.55}
local sMist  = pile{{"lead white", 2}, {"pale smalt", 0.5}, {"Naples yellow", 0.15}, thinner=0.4}
local sShoreD= pile{{"raw umber", 2}, {"bone black", 1}, {"Prussian blue", 0.3}, {"green earth", 0.2}}
local sShoreL= pile{{"yellow ochre", 1}, {"raw umber", 0.8}, {"lead white", 0.25}}
local sTreeD = pile{{"raw umber", 2}, {"bone black", 1.1}}
local sTreeM = pile{{"raw umber", 1.2}, {"bone black", 0.5}, {"yellow ochre", 0.15}}
local sRim   = pile{{"lead white", 1}, {"Naples yellow", 0.3}, {"raw umber", 0.3}}
local sFig   = pile{{"raw umber", 1}, {"bone black", 1}, {"Prussian blue", 0.2}}

local function sw(a, b, x) return smoothstep(a, b, x) end
function waterline(x) return 662 + 5*math.sin(x/70 + 1.3) + 3*math.sin(x/23 + 0.5) end
local function wtop(x) return 480 + 2.5*math.sin(x/110) + 1.5*math.sin(x/37) end

-- SKY
local wDeep = function(x, y) return 1 - sw(40, 260, y) end
local wMid  = function(x, y) return sw(60, 200, y) * (1 - sw(280, 420, y)) end
local wPale = function(x, y) return sw(220, 360, y) * (1 - sw(400, 448, y)) end
local wGlow = function(x, y) return sw(370, 440, y) end
work(above(function(x) return 468 end), {hand="broad",
  piles={{sDeep, wDeep}, {sMid, wMid}, {sPale, wPale}, {sGlow, wGlow}},
  angle=0, length={130, 230}, coverage=1.3, fill=true, pressure={0.5, 0.75}, seed=3})
local cD1 = ellipse(280, 110, 400, 26):soften(16)
work(cD1, {hand="body", piles={{sDeep, 0.55}, {sMid, 0.45}}, angle=0, length={90, 170},
  coverage=1.1, pressure={0.35, 0.55}, seed=4})
blend(cD1:soften(6), {angle=0.1})
local cL1 = ellipse(660, 250, 360, 22):soften(18)
work(cL1, {hand="body", piles={{sPale, 0.7}, {sGlow, 0.3}}, angle=0, length={90, 170},
  coverage=1.0, pressure={0.3, 0.5}, seed=5})
blend(cL1:soften(6), {angle=-0.05})
local band = rect(0, 396, 1000, 74):soften(20)
work(band, {hand="glaze", pile=sGlowG, coverage=1.1, angle=0, length={150, 260},
  pressure={0.22, 0.35}, seed=6})

-- WATER
local waterT = (below(wtop) - below(waterline)) * rect(20, 470, 640, 250)
local vTop = function(x, y) return sw(478, 505, y) * (1 - sw(520, 560, y)) end
local vMid = function(x, y) return sw(505, 545, y) * (1 - sw(585, 625, y)) end
local vLow = function(x, y) return sw(575, 620, y) end
work(waterT, {hand="body", piles={{sWTop, vTop}, {sWMid, vMid}, {sWLow, vLow}},
  angle=0, length={130, 230}, coverage=1.4, fill=true, pressure={0.5, 0.75}, seed=7})
local farT = rect(0, 461, 640, 20):roughen(5, 25, 7):soften(2)
farT = farT * mask(function(x, y) return clamp((x - 30)/140, 0, 1) * clamp((620 - x)/140, 0, 1) end)
work(farT, {hand="body", pile=sFar, angle=0, length={90, 160}, coverage=1.4, fill=true,
  pressure={0.5, 0.7}, seed=8})
local mistT = rect(20, 430, 620, 84):soften(22)
work(mistT, {hand="glaze", pile=sMist, coverage=0.8, angle=0, length={140, 240},
  pressure={0.2, 0.3}, seed=9})
local colT = mask(function(x, y)
  local t = clamp((y - 478) / 184, 0, 1)
  local half = 16 + 80 * t * t
  local c = 500 + 25 * t
  if y > 478 and y < 662 and math.abs(x - c) < half then return 1 else return 0 end
end) * rect(20, 470, 640, 250)
stipple(colT, {pile=sGlow, width=2.6,
  coverage=function(x, y) return 2.4 * (1 - sw(478, 560, y)) + 0.35 end,
  drag={7, 0}, cluster=0.35, pressure={0.4, 0.7}, dips={18, 0.5}, seed=10})

-- FOREGROUND SHORE
local shoreT = below(waterline) * rect(20, 640, 640, 100)
work(shoreT, {hand="body", pile=sShoreD, coverage=2, angle=0.04, length={60, 120},
  fill=true, pressure={0.6, 0.85}, seed=11})
work(shoreT, {hand="body", pile=sShoreL, coverage=0.7, load=0.35, angle=-0.07,
  length={40, 90}, pressure={0.4, 0.6}, seed=12})
local wetT = mask(function(x, y) local wl = waterline(x)
  if y > wl - 1 and y < wl + 9 then return 1 else return 0 end end) * rect(20, 640, 640, 100)
work(wetT, {hand="body", pile=sShoreL, coverage=0.7, length={24, 55}, angle=0,
  pressure={0.4, 0.6}, broken=0.6, seed=13})

-- FIGURE + reflection
local fb = brush("filbert", 10)
fb:load(sFig, 0.9)
fb:gesture({{500, 546, 0.85}, {501, 572, 0.9}, {500, 602, 0.9}, {500, 631, 0.85}})
fb:gesture({{489, 550, 0.8}, {500, 545, 0.9}, {511, 550, 0.8}})
local hb = brush{kind="round", width=11}
hb:load(sFig, 0.9)
hb:touch(500, 536, {pressure=0.75})
local rb = brush("filbert", 7)
rb:load(sFig, 0.5)
rb:gesture({{500, 634, 0.7}, {499, 646, 0.55}, {500, 658, 0.4}})
rb:gesture({{497, 636, 0.5}, {496, 644, 0.4}, {497, 652, 0.3}})
rb:gesture({{503, 637, 0.45}, {504, 645, 0.35}, {503, 653, 0.25}})
local pb = brush{kind="rigger", width=2}
pb:load(sWTop, 0.5)
pb:gesture({{488, 632, 0.5}, {512, 632, 0.4}})
pb:gesture({{491, 636, 0.4}, {509, 636, 0.3}})

-- TREE
local tb = brush("filbert", 22)
tb:load(sTreeD, 1.0)
tb:gesture({{884, 716, 0.95}, {872, 655, 0.95}, {856, 595, 0.9}, {838, 540, 0.85},
  {818, 495, 0.75}, {800, 455, 0.6}}, {wobble=3})
tb:gesture({{880, 716, 0.9}, {866, 648, 0.9}, {850, 585, 0.85}, {830, 528, 0.75},
  {810, 480, 0.6}, {795, 448, 0.5}}, {wobble=2})
local lb = brush{kind="round", width=7, point=0.85, stiffness=0.6}
lb:load(sTreeD, 0.95)
lb:gesture({{800, 450, 0.8}, {770, 400, 0.65}, {735, 355, 0.5}, {705, 320, 0.3}, {688, 292, 0.1}}, {wobble=2.5})
lb:gesture({{812, 440, 0.8}, {850, 395, 0.65}, {885, 360, 0.45}, {910, 330, 0.15}}, {wobble=2.5})
lb:gesture({{838, 490, 0.8}, {890, 468, 0.6}, {935, 448, 0.35}, {968, 430, 0.12}}, {wobble=2.5})
lb:gesture({{815, 470, 0.75}, {775, 448, 0.5}, {745, 432, 0.15}}, {wobble=2})
lb:gesture({{806, 445, 0.75}, {812, 400, 0.55}, {818, 370, 0.15}}, {wobble=2})
local bb = brush{kind="round", width=3.6, point=0.85, stiffness=0.6}
bb:load(sTreeD, 0.9)
bb:gesture({{748, 372, 0.75}, {715, 345, 0.5}, {688, 330, 0.12}}, {wobble=1.6})
bb:gesture({{722, 340, 0.7}, {740, 305, 0.45}, {752, 278, 0.1}}, {wobble=1.6})
bb:gesture({{862, 382, 0.75}, {905, 372, 0.5}, {940, 368, 0.12}}, {wobble=1.6})
bb:gesture({{895, 348, 0.7}, {915, 312, 0.45}, {925, 285, 0.1}}, {wobble=1.6})
bb:gesture({{948, 442, 0.7}, {975, 405, 0.45}, {990, 375, 0.1}}, {wobble=1.6})
local wb = brush{kind="rigger", width=1.4, point=1, stiffness=0.5}
wb:load(sTreeM, 0.8)
local function twig(x0, y0, ang, len, p0)
  local x1 = x0 + math.cos(ang) * len
  local y1 = y0 + math.sin(ang) * len + len * 0.2
  wb:gesture({{x0, y0, p0}, {x1, y1, 0.06}}, {wobble=1.1})
end
for i = 1, 7 do twig(688, 292, rand(-2.9, -1.7), rand(14, 26), 0.55) end
for i = 1, 6 do twig(705, 320, rand(-2.6, -1.2), rand(12, 22), 0.5) end
for i = 1, 6 do twig(752, 278, rand(-2.4, -1.0), rand(12, 22), 0.5) end
for i = 1, 6 do twig(910, 330, rand(-1.9, -0.6), rand(12, 22), 0.5) end
for i = 1, 6 do twig(925, 285, rand(-2.2, -0.9), rand(12, 20), 0.5) end
for i = 1, 6 do twig(940, 368, rand(-1.6, -0.3), rand(12, 22), 0.5) end
for i = 1, 6 do twig(968, 430, rand(-1.7, -0.4), rand(12, 22), 0.5) end
for i = 1, 6 do twig(990, 375, rand(-1.8, -0.5), rand(12, 20), 0.5) end
for i = 1, 5 do twig(745, 432, rand(-1.9, -0.8), rand(10, 18), 0.45) end
for i = 1, 5 do twig(818, 370, rand(-2.5, -1.2), rand(10, 18), 0.45) end
for i = 1, 5 do twig(688, 330, rand(-2.7, -1.5), rand(10, 18), 0.45) end
local rim = brush{kind="rigger", width=1.6, point=0.9}
rim:load(sRim, 0.35)
rim:gesture({{874, 706, 0.5}, {861, 636, 0.45}, {845, 566, 0.4}, {827, 508, 0.32}}, {wobble=1})
rim:gesture({{823, 500, 0.32}, {806, 462, 0.25}, {794, 442, 0.15}}, {wobble=1})
print("scratch rehearsal 3 laid")
