-- easel session "scratch": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box friedrich
--@ engine 5

--@ chunk 1
canvas{aspect=1.3333333333333333, ground={{apply="knife", pile={{"red earth", 1}, {"yellow ochre", 2}}, texture=0.6, um=25}, {apply="brush", pile={{"lead white", 5}, {"yellow ochre", 0.35}, {"raw umber", 0.2}}, um=55}}, linen={16, 14}, seed=11, size=900}

--@ chunk 2
-- scratch trial: the full lay-in, to judge before it touches the painting
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
pRipD  = pile{{"cobalt blue", 1.5}, {"bone black", 0.6}, {"raw umber", 0.3}, {"lead white", 0.3}, turps=0.5, name="ripple dark"}
pRipL  = pile{{"lead white", 1.5}, {"yellow ochre", 0.25}, {"pale smalt", 0.6}, turps=0.5, name="ripple light"}

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
  length={30, 70}, angle=0.0, coverage=3, clip=true, pressure={0.5, 0.8}, seed=4})

-- the bright band where the dark land zone will meet the light sky
glowM = rect(0, 364, 1000, 68):soften(16) * mask(function(x, y)
  local g = 0.3 + 0.7 * math.exp(-((x - 560) ^ 2) / (2 * 190 ^ 2))
  local v = clamp((y - 364) / 68, 0, 1)
  return g * (0.4 + 0.6 * v)
end)
work(glowM, {tool="filbert 14", pile=pGlow, length={40, 90}, angle=0, coverage=1.4, clip=true, pressure={0.5, 0.75}, seed=9})

-- WATER: one graded pass, pale echo of the glow at the horizon, darkening down
waterM = rect(0, 418, 1000, 240)
work(waterM, {tool="filbert 12", piles={
    {pWPale, function(x, y) local a = waterw(y); return a end},
    {pWMid,  function(x, y) local _, b = waterw(y); return b end},
    {pWDark, function(x, y) local _, _, c = waterw(y); return c end}},
  length={30, 70}, angle=0.0, coverage=3, clip=true, pressure={0.5, 0.8}, seed=8})

-- the moon's reflection column, widening toward the viewer
colM = poly({{545,428},{575,428},{588,480},{608,540},{622,600},{632,652},{488,652},{498,600},{512,540},{532,480}}, true):soften(10)
work(colM, {tool="filbert 8", piles={
    {pCol, function(x, y) return clamp(1.4 - (y - 428) / 120, 0, 1) end},
    {pWPale, function(x, y) return 1 - clamp(1.4 - (y - 428) / 120, 0, 1) end}},
  length={10, 34}, angle=0, coverage=1.6, clip=true, pressure={0.45, 0.75}, seed=10})

-- first ripples: broken horizontal strokes, smaller toward the horizon
work(waterM, {tool="filbert 5", pile=pRipD, length={6, 22}, angle=0, coverage=1.1, clip=true,
  scale_at=function(x, y) local t = clamp((y - 418) / 240, 0, 1); return 0.3 + 0.7 * t end,
  pressure={0.4, 0.7}, seed=7})
work(colM:grow(26) + rect(0, 418, 1000, 84), {tool="filbert 4", pile=pRipL, length={5, 18}, angle=0, coverage=0.9, clip=true,
  scale_at=function(x, y) local t = clamp((y - 418) / 240, 0, 1); return 0.3 + 0.7 * t end,
  pressure={0.35, 0.6}, seed=12})

-- BANK: the dark foreground strip
bankTopPts = {{0,664},{140,656},{300,662},{470,652},{560,646},{640,652},{800,660},{1000,668}}
bankM = poly({{0,664},{140,656},{300,662},{470,652},{560,646},{640,652},{800,660},{1000,668},{1000,750},{0,750}}, true):soften(4)
work(bankM, {tool="filbert 16", pile=pBank, length={50, 120}, angle=-0.04, coverage=2.2, clip=true, pressure={0.6, 0.9}, seed=3})

-- faint pale waterline just below the bank edge
local wl = {}
for i, p in ipairs(bankTopPts) do wl[#wl+1] = {p[1], p[2] + 5} end
for i = #bankTopPts, 1, -1 do local p = bankTopPts[i] wl[#wl+1] = {p[1], p[2] + 11} end
waterlineM = poly(wl, true):soften(2)
work(waterlineM, {tool="filbert 4", pile=pEdge, length={8, 26}, angle=0.02, coverage=1.1, edge="lost", pressure={0.5, 0.8}, seed=13})

-- MOON: small disc, veiled by a thin cloud
work(ellipse(560, 362, 42, 34):soften(12), {pile=pGlow, tool="filbert 18", length={30, 60}, coverage=0.5, clip=true, angle=0, pressure={0.3, 0.5}, seed=5})
local bm = brush("round", 16)
bm:load(pMoon, 0.95)
bm:touch(560, 362, {pressure=0.6})
bm:touch(560, 362, {pressure=0.35})
work(rect(494, 350, 132, 30):soften(8), {pile=pVeil, tool="filbert 9", length={20, 60}, angle=0.01, coverage=1.2, edge="lost", pressure={0.25, 0.5}, seed=6})
print("scratch lay-in done")
