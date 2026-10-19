-- furrows long enough to cross the old seam low on the bole
local fb = brush{kind="round", width=1.8, point=0.6}
local sn = noise{seed=141, period=26}
for i = 1, 30 do
  local x0 = rand(448, 562)
  local y0, y1 = rand(515, 545), rand(590, 616)
  local pts = {}
  for k = 0, 6 do local y = y0 + (y1 - y0) * k / 6; pts[#pts + 1] = {x0 + 4 * sn(x0, y) + 0.1 * (y - 560) * (x0 - 505) / 60, y} end
  if i % 4 == 1 then fb:reload(i % 3 == 0 and "#3b322a" or BARK.dark, 0.7) end
  fb:stroke(pts, {pressure={rand(0.35, 0.7), rand(0.2, 0.5)}, ramps={0.2, 0.3}, shake=0.6, clip=trunkM})
end
-- the foot seated in grass: dense blades across its line
local g1 = brush{kind="rigger", width=1.0, point=1}
local g2 = brush{kind="rigger", width=0.7, point=1}
local wind = noise{seed=111, period=160}
local cols = {"#2a271f", "#312d23", "#433d2d", "#23211b", "#5a5038"}
for i = 1, 420 do
  local x = rand(420, 600)
  local edge = 606 + 12 * math.exp(-((x - 510) / 70) ^ 2)
  local y = edge + rand(-10, 12)
  local b = i % 3 == 0 and g2 or g1
  if i % 6 == 1 then b:reload(cols[math.random(1, #cols)], 0.7) end
  local h = rand(6, 26)
  local lean = 0.22 * wind(x, y) + randn(0, 0.3)
  local curl = randn(0, 0.25)
  b:stroke({{x, y}, {x + lean * h * 0.35, y - h * 0.5}, {x + lean * h + curl * h * 0.3, y - h + math.abs(curl) * h * 0.2}},
    {pressure={rand(0.4, 0.7), 0}, ramps={0.04, 0.7}, shake=0.2})
end
local t = timesheet(); print(t.sitting)
