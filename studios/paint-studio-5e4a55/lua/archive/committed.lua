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
waterdark = pile{{"raw umber",0.56},{"Prussian blue",0.14},{"red earth",0.19},{"green earth",0.11}, name="waterdark"}
haze = pile{{"lead white",0.68},{"yellow ochre",0.17},{"red earth",0.05},{"smalt",0.10}, name="haze"}
amber = pile{{"yellow ochre",0.6},{"red earth",0.2},{"lead white",0.2}, name="amber"}
deeprust = pile{{"red earth",0.5},{"raw umber",0.33},{"yellow ochre",0.17}, name="deeprust"}
glowrefl = pile{{"lead white",3},{"yellow ochre",1.4},{"chrome yellow",0.4},{"red earth",0.25},{"raw umber",0.15}, name="glowrefl"}
-- field: dark water top (y 100..400) grading to rust lower (400..700)
local field = rect(0, 100, 1000, 600)
work(field, {hand="body", tool={kind="flat", width=10}, angle=math.pi/2, coverage=3, fill=true, clip=true, length={40, 120},
  piles={{waterdark, function(x, y) return lerp(0.8, 0.35, clamp((y - 250) / 350, 0, 1)) end},
         {haze, 0.12},
         {deeprust, function(x, y) return lerp(0.02, 0.35, clamp((y - 250) / 350, 0, 1)) end},
         {amber, function(x, y) return lerp(0.06, 0.2, clamp((y - 250) / 350, 0, 1)) end}}})
-- light streaks at x 200, 500, 800
for i, cx in ipairs({200, 500, 800}) do
  local m = ribbon({{cx, 110}, {cx + 2, 400}, {cx - 2, 690}}, {40, 46, 44}):roughen(3, 40, i):soften(6)
  work(m, {hand="body", tool="flat 6", angle=math.pi/2, coverage=2, length={40, 100}, clip=true,
    piles={{haze, 0.7}, {glowrefl, 0.2}, {waterdark, 0.2}}, load_at=function(x, y) return 0.5 end})
end
blend(field:shrink(4), {angle=math.pi/2})
print(wait(60 * 24 * 60))

--@ chunk 3
local function col(cx, yTop, yBot, seed)
  local nS = noise{seed=seed, period=50, octaves=2}
  local nB = noise{seed=seed + 1, period=22, octaves=2}
  return mask(function(x, y)
    if y < yTop or y > yBot + 14 or x < cx - 34 or x > cx + 34 then return 0 end
    local l = cx - 27 + 3 * nS(y, 0)
    local r = cx + 27 + 3 * nS(y, 40)
    local b = yBot + 10 * nB(x, 0)
    if x >= l and x <= r and y <= b then return 1 end
    return 0
  end)
end
local darkP = {{waterdark, 0.8}, {haze, 0.12}, {amber, 0.05}, {deeprust, 0.03}}
-- (a)
local ma = col(200, 105, 230, 11)
work(ma, {hand="body", tool="flat 4", angle=math.pi/2, coverage=3, fill=true, clip=true, length={30, 80}, piles=darkP, load=0.9})
local band = col(200, 195, 275, 12):soften(4)
blend(band, {angle=math.pi/2})
-- (b) graded colour, full load
local function gp(y0, y1)
  local function t(y) return clamp((y - y0) / (y1 - y0), 0, 1) end
  return {{waterdark, function(x, y) return lerp(0.8, 0.2, t(y)) end},
          {haze, function(x, y) return lerp(0.12, 0.62, t(y)) end},
          {glowrefl, function(x, y) return lerp(0.0, 0.14, t(y)) end},
          {amber, 0.05}}
end
local mb = col(500, 105, 330, 21)
work(mb, {hand="body", tool="flat 4", angle=math.pi/2, coverage=3, fill=true, clip=true, length={30, 80}, piles=gp(140, 330), load=0.9})
blend(mb:shrink(3), {angle=math.pi/2})
local mc = col(800, 105, 330, 31)
work(mc, {hand="body", tool="flat 4", angle=math.pi/2, coverage=3, fill=true, clip=true, length={30, 80}, piles=gp(140, 330), load=0.9})
print(wait(60))

--@ chunk 4
palette{scrape={glowrefl}}
gD6 = pile{{"raw umber",1},{"smalt",0.8},{"lead white",0.3},{"red earth",0.2}, medium=0.6, name="gD6"}
gD5 = pile{{"raw umber",1},{"smalt",0.8},{"lead white",0.3},{"red earth",0.2}, medium=0.5, name="gD5"}
local function col(cx, yTop, yBot, hw, seed)
  local nS = noise{seed=seed, period=50, octaves=2}
  local nB = noise{seed=seed + 1, period=22, octaves=2}
  return mask(function(x, y)
    if y < yTop or y > yBot + 14 or x < cx - hw - 6 or x > cx + hw + 6 then return 0 end
    local l = cx - hw + 3 * nS(y, 0)
    local r = cx + hw + 3 * nS(y, 40)
    local b = yBot + 10 * nB(x, 0)
    if x >= l and x <= r and y <= b then return 1 end
    return 0
  end)
end
local tool = {kind="filbert", width=14, stiffness=0.3}
for k, yb in ipairs({600, 520, 445}) do
  local m = col(500, 350, yb, 36 - k * 2, 100 + k)
  work(m, {hand="glaze", pile=gD6, coverage=1, angle=math.pi/2, tool=tool, clip=m})
end
for k, yb in ipairs({600, 520, 445}) do
  local m = col(800, 350, yb, 36 - k * 2, 110 + k)
  work(m, {hand="glaze", pile=gD5, coverage=1, angle=math.pi/2, tool=tool, clip=m})
end
print(wait(60))

--@ chunk 5
glowrefl = pile{{"lead white",3},{"yellow ochre",1.4},{"chrome yellow",0.4},{"red earth",0.25},{"raw umber",0.15}, name="glowrefl"}
for i, cx in ipairs({350, 650, 930}) do
  local m = ribbon({{cx, 110}, {cx + 2, 400}, {cx - 2, 690}}, {40, 46, 44}):roughen(3, 40, i + 10):soften(6)
  work(m, {hand="body", tool="flat 6", angle=math.pi/2, coverage=2, length={40, 100}, clip=true,
    piles={{haze, 0.7}, {glowrefl, 0.2}, {waterdark, 0.2}}, load_at=function(x, y) return 0.5 end})
  blend(m:shrink(2), {angle=math.pi/2})
end
print(wait(60 * 24 * 60))

--@ chunk 6
palette{scrape={gD6, gD5}}
wg7 = pile{{"raw umber",0.56},{"Prussian blue",0.14},{"red earth",0.19},{"green earth",0.11}, medium=0.7, name="wg7"}
wg6 = pile{{"raw umber",0.56},{"Prussian blue",0.1},{"red earth",0.25},{"green earth",0.11}, medium=0.6, name="wg6"}
local function col(cx, yTop, yBot, hw, seed)
  local nS = noise{seed=seed, period=50, octaves=2}
  local nB = noise{seed=seed + 1, period=22, octaves=2}
  return mask(function(x, y)
    if y < yTop or y > yBot + 14 or x < cx - hw - 6 or x > cx + hw + 6 then return 0 end
    local l = cx - hw + 3 * nS(y, 0)
    local r = cx + hw + 3 * nS(y, 40)
    local b = yBot + 10 * nB(x, 0)
    if x >= l and x <= r and y <= b then return 1 end
    return 0
  end)
end
local tool = {kind="filbert", width=14, stiffness=0.3}
-- generous masks (wider than the streak by ~10 each side) to test for a box over the dark water
for k, yb in ipairs({330, 250, 180}) do
  local m = col(350, 105, yb, 34 - k * 2, 200 + k)
  work(m, {hand="glaze", pile=wg7, coverage=1, angle=math.pi/2, tool=tool, clip=m})
end
for k, yb in ipairs({330, 250, 180}) do
  local m = col(650, 105, yb, 34 - k * 2, 210 + k)
  work(m, {hand="glaze", pile=wg6, coverage=1, angle=math.pi/2, tool=tool, clip=m})
end
print(wait(60))

--@ chunk 7
palette{scrape={wg7, wg6}}
gD2 = pile{{"raw umber",1},{"smalt",0.8},{"lead white",0.3},{"red earth",0.2}, medium=0.82, name="gD2"}
local function col(cx, yTop, yBot, hw, seed)
  local nS = noise{seed=seed, period=50, octaves=2}
  local nB = noise{seed=seed + 1, period=22, octaves=2}
  return mask(function(x, y)
    if y < yTop or y > yBot + 14 or x < cx - hw - 6 or x > cx + hw + 6 then return 0 end
    local l = cx - hw + 3 * nS(y, 0)
    local r = cx + hw + 3 * nS(y, 40)
    local b = yBot + 10 * nB(x, 0)
    if x >= l and x <= r and y <= b then return 1 end
    return 0
  end)
end
local tool = {kind="filbert", width=14, stiffness=0.3}
for k, yb in ipairs({300, 250, 200, 160}) do
  local m = col(930, 105, yb, 36 - k * 2, 300 + k)
  work(m, {hand="glaze", pile=gD2, coverage=1, angle=math.pi/2, tool=tool, clip=m})
end
print(wait(60))

--@ chunk 8
glowrefl = glowrefl or pile{{"lead white",3},{"yellow ochre",1.4},{"chrome yellow",0.4},{"red earth",0.25},{"raw umber",0.15}, name="glowrefl"}
palette{scrape={gD2}}
local field = rect(0, 760, 1000, 480)
work(field, {hand="body", tool={kind="flat", width=10}, angle=math.pi/2, coverage=3, fill=true, clip=true, length={40, 120},
  piles={{waterdark, function(x, y) return lerp(0.8, 0.45, clamp((y - 850) / 300, 0, 1)) end},
         {haze, 0.12},
         {deeprust, function(x, y) return lerp(0.02, 0.3, clamp((y - 850) / 300, 0, 1)) end},
         {amber, function(x, y) return lerp(0.06, 0.18, clamp((y - 850) / 300, 0, 1)) end}}})
for i, cx in ipairs({300, 700}) do
  local m = ribbon({{cx, 770}, {cx + 3, 1000}, {cx - 2, 1235}}, {44, 50, 46}):roughen(3, 40, i + 30):soften(8)
  work(m, {hand="body", tool="flat 6", angle=math.pi/2, coverage=2, length={40, 100}, clip=true,
    piles={{haze, 0.7}, {glowrefl, 0.25}, {waterdark, 0.15}}, load_at=function(x, y) return 0.55 end})
end
blend(field:shrink(4), {angle=math.pi/2})
print(wait(60 * 24 * 60))

--@ chunk 9
local function region(xl, xr, yTop, yBot, seed)
  local nB = noise{seed=seed, period=30, octaves=2}
  local nS = noise{seed=seed + 1, period=60, octaves=2}
  return mask(function(x, y)
    if x < xl - 20 or x > xr + 20 or y < yTop or y > yBot + 40 then return 0 end
    local b = yBot + 12 * nB(x, 0)
    local v = clamp((b - y) / 30, 0, 1)
    local l = clamp((x - (xl + 6 * nS(y, 0))) / 18, 0, 1)
    local r = clamp(((xr + 6 * nS(y, 30)) - x) / 18, 0, 1)
    return v * l * r
  end)
end
local P = {{waterdark, 0.8}, {haze, 0.13}, {amber, 0.05}, {deeprust, 0.02}}
for i, cx in ipairs({300, 700}) do
  local m = region(cx - 70, cx + 70, 762, 900, 40 + i)
  print(m:area())
  work(m, {hand="body", tool="flat 6", angle=math.pi/2, coverage=3, length={30, 90}, clip=true, piles=P,
    load_at=function(x, y) return lerp(0.85, 0.35, clamp((y - 800) / 120, 0, 1)) end, pressure={0.25, 0.5}})
  blend(m, {angle=math.pi/2})
  if i == 2 then blend(m, {angle=math.pi/2}) end
end
print(wait(60))

--@ chunk 10
print(wait(60 * 24 * 60))
couch = pile({{"raw umber",0.05},{"smalt",0.05}, medium=0.95, name="couch"})
print(couch)

--@ chunk 11
local P = {{waterdark, 0.8}, {haze, 0.13}, {amber, 0.05}, {deeprust, 0.02}}
local function trial(cx, useCouch, seed)
  local area = rect(cx - 80, 902, 160, 200)
  if useCouch then
    work(area, {hand="glaze", pile=couch, coverage=1, angle=math.pi/2, tool={kind="filbert", width=20, stiffness=0.3}, clip=true})
  end
  -- cover strokes: from the top edge down, lengths decreasing outward from the streak, load fading
  local b = brush{kind="flat", width=6}
  math.randomseed(seed)
  for k = 1, 22 do
    local x = cx - 34 + rand(0, 68)
    local L = rand(40, 110) * (1 - 0.5 * math.abs(x - cx) / 40)
    b:reload(waterdark, 0.5)
    b:load(haze, 0.08)
    b:stroke({{x, 904}, {x + rand(-2, 2), 904 + L}}, {pressure={0.5, 0.05}, ramps={0.05, 0.6}, orient="across", clip=area})
  end
  blend(area:shrink(2):soften(10), {angle=math.pi/2})
end
trial(300, true, 1)
trial(700, false, 2)
print(wait(60))
