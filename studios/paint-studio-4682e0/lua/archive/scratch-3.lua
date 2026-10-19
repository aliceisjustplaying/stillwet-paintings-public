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
wallDk = pile{{"raw umber", 2}, {"bone black", 1}, {"burnt sienna", 0.6}}
sky = pile{{"lead white", 8}, {"Naples yellow", 1}, {"lemon chrome", 0.25}}
local dk = rect(20, 20, 960, 710)
work(dk, {hand="body", tool="filbert 12", pile=wallDk, coverage=2.5, fill=true, clip=dk, angle=0})
work(rect(700, 20, 150, 710), {hand="body", tool="filbert 10", pile=sky, coverage=2.5, fill=true, clip=rect(700, 20, 150, 710), angle=1.57})
print(wait(14 * 24 * 60))
smokeE = pile{{"lead white", 3}, {"raw umber", 0.2}, {"yellow ochre", 0.7}, {"Naples yellow", 0.3}, medium=0.9}
function billows(cx, cy, n, seed, len)
  math.randomseed(seed)
  local m = nil
  for i = 1, n do
    local t = (i - 1) / (n - 1)
    local x = cx + t * len + rand(-15, 15)
    local y = cy - t * 50 + rand(-20, 20)
    local r = 14 + t * 36 + rand(-6, 6)
    local e = ellipse(x, y, r * rand(0.9, 1.3), r * rand(0.8, 1.1))
    m = m and (m + e) or e
  end
  return m
end
local c = billows(60, 150, 12, 21, 300)
work(c, {hand="glaze", pile=smokeE, coverage=1})
blend(c:grow(8):blur(10), {angle=-0.15})
blend(c:grow(8):blur(10), {angle=-0.15})
blend(c:grow(16):blur(16), {angle=1.2, clip=false})
local c2 = billows(60, 420, 12, 22, 300)
work(c2, {hand="glaze", pile=smokeE, coverage=0.6})
work(c2:shrink(15), {hand="glaze", pile=smokeE, coverage=0.6})
blend(c2:grow(8):blur(10), {angle=-0.15})
local c3 = billows(500, 300, 12, 23, 380)
work(c3, {hand="glaze", pile=smokeE, coverage=1})
blend(c3:grow(8):blur(10), {angle=-0.15})

--@ chunk 3
zombP = pile{{"bone black", 1}, {"raw umber", 1.2}, {"green earth", 1.2}, medium=0.3}
zombQ = pile{{"bone black", 1}, {"raw umber", 1.2}, {"red earth", 0.6}, turps=0.5}
local b = brush{kind="round", width=6}
b:load(zombP, 0.9)
print(b:spatter{at={740, 420}, toward={90, -50}, spread=0.5, force=0.7})
b:load(zombQ, 0.9)
print(b:spatter{at={740, 560}, toward={90, -40}, spread=0.4, force=0.4})
b:load(zombQ, 0.9)
print(b:spatter{at={740, 650}, toward={60, -20}, spread=0.6, force=0.9})

--@ chunk 4
floorLit = pile{{"lead white", 3}, {"yellow ochre", 2}, {"Naples yellow", 1}, {"burnt sienna", 0.2}}
local m = rect(20, 600, 660, 120)
work(m, {hand="body", tool={kind="filbert", width=9, lay=1.5}, pile=floorLit, coverage=2, fill=true, clip=m, angle=0})
print(wait(14 * 24 * 60))
gW1 = pile{{"raw sienna", 1}, {"burnt sienna", 0.5}, {"raw umber", 0.3}, medium=0.5}
gW2 = pile{{"burnt sienna", 1}, {"raw umber", 0.6}, medium=0.5}
gW3 = pile{{"raw umber", 1}, {"burnt sienna", 1}, {"yellow ochre", 0.5}, medium=0.3}
work(rect(40, 610, 140, 100), {hand="glaze", pile=gW1, coverage=1, clip=true})
work(rect(200, 610, 140, 100), {hand="glaze", pile=gW2, coverage=1, clip=true})
work(rect(360, 610, 140, 100), {hand="glaze", pile=gW3, coverage=1, clip=true})

--@ chunk 5
floorSh = pile{{"raw umber", 2}, {"burnt sienna", 1}, {"yellow ochre", 0.6}, {"bone black", 0.3}}
local dk = rect(20, 20, 960, 540)
-- the existing scratch is already dark there (wallDk + sky stripe). Paint a fresh floor-dark area first
local m = rect(20, 20, 660, 300)
work(m, {hand="body", tool="filbert 10", pile=floorSh, coverage=2.5, fill=true, clip=m, angle=0})
print(wait(10 * 24 * 60))
-- trapezoid of light: edge function soft toward the bottom
local trap = poly({{200, 40}, {450, 40}, {380, 300}, {60, 300}})
work(trap, {hand="body", tool={kind="filbert", width=8}, pile=floorLit, coverage=2.5, fill=true,
  edge=function(x, y) return clamp((y - 40) / 260, 0, 1) end, angle=-1.2, angle_jitter=0.05, length={15, 40}})

--@ chunk 6
local function xl(y) return 200 - (140 / 260) * (y - 40) end
local function xr(y) return 450 - (70 / 260) * (y - 40) end
local function w(y) return 2 + 18 * clamp((y - 40) / 260, 0, 1) end
local band = mask(function(x, y)
  if y < 36 or y > 330 then return 0 end
  local d = math.min(math.abs(x - xl(y)), math.abs(x - xr(y)))
  local dv = (y <= 300) and math.abs(y - 300) or (y - 300)
  local e1 = 1 - smoothstep(w(y) * 0.6, w(y), d)
  local inx = (x > xl(y) - w(y)) and (x < xr(y) + w(y)) and 1 or 0
  local e2 = (1 - smoothstep(14, 22, dv)) * inx
  return math.max(e1, e2)
end)
blend(band, {angle=-1.2})
blend(band, {angle=0.4})

--@ chunk 7
local function xl(y) return 200 - (140 / 260) * (y - 40) end
local function xr(y) return 450 - (70 / 260) * (y - 40) end
local function w(y) return 2 + 18 * clamp((y - 40) / 260, 0, 1) end
-- wet dark band laid just outside the light edge (outer strip)
local outer = mask(function(x, y)
  if y < 40 or y > 318 then return 0 end
  local ww = w(y) * 1.2
  local left = (x < xl(y) and x > xl(y) - ww) and 1 or 0
  local right = (x > xr(y) and x < xr(y) + ww) and 1 or 0
  local bottom = (y > 300 and x > xl(y) - ww and x < xr(y) + ww) and 1 or 0
  return math.max(left, right, bottom)
end)
work(outer, {hand="detail", tool={kind="filbert", width=5}, pile=floorSh, coverage=3, fill=true, clip=outer, angle=-1.2, length={8, 20}})
local band = mask(function(x, y)
  if y < 36 or y > 330 then return 0 end
  local d = math.min(math.abs(x - xl(y)), math.abs(x - xr(y)))
  local e1 = 1 - smoothstep(w(y) * 0.7, w(y), d)
  local inx = (x > xl(y) - w(y)) and (x < xr(y) + w(y)) and 1 or 0
  local e2 = (1 - smoothstep(14, 22, math.abs(y - 300))) * inx
  return math.max(e1, e2)
end)
blend(band, {angle=-1.2})
blend(band, {angle=0.4})
blend(band, {angle=-1.2})

--@ chunk 8
wallHi = pile{{"yellow ochre", 2}, {"burnt sienna", 0.6}, {"lead white", 0.7}, {"raw umber", 0.2}}
wallMid = pile{{"raw umber", 1}, {"burnt sienna", 1}, {"yellow ochre", 1}}
warmD = pile{{"raw umber", 2}, {"burnt sienna", 1.2}, {"bone black", 0.4}}
local mixes = {
  {{wallHi, 1}, {wallMid, 0.001}},
  {{wallHi, 0.5}, {wallMid, 0.5}},
  {{wallMid, 1}, {warmD, 0.001}},
  {{wallMid, 0.6}, {warmD, 0.4}},
  {{wallMid, 0.3}, {warmD, 0.7}},
}
for i, m in ipairs(mixes) do
  local r = rect(20 + (i - 1) * 130, 380, 110, 90)
  work(r, {hand="body", tool="filbert 8", piles=m, coverage=2.5, fill=true, clip=r, angle=0})
end

--@ chunk 9
print("noop")

--@ chunk 10
local m = rect(20, 480, 600, 110)
floorLit = pile{{"lead white", 3}, {"yellow ochre", 2}, {"Naples yellow", 1}, {"burnt sienna", 0.2}}
work(m, {hand="body", tool={kind="filbert", width=9, lay=1.5}, pile=floorLit, coverage=2, fill=true, clip=m, angle=0})
print(wait(12 * 24 * 60))
gW2 = pile{{"burnt sienna", 1}, {"raw umber", 0.6}, medium=0.5}
local gm = rect(30, 490, 580, 90) * mask(function(x, y) return smoothstep(40, 600, x) end)
work(gm, {hand="glaze", pile=gW2, coverage=1, clip=true, angle=1.57})

--@ chunk 11
local m = rect(20, 610, 600, 110)
work(m, {hand="body", tool={kind="filbert", width=9, lay=1.5}, pile=floorLit, coverage=2, fill=true, clip=m, angle=0})
print(wait(12 * 24 * 60))
-- three stepped glazes, light -> heavy; then a blend across the steps
gW2b = pile{{"burnt sienna", 1}, {"raw umber", 0.6}, medium=0.75}
work(rect(150, 615, 465, 100), {hand="glaze", pile=gW2b, coverage=1, clip=true, angle=1.57})
work(rect(300, 615, 315, 100), {hand="glaze", pile=gW2b, coverage=1, clip=true, angle=1.57})
work(rect(450, 615, 165, 100), {hand="glaze", pile=gW2b, coverage=1, clip=true, angle=1.57})
blend(rect(100, 615, 520, 100), {angle=0})

--@ chunk 12
local m = rect(20, 740, 600, 0)
local m2 = rect(660, 470, 320, 250)
work(m2, {hand="body", tool={kind="filbert", width=9, lay=1.5}, pile=floorLit, coverage=2, fill=true, clip=m2, angle=0})
print(wait(12 * 24 * 60))
local ok, e = pcall(function()
  work(rect(760, 480, 210, 110), {hand="glaze", pile=gW2, coverage=1, edge="lost", angle=1.57})
end)
print(ok, e)
work(rect(760, 600, 210, 110), {hand="glaze", pile=gW2, coverage=1, edge={lost=1, period=40}, angle=1.57})
