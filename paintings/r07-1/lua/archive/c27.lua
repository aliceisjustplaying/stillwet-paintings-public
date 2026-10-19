-- bark strokes across the seam, the color of the bark just above it
local sn = noise{seed=151, period=20}
local seam = trunkM:shrink(3) * mask(function(x, y) local c = 556 + 6 * sn(x, 0); return smoothstep(c - 14, c - 6, y) * (1 - smoothstep(c + 6, c + 14, y)) end)
work(seam, {hand="detail", tool="filbert 3", length={10, 22}, coverage=2, medium=0.15, pal=barkpal, angle=-1.57, angle_jitter=0.2, clip=false, hug=false,
  color=function(x, y) return sample(505 + (x - 505) * 0.75, 535, 2) end})
-- a low mound of earth and grass over the foot line
local mn = noise{seed=153, period=30}
local mound = mask(function(x, y)
  local top = 608 + 5 * mn(x, 0) - 6 * math.exp(-((x - 505) / 60) ^ 2)
  return smoothstep(top - 2, top + 2, y) * smoothstep(410, 440, x) * (1 - smoothstep(580, 610, x)) * (1 - smoothstep(632, 640, y))
end)
work(mound, {hand="body", tool="filbert 4", length={10, 30}, coverage=2.4, medium=0.15, pal=bankpal, angle=-0.1, hug=false,
  color=function(x, y) return sample(x < 505 and x - 70 or x + 70, y + 4, 4) end})
local g1 = brush{kind="rigger", width=1.0, point=1}
local g2 = brush{kind="rigger", width=0.7, point=1}
local wind = noise{seed=111, period=160}
local cols = {"#4a4432", "#433d2d", "#5a5038", "#6b5d40", "#2f2b22"}
for i = 1, 300 do
  local x = rand(425, 595)
  local top = 608 + 5 * mn(x, 0) - 6 * math.exp(-((x - 505) / 60) ^ 2)
  local y = top + rand(0, 14)
  local b = i % 3 == 0 and g2 or g1
  if i % 5 == 1 then b:reload(cols[math.random(1, #cols)], 0.7) end
  local h = rand(6, 24)
  local lean = 0.22 * wind(x, y) + randn(0, 0.3)
  local curl = randn(0, 0.25)
  b:stroke({{x, y}, {x + lean * h * 0.35, y - h * 0.5}, {x + lean * h + curl * h * 0.3, y - h + math.abs(curl) * h * 0.2}},
    {pressure={rand(0.4, 0.7), 0}, ramps={0.04, 0.7}, shake=0.2})
end
local t = timesheet(); print(t.sitting)
