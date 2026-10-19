-- grass, blade by blade: tussocks on the bank's crest against the water, rushes, and the bank's face
GR = {dark="#27251e", olive="#3a3627", straw="#7a6a4a", pale="#948259"}
local wind = noise{seed=111, period=160}
local g1 = brush{kind="rigger", width=0.9, point=1}
local g2 = brush{kind="rigger", width=0.6, point=1}
local function blade(b, x, y, h, lean, curl, p)
  local tx, ty = x + lean * h, y - h
  b:stroke({{x, y}, {x + lean * h * 0.35, y - h * 0.5}, {tx + curl * h * 0.3, ty + math.abs(curl) * h * 0.2}}, {pressure={p, 0}, ramps={0.04, 0.7}, shake=0.2})
end
-- 1. tussocks along the crest, spaced by hand
local xs = uneven(80, 4, 996, 0.7, 0.5, 7)
local n = 0
for i, x0 in ipairs(xs) do
  local y0 = bankTop(x0) + rand(1, 5)
  local size = rand(0.5, 1.4) * (1 + 0.4 * wind:at01(x0, 3))
  local count = math.floor(rand(14, 30) * size)
  for k = 1, count do
    local lean = 0.25 * wind(x0, 0) + randn(0, 0.28)
    local h = rand(7, 26) * size
    local b = (k % 3 == 0) and g2 or g1
    if n % 6 == 0 then b:reload(k % 4 == 0 and GR.olive or GR.dark, 0.7) end
    if k > count - 2 and rand() < 0.5 then b:reload(mix(GR.straw, GR.dark, rand(0.1, 0.5)), 0.6) end
    blade(b, x0 + randn(0, 2.5 * size), y0 + rand(0, 3), h, lean, randn(0, 0.25), rand(0.45, 0.75))
    n = n + 1
  end
end
-- the crest between the tussocks: low grass all along, so the bank has no ruled edge
for x = -4, 1004, 1.6 do
  local y0 = bankTop(x) + rand(0, 4)
  if n % 9 == 0 then g2:reload(rand() < 0.7 and GR.dark or GR.olive, 0.7) end
  blade(g2, x + rand(-0.8, 0.8), y0, rand(3, 10), 0.2 * wind(x, 0) + randn(0, 0.3), randn(0, 0.2), rand(0.4, 0.7))
  n = n + 1
end
-- 2. rushes: straight stems in a few clumps, one or two snapped
local rb = brush{kind="rigger", width=0.8, point=1}
for _, cx in ipairs({92, 318, 671, 866}) do
  local y0 = bankTop(cx) + 2
  rb:reload(GR.dark, 0.8)
  for k = 1, math.random(10, 18) do
    local x = cx + randn(0, 4)
    local h = rand(16, 42)
    local a = -1.57 + randn(0, 0.12) + 0.08 * wind(cx, 0)
    local pts = {{x, y0 + rand(0, 3)}, {x + math.cos(a) * h * 0.5, y0 - h * 0.5}}
    if rand() < 0.12 then a = a + (rand() < 0.5 and -1 or 1) * rand(0.8, 1.4) end
    pts[3] = {pts[2][1] + math.cos(a) * h * 0.5, pts[2][2] + math.sin(a) * h * 0.5}
    if k % 5 == 0 then rb:reload(GR.dark, 0.8) end
    rb:stroke(pts, {pressure={0.6, 0.05}, ramps={0.03, 0.5}, shake=0.1})
  end
end
-- 3. the bank's face: fewer, taller blades toward me, a few pale stalks catching the sky
local fb = brush{kind="rigger", width=1.1, point=1}
local patch = noise{seed=113, period=90}
local i = 0
while i < 480 do
  local x = rand(-5, 1005)
  local y = rand(bankTop(x) + 12, 718)
  local pz = patch:at01(x, y)
  if rand() < pz * pz * 1.6 then
  i = i + 1
  local depth = (y - 570) / 150
  local h = (5 + 26 * depth) * rand(0.5, 1.5)
  local pale = pz > 0.72 and rand() < 0.25
  local b = depth > 0.5 and fb or g1
  if i % 7 == 1 or pale then b:reload(pale and mix(GR.straw, GR.olive, rand(0.35, 0.7)) or (rand() < 0.5 and GR.dark or "#4a4432"), 0.7) end
  blade(b, x, y, h, 0.2 * wind(x, y) + randn(0, 0.25), randn(0, 0.25), 0.35 + 0.45 * depth)
  end
end
-- 4. grass round the willow's foot
for i = 1, 90 do
  local x = rand(430, 590)
  local y = 612 + rand(-6, 10)
  if i % 6 == 1 then g1:reload(i % 12 == 1 and GR.olive or GR.dark, 0.7) end
  blade(g1, x, y, rand(6, 20), randn(0, 0.3), randn(0, 0.25), rand(0.5, 0.75))
end
local t = timesheet(); print(t.sitting)
