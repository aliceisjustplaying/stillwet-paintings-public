-- easel session "scratch": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box every
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
canvas{aspect=1.3333333333333333, ground={{apply="knife", pile={{"lead white", 1}}, texture=0.25, um=70}, {apply="brush", pile={{"lead white", 3}, {"yellow ochre", 1.2}, {"raw umber", 1}, {"red earth", 0.35}}, um=25}}, linen={16, 14}, seed=1873, size=700}

--@ chunk 2
floorLit = pile{{"lead white", 3}, {"yellow ochre", 2}, {"Naples yellow", 1}, {"burnt sienna", 0.2}}
local m2 = rect(20, 20, 960, 220)
work(m2, {hand="body", tool={kind="filbert", width=9, lay=1.5}, pile=floorLit, coverage=2, fill=true, clip=m2, angle=0})
print(wait(12 * 24 * 60))
dragP = pile{{"burnt sienna", 1}, {"raw umber", 0.8}, {"yellow ochre", 0.6}, medium=0.45}
local b = brush{kind="filbert", width=10}
for i = 0, 22 do
  local x = 40 + i * 9
  b:reload(dragP, 0.45)
  b:stroke({{x, 230}, {x + 2, 150}, {x + 4, 40}}, {pressure={0.6, 0.15}, ramps={0.02, 0.5}})
end
for i = 0, 22 do
  local x = 300 + i * 9
  b:reload(dragP, 0.3)
  b:stroke({{x, 230}, {x + 2, 140}, {x + 4, 40}}, {pressure={0.5, 0.05}, ramps={0.02, 0.8}})
end
dragQ = pile{{"burnt sienna", 1}, {"raw umber", 0.8}, {"yellow ochre", 0.6}, medium=0.7}
for i = 0, 22 do
  local x = 560 + i * 9
  b:reload(dragQ, 0.5)
  b:stroke({{x, 230}, {x + 2, 140}, {x + 4, 40}}, {pressure={0.6, 0.1}, ramps={0.02, 0.7}})
end

--@ chunk 3
gW2b = pile{{"burnt sienna", 1}, {"raw umber", 0.6}, medium=0.75}
local m = rect(30, 300, 400, 120)
work(m, {hand="body", tool={kind="filbert", width=9, lay=1.5}, pile=floorLit, coverage=2, fill=true, clip=m, angle=0})
local m2 = rect(480, 300, 400, 120)
work(m2, {hand="body", tool={kind="filbert", width=9, lay=1.5}, pile=floorLit, coverage=2, fill=true, clip=m2, angle=0})
print(wait(12 * 24 * 60))
local ok, e = pcall(function()
  work(rect(40, 305, 380, 110), {hand="glaze", tool={kind="filbert", width=14}, pile=gW2b, coverage=function(x, y) return 0.1 + 0.9 * (x - 40) / 380 end, clip=true, angle=1.57})
end)
print(ok, e)
-- variant: single-tone glaze then gradient blend lift
work(rect(490, 305, 380, 110), {hand="glaze", pile=gW2b, coverage=1, clip=true, angle=1.57})
work(rect(490, 305, 380, 110), {hand="glaze", pile=gW2b, coverage=1, clip=true, angle=0})
local r = rag{width=40}
r:dip(0.4)
r:wipe(rect(490, 305, 140, 110), {pressure=0.4, angle=1.57, passes=2})
r:refold()
r:wipe(rect(490, 305, 260, 110), {pressure=0.25, angle=1.57, passes=1})

--@ chunk 4
wallDk = pile{{"raw umber", 2}, {"bone black", 1}, {"burnt sienna", 0.6}}
sky = pile{{"lead white", 8}, {"Naples yellow", 1}, {"lemon chrome", 0.25}}
local dk = rect(20, 450, 960, 290)
work(dk, {hand="body", tool="filbert 12", pile=wallDk, coverage=2.5, fill=true, clip=dk, angle=0})
work(rect(640, 450, 180, 290), {hand="body", tool="filbert 10", pile=sky, coverage=2.5, fill=true, clip=rect(640, 450, 180, 290), angle=1.57})
print(wait(14 * 24 * 60))
smokeE = pile{{"lead white", 3}, {"raw umber", 0.2}, {"yellow ochre", 0.7}, {"Naples yellow", 0.3}, medium=0.9}
function puff(cx, cy, r, seed)
  local m = nil
  math.randomseed(seed)
  for i = 1, 7 do
    local a = rand(0, 6.28)
    local rr = r * rand(0.35, 0.7)
    local e = ellipse(cx + math.cos(a) * r * 0.5, cy + math.sin(a) * r * 0.4, rr * rand(1.0, 1.4), rr)
    m = m and (m + e) or e
  end
  return m
end
-- a drifting trail of puffs, then blended
local trail = nil
for i = 0, 8 do
  local t = i / 8
  local p = puff(120 + t * 600, 620 - t * 70 + 20 * math.sin(t * 6), 22 + t * 55, 100 + i)
  trail = trail and (trail + p) or p
end
work(trail, {hand="glaze", tool={kind="filbert", width=14}, pile=smokeE, coverage=1, angle=-0.15})
blend(trail:grow(6):blur(8), {angle=-0.15})
local core = nil
for i = 0, 8 do
  local t = i / 8
  local p = puff(130 + t * 600, 618 - t * 70 + 20 * math.sin(t * 6), (22 + t * 55) * 0.55, 200 + i)
  core = core and (core + p) or p
end
work(core, {hand="glaze", tool={kind="filbert", width=10}, pile=smokeE, coverage=1, angle=-0.15})
blend(core:grow(4):blur(6), {angle=0.8})

--@ chunk 5
wait(1)
local dk = rect(20, 20, 960, 410)
work(dk, {hand="body", tool="filbert 12", pile=wallDk, coverage=2.5, fill=true, clip=dk, angle=0})
work(rect(640, 20, 180, 410), {hand="body", tool="filbert 10", pile=sky, coverage=2.5, fill=true, clip=rect(640, 20, 180, 410), angle=1.57})
print(wait(14 * 24 * 60))
smokeW = pile{{"lead white", 3}, {"yellow ochre", 0.8}, {"Naples yellow", 0.4}, {"raw umber", 0.1}, medium=0.9}
-- A: noise-density glaze, two thresholds, blended
local nz = noise{seed=5, octaves=4, period=90, kind="billow", warp={120, 40}, stretch={-0.2, 2.2}}
local function plume(x, y)
  local cy = 130 - (x - 40) * 0.12
  local w = 18 + (x - 40) * 0.12
  return math.exp(-((y - cy) / w)^2) * smoothstep(40, 90, x) * (1 - smoothstep(560, 640, x))
end
local d1 = mask(function(x, y) return smoothstep(0.15, 0.35, plume(x, y) * (0.6 + 0.6 * nz:at01(x, y))) end)
work(d1, {hand="glaze", tool={kind="filbert", width=16}, pile=smokeW, coverage=1, angle=-0.12})
blend(d1:blur(6), {angle=-0.12})
local d2 = mask(function(x, y) return smoothstep(0.45, 0.65, plume(x, y) * (0.5 + 0.8 * nz:at01(x + 30, y))) end)
work(d2, {hand="glaze", tool={kind="filbert", width=12}, pile=smokeW, coverage=1, angle=-0.12})
blend(d2:blur(5), {angle=0.5})
-- B: badger swept strokes along drift lines
local bb = brush{kind="badger", width=24}
for i = 0, 6 do
  bb:reload(smokeW, 0.25)
  local y0 = 300 + i * 12
  bb:stroke({{60, y0 + 30}, {200, y0 + 10 + 10 * math.sin(i)}, {380, y0 - 20}, {600, y0 - 50 + 8 * math.cos(i)}}, {pressure={0.15, 0.35}, ramps={0.3, 0.4}})
end

--@ chunk 6
wait(1)
local dk = rect(20, 450, 600, 290)
work(dk, {hand="body", tool="filbert 12", pile=wallDk, coverage=2.5, fill=true, clip=dk, angle=0})
print(wait(14 * 24 * 60))
smokeW2 = pile{{"lead white", 3}, {"yellow ochre", 1.2}, {"Naples yellow", 0.5}, {"burnt sienna", 0.15}, medium=0.85}
local nz = noise{seed=9, octaves=4, period=70, kind="billow", warp={100, 35}}
local function plume(x, y)
  local cy = 600 - (x - 40) * 0.12
  local w = 22 + (x - 40) * 0.14
  return math.exp(-((y - cy) / w)^2) * smoothstep(40, 100, x) * (1 - smoothstep(520, 600, x))
end
local function dens(x, y) return plume(x, y) * (0.3 + 0.9 * nz:at01(x, y)) end
local area = mask(function(x, y) return dens(x, y) > 0.05 and 1 or 0 end)
stipple(area, {pile=smokeW2, width=10, coverage=function(x, y) return 2.5 * dens(x, y) end, feather=1, pressure={0.2, 0.5}, dips={30, 0.4, 0}})
blend(area:grow(8):blur(8), {angle=-0.12})

--@ chunk 7
local area = rect(40, 470, 560, 250)
blend(area:blur(4), {angle=0.6})
