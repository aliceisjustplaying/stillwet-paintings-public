-- easel session "scratch": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box friedrich
--@ engine 5

--@ chunk 1
canvas{aspect=1.4, ground={{apply="knife", pile={{"red earth", 3}, {"yellow ochre", 2}, {"lead white", 1}}, texture=0.35, um=45}, {apply="knife", pile={{"lead white", 6}, {"yellow ochre", 1}, {"raw umber", 0.5}}, texture=0.5, um=40}, {apply="brush", pile={{"lead white", 8}, {"yellow ochre", 0.4}, {"raw umber", 0.3}}, um=55}}, linen={14, 16}, seed=11, size=1200}

--@ chunk 2
-- scratch rehearsal 4: corrected values, fuller tree, fuller figure
local sDeep  = pile{{"smalt", 2}, {"Prussian blue", 0.6}, {"bone black", 0.5}, {"lead white", 0.3}, turps=0.55}
local sMid   = pile{{"pale smalt", 2}, {"smalt", 1}, {"lead white", 1.2}, {"raw umber", 0.15}, turps=0.5}
local sPale  = pile{{"pale smalt", 1.5}, {"lead white", 2}, {"Naples yellow", 0.12}, turps=0.45}
local sGlow  = pile{{"lead white", 3}, {"Naples yellow", 1}, {"red earth", 0.22}, turps=0.4}
local sGlowG = pile{{"lead white", 2}, {"Naples yellow", 1}, {"red earth", 0.15}, medium=0.45}
local sWTop  = pile{{"lead white", 1.6}, {"Naples yellow", 0.5}, {"pale smalt", 0.5}, turps=0.5}
local sWMid  = pile{{"pale smalt", 1}, {"raw umber", 0.45}, {"lead white", 0.5}, {"Prussian blue", 0.2}, turps=0.5}
local sWLow  = pile{{"raw umber", 1.2}, {"Prussian blue", 0.5}, {"bone black", 0.45}, {"lead white", 0.1}, turps=0.5}
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

-- SKY: darker top, pale zone narrower, warm glow confined to the bottom band
local wDeep = function(x, y) return 1 - sw(30, 200, y) end
local wMid  = function(x, y) return sw(60, 180, y) * (1 - sw(260, 380, y)) end
local wPale = function(x, y) return sw(240, 340, y) * (1 - sw(390, 425, y)) end
local wGlow = function(x, y) return sw(370, 440, y) end
work(above(function(x) return 468 end), {hand="broad",
  piles={{sDeep, wDeep}, {sMid, wMid}, {sPale, wPale}, {sGlow, wGlow}},
  angle=0, length={130, 230}, coverage=1.3, fill=true, pressure={0.5, 0.75}, seed=3})
-- cloud bands: dark high, light mid, one wedge each side
local cD1 = ellipse(280, 110, 400, 26):soften(16)
work(cD1, {hand="body", piles={{sDeep, 0.55}, {sMid, 0.45}}, angle=0, length={90, 170},
  coverage=1.1, pressure={0.35, 0.55}, seed=4})
blend(cD1:soften(6), {angle=0.1})
local cL1 = ellipse(660, 250, 360, 22):soften(18)
work(cL1, {hand="body", piles={{sPale, 0.7}, {sGlow, 0.3}}, angle=0, length={90, 170},
  coverage=1.0, pressure={0.3, 0.5}, seed=5})
blend(cL1:soften(6), {angle=-0.05})
local cL2 = ellipse(240, 340, 220, 16):soften(16)
work(cL2, {hand="body", piles={{sPale, 0.7}, {sGlow, 0.3}}, angle=0, length={70, 130},
  coverage=0.8, pressure={0.28, 0.45}, seed=14})
blend(cL2:soften(6), {angle=0.05})
local cD2 = ellipse(820, 300, 200, 14):soften(16)
work(cD2, {hand="body", piles={{sDeep, 0.4}, {sMid, 0.6}}, angle=0, length={70, 130},
  coverage=0.8, pressure={0.3, 0.5}, seed=15})
blend(cD2:soften(6), {angle=-0.08})
-- afterglow band: quiet glaze, kept to the bottom of the sky
local band = rect(0, 404, 1000, 66):soften(18)
work(band, {hand="glaze", pile=sGlowG, coverage=1.1, angle=0, length={150, 260},
  pressure={0.22, 0.35}, seed=6})

-- WATER: bright only in a narrow reflection under the shore, darkening sooner
local waterT = (below(wtop) - below(waterline)) * rect(20, 470, 640, 250)
local vTop = function(x, y) return sw(476, 496, y) * (1 - sw(516, 540, y)) end
local vMid = function(x, y) return sw(500, 530, y) * (1 - sw(570, 610, y)) end
local vLow = function(x, y) return sw(550, 596, y) end
work(waterT, {hand="broad", piles={{sWTop, vTop}, {sWMid, vMid}, {sWLow, vLow}},
  angle=0, length={150, 260}, coverage=1.2, fill=true, pressure={0.4, 0.6}, seed=7})
-- far shore strip
local farT = rect(0, 461, 640, 20):roughen(4, 30, 7):soften(3)
farT = farT * mask(function(x, y) return clamp((x - 30)/140, 0, 1) * clamp((620 - x)/140, 0, 1) end)
work(farT, {hand="body", pile=sFar, angle=0, length={90, 160}, coverage=1.4, fill=true,
  pressure={0.5, 0.7}, seed=8})
-- mist veil
local mistT = rect(20, 430, 620, 84):soften(22)
work(mistT, {hand="glaze", pile=sMist, coverage=0.8, angle=0, length={140, 240},
  pressure={0.2, 0.3}, seed=9})
-- glimmer column
local colT = mask(function(x, y)
  local t = clamp((y - 478) / 184, 0, 1)
  local half = 16 + 80 * t * t
  local c = 500 + 25 * t
  if y > 478 and y < 662 and math.abs(x - c) < half then return 1 else return 0 end
end) * rect(20, 470, 640, 250)
stipple(colT, {pile=sGlow, width=2.6,
  coverage=function(x, y) return 2.6 * (1 - sw(478, 555, y)) + 0.4 end,
  drag={7, 0}, cluster=0.35, pressure={0.4, 0.7}, dips={18, 0.5}, seed=10})

-- FOREGROUND SHORE: quiet dark mass, muted lights
local shoreT = below(waterline) * rect(20, 640, 640, 100)
work(shoreT, {hand="body", pile=sShoreD, coverage=2, angle=0.04, length={60, 120},
  fill=true, pressure={0.6, 0.85}, seed=11})
work(shoreT, {hand="body", piles={{sShoreL, 0.55}, {sShoreD, 0.45}}, coverage=0.5, load=0.3,
  angle=-0.07, length={40, 90}, pressure={0.3, 0.5}, seed=12})
local wetT = mask(function(x, y) local wl = waterline(x)
  if y > wl - 1 and y < wl + 8 then return 1 else return 0 end end) * rect(20, 640, 640, 100)
work(wetT, {hand="body", pile=sShoreL, coverage=0.6, length={24, 55}, angle=0,
  pressure={0.4, 0.6}, broken=0.6, seed=13})

-- FIGURE: fuller cloak, bowed head, rim, reflection, ripples
local fb = brush("filbert", 12)
fb:load(sFig, 0.95)
fb:gesture({{500, 547, 0.9}, {501, 575, 0.92}, {500, 605, 0.92}, {500, 631, 0.88}})
fb:gesture({{489, 551, 0.85}, {500, 545, 0.92}, {511, 551, 0.85}})
fb:gesture({{493, 552, 0.8}, {492, 580, 0.85}, {493, 610, 0.85}, {494, 630, 0.8}})
fb:gesture({{507, 552, 0.8}, {508, 580, 0.85}, {507, 610, 0.85}, {506, 630, 0.8}})
local hb = brush{kind="round", width=12}
hb:load(sFig, 0.95)
hb:touch(500, 536, {pressure=0.8})
local fr = brush{kind="rigger", width=1.2, point=0.9}
fr:load(sRim, 0.35)
fr:gesture({{489, 552, 0.5}, {488, 580, 0.45}, {490, 610, 0.35}, {491, 628, 0.12}}, {wobble=0.6})
fr:gesture({{494, 531, 0.4}, {492, 536, 0.2}}, {wobble=0.4})
local rb = brush("filbert", 8)
rb:load(sFig, 0.5)
rb:gesture({{500, 634, 0.7}, {499, 646, 0.55}, {500, 658, 0.4}})
rb:gesture({{496, 636, 0.5}, {495, 644, 0.4}, {496, 652, 0.3}})
rb:gesture({{504, 637, 0.45}, {505, 645, 0.35}, {504, 653, 0.25}})
local pb = brush{kind="rigger", width=2}
pb:load(sWTop, 0.5)
pb:gesture({{488, 632, 0.5}, {512, 632, 0.4}})
pb:gesture({{491, 636, 0.4}, {509, 636, 0.3}})
pb:gesture({{486, 646, 0.35}, {514, 646, 0.25}})

-- TREE: full skeleton
local tb = brush("filbert", 22)
tb:load(sTreeD, 1.0)
tb:gesture({{884, 716, 0.95}, {872, 655, 0.95}, {856, 595, 0.9}, {838, 540, 0.85},
  {818, 495, 0.75}, {800, 455, 0.6}}, {wobble=3})
tb:gesture({{880, 716, 0.9}, {866, 648, 0.9}, {850, 585, 0.85}, {830, 528, 0.75},
  {810, 480, 0.6}, {795, 448, 0.5}}, {wobble=2})
local function limb(pts, w, p0, pl, wob)
  local b = brush{kind="round", width=w, point=0.85, stiffness=0.55}
  b:load(pl, 0.95)
  local g = {}
  for i, pt in ipairs(pts) do
    local t = (i - 1) / math.max(1, #pts - 1)
    g[i] = {pt[1], pt[2], p0 * (1 - 0.87 * t)}
  end
  b:gesture(g, {wobble=wob or 2})
end
-- main limbs
limb({{798, 448}, {762, 392}, {724, 348}, {694, 312}, {676, 282}, {668, 258}}, 10, 0.85, sTreeD, 2.5)
limb({{810, 438}, {848, 392}, {882, 358}, {908, 330}, {922, 308}}, 10, 0.85, sTreeD, 2.5)
limb({{836, 486}, {888, 466}, {934, 446}, {970, 428}}, 9, 0.85, sTreeD, 2.5)
limb({{812, 466}, {772, 446}, {742, 430}, {722, 416}}, 8, 0.8, sTreeD, 2)
limb({{804, 444}, {812, 398}, {822, 362}, {830, 336}}, 8, 0.8, sTreeD, 2)
limb({{830, 520}, {866, 500}, {898, 486}}, 7, 0.8, sTreeD, 2)
limb({{822, 492}, {790, 472}, {764, 458}}, 6, 0.8, sTreeD, 2)
-- second order
limb({{724, 348}, {694, 330}, {668, 318}}, 5, 0.8, sTreeD, 1.6)
limb({{700, 322}, {716, 292}, {726, 266}}, 4.5, 0.78, sTreeD, 1.6)
limb({{676, 282}, {656, 268}, {642, 258}}, 4, 0.75, sTreeD, 1.6)
limb({{860, 380}, {900, 372}, {938, 368}}, 5, 0.8, sTreeD, 1.6)
limb({{890, 352}, {916, 322}, {932, 296}}, 4.5, 0.78, sTreeD, 1.6)
limb({{908, 330}, {940, 312}, {962, 296}}, 4, 0.75, sTreeD, 1.6)
limb({{910, 452}, {950, 424}, {976, 398}}, 4.5, 0.78, sTreeD, 1.6)
limb({{970, 428}, {992, 412}, {998, 400}}, 3.5, 0.72, sTreeD, 1.6)
limb({{752, 438}, {724, 420}, {700, 410}}, 4, 0.75, sTreeD, 1.6)
limb({{818, 380}, {842, 356}, {862, 340}}, 4, 0.75, sTreeD, 1.6)
limb({{830, 336}, {852, 316}, {868, 296}}, 3.5, 0.72, sTreeD, 1.6)
limb({{866, 500}, {898, 486}, {926, 474}}, 4, 0.75, sTreeD, 1.6)
-- third order
limb({{694, 330}, {672, 318}, {654, 310}}, 2.6, 0.75, sTreeM, 1.3)
limb({{900, 372}, {928, 362}, {952, 356}}, 2.6, 0.75, sTreeM, 1.3)
limb({{950, 424}, {972, 404}, {990, 386}}, 2.6, 0.75, sTreeM, 1.3)
limb({{842, 356}, {862, 344}, {880, 334}}, 2.6, 0.75, sTreeM, 1.3)
limb({{716, 292}, {706, 272}, {700, 254}}, 2.6, 0.75, sTreeM, 1.3)
limb({{916, 322}, {930, 300}, {940, 282}}, 2.6, 0.75, sTreeM, 1.3)
-- twig clusters at branch ends
local wb = brush{kind="rigger", width=1.4, point=1, stiffness=0.5}
wb:load(sTreeM, 0.8)
local function cluster(x0, y0, a0, spread, n, lmin, lmax, pl)
  wb:reload(pl or sTreeM, 0.8)
  for i = 1, n do
    local a = a0 + rand(-spread, spread)
    local L = rand(lmin, lmax)
    local x1 = x0 + math.cos(a) * L
    local y1 = y0 + math.sin(a) * L + L * 0.15
    wb:gesture({{x0, y0, 0.5}, {x1, y1, 0.05}}, {wobble=1})
  end
end
cluster(668, 258, -2.2, 0.7, 8, 12, 24)
cluster(642, 258, -2.5, 0.6, 6, 10, 20)
cluster(726, 266, -1.9, 0.6, 6, 10, 20)
cluster(700, 254, -1.6, 0.6, 5, 10, 18)
cluster(922, 308, -1.2, 0.6, 7, 12, 22)
cluster(932, 296, -1.1, 0.6, 6, 10, 20)
cluster(962, 296, -0.8, 0.6, 6, 10, 20)
cluster(940, 282, -1.4, 0.6, 5, 10, 18)
cluster(938, 368, -0.2, 0.6, 6, 10, 20)
cluster(952, 356, -0.5, 0.6, 5, 10, 18)
cluster(970, 428, -0.1, 0.6, 7, 12, 22)
cluster(976, 398, -1.0, 0.6, 6, 10, 20)
cluster(998, 400, -0.3, 0.6, 5, 10, 18)
cluster(990, 386, -0.9, 0.6, 5, 10, 18, sTreeD)
cluster(722, 416, -2.8, 0.6, 6, 10, 20)
cluster(700, 410, -2.9, 0.6, 5, 10, 18)
cluster(830, 336, -1.5, 0.6, 6, 10, 20)
cluster(868, 296, -1.2, 0.6, 6, 10, 20)
cluster(880, 334, -1.1, 0.6, 5, 10, 18)
cluster(862, 340, -0.9, 0.6, 5, 10, 18, sTreeD)
cluster(898, 486, 0.1, 0.6, 6, 10, 20)
cluster(926, 474, 0.0, 0.6, 5, 10, 18)
cluster(764, 458, 2.9, 0.6, 5, 10, 18)
cluster(860, 610, 2.6, 0.7, 4, 8, 14, sTreeD)   -- epicormic shoot, trunk
cluster(840, 522, -0.4, 0.7, 4, 8, 14, sTreeD)  -- epicormic shoot, trunk
-- rim light: trunk left edge and the limbs facing the light
local rim = brush{kind="rigger", width=2, point=0.9}
rim:load(sRim, 0.4)
rim:gesture({{874, 706, 0.5}, {861, 636, 0.45}, {845, 566, 0.4}, {827, 508, 0.32}}, {wobble=1})
rim:gesture({{823, 500, 0.32}, {806, 462, 0.25}, {794, 442, 0.15}}, {wobble=1})
rim:gesture({{786, 448, 0.4}, {754, 396, 0.35}, {722, 352, 0.3}, {694, 318, 0.22}, {678, 288, 0.12}}, {wobble=1})
rim:gesture({{796, 448, 0.35}, {802, 402, 0.3}, {812, 366, 0.2}}, {wobble=1})
rim:gesture({{806, 474, 0.3}, {768, 454, 0.25}, {738, 438, 0.15}}, {wobble=1})
print("scratch rehearsal 4 laid")
