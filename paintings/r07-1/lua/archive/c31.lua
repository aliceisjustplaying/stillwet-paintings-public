-- the crest's rhythm broken: a denser low fringe between the tufts, two big clumps, a few tall seed stalks
local wind = noise{seed=111, period=160}
local fr = noise{seed=171, period=50}
local g1 = brush{kind="rigger", width=0.8, point=1}
local g2 = brush{kind="rigger", width=0.6, point=1}
local function blade(b, x, y, h, lean, curl, p)
  b:stroke({{x, y}, {x + lean * h * 0.35, y - h * 0.5}, {x + lean * h + curl * h * 0.3, y - h + math.abs(curl) * h * 0.2}}, {pressure={p, 0}, ramps={0.04, 0.7}, shake=0.2})
end
local n = 0
for x = -4, 1004, 0.9 do
  if not (x > 440 and x < 575) then
    local hh = 3 + 9 * fr:at01(x, 0) ^ 1.5
    local y0 = bankTop(x) + rand(0.5, 4)
    if n % 10 == 0 then g2:reload(rand() < 0.75 and "#26241d" or "#3a3627", 0.7) end
    blade(g2, x + rand(-0.6, 0.6), y0, hh * rand(0.5, 1.3), 0.25 * wind(x, 0) + randn(0, 0.3), randn(0, 0.2), rand(0.4, 0.65))
    n = n + 1
  end
end
for _, c in ipairs({{176, 1.9}, {772, 1.6}, {382, 1.2}}) do
  local x0, size = c[1], c[2]
  local y0 = bankTop(x0) + 3
  for k = 1, math.floor(45 * size) do
    local b = k % 3 == 0 and g2 or g1
    if k % 6 == 1 then b:reload(k % 4 == 1 and "#3a3627" or "#27251e", 0.7) end
    if k % 11 == 0 then b:reload(mix("#7a6a4a", "#27251e", rand(0.2, 0.5)), 0.6) end
    blade(b, x0 + randn(0, 5 * size), y0 + rand(0, 4), rand(8, 26) * size, 0.25 * wind(x0, 0) + randn(0, 0.3), randn(0, 0.25), rand(0.5, 0.75))
  end
end
-- tall dry stalks with seed heads, few, leaning with the wind
local sb = brush{kind="rigger", width=0.55, point=1}
local hb = brush{kind="round", width=1.3}
for i = 1, 22 do
  local x = rand(0, 1000)
  if not (x > 430 and x < 585) then
    local y0 = bankTop(x) + rand(1, 4)
    local h = rand(22, 46)
    local lean = 0.3 * wind(x, 0) + randn(0, 0.12)
    local tx, ty = x + lean * h, y0 - h
    sb:reload(mix("#2a271f", "#6b5d40", rand(0, 0.4)), 0.7)
    sb:stroke({{x, y0}, {x + lean * h * 0.45, y0 - h * 0.5}, {tx, ty}}, {pressure={0.5, 0.2}, ramps={0.05, 0.3}})
    hb:reload(mix("#3a3326", "#7a6a4a", rand(0.1, 0.5)), 0.5)
    for k = 1, math.random(3, 6) do
      local t = k / 7
      hb:touch(tx - lean * h * 0.12 * t, ty + h * 0.12 * t, {pressure=rand(0.3, 0.5), drag={lean * 0.6, -1}})
    end
  end
end
print(n)
