-- easel session "scratch": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box friedrich
--@ engine 5

--@ chunk 1
canvas{aspect=1.4, ground={{apply="knife", pile={{"red earth", 3}, {"yellow ochre", 2}, {"lead white", 1}}, texture=0.35, um=45}, {apply="knife", pile={{"lead white", 6}, {"yellow ochre", 1}, {"raw umber", 0.5}}, texture=0.5, um=40}, {apply="brush", pile={{"lead white", 8}, {"yellow ochre", 0.4}, {"raw umber", 0.3}}, um=55}}, linen={14, 16}, seed=11, size=1200}

--@ chunk 2
-- scratch rehearsal 7: muted quiet sky, rest as rehearsal 6
local sDeep  = pile{{"smalt", 2}, {"Prussian blue", 0.5}, {"bone black", 0.4}, {"lead white", 0.5}, {"raw umber", 0.2}, turps=0.55}
local sMid   = pile{{"pale smalt", 2.5}, {"smalt", 0.6}, {"Prussian blue", 0.2}, {"lead white", 0.9}, {"raw umber", 0.2}, turps=0.5}
local sPale  = pile{{"pale smalt", 2}, {"lead white", 1.4}, {"Naples yellow", 0.1}, turps=0.45}
local sGlow  = pile{{"lead white", 3}, {"Naples yellow", 1}, {"red earth", 0.22}, turps=0.4}
local sGlowG = pile{{"lead white", 2}, {"Naples yellow", 1}, {"red earth", 0.15}, medium=0.45}
local sWTop  = pile{{"lead white", 1.6}, {"Naples yellow", 0.5}, {"pale smalt", 0.5}, turps=0.5}
local sWMid  = pile{{"pale smalt", 1}, {"raw umber", 0.45}, {"lead white", 0.4}, {"Prussian blue", 0.2}, turps=0.5}
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
local function glowX(x) return 0.5 + 0.5 * math.exp(-((x - 500) / 260) ^ 2) end

-- SKY
local skyM = above(function(x) return 468 end)
local wDeep = function(x, y) return 1 - sw(30, 190, y) end
local wMid  = function(x, y) return sw(50, 170, y) * (1 - sw(300, 400, y)) end
local wPale = function(x, y) return sw(300, 380, y) * (1 - sw(400, 432, y)) end
local wGlow = function(x, y) return sw(375, 442, y) * glowX(x) end
work(skyM, {hand="broad",
  piles={{sDeep, wDeep}, {sMid, wMid}, {sPale, wPale}, {sGlow, wGlow}},
  angle=0, length={130, 230}, coverage=1.5, fill=true, pressure={0.5, 0.75},
  curve={0.3, 0.5}, mix_jitter=0.5, seed=3})
blend(skyM, {angle=0})
local cD1 = ellipse(280, 110, 400, 26):soften(16)
work(cD1, {hand="body", piles={{sDeep, 0.45}, {sMid, 0.55}}, angle=0, length={90, 170},
  coverage=0.9, pressure={0.35, 0.55}, seed=4})
blend(cD1:soften(6), {angle=0.1})
local cL1 = ellipse(660, 250, 360, 22):soften(18)
work(cL1, {hand="body", piles={{sPale, 0.7}, {sGlow, 0.3}}, angle=0, length={90, 170},
  coverage=0.8, pressure={0.3, 0.5}, seed=5})
blend(cL1:soften(6), {angle=-0.05})
local cL2 = ellipse(240, 340, 220, 16):soften(16)
work(cL2, {hand="body", piles={{sPale, 0.7}, {sGlow, 0.3}}, angle=0, length={70, 130},
  coverage=0.7, pressure={0.28, 0.45}, seed=14})
blend(cL2:soften(6), {angle=0.05})
local cD2 = ellipse(820, 300, 200, 14):soften(16)
work(cD2, {hand="body", piles={{sDeep, 0.35}, {sMid, 0.65}}, angle=0, length={70, 130},
  coverage=0.7, pressure={0.3, 0.5}, seed=15})
blend(cD2:soften(6), {angle=-0.08})
local band = rect(0, 404, 1000, 66):soften(18)
work(band, {hand="glaze", pile=sGlowG, coverage=1.0, angle=0, length={150, 260},
  load=0.8, load_at=function(x, y) return 0.6 + 0.55 * glowX(x) end, pressure={0.22, 0.35}, seed=6})

-- WATER
local waterT = (below(wtop) - below(waterline)) * rect(20, 470, 640, 250)
local vTop = function(x, y) return sw(476, 496, y) * (1 - sw(516, 540, y)) * glowX(x) end
local vMid = function(x, y) return sw(500, 530, y) * (1 - sw(550, 590, y)) end
local vLow = function(x, y) return sw(530, 575, y) end
work(waterT, {hand="broad", piles={{sWTop, vTop}, {sWMid, vMid}, {sWLow, vLow}},
  angle=0, length={150, 260}, coverage=1.2, fill=true, pressure={0.35, 0.5}, seed=7})
local farT = rect(0, 462, 640, 16):roughen(3, 40, 7):soften(4)
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
stipple(colT, {pile=sGlow, width=2.0,
  coverage=function(x, y) return 1.3 * (1 - sw(478, 555, y)) + 0.3 end,
  drag={5, 0}, cluster=0.4, pressure={0.4, 0.7}, dips={18, 0.5}, seed=10})

-- FOREGROUND SHORE
local shoreT = below(waterline) * rect(20, 640, 640, 100)
work(shoreT, {hand="body", pile=sShoreD, coverage=2, angle=0.04, length={60, 120},
  fill=true, pressure={0.6, 0.85}, seed=11})
work(shoreT, {hand="body", piles={{sShoreL, 0.22}, {sShoreD, 0.78}}, coverage=0.35, load=0.2,
  angle=-0.07, length={40, 90}, pressure={0.3, 0.45}, seed=12})
local wetT = mask(function(x, y) local wl = waterline(x)
  if y > wl - 1 and y < wl + 8 then return 1 else return 0 end end) * rect(20, 640, 640, 100)
work(wetT, {hand="body", pile=sRim, coverage=0.5, load=0.3, length={24, 55}, angle=0,
  pressure={0.4, 0.6}, broken=0.6, seed=13})

-- FIGURE
local fb = brush("filbert", 12)
fb:load(sFig, 0.95)
fb:gesture({{500, 547, 0.9}, {501, 575, 0.92}, {500, 605, 0.92}, {500, 631, 0.88}})
fb:gesture({{489, 551, 0.85}, {500, 545, 0.92}, {511, 551, 0.85}})
fb:gesture({{493, 552, 0.8}, {492, 580, 0.85}, {493, 610, 0.85}, {494, 630, 0.8}})
fb:gesture({{507, 552, 0.8}, {508, 580, 0.85}, {507, 610, 0.85}, {506, 630, 0.8}})
local hb = brush{kind="round", width=12}
hb:load(sFig, 0.95)
hb:gesture({{500, 529, 0.7}, {500, 543, 0.8}})
hb:touch(500, 536, {pressure=0.85})
local fr = brush{kind="rigger", width=1.2, point=0.9}
fr:load(sRim, 0.35)
fr:gesture({{489, 552, 0.5}, {488, 580, 0.45}, {490, 610, 0.35}, {491, 628, 0.12}}, {wobble=0.6})
fr:gesture({{494, 530, 0.4}, {492, 535, 0.2}}, {wobble=0.4})
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

-- TREE
local tb = brush("filbert", 22)
tb:load(sTreeD, 1.0)
tb:gesture({{884, 716, 0.95}, {872, 655, 0.95}, {856, 595, 0.9}, {838, 540, 0.85},
  {818, 495, 0.75}, {800, 455, 0.6}}, {wobble=3})
tb:gesture({{880, 716, 0.9}, {866, 648, 0.9}, {850, 585, 0.85}, {830, 528, 0.75},
  {810, 480, 0.6}, {795, 448, 0.5}}, {wobble=2})
local tbase = brush("filbert", 26)
tbase:load(sTreeD, 1.0)
tbase:gesture({{892, 716, 0.9}, {878, 700, 0.85}, {868, 686, 0.7}}, {wobble=2})
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
limb({{798, 448}, {762, 392}, {724, 348}, {694, 312}, {676, 282}, {668, 258}}, 11, 0.85, sTreeD, 2.5)
limb({{810, 438}, {848, 392}, {882, 358}, {908, 330}, {922, 308}}, 10, 0.85, sTreeD, 2.5)
limb({{836, 486}, {888, 466}, {934, 446}, {970, 428}}, 8, 0.85, sTreeD, 2.5)
limb({{812, 466}, {772, 446}, {742, 430}, {722, 416}}, 7, 0.8, sTreeD, 2)
limb({{804, 444}, {812, 398}, {822, 362}, {830, 336}}, 7, 0.8, sTreeD, 2)
limb({{830, 520}, {866, 500}, {898, 486}}, 6, 0.8, sTreeD, 2)
limb({{822, 492}, {790, 472}, {764, 458}}, 5, 0.8, sTreeD, 2)
limb({{724, 348}, {694, 330}, {668, 318}}, 5, 0.8, sTreeD, 1.6)
limb({{700, 322}, {716, 292}, {726, 266}}, 4.5, 0.78, sTreeD, 1.6)
limb({{676, 282}, {656, 268}, {642, 258}}, 4, 0.75, sTreeD, 1.6)
limb({{748, 372}, {720, 352}, {698, 342}}, 3.5, 0.72, sTreeD, 1.6)
limb({{860, 380}, {900, 372}, {938, 368}}, 5, 0.8, sTreeD, 1.6)
limb({{890, 352}, {916, 322}, {932, 296}}, 4.5, 0.78, sTreeD, 1.6)
limb({{908, 330}, {940, 312}, {962, 296}}, 4, 0.75, sTreeD, 1.6)
limb({{848, 392}, {826, 372}, {808, 360}}, 3.5, 0.72, sTreeD, 1.6)
limb({{910, 452}, {950, 424}, {976, 398}}, 4.5, 0.78, sTreeD, 1.6)
limb({{970, 428}, {992, 412}, {998, 400}}, 3.5, 0.72, sTreeD, 1.6)
limb({{888, 466}, {862, 452}, {840, 444}}, 3.5, 0.72, sTreeD, 1.6)
limb({{752, 438}, {724, 420}, {700, 410}}, 4, 0.75, sTreeD, 1.6)
limb({{818, 380}, {842, 356}, {862, 340}}, 4, 0.75, sTreeD, 1.6)
limb({{830, 336}, {852, 316}, {868, 296}}, 3.5, 0.72, sTreeD, 1.6)
limb({{816, 388}, {796, 372}, {780, 362}}, 3, 0.7, sTreeD, 1.6)
limb({{866, 500}, {898, 486}, {926, 474}}, 4, 0.75, sTreeD, 1.6)
limb({{694, 330}, {672, 318}, {654, 310}}, 2.6, 0.75, sTreeM, 1.3)
limb({{900, 372}, {928, 362}, {952, 356}}, 2.6, 0.75, sTreeM, 1.3)
limb({{950, 424}, {972, 404}, {990, 386}}, 2.6, 0.75, sTreeD, 1.3)
limb({{842, 356}, {862, 344}, {880, 334}}, 2.6, 0.75, sTreeM, 1.3)
limb({{716, 292}, {706, 272}, {700, 254}}, 2.6, 0.75, sTreeD, 1.3)
limb({{916, 322}, {930, 300}, {940, 282}}, 2.6, 0.75, sTreeD, 1.3)
local wb = brush{kind="rigger", width=1.4, point=1, stiffness=0.5}
wb:load(sTreeD, 0.8)
local function twig_gesture(x0, y0, a, L, p0)
  local x1 = x0 + math.cos(a) * L
  local y1 = y0 + math.sin(a) * L + L * 0.18
  wb:gesture({{x0, y0, p0}, {x1, y1, 0.05}}, {wobble=0.8})
end
local function bough_twigs(pts, side, n, lmin, lmax, pl)
  wb:reload(pl or sTreeD, 0.75)
  local np = #pts
  for i = 1, n do
    local t = 0.4 + 0.6 * (i - 0.5) / n
    local fi = t * (np - 1) + 1
    local i0 = math.floor(fi); if i0 >= np then i0 = np - 1 end
    local f = fi - i0
    local x0 = lerp(pts[i0][1], pts[i0 + 1][1], f)
    local y0 = lerp(pts[i0][2], pts[i0 + 1][2], f)
    local ia = math.max(1, i0 - 1); local ib = math.min(np, i0 + 2)
    local ab = math.atan(pts[ib][2] - pts[ia][2], pts[ib][1] - pts[ia][1])
    local s = side * (0.5 + 0.4 * ((i % 2) - 0.5) * 2)
    local a = ab + s * (0.55 + 0.4 * rand(0, 1)) + rand(-0.12, 0.12)
    twig_gesture(x0, y0, a, rand(lmin, lmax), 0.45)
  end
end
local function tip_cluster(x0, y0, a0, spread, n, lmin, lmax, pl)
  wb:reload(pl or sTreeD, 0.8)
  local a = a0
  for i = 1, n do
    a = a + rand(-spread, spread) * 0.8
    local L = rand(lmin, lmax)
    if i % 3 == 0 then
      local xm = x0 + math.cos(a) * L * 0.6
      local ym = y0 + math.sin(a) * L * 0.6 + L * 0.1
      local x1 = x0 + math.cos(a) * L
      local y1 = y0 + math.sin(a) * L + L * 0.18
      wb:gesture({{x0, y0, 0.5}, {xm, ym, 0.3}, {x1, y1, 0.05}}, {wobble=0.8})
    else
      twig_gesture(x0, y0, a, L, 0.5)
    end
  end
end
bough_twigs({{798, 448}, {762, 392}, {724, 348}, {694, 312}, {676, 282}, {668, 258}}, -1, 4, 10, 18)
bough_twigs({{810, 438}, {848, 392}, {882, 358}, {908, 330}, {922, 308}}, 1, 4, 10, 18)
bough_twigs({{836, 486}, {888, 466}, {934, 446}, {970, 428}}, 1, 3, 10, 16)
bough_twigs({{812, 466}, {772, 446}, {742, 430}, {722, 416}}, -1, 3, 9, 15)
bough_twigs({{804, 444}, {812, 398}, {822, 362}, {830, 336}}, 1, 3, 9, 15)
bough_twigs({{830, 520}, {866, 500}, {898, 486}}, 1, 2, 9, 14)
bough_twigs({{822, 492}, {790, 472}, {764, 458}}, -1, 2, 9, 14)
bough_twigs({{724, 348}, {694, 330}, {668, 318}}, -1, 2, 8, 13)
tip_cluster(668, 318, -2.6, 0.5, 5, 10, 18)
bough_twigs({{700, 322}, {716, 292}, {726, 266}}, 1, 2, 8, 13)
tip_cluster(726, 266, -1.2, 0.5, 5, 10, 18, sTreeM)
bough_twigs({{676, 282}, {656, 268}, {642, 258}}, -1, 2, 8, 13)
tip_cluster(642, 258, -2.5, 0.5, 5, 9, 16)
tip_cluster(698, 342, -2.7, 0.5, 4, 9, 15)
bough_twigs({{860, 380}, {900, 372}, {938, 368}}, 1, 2, 8, 13)
tip_cluster(938, 368, -0.15, 0.5, 5, 10, 17)
bough_twigs({{890, 352}, {916, 322}, {932, 296}}, 1, 2, 8, 13)
tip_cluster(932, 296, -1.0, 0.5, 5, 10, 17)
bough_twigs({{908, 330}, {940, 312}, {962, 296}}, 1, 2, 8, 13)
tip_cluster(962, 296, -0.65, 0.5, 5, 10, 17, sTreeM)
tip_cluster(808, 360, -2.5, 0.5, 4, 9, 15)
bough_twigs({{910, 452}, {950, 424}, {976, 398}}, 1, 2, 8, 13)
tip_cluster(976, 398, -0.8, 0.5, 5, 10, 17)
tip_cluster(998, 400, -1.0, 0.5, 4, 9, 15)
tip_cluster(840, 444, -2.7, 0.5, 4, 9, 15)
bough_twigs({{752, 438}, {724, 420}, {700, 410}}, -1, 2, 8, 13)
tip_cluster(700, 410, -2.7, 0.5, 5, 9, 16, sTreeM)
bough_twigs({{818, 380}, {842, 356}, {862, 340}}, 1, 2, 8, 13)
tip_cluster(862, 340, -0.7, 0.5, 5, 9, 16)
bough_twigs({{830, 336}, {852, 316}, {868, 296}}, 1, 2, 8, 12)
tip_cluster(868, 296, -0.85, 0.5, 4, 9, 15)
tip_cluster(780, 362, -2.5, 0.5, 4, 9, 14)
bough_twigs({{866, 500}, {898, 486}, {926, 474}}, 1, 2, 8, 12)
tip_cluster(926, 474, -0.4, 0.5, 4, 9, 15)
tip_cluster(654, 310, -2.6, 0.5, 4, 8, 13)
tip_cluster(952, 356, -0.4, 0.5, 4, 8, 13)
tip_cluster(990, 386, -0.9, 0.5, 4, 8, 13)
tip_cluster(880, 334, -0.9, 0.5, 4, 8, 13, sTreeM)
tip_cluster(700, 254, -1.6, 0.5, 4, 8, 13)
tip_cluster(940, 282, -1.4, 0.5, 4, 8, 13)
tip_cluster(668, 258, -1.9, 0.6, 7, 12, 22)
tip_cluster(922, 308, -1.05, 0.6, 6, 11, 20)
tip_cluster(970, 428, -0.5, 0.6, 6, 11, 20)
tip_cluster(722, 416, -2.5, 0.6, 5, 10, 17)
tip_cluster(830, 336, -1.3, 0.6, 5, 10, 17)
tip_cluster(898, 486, -0.4, 0.6, 5, 10, 17)
tip_cluster(764, 458, -2.6, 0.6, 4, 9, 15)
tip_cluster(860, 610, 2.6, 0.7, 4, 8, 13)
tip_cluster(840, 522, -0.4, 0.7, 4, 8, 13)
local rim = brush{kind="rigger", width=2, point=0.9}
rim:load(sRim, 0.45)
rim:gesture({{874, 706, 0.5}, {861, 636, 0.45}, {845, 566, 0.4}, {827, 508, 0.32}}, {wobble=1})
rim:gesture({{823, 500, 0.32}, {806, 462, 0.25}, {794, 442, 0.15}}, {wobble=1})
rim:gesture({{786, 448, 0.4}, {754, 396, 0.35}, {722, 352, 0.3}, {694, 318, 0.22}, {678, 288, 0.12}}, {wobble=1})
rim:gesture({{796, 448, 0.35}, {802, 402, 0.3}, {812, 366, 0.2}}, {wobble=1})
rim:gesture({{806, 474, 0.3}, {768, 454, 0.25}, {738, 438, 0.15}}, {wobble=1})
print("scratch rehearsal 7 laid")
