-- easel session "painting": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box friedrich
--@ engine 5

--@ chunk 1
canvas{size=1200, aspect=1.4, linen={14, 16}, seed=11,
  ground={
    {pile={{"red earth", 3}, {"yellow ochre", 2}, {"lead white", 1}}, um=45, apply="knife", texture=0.35},
    {pile={{"lead white", 6}, {"yellow ochre", 1}, {"raw umber", 0.5}}, um=40, apply="knife", texture=0.5},
    {pile={{"lead white", 8}, {"yellow ochre", 0.4}, {"raw umber", 0.3}}, um=55, apply="brush"},
  }}
palette{set_out={"lead white", "smalt", "pale smalt", "Prussian blue", "yellow ochre", "red earth", "raw umber", "bone black", "Naples yellow", "green earth"}}
print("canvas", W, H)

--@ chunk 2
skyDeep  = pile{{"smalt", 2}, {"Prussian blue", 0.45}, {"bone black", 0.3}, {"lead white", 0.4}, turps=0.55, name="sky deep"}
skyMid   = pile{{"pale smalt", 2}, {"smalt", 1}, {"lead white", 1.2}, {"raw umber", 0.15}, turps=0.5, name="sky mid"}
skyPale  = pile{{"pale smalt", 1.5}, {"lead white", 2}, {"Naples yellow", 0.12}, turps=0.45, name="sky pale"}
glow     = pile{{"lead white", 3}, {"Naples yellow", 1}, {"red earth", 0.22}, turps=0.4, name="afterglow"}
glowGlaze= pile{{"lead white", 2}, {"Naples yellow", 1}, {"red earth", 0.15}, medium=0.45, name="glow glaze"}
waterTop = pile{{"lead white", 1.6}, {"Naples yellow", 0.5}, {"pale smalt", 0.5}, turps=0.5, name="water top"}
waterMid = pile{{"pale smalt", 1}, {"raw umber", 0.5}, {"lead white", 0.6}, {"Prussian blue", 0.15}, turps=0.5, name="water mid"}
waterLow = pile{{"raw umber", 1}, {"Prussian blue", 0.4}, {"bone black", 0.35}, {"lead white", 0.15}, turps=0.5, name="water low"}
shoreFar = pile{{"raw umber", 1}, {"bone black", 0.5}, {"Prussian blue", 0.25}, turps=0.55, name="far shore"}
mist     = pile{{"lead white", 2}, {"pale smalt", 0.5}, {"Naples yellow", 0.15}, thinner=0.4, name="mist"}
shoreDark= pile{{"raw umber", 2}, {"bone black", 1}, {"Prussian blue", 0.3}, {"green earth", 0.2}, name="shore dark"}
shoreLit = pile{{"yellow ochre", 1}, {"raw umber", 0.8}, {"lead white", 0.25}, name="shore light"}
treeDark = pile{{"raw umber", 2}, {"bone black", 1.1}, name="tree dark"}
treeMid  = pile{{"raw umber", 1.2}, {"bone black", 0.5}, {"yellow ochre", 0.15}, name="tree mid"}
rimLight = pile{{"lead white", 1}, {"Naples yellow", 0.3}, {"raw umber", 0.3}, name="rim light"}
figDark  = pile{{"raw umber", 1}, {"bone black", 1}, {"Prussian blue", 0.2}, name="figure"}
print(palette())

--@ chunk 3
h = pencil("2H")
h:rule({30, 468}, {970, 468}, {pressure=0.16})          -- horizon, ruled level
h:line({{30, 470}, {970, 470}}, {pressure=0.11})        -- far shore line
h:line({{40, 663}, {960, 663}}, {pressure=0.12})        -- waterline
h:line({{500, 530}, {500, 634}}, {pressure=0.13})       -- figure axis
h:line({{489, 549}, {511, 549}}, {pressure=0.11})       -- figure shoulders
h:sketch({{884, 716}, {868, 640}, {850, 570}, {828, 510}, {808, 468}, {795, 440}}, {pressure=0.13, wander=3})
h:sketch({{800, 450}, {770, 400}, {735, 355}, {705, 320}, {688, 292}}, {pressure=0.12, wander=2})
h:sketch({{812, 440}, {850, 395}, {885, 360}, {910, 330}}, {pressure=0.12, wander=2})
h:sketch({{838, 490}, {890, 468}, {935, 448}, {968, 430}}, {pressure=0.12, wander=2})
h:sketch({{815, 470}, {775, 448}, {745, 432}}, {pressure=0.11, wander=2})
print("sketch laid")

--@ chunk 4
-- CAMPAIGN 1: the sky. Piles refreshed to the rehearsed recipes first.
skyDeep  = pile{{"smalt", 2}, {"Prussian blue", 0.2}, {"bone black", 0.35}, {"lead white", 0.6}, {"raw umber", 0.25}, turps=0.55, name="sky deep"}
skyMid   = pile{{"pale smalt", 2}, {"smalt", 0.5}, {"Prussian blue", 0.12}, {"lead white", 1.0}, {"raw umber", 0.25}, turps=0.5, name="sky mid"}
skyPale  = pile{{"pale smalt", 1.5}, {"lead white", 1.5}, {"Naples yellow", 0.1}, {"raw umber", 0.1}, turps=0.45, name="sky pale"}
waterMid = pile{{"pale smalt", 1}, {"raw umber", 0.45}, {"lead white", 0.4}, {"Prussian blue", 0.12}, turps=0.5, name="water mid"}
waterLow = pile{{"raw umber", 1.2}, {"Prussian blue", 0.3}, {"bone black", 0.45}, {"lead white", 0.1}, turps=0.5, name="water low"}
glow     = pile{{"lead white", 3}, {"Naples yellow", 1}, {"red earth", 0.22}, turps=0.4, name="afterglow"}
glowGlaze= pile{{"lead white", 2}, {"Naples yellow", 1}, {"red earth", 0.15}, medium=0.45, name="glow glaze"}
waterTop = pile{{"lead white", 1.6}, {"Naples yellow", 0.5}, {"pale smalt", 0.5}, turps=0.5, name="water top"}
print(palette())

local function sw(a, b, x) return smoothstep(a, b, x) end
local function glowX(x) return 0.5 + 0.5 * math.exp(-((x - 500) / 260) ^ 2) end
local skyM = above(function(x) return 468 end)
local wDeep = function(x, y) return 1 - sw(30, 190, y) end
local wMid  = function(x, y) return sw(50, 170, y) * (1 - sw(300, 400, y)) end
local wPale = function(x, y) return sw(300, 380, y) * (1 - sw(400, 432, y)) end
local wGlow = function(x, y) return sw(375, 442, y) * glowX(x) end

-- base: one pass of large soft horizontal bands, graded by height
local bigsky = brush{kind="filbert", width=64, point=0, stiffness=0.35}
work(skyM, {hand="body", tool=bigsky, ruler=true,
  piles={{skyDeep, wDeep}, {skyMid, wMid}, {skyPale, wPale}, {glow, wGlow}},
  angle=0, length={280, 420}, coverage=1.15, fill=true, pressure={0.55, 0.8},
  ramps={0.25, 0.25}, mix_jitter=0.25, seed=3})

-- cloud bands: one dark high, light mid, one wedge each side
local cD1 = ellipse(280, 110, 400, 26):soften(16)
work(cD1, {hand="body", piles={{skyDeep, 0.45}, {skyMid, 0.55}}, angle=0, length={90, 170},
  coverage=0.9, pressure={0.35, 0.55}, seed=4})
blend(cD1:soften(6), {angle=0.1})
local cL1 = ellipse(660, 250, 360, 22):soften(18)
work(cL1, {hand="body", piles={{skyPale, 0.7}, {glow, 0.3}}, angle=0, length={90, 170},
  coverage=0.8, pressure={0.3, 0.5}, seed=5})
blend(cL1:soften(6), {angle=-0.05})
local cL2 = ellipse(240, 340, 220, 16):soften(16)
work(cL2, {hand="body", piles={{skyPale, 0.7}, {glow, 0.3}}, angle=0, length={70, 130},
  coverage=0.7, pressure={0.28, 0.45}, seed=14})
blend(cL2:soften(6), {angle=0.05})
local cD2 = ellipse(820, 300, 200, 14):soften(16)
work(cD2, {hand="body", piles={{skyDeep, 0.35}, {skyMid, 0.65}}, angle=0, length={70, 130},
  coverage=0.7, pressure={0.3, 0.5}, seed=15})
blend(cD2:soften(6), {angle=-0.08})

-- the afterglow: quiet glaze, brightest at the centre
local band = rect(0, 404, 1000, 66):soften(18)
work(band, {hand="glaze", pile=glowGlaze, coverage=1.0, angle=0, length={150, 260},
  load=0.8, load_at=function(x, y) return 0.6 + 0.55 * glowX(x) end, pressure={0.22, 0.35}, seed=6})

-- smooth the wet sky with a clean badger, horizontal passes
local sm = brush("badger", 40)
for i = 0, 13 do
  local y = 20 + i * 34
  sm:stroke({{0, y}, {1000, y}}, {pressure=0.3, orient="across", ramps={0.12, 0.12}})
  sm:wipe(0.92)
end
for i = 0, 13 do
  local y = 37 + i * 34
  sm:stroke({{0, y}, {1000, y}}, {pressure=0.22, orient="across", ramps={0.15, 0.15}})
  sm:wipe(0.92)
end
print("campaign 1 (sky) laid")

--@ chunk 5
wait(2 * 24 * 60)
print("top:", drying(200, 100))
print("mid sky:", drying(500, 300))
print("glow band:", drying(500, 440))
print("sky bottom:", drying(800, 465))

--@ chunk 6
wait(24 * 60)
print("glow band:", drying(500, 440))
print("sky bottom:", drying(800, 465))
print("mid sky:", drying(500, 300))

--@ chunk 7
-- CAMPAIGN 2: water, far shore, mist, glimmer
local function sw(a, b, x) return smoothstep(a, b, x) end
function waterline(x) return 662 + 5*math.sin(x/70 + 1.3) + 3*math.sin(x/23 + 0.5) end
local function wtop(x) return 480 + 2.5*math.sin(x/110) + 1.5*math.sin(x/37) end
local function glowX(x) return 0.5 + 0.5 * math.exp(-((x - 500) / 260) ^ 2) end

-- water: graded, bright in a narrow reflection under the shore, dark toward the viewer
local waterM = below(wtop) - below(waterline)
local vTop = function(x, y) return sw(476, 496, y) * (1 - sw(516, 540, y)) * glowX(x) end
local vMid = function(x, y) return sw(500, 530, y) * (1 - sw(550, 590, y)) end
local vLow = function(x, y) return sw(530, 575, y) end
work(waterM, {hand="broad", piles={{waterTop, vTop}, {waterMid, vMid}, {waterLow, vLow}},
  angle=0, length={150, 260}, coverage=1.2, fill=true, pressure={0.35, 0.5}, seed=7})

-- far shore: a low dark strip, dissolving at its ends
local farT = rect(0, 462, 1000, 20):roughen(3, 40, 7):soften(4)
farT = farT * mask(function(x, y) return clamp((x - 30)/140, 0, 1) * clamp((970 - x)/140, 0, 1) end)
work(farT, {hand="body", pile=shoreFar, angle=0, length={90, 160}, coverage=1.4, fill=true,
  pressure={0.5, 0.7}, seed=8})

-- mist veiling the seam
local mistT = rect(0, 430, 1000, 84):soften(22)
work(mistT, {hand="glaze", pile=mist, coverage=0.8, angle=0, length={140, 240},
  pressure={0.2, 0.3}, seed=9})

-- the glitter path under the light
local colT = mask(function(x, y)
  local t = clamp((y - 478) / 184, 0, 1)
  local half = 16 + 80 * t * t
  local c = 500 + 25 * t
  if y > 478 and y < 662 and math.abs(x - c) < half then return 1 else return 0 end
end)
stipple(colT, {pile=glow, width=2.0,
  coverage=function(x, y) return 1.3 * (1 - sw(478, 555, y)) + 0.3 end,
  drag={5, 0}, cluster=0.4, pressure={0.4, 0.7}, dips={18, 0.5}, seed=10})
print("campaign 2 (water, far shore, mist, glimmer) laid")

--@ chunk 8
-- CAMPAIGN 2b: repairs while wet — calm the water, veil the heavy far shore, re-glitter
local function sw(a, b, x) return smoothstep(a, b, x) end
function waterline(x) return 662 + 5*math.sin(x/70 + 1.3) + 3*math.sin(x/23 + 0.5) end

-- 1. smooth the wet water with a clean badger, horizontal passes
local sm = brush("badger", 40)
for i = 0, 6 do
  local y = 492 + i * 28
  sm:stroke({{0, y}, {1000, y}}, {pressure=0.28, orient="across", ramps={0.12, 0.12}})
  sm:wipe(0.92)
end
for i = 0, 6 do
  local y = 578 + i * 14
  sm:stroke({{0, y}, {1000, y}}, {pressure=0.28, orient="across", ramps={0.12, 0.12}})
  sm:wipe(0.92)
end
for i = 0, 6 do
  local y = 505 + i * 28
  sm:stroke({{0, y}, {1000, y}}, {pressure=0.2, orient="across", ramps={0.15, 0.15}})
  sm:wipe(0.92)
end
for i = 0, 6 do
  local y = 585 + i * 13
  sm:stroke({{0, y}, {1000, y}}, {pressure=0.2, orient="across", ramps={0.15, 0.15}})
  sm:wipe(0.92)
end

-- 2. veil the far shore strip and the water's far edge with mist
local veilT = rect(0, 458, 1000, 44):soften(14)
work(veilT, {hand="glaze", pile=mist, coverage=1.0, angle=0, length={140, 240},
  pressure={0.25, 0.35}, seed=22})

-- 3. re-lay the glitter over the calmed water
local colT = mask(function(x, y)
  local t = clamp((y - 478) / 184, 0, 1)
  local half = 16 + 80 * t * t
  local c = 500 + 25 * t
  if y > 478 and y < 662 and math.abs(x - c) < half then return 1 else return 0 end
end)
stipple(colT, {pile=glow, width=2.0,
  coverage=function(x, y) return 1.3 * (1 - sw(478, 555, y)) + 0.3 end,
  drag={5, 0}, cluster=0.4, pressure={0.4, 0.7}, dips={18, 0.5}, seed=23})
print("campaign 2b (repairs) done")

--@ chunk 9
-- CAMPAIGN 3: the foreground shore
function waterline(x) return 662 + 5*math.sin(x/70 + 1.3) + 3*math.sin(x/23 + 0.5) end
local function sw(a, b, x) return smoothstep(a, b, x) end

-- deepen the water just above the shore (a second thin pass of the dark water)
local deepM = (below(function(x) return 585 end) - below(waterline))
work(deepM, {hand="body", pile=waterLow, angle=0, length={100, 180}, coverage=1.0,
  fill=true, pressure={0.4, 0.6}, seed=24})
local sm = brush("badger", 40)
for i = 0, 3 do
  local y = 592 + i * 22
  sm:stroke({{0, y}, {1000, y}}, {pressure=0.2, orient="across", ramps={0.15, 0.15}})
  sm:wipe(0.92)
end

-- the shore mass
local shoreM = below(waterline)
work(shoreM, {hand="body", pile=shoreDark, coverage=2, angle=0.04, length={60, 120},
  fill=true, pressure={0.6, 0.85}, seed=11})
-- faint warm lights in the dark mass
work(shoreM, {hand="body", piles={{shoreLit, 0.22}, {shoreDark, 0.78}}, coverage=0.35, load=0.2,
  angle=-0.07, length={40, 90}, pressure={0.3, 0.45}, seed=12})
-- the wet edge catching the last light
local wetT = mask(function(x, y) local wl = waterline(x)
  if y > wl - 1 and y < wl + 8 then return 1 else return 0 end end)
work(wetT, {hand="body", pile=rimLight, coverage=0.5, load=0.3, length={24, 55}, angle=0,
  pressure={0.4, 0.6}, broken=0.6, seed=13})

-- sparse grass tufts and a few stones
local gt = brush{kind="rigger", width=1.2, point=1, stiffness=0.5}
gt:load(treeDark, 0.8)
local tufts = {{120, 690}, {180, 672}, {240, 700}, {310, 680}, {370, 668}, {430, 695},
  {560, 685}, {620, 670}, {680, 700}, {740, 678}, {800, 692}, {860, 672}, {930, 688}, {970, 676}}
for i, t in ipairs(tufts) do
  local x, y = t[1], t[2]
  local n = 3
  for j = 1, n do
    local a = -1.75 + (j - 1) * 0.18 + rand(-0.08, 0.08)
    local L = rand(8, 16)
    gt:gesture({{x, y, 0.5}, {x + math.cos(a) * L, y + math.sin(a) * L, 0.05}}, {wobble=0.5})
  end
end
-- ochre tips on a few tufts
gt:reload(shoreLit, 0.5)
for i, t in ipairs({tufts[2], tufts[5], tufts[9], tufts[13]}) do
  local x, y = t[1], t[2]
  gt:gesture({{x, y - 6, 0.4}, {x + rand(-2, 2), y - 14, 0.05}}, {wobble=0.4})
end
-- stones: mid-grey-umber touches with a light tick
local st = brush{kind="round", width=6}
st:load(treeMid, 0.9)
local stones = {{200, 700}, {350, 690}, {600, 705}, {760, 690}, {905, 704}}
for i, s in ipairs(stones) do
  st:touch(s[1], s[2], {pressure=0.7})
  st:touch(s[1] + rand(-3, 3), s[2] + rand(-2, 2), {pressure=0.5})
end
local lt = brush{kind="rigger", width=1.4, point=0.9}
lt:load(rimLight, 0.4)
for i, s in ipairs(stones) do
  lt:gesture({{s[1] - 4, s[2] - 3, 0.4}, {s[1] - 1, s[2] - 5, 0.1}}, {wobble=0.4})
end
print("campaign 3 (shore) laid")

--@ chunk 10
-- CAMPAIGN 3b: repair the wet edge — knock back the bead row, lay a quiet broken edge
function waterline(x) return 662 + 5*math.sin(x/70 + 1.3) + 3*math.sin(x/23 + 0.5) end

-- knock the bright dashes back into the dark shore
local wetT2 = mask(function(x, y) local wl = waterline(x)
  if y > wl - 2 and y < wl + 9 then return 1 else return 0 end end)
work(wetT2, {hand="body", pile=shoreDark, coverage=0.9, length={30, 60}, angle=0,
  pressure={0.4, 0.6}, seed=25})

-- a quiet, irregular light edge: hand-placed faint dashes along the waterline
local we = brush{kind="rigger", width=2.2, point=0.9}
we:load(rimLight, 0.28)
for i = 1, 22 do
  local x = 18 + i * 45 + rand(-20, 20)
  local y = waterline(x) + rand(-1, 4)
  local L = rand(8, 26)
  local a = rand(-0.14, 0.14)
  we:gesture({{x, y, 0.35}, {x + math.cos(a) * L, y + math.sin(a) * L, 0.08}}, {wobble=0.6})
end
-- a few slightly brighter laps of water
we:reload(rimLight, 0.45)
for i, x in ipairs({250, 520, 790}) do
  local y = waterline(x) + 2
  we:gesture({{x, y, 0.4}, {x + rand(14, 26), y + rand(-1, 2), 0.1}}, {wobble=0.5})
  we:gesture({{x + 6, y + 4, 0.3}, {x + 6 + rand(10, 18), y + 4, 0.08}}, {wobble=0.5})
end
print("campaign 3b (wet edge repair) done")

--@ chunk 11
wait(2 * 24 * 60)
print("shore:", drying(300, 690))
print("shore at root:", drying(880, 700))
print("water at figure:", drying(500, 580))
print("water low:", drying(500, 640))
print("sky:", drying(500, 200))

--@ chunk 12
-- CAMPAIGN 4: the bare tree, right side, leaning toward the light
local tb = brush("filbert", 22)
tb:load(treeDark, 1.0)
tb:gesture({{884, 716, 0.95}, {872, 655, 0.95}, {856, 595, 0.9}, {838, 540, 0.85},
  {818, 495, 0.75}, {800, 455, 0.6}}, {wobble=3})
tb:gesture({{880, 716, 0.9}, {866, 648, 0.9}, {850, 585, 0.85}, {830, 528, 0.75},
  {810, 480, 0.6}, {795, 448, 0.5}}, {wobble=2})
local tbase = brush("filbert", 26)
tbase:load(treeDark, 1.0)
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
-- main limbs
limb({{798, 448}, {762, 392}, {724, 348}, {694, 312}, {676, 282}, {668, 258}}, 11, 0.85, treeDark, 2.5)
limb({{810, 438}, {848, 392}, {882, 358}, {908, 330}, {922, 308}}, 10, 0.85, treeDark, 2.5)
limb({{836, 486}, {888, 466}, {934, 446}, {970, 428}}, 8, 0.85, treeDark, 2.5)
limb({{812, 466}, {772, 446}, {742, 430}, {722, 416}}, 7, 0.8, treeDark, 2)
limb({{804, 444}, {812, 398}, {822, 362}, {830, 336}}, 7, 0.8, treeDark, 2)
limb({{830, 520}, {866, 500}, {898, 486}}, 6, 0.8, treeDark, 2)
limb({{822, 492}, {790, 472}, {764, 458}}, 5, 0.8, treeDark, 2)
-- second order
limb({{724, 348}, {694, 330}, {668, 318}}, 5, 0.8, treeDark, 1.6)
limb({{700, 322}, {716, 292}, {726, 266}}, 4.5, 0.78, treeDark, 1.6)
limb({{676, 282}, {656, 268}, {642, 258}}, 4, 0.75, treeDark, 1.6)
limb({{748, 372}, {720, 352}, {698, 342}}, 3.5, 0.72, treeDark, 1.6)
limb({{860, 380}, {900, 372}, {938, 368}}, 5, 0.8, treeDark, 1.6)
limb({{890, 352}, {916, 322}, {932, 296}}, 4.5, 0.78, treeDark, 1.6)
limb({{908, 330}, {940, 312}, {962, 296}}, 4, 0.75, treeDark, 1.6)
limb({{848, 392}, {826, 372}, {808, 360}}, 3.5, 0.72, treeDark, 1.6)
limb({{910, 452}, {950, 424}, {976, 398}}, 4.5, 0.78, treeDark, 1.6)
limb({{970, 428}, {992, 412}, {998, 400}}, 3.5, 0.72, treeDark, 1.6)
limb({{888, 466}, {862, 452}, {840, 444}}, 3.5, 0.72, treeDark, 1.6)
limb({{752, 438}, {724, 420}, {700, 410}}, 4, 0.75, treeDark, 1.6)
limb({{818, 380}, {842, 356}, {862, 340}}, 4, 0.75, treeDark, 1.6)
limb({{830, 336}, {852, 316}, {868, 296}}, 3.5, 0.72, treeDark, 1.6)
limb({{816, 388}, {796, 372}, {780, 362}}, 3, 0.7, treeDark, 1.6)
limb({{866, 500}, {898, 486}, {926, 474}}, 4, 0.75, treeDark, 1.6)
-- third order
limb({{694, 330}, {672, 318}, {654, 310}}, 2.6, 0.75, treeMid, 1.3)
limb({{900, 372}, {928, 362}, {952, 356}}, 2.6, 0.75, treeMid, 1.3)
limb({{950, 424}, {972, 404}, {990, 386}}, 2.6, 0.75, treeDark, 1.3)
limb({{842, 356}, {862, 344}, {880, 334}}, 2.6, 0.75, treeMid, 1.3)
limb({{716, 292}, {706, 272}, {700, 254}}, 2.6, 0.75, treeDark, 1.3)
limb({{916, 322}, {930, 300}, {940, 282}}, 2.6, 0.75, treeDark, 1.3)

-- twigs along the outer boughs, drifting clusters at the tips, some forking
local wb = brush{kind="rigger", width=1.4, point=1, stiffness=0.5}
wb:load(treeDark, 0.8)
local function twig_gesture(x0, y0, a, L, p0)
  local x1 = x0 + math.cos(a) * L
  local y1 = y0 + math.sin(a) * L + L * 0.18
  wb:gesture({{x0, y0, p0}, {x1, y1, 0.05}}, {wobble=0.8})
end
local function bough_twigs(pts, side, n, lmin, lmax, pl)
  wb:reload(pl or treeDark, 0.75)
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
  wb:reload(pl or treeDark, 0.8)
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
tip_cluster(726, 266, -1.2, 0.5, 5, 10, 18, treeMid)
bough_twigs({{676, 282}, {656, 268}, {642, 258}}, -1, 2, 8, 13)
tip_cluster(642, 258, -2.5, 0.5, 5, 9, 16)
tip_cluster(698, 342, -2.7, 0.5, 4, 9, 15)
bough_twigs({{860, 380}, {900, 372}, {938, 368}}, 1, 2, 8, 13)
tip_cluster(938, 368, -0.15, 0.5, 5, 10, 17)
bough_twigs({{890, 352}, {916, 322}, {932, 296}}, 1, 2, 8, 13)
tip_cluster(932, 296, -1.0, 0.5, 5, 10, 17)
bough_twigs({{908, 330}, {940, 312}, {962, 296}}, 1, 2, 8, 13)
tip_cluster(962, 296, -0.65, 0.5, 5, 10, 17, treeMid)
tip_cluster(808, 360, -2.5, 0.5, 4, 9, 15)
bough_twigs({{910, 452}, {950, 424}, {976, 398}}, 1, 2, 8, 13)
tip_cluster(976, 398, -0.8, 0.5, 5, 10, 17)
tip_cluster(998, 400, -1.0, 0.5, 4, 9, 15)
tip_cluster(840, 444, -2.7, 0.5, 4, 9, 15)
bough_twigs({{752, 438}, {724, 420}, {700, 410}}, -1, 2, 8, 13)
tip_cluster(700, 410, -2.7, 0.5, 5, 9, 16, treeMid)
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
tip_cluster(880, 334, -0.9, 0.5, 4, 8, 13, treeMid)
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

-- rim light on the edges facing the afterglow
local rim = brush{kind="rigger", width=2, point=0.9}
rim:load(rimLight, 0.45)
rim:gesture({{874, 706, 0.5}, {861, 636, 0.45}, {845, 566, 0.4}, {827, 508, 0.32}}, {wobble=1})
rim:gesture({{823, 500, 0.32}, {806, 462, 0.25}, {794, 442, 0.15}}, {wobble=1})
rim:gesture({{786, 448, 0.4}, {754, 396, 0.35}, {722, 352, 0.3}, {694, 318, 0.22}, {678, 288, 0.12}}, {wobble=1})
rim:gesture({{796, 448, 0.35}, {802, 402, 0.3}, {812, 366, 0.2}}, {wobble=1})
rim:gesture({{806, 474, 0.3}, {768, 454, 0.25}, {738, 438, 0.15}}, {wobble=1})
print("campaign 4 (tree) laid")

--@ chunk 13
-- CAMPAIGN 4b: re-lay the limbs smooth — soft brush, fluid paint, same paths
-- (knifing "tree soft" scrapes the oldest heap, "far shore"; recipe kept in the journal)
treeSoft = pile{{"raw umber", 2}, {"bone black", 1.1}, medium=0.3, name="tree soft"}

local function slim(pts, w, p0, pl, wob)
  local b = brush{kind="round", width=w, point=0.85, stiffness=0.2}
  b:load(pl, 0.9)
  local g = {}
  for i, pt in ipairs(pts) do
    local t = (i - 1) / math.max(1, #pts - 1)
    g[i] = {pt[1], pt[2], p0 * (1 - 0.87 * t)}
  end
  b:gesture(g, {wobble=wob or 2})
end
-- main limbs
slim({{798, 448}, {762, 392}, {724, 348}, {694, 312}, {676, 282}, {668, 258}}, 11, 0.85, treeSoft, 2.5)
slim({{810, 438}, {848, 392}, {882, 358}, {908, 330}, {922, 308}}, 10, 0.85, treeSoft, 2.5)
slim({{836, 486}, {888, 466}, {934, 446}, {970, 428}}, 8, 0.85, treeSoft, 2.5)
slim({{812, 466}, {772, 446}, {742, 430}, {722, 416}}, 7, 0.8, treeSoft, 2)
slim({{804, 444}, {812, 398}, {822, 362}, {830, 336}}, 7, 0.8, treeSoft, 2)
slim({{830, 520}, {866, 500}, {898, 486}}, 6, 0.8, treeSoft, 2)
slim({{822, 492}, {790, 472}, {764, 458}}, 5, 0.8, treeSoft, 2)
-- second order
slim({{724, 348}, {694, 330}, {668, 318}}, 5, 0.8, treeSoft, 1.6)
slim({{700, 322}, {716, 292}, {726, 266}}, 4.5, 0.78, treeSoft, 1.6)
slim({{676, 282}, {656, 268}, {642, 258}}, 4, 0.75, treeSoft, 1.6)
slim({{748, 372}, {720, 352}, {698, 342}}, 3.5, 0.72, treeSoft, 1.6)
slim({{860, 380}, {900, 372}, {938, 368}}, 5, 0.8, treeSoft, 1.6)
slim({{890, 352}, {916, 322}, {932, 296}}, 4.5, 0.78, treeSoft, 1.6)
slim({{908, 330}, {940, 312}, {962, 296}}, 4, 0.75, treeSoft, 1.6)
slim({{848, 392}, {826, 372}, {808, 360}}, 3.5, 0.72, treeSoft, 1.6)
slim({{910, 452}, {950, 424}, {976, 398}}, 4.5, 0.78, treeSoft, 1.6)
slim({{970, 428}, {992, 412}, {998, 400}}, 3.5, 0.72, treeSoft, 1.6)
slim({{888, 466}, {862, 452}, {840, 444}}, 3.5, 0.72, treeSoft, 1.6)
slim({{752, 438}, {724, 420}, {700, 410}}, 4, 0.75, treeSoft, 1.6)
slim({{818, 380}, {842, 356}, {862, 340}}, 4, 0.75, treeSoft, 1.6)
slim({{830, 336}, {852, 316}, {868, 296}}, 3.5, 0.72, treeSoft, 1.6)
slim({{816, 388}, {796, 372}, {780, 362}}, 3, 0.7, treeSoft, 1.6)
slim({{866, 500}, {898, 486}, {926, 474}}, 4, 0.75, treeSoft, 1.6)
-- third order, slightly lighter by load
slim({{694, 330}, {672, 318}, {654, 310}}, 2.6, 0.75, treeSoft, 1.3)
slim({{900, 372}, {928, 362}, {952, 356}}, 2.6, 0.75, treeSoft, 1.3)
slim({{950, 424}, {972, 404}, {990, 386}}, 2.6, 0.75, treeSoft, 1.3)
slim({{842, 356}, {862, 344}, {880, 334}}, 2.6, 0.75, treeSoft, 1.3)
slim({{716, 292}, {706, 272}, {700, 254}}, 2.6, 0.75, treeSoft, 1.3)
slim({{916, 322}, {930, 300}, {940, 282}}, 2.6, 0.75, treeSoft, 1.3)
print("campaign 4b (smooth limbs) done")

--@ chunk 14
-- test: re-lay the leader limb with opaque body paint on a very soft brush
local b = brush{kind="round", width=11, point=0.85, stiffness=0.15}
b:load(treeDark, 1.0)
local g = {}
local pts = {{798, 448}, {762, 392}, {724, 348}, {694, 312}, {676, 282}, {668, 258}}
for i, pt in ipairs(pts) do
  local t = (i - 1) / (#pts - 1)
  g[i] = {pt[1], pt[2], 0.9 * (1 - 0.87 * t)}
end
b:gesture(g, {wobble=2.5})
print("leader re-laid opaque/soft")

--@ chunk 15
-- test 2: fluid paint, thick lay, soft brush — should level smooth and hide old ridges
local b = brush{kind="round", width=11, point=0.85, stiffness=0.15, lay=4}
b:load(treeSoft, 1.0)
local g = {}
local pts = {{798, 448}, {762, 392}, {724, 348}, {694, 312}, {676, 282}, {668, 258}}
for i, pt in ipairs(pts) do
  local t = (i - 1) / (#pts - 1)
  g[i] = {pt[1], pt[2], 0.9 * (1 - 0.85 * t)}
end
b:gesture(g, {wobble=2.5})
print("leader re-laid fluid+thick")

--@ chunk 16
wait(150)
print("leader area drying:", drying(720, 330))

--@ chunk 17
-- CAMPAIGN 5: the figure, standing in the shallows, seen from behind
local fb = brush("filbert", 12)
fb:load(figDark, 0.95)
fb:gesture({{500, 547, 0.9}, {501, 575, 0.92}, {500, 605, 0.92}, {500, 631, 0.88}})
fb:gesture({{489, 551, 0.85}, {500, 545, 0.92}, {511, 551, 0.85}})
fb:gesture({{493, 552, 0.8}, {492, 580, 0.85}, {493, 610, 0.85}, {494, 630, 0.8}})
fb:gesture({{507, 552, 0.8}, {508, 580, 0.85}, {507, 610, 0.85}, {506, 630, 0.8}})
local hb = brush{kind="round", width=12}
hb:load(figDark, 0.95)
hb:gesture({{500, 529, 0.7}, {500, 543, 0.8}})
hb:touch(500, 536, {pressure=0.85})
-- faint rim on the left contour, catching the afterglow
local fr = brush{kind="rigger", width=1.2, point=0.9}
fr:load(rimLight, 0.35)
fr:gesture({{489, 552, 0.5}, {488, 580, 0.45}, {490, 610, 0.35}, {491, 628, 0.12}}, {wobble=0.6})
fr:gesture({{494, 530, 0.4}, {492, 535, 0.2}}, {wobble=0.4})
-- reflection in the still water, broken and compressed
local rb = brush("filbert", 8)
rb:load(figDark, 0.5)
rb:gesture({{500, 634, 0.7}, {499, 646, 0.55}, {500, 658, 0.4}})
rb:gesture({{496, 636, 0.5}, {495, 644, 0.4}, {496, 652, 0.3}})
rb:gesture({{504, 637, 0.45}, {505, 645, 0.35}, {504, 653, 0.25}})
-- ripples where the figure stands
local pb = brush{kind="rigger", width=2}
pb:load(waterTop, 0.5)
pb:gesture({{488, 632, 0.5}, {512, 632, 0.4}})
pb:gesture({{491, 636, 0.4}, {509, 636, 0.3}})
pb:gesture({{486, 646, 0.35}, {514, 646, 0.25}})
print("campaign 5 (figure) laid")

--@ chunk 18
-- CAMPAIGN 6a: repairs — solid leader limb; quiet waterline edge; dark quiet stones
function waterline(x) return 662 + 5*math.sin(x/70 + 1.3) + 3*math.sin(x/23 + 0.5) end

-- 1. the leader limb, solid again (same path, same paint as the original)
local L1 = {{798, 448}, {762, 392}, {724, 348}, {694, 312}, {676, 282}, {668, 258}}
local function solid_limb(pts, w, p0, pl, wob)
  local b = brush{kind="round", width=w, point=0.85, stiffness=0.5}
  b:load(pl, 1.0)
  local g = {}
  for i, pt in ipairs(pts) do
    local t = (i - 1) / math.max(1, #pts - 1)
    g[i] = {pt[1], pt[2], p0 * (1 - 0.87 * t)}
  end
  b:gesture(g, {wobble=wob or 2})
end
solid_limb(L1, 11, 0.9, treeDark, 2.5)
-- the fork area, where the leader meets the trunk: re-lay the trunk top and L5 root
solid_limb({{804, 444}, {812, 398}, {822, 362}, {830, 336}}, 7, 0.85, treeDark, 2)

-- 2. bury the beady waterline row and the pale stones with solid dark
local band = mask(function(x, y) local wl = waterline(x)
  if y > wl - 3 and y < wl + 11 then return 1 else return 0 end end)
work(band, {hand="body", pile=shoreDark, coverage=2.2, fill=true, angle=0,
  length={40, 80}, pressure={0.5, 0.7}, seed=31})
-- stones: bury, then a few small dark ones with a faint sheen
local st = brush{kind="round", width=8}
st:load(shoreDark, 1.0)
local stonePos = {{200, 700}, {350, 690}, {600, 705}, {760, 690}, {905, 704}}
for i, s in ipairs(stonePos) do
  st:touch(s[1], s[2], {pressure=0.75})
  st:touch(s[1] + rand(-4, 4), s[2] + rand(-3, 3), {pressure=0.6})
end
local st2 = brush{kind="round", width=5}
st2:load(treeDark, 0.95)
local stonePos2 = {{255, 696}, {540, 700}, {700, 694}, {850, 700}, {960, 692}}
for i, s in ipairs(stonePos2) do
  st2:touch(s[1], s[2], {pressure=0.7})
end
local lt = brush{kind="rigger", width=1.2, point=0.9}
lt:load(rimLight, 0.22)
for i, s in ipairs(stonePos2) do
  lt:gesture({{s[1] - 3, s[2] - 2, 0.35}, {s[1] - 1, s[2] - 4, 0.08}}, {wobble=0.4})
end

-- 3. the quiet light edge: thin faint dashes, irregular, hand-placed
local we = brush{kind="rigger", width=1.6, point=0.9}
we:load(rimLight, 0.22)
for i = 1, 20 do
  local x = 15 + i * 49 + rand(-22, 22)
  local y = waterline(x) + rand(-1, 3)
  local L = rand(6, 18)
  local a = rand(-0.12, 0.12)
  we:gesture({{x, y, 0.32}, {x + math.cos(a) * L, y + math.sin(a) * L, 0.06}}, {wobble=0.6})
end
we:reload(rimLight, 0.4)
for i, x in ipairs({180, 470, 720, 900}) do
  local y = waterline(x) + 2
  we:gesture({{x, y, 0.38}, {x + rand(10, 18), y + rand(-1, 2), 0.08}}, {wobble=0.5})
end
print("campaign 6a (repairs) done")

--@ chunk 19
-- CAMPAIGN 6b: bury the misplaced rims — solid opaque re-lay of trunk and main limbs
local function chunk_limb(pts, w, p0, pl, wob)
  local n = #pts
  local i = 1
  while i < n do
    local j = math.min(n, i + 2)
    local seg = {}
    for k = i, j do
      local t = (k - 1) / math.max(1, n - 1)
      seg[#seg + 1] = {pts[k][1], pts[k][2], p0 * (1 - 0.87 * t)}
    end
    local b = brush{kind="round", width=w, point=0.85, stiffness=0.5, lay=3}
    b:load(pl, 1.0)
    b:gesture(seg, {wobble=wob or 2})
    i = i + 2
  end
end
local function chunk_trunk(pts, w, p0, p1, pl)
  local n = #pts
  local i = 1
  while i < n do
    local j = math.min(n, i + 2)
    local seg = {}
    for k = i, j do
      local t = (k - 1) / math.max(1, n - 1)
      seg[#seg + 1] = {pts[k][1], pts[k][2], p0 + (p1 - p0) * t}
    end
    local b = brush{kind="filbert", width=w, lay=3}
    b:load(pl, 1.0)
    b:gesture(seg, {wobble=2.5})
    i = i + 2
  end
end
-- trunk
chunk_trunk({{884, 716}, {872, 655}, {856, 595}, {838, 540}, {818, 495}, {800, 455}}, 22, 0.95, 0.6, treeDark)
chunk_trunk({{880, 716}, {866, 648}, {850, 585}, {830, 528}, {810, 480}, {795, 448}}, 20, 0.9, 0.55, treeDark)
chunk_trunk({{892, 716}, {878, 700}, {868, 686}}, 26, 0.9, 0.7, treeDark)
-- main limbs
chunk_limb({{798, 448}, {762, 392}, {724, 348}, {694, 312}, {676, 282}, {668, 258}}, 11, 0.9, treeDark, 2.5)
chunk_limb({{810, 438}, {848, 392}, {882, 358}, {908, 330}, {922, 308}}, 10, 0.9, treeDark, 2.5)
chunk_limb({{836, 486}, {888, 466}, {934, 446}, {970, 428}}, 8, 0.9, treeDark, 2.5)
chunk_limb({{812, 466}, {772, 446}, {742, 430}, {722, 416}}, 7, 0.88, treeDark, 2)
chunk_limb({{804, 444}, {812, 398}, {822, 362}, {830, 336}}, 7, 0.88, treeDark, 2)
chunk_limb({{830, 520}, {866, 500}, {898, 486}}, 6, 0.88, treeDark, 2)
chunk_limb({{822, 492}, {790, 472}, {764, 458}}, 5, 0.88, treeDark, 2)
print("campaign 6b (solid re-lay) done")

--@ chunk 20
wait(3 * 24 * 60)
print("leader lower:", drying(770, 410))
print("leader mid:", drying(720, 340))
print("trunk:", drying(850, 620))
print("L5:", drying(815, 380))
print("6b film (trunk top):", drying(810, 470))

--@ chunk 21
wait(4 * 24 * 60)
print("leader lower:", drying(770, 410))
print("leader mid:", drying(720, 340))
print("trunk:", drying(850, 620))
print("L5:", drying(815, 380))
print("trunk top:", drying(810, 470))

--@ chunk 22
wait(7 * 24 * 60)
for i, p in ipairs({{780, 425}, {765, 405}, {745, 385}, {725, 365}, {705, 345}, {685, 325}, {670, 300},
  {850, 620}, {865, 540}, {880, 470}, {815, 380}, {820, 350}, {760, 440}, {830, 490}, {880, 660}}) do
  print(p[1], p[2], drying(p[1], p[2]))
end

--@ chunk 23
wait(7 * 24 * 60)
for i, p in ipairs({{780, 425}, {765, 405}, {880, 470}, {798, 448}, {740, 390}}) do
  print(p[1], p[2], drying(p[1], p[2]))
end

--@ chunk 24
wait(14 * 24 * 60)
for i, p in ipairs({{780, 425}, {765, 405}, {798, 448}, {740, 390}, {720, 340}}) do
  print(p[1], p[2], drying(p[1], p[2]))
end

--@ chunk 25
-- CAMPAIGN 6c: tree repairs — veil the stray rim lines, re-lay the leader, proper edge rims
local function sw(a, b, x) return smoothstep(a, b, x) end
local function glowX(x) return 0.5 + 0.5 * math.exp(-((x - 500) / 260) ^ 2) end

-- 1. veil the stray pale lines with sky-matched graded color
local wP  = function(x, y) return sw(300, 380, y) * (1 - sw(400, 432, y)) end
local wG  = function(x, y) return sw(375, 442, y) * glowX(x) end
local wM2 = function(x, y) return sw(50, 170, y) * (1 - sw(300, 400, y)) end
local veilTool = brush{kind="filbert", width=5, stiffness=0.4, lay=2}
local function veil(pts, w, extra)
  local piles = {{skyPale, wP}, {glow, wG}, {skyMid, wM2}}
  if extra then piles[#piles + 1] = extra end
  local dx = pts[#pts][1] - pts[1][1]
  local dy = pts[#pts][2] - pts[1][2]
  work(ribbon(pts, w), {hand="body", tool=veilTool, piles=piles,
    angle=math.atan(dy, dx), length={30, 60}, coverage=1.2, clip=true,
    pressure={0.3, 0.5}, seed=41})
end
veil({{786, 448}, {754, 396}, {722, 352}, {678, 288}}, 5)
veil({{796, 448}, {802, 402}, {812, 366}}, 5)
veil({{806, 474}, {768, 454}, {738, 438}}, 5, {shoreDark, function(x, y) return sw(456, 464, y) * 2.5 end})
veil({{816, 444}, {854, 398}, {888, 364}, {914, 336}}, 6)

-- 2. re-lay the leader solid over the dry paint
local function chunk_limb(pts, w, p0, pl, wob)
  local n = #pts
  local i = 1
  while i < n do
    local j = math.min(n, i + 2)
    local seg = {}
    for k = i, j do
      local t = (k - 1) / math.max(1, n - 1)
      seg[#seg + 1] = {pts[k][1], pts[k][2], p0 * (1 - 0.87 * t)}
    end
    local b = brush{kind="round", width=w, point=0.85, stiffness=0.5, lay=2}
    b:load(pl, 1.0)
    b:gesture(seg, {wobble=wob or 2})
    i = i + 2
  end
end
chunk_limb({{798, 448}, {762, 392}, {724, 348}, {694, 312}, {676, 282}, {668, 258}}, 11, 0.9, treeDark, 2.5)

-- 3. proper rims on the light-facing edges
local rim = brush{kind="rigger", width=1.6, point=0.9}
rim:load(rimLight, 0.35)
rim:gesture({{873, 716, 0.45}, {862, 655, 0.4}, {847, 595, 0.32}}, {wobble=1})
rim:gesture({{830, 540, 0.3}, {811, 495, 0.22}, {794, 455, 0.12}}, {wobble=1})
rim:gesture({{795, 450, 0.4}, {759, 394, 0.32}, {721, 350, 0.22}}, {wobble=1})
rim:gesture({{691, 314, 0.2}, {673, 284, 0.14}, {665, 260, 0.08}}, {wobble=1})
rim:gesture({{807, 436, 0.35}, {845, 390, 0.28}, {879, 356, 0.18}}, {wobble=1})
rim:gesture({{905, 328, 0.16}, {919, 306, 0.1}}, {wobble=1})
print("campaign 6c (tree repairs) done")
