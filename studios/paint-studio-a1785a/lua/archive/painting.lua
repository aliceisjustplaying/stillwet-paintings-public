-- easel session "painting": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box friedrich
--@ engine 5

--@ chunk 1
canvas{size=900, aspect=4/3, linen={16, 14}, seed=11,
  ground={
    {pile={{"red earth", 1}, {"yellow ochre", 2}}, um=25, apply="knife", texture=0.6},
    {pile={{"lead white", 5}, {"yellow ochre", 0.35}, {"raw umber", 0.2}}, um=55, apply="brush"}
  }}
print("canvas:", W, "x", H)
print(table.concat(tubes(), ", "))

--@ chunk 2
palette{dirty=0.15}
pDeep  = pile{{"cobalt blue", 3}, {"bone black", 1}, {"lead white", 1}, turps=0.55, name="sky deep"}
pMid   = pile{{"pale smalt", 3}, {"lead white", 2}, {"yellow ochre", 0.2}, turps=0.55, name="sky mid"}
pLight = pile{{"pale smalt", 2}, {"lead white", 3}, {"yellow ochre", 0.35}, {"red earth", 0.06}, turps=0.55, name="sky light"}
pGlow  = pile{{"lead white", 4}, {"yellow ochre", 0.6}, {"red earth", 0.15}, turps=0.55, name="horizon glow"}
pMoon  = pile{{"lead white", 3}, {"yellow ochre", 0.1}, name="moon"}
pVeil  = pile{{"pale smalt", 1}, {"lead white", 2}, {"yellow ochre", 0.15}, thinner=0.45, name="veil"}
pWPale = pile{{"lead white", 2.5}, {"yellow ochre", 0.4}, {"pale smalt", 1.2}, turps=0.55, name="water pale"}
pWMid  = pile{{"pale smalt", 2.5}, {"cobalt blue", 1}, {"lead white", 1.2}, {"bone black", 0.25}, turps=0.55, name="water mid"}
pWDark = pile{{"cobalt blue", 2.5}, {"bone black", 1}, {"raw umber", 0.5}, {"lead white", 0.35}, turps=0.55, name="water dark"}
pCol   = pile{{"lead white", 3}, {"yellow ochre", 0.5}, {"red earth", 0.1}, turps=0.5, name="moon column"}
pBank  = pile{{"raw umber", 2}, {"bone black", 1.2}, {"green earth", 0.7}, {"yellow ochre", 0.25}, turps=0.5, name="bank"}
pEdge  = pile{{"yellow ochre", 1.2}, {"lead white", 0.7}, {"raw umber", 0.4}, turps=0.5, name="bank edge light"}
print(palette())

--@ chunk 3
h = pencil("2H")
-- horizon, ruled, level
h:rule({0, 425}, {1000, 425}, {pressure=0.16})
-- the axis
h:rule({560, 330}, {560, 662}, {pressure=0.11})
-- moon, small circle on the axis
h:sketch({{560,350},{571,362},{560,374},{549,362},{560,350}}, {pressure=0.14, passes=2, wander=0.6})
-- figure: cloak and head, seen from behind, feet at the water's edge
figPts = {{546,586},{547,584},{553,580},{560,578.5},{567,580},{573,584},{574,586},{572,610},{570,632},{569,650},{551,650},{550,632},{548,610},{546,586}}
h:line({{560,562},{560,650}}, {pressure=0.17})
h:sketch({{553,570},{560,563},{567,570},{560,577},{553,570}}, {pressure=0.14, passes=2, wander=0.4})
h:line({{547,584},{574,584}}, {pressure=0.14})
h:line({{550,650},{570,650}}, {pressure=0.14})
-- bare tree on the left: trunk and main limbs
treeLines = {
  {{150,658},{154,600},{150,545},{158,495},{152,450},{160,415}},
  {{160,415},{175,370},{168,330},{185,295},{178,262}},
  {{158,430},{130,400},{105,385},{85,372}},
  {{162,420},{200,405},{245,398},{285,405},{315,420}},
  {{118,398},{108,372},{102,348},{100,328}},
  {{236,402},{252,378},{262,352},{268,334}},
}
for i, ln in ipairs(treeLines) do h:line(ln, {pressure=0.13}) end
-- bank edge
bankTopPts = {{0,664},{140,656},{300,662},{470,652},{560,646},{640,652},{800,660},{1000,668}}
h:line(bankTopPts, {pressure=0.15})
-- moon's reflection column, faint
h:line({{545,428},{532,480},{512,540},{498,600},{488,652}}, {pressure=0.09})
h:line({{575,428},{588,480},{608,540},{622,600},{632,652}}, {pressure=0.09})
print("underdrawing laid")

--@ chunk 4
-- LAY-IN (lean, turps-thinned): sky, glow band, moon, water, column, first ripples, bank
pDeep  = pile{{"cobalt blue", 3}, {"bone black", 1.2}, {"lead white", 0.8}, turps=0.55, name="sky deep"}
pMid   = pile{{"pale smalt", 3}, {"lead white", 1.6}, {"cobalt blue", 0.3}, {"yellow ochre", 0.15}, turps=0.55, name="sky mid"}
pLight = pile{{"pale smalt", 1.5}, {"lead white", 3}, {"yellow ochre", 0.3}, {"red earth", 0.05}, turps=0.55, name="sky light"}
pGlow  = pile{{"lead white", 4}, {"yellow ochre", 0.6}, {"red earth", 0.15}, turps=0.55, name="horizon glow"}
pMoon  = pile{{"lead white", 1}, {"yellow ochre", 0.05}, name="moon"}
pVeil  = pile{{"pale smalt", 1}, {"lead white", 2}, {"yellow ochre", 0.15}, thinner=0.45, name="veil"}
pWPale = pile{{"lead white", 2.5}, {"yellow ochre", 0.4}, {"pale smalt", 1.2}, turps=0.55, name="water pale"}
pWMid  = pile{{"pale smalt", 2.5}, {"cobalt blue", 1}, {"lead white", 1.2}, {"bone black", 0.25}, turps=0.55, name="water mid"}
pWDark = pile{{"cobalt blue", 2.5}, {"bone black", 1}, {"raw umber", 0.5}, {"lead white", 0.35}, turps=0.55, name="water dark"}
pCol   = pile{{"lead white", 3}, {"yellow ochre", 0.5}, {"red earth", 0.1}, turps=0.5, name="moon column"}
pBank  = pile{{"raw umber", 2}, {"bone black", 1.2}, {"green earth", 0.7}, {"yellow ochre", 0.25}, turps=0.5, name="bank"}
pRipD  = pile{{"cobalt blue", 1.5}, {"bone black", 0.6}, {"raw umber", 0.3}, {"lead white", 0.3}, turps=0.5, name="ripple dark"}

local function skyw(y)
  local t = clamp(y / 430, 0, 1)
  local d = clamp(1.15 - t * 2.6, 0, 1)
  local m = clamp(math.min(t * 3.2, (1 - t) * 2.2), 0, 1)
  local g = clamp((t - 0.72) / 0.28, 0, 1)
  local l = clamp(1 - d - m - g, 0, 1)
  local s = d + m + l + g
  if s <= 0 then return 0, 0, 0, 1 end
  return d / s, m / s, l / s, g / s
end
local function waterw(y)
  local t = clamp((y - 418) / 240, 0, 1)
  local p = clamp(1 - t * 1.6, 0, 1)
  local m = clamp(math.min(t * 2.6, (1 - t) * 1.8), 0, 1)
  local d = clamp((t - 0.55) / 0.45, 0, 1)
  local s = p + m + d
  if s <= 0 then return 0, 0, 1 end
  return p / s, m / s, d / s
end

-- SKY: one graded pass, deep at the zenith to warm glow at the horizon
skyM = rect(0, 0, 1000, 432)
work(skyM, {tool="filbert 12", piles={
    {pDeep,  function(x, y) local a = skyw(y); return a end},
    {pMid,   function(x, y) local _, b = skyw(y); return b end},
    {pLight, function(x, y) local _, _, c = skyw(y); return c end},
    {pGlow,  function(x, y) local _, _, _, d = skyw(y); return d end}},
  length={30, 70}, angle=0.0, coverage=3.2, clip=true, fill=true, pressure={0.5, 0.8}, seed=4})

-- the bright band where the dark land zone meets the light sky
glowM = rect(0, 364, 1000, 68):soften(16) * mask(function(x, y)
  local g = 0.3 + 0.7 * math.exp(-((x - 560) ^ 2) / (2 * 190 ^ 2))
  local v = clamp((y - 364) / 68, 0, 1)
  return g * (0.4 + 0.6 * v)
end)
work(glowM, {tool="filbert 14", pile=pGlow, length={40, 90}, angle=0, coverage=1.4, clip=true, fill=true, pressure={0.5, 0.75}, seed=9})

-- MOON: cool the sky around it, then a bright small disc, veiled below
work(ellipse(560, 362, 55, 44):soften(18), {pile=pMid, tool="filbert 18", length={40, 80}, coverage=0.3, clip=true, angle=0, pressure={0.3, 0.5}, seed=5})
local bm = brush("round", 20)
bm:load(pMoon, 0.95)
bm:touch(560, 362, {pressure=0.65})
bm:touch(560, 362, {pressure=0.35})
work(rect(500, 366, 120, 16):soften(6), {pile=pVeil, tool="filbert 7", length={16, 44}, angle=0.01, coverage=1.0, edge="lost", pressure={0.25, 0.45}, seed=6})

-- WATER: one graded pass, pale echo of the glow at the horizon, darkening down
waterM = rect(0, 418, 1000, 240)
work(waterM, {tool="filbert 12", piles={
    {pWPale, function(x, y) local a = waterw(y); return a end},
    {pWMid,  function(x, y) local _, b = waterw(y); return b end},
    {pWDark, function(x, y) local _, _, c = waterw(y); return c end}},
  length={30, 70}, angle=0.0, coverage=3.2, clip=true, fill=true, pressure={0.5, 0.8}, seed=8})

-- the moon's reflection column, widening toward the viewer
colM = poly({{545,428},{575,428},{588,480},{608,540},{622,600},{632,652},{488,652},{498,600},{512,540},{532,480}}, true):soften(10)
work(colM, {tool="filbert 8", piles={
    {pCol, function(x, y) return clamp(1.4 - (y - 428) / 120, 0, 1) end},
    {pWPale, function(x, y) return 1 - clamp(1.4 - (y - 428) / 120, 0, 1) end}},
  length={10, 34}, angle=0, coverage=1.6, clip=true, fill=true, pressure={0.45, 0.75}, seed=10})

-- first ripples: sparse dark horizontals, none in the calmest water at the horizon
work(rect(0, 450, 1000, 208), {tool="filbert 5", pile=pRipD, length={8, 26}, angle=0, coverage=0.6, clip=true,
  scale_at=function(x, y) local t = clamp((y - 450) / 208, 0, 1); return 0.35 + 0.65 * t end,
  pressure={0.35, 0.6}, seed=7})

-- BANK: the dark foreground strip
bankM = poly({{0,664},{140,656},{300,662},{470,652},{560,646},{640,652},{800,660},{1000,668},{1000,750},{0,750}}, true):soften(4)
work(bankM, {tool="filbert 16", pile=pBank, length={50, 120}, angle=-0.04, coverage=2.4, clip=true, fill=true, pressure={0.6, 0.9}, seed=3})
print("lay-in done")

--@ chunk 5
wait(3 * 24 * 60)
print("sky (200,100):", drying(200, 100))
print("sky glow (300,400):", drying(300, 400))
print("moon (560,362):", drying(560, 362))
print("water far (300,450):", drying(300, 450))
print("water mid (700,520):", drying(700, 520))
print("water near (300,620):", drying(300, 620))
print("column (560,500):", drying(560, 500))
print("bank (200,700):", drying(200, 700))
print("bank edge (560,648):", drying(560, 648))

--@ chunk 6
wait(2 * 24 * 60)
print("sky (200,100):", drying(200, 100))
print("sky glow (300,400):", drying(300, 400))
print("water far (300,450):", drying(300, 450))
print("water mid (700,520):", drying(700, 520))
print("water near (300,620):", drying(300, 620))
print("column (560,500):", drying(560, 500))
print("bank edge (560,648):", drying(560, 648))
print("bank (800,700):", drying(800, 700))

--@ chunk 7
-- SESSION 2 / SKY: clouds, wedge, moon, mist, far shore (body color over the dry lean lay-in)
pCloudL = pile{{"pale smalt", 1.5}, {"lead white", 3}, {"yellow ochre", 0.3}, {"red earth", 0.05}, medium=0.25, name="cloud light"}
pCloudM = pile{{"pale smalt", 2.5}, {"lead white", 1.6}, {"cobalt blue", 0.3}, {"yellow ochre", 0.15}, medium=0.25, name="cloud mid"}
pCloudD = pile{{"pale smalt", 1}, {"cobalt blue", 1}, {"bone black", 0.4}, {"lead white", 0.8}, medium=0.25, name="cloud dark"}
pDeepB  = pile{{"cobalt blue", 3}, {"bone black", 1.2}, {"lead white", 0.8}, medium=0.2, name="sky deep body"}
pMoon2  = pile{{"lead white", 1}, {"yellow ochre", 0.04}, name="moon bright"}
pVeil2  = pile{{"pale smalt", 1}, {"lead white", 2}, {"yellow ochre", 0.15}, thinner=0.5, name="veil thin"}
pMist   = pile{{"lead white", 3}, {"yellow ochre", 0.5}, {"red earth", 0.1}, medium=0.3, name="mist"}
pShore  = pile{{"pale smalt", 1.5}, {"lead white", 2}, {"yellow ochre", 0.25}, medium=0.3, name="far shore"}

-- deepen the zenith
work(rect(0, 0, 1000, 110):soften(24), {tool="filbert 18", pile=pDeepB, length={90, 200}, angle=0.01, coverage=1.0, clip=true, pressure={0.4, 0.7}, seed=21})

-- cloud strata: long soft horizontal strokes, broken past the band
work(rect(0, 20, 1000, 30):soften(10), {tool="filbert 12", pile=pCloudD, length={80, 200}, angle=0, coverage=0.6, edge="lost", pressure={0.3, 0.5}, seed=20})
work(rect(0, 55, 1000, 40):soften(10), {tool="filbert 14", pile=pCloudD, length={100, 260}, angle=0, coverage=0.9, edge="lost", pressure={0.3, 0.55}, seed=22})
work(rect(0, 130, 1000, 45):soften(12), {tool="filbert 16", pile=pCloudL, length={110, 280}, angle=0, coverage=0.9, edge="lost", pressure={0.3, 0.5}, seed=23})
work(rect(0, 168, 1000, 22):soften(8), {tool="filbert 10", pile=pCloudM, length={90, 220}, angle=0, coverage=0.8, edge="lost", pressure={0.35, 0.6}, seed=24})
work(rect(0, 215, 1000, 40):soften(12), {tool="filbert 14", pile=pCloudM, length={100, 260}, angle=0, coverage=0.9, edge="lost", pressure={0.3, 0.55}, seed=25})
work(rect(0, 248, 1000, 20):soften(8), {tool="filbert 9", pile=pCloudD, length={80, 200}, angle=0, coverage=0.7, edge="lost", pressure={0.3, 0.5}, seed=26})
work(rect(0, 285, 1000, 38):soften(12), {tool="filbert 14", pile=pCloudL, length={100, 260}, angle=0.01, coverage=0.8, edge="lost", pressure={0.3, 0.5}, seed=27})

-- one wedge of lighter cloud, descending from the upper left toward the moon
local bw = brush("filbert", 16)
bw:load(pCloudL, 0.8)
bw:gesture({{95,195,0.4},{240,235,0.35},{400,290,0.3},{530,340,0.22}}, {orient="along", wobble=6})
bw:gesture({{120,215,0.3},{280,255,0.28},{430,305,0.2},{545,350,0.14}}, {orient="along", wobble=8})
bw:gesture({{70,175,0.28},{230,215,0.25},{390,272,0.18},{520,330,0.12}}, {orient="along", wobble=5})

-- the moon: cool the sky around it, lay a bright small disc, veil its lower third
work(ellipse(560, 362, 44, 36):soften(16), {tool="filbert 16", pile=pCloudM, length={40, 90}, coverage=0.5, clip=true, angle=0, pressure={0.35, 0.55}, seed=28})
local mb = brush("round", 20)
mb:load(pMoon2, 1.0)
mb:touch(560, 362, {pressure=0.7})
mb:touch(560, 362, {pressure=0.4})
local vb = brush("filbert", 10)
vb:load(pVeil2, 0.7)
vb:gesture({{508,371,0.35},{560,368,0.3},{616,372,0.18}}, {orient="along"})
vb:gesture({{524,378,0.26},{566,376,0.2},{606,379,0.1}}, {orient="along"})

-- a faint far shore dissolving in haze, right of the moon
work(rect(715, 409, 285, 17):soften(7), {tool="filbert 12", pile=pShore, length={60, 160}, angle=0, coverage=0.7, clip=true, pressure={0.3, 0.5}, seed=29})
work(rect(715, 422, 285, 9):soften(4), {tool="filbert 8", pile=pCloudM, length={40, 120}, angle=0, coverage=0.5, clip=true, pressure={0.3, 0.5}, seed=30})

-- mist lying on the horizon at both ends (the centre stays ruled)
work(rect(0, 396, 180, 42):soften(12), {tool="filbert 18", pile=pMist, length={60, 160}, angle=0, coverage=0.8, clip=true, pressure={0.3, 0.5}, seed=31})
work(rect(830, 396, 170, 42):soften(12), {tool="filbert 18", pile=pMist, length={60, 160}, angle=0, coverage=0.7, clip=true, pressure={0.3, 0.5}, seed=32})
print("sky campaign done")
