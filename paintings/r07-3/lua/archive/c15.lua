-- the bank's grass, blade by blade in fine upturned strokes against the water, and a few groups of reeds
reedpal = pal:only{"raw umber", "bone black", "yellow ochre", "red earth", "lead white"}
local lean = noise{seed=101, period=300}
local dens = noise{seed=102, period=60, octaves=2}
local blade = brush{kind="rigger", width=0.8, point=1}
local nb = 0
-- grass along the brow: many short blades, more where the bank rises, gaps where it's bare
for i = 1, 1400 do
  local x = rand(-5, 1005)
  local keep = 0.25 + 0.75 * (G(x, 90, 200) + G(x, 930, 160)) 
  if rand() < keep * (0.3 + 0.9 * dens:at01(x, 0)) then
    local yb = bankcurve(x) + rand(0.5, 1) * rand(0, 16)
    local h = rand(3, 12) * (1 + 1.4 * (G(x, 90, 200) + G(x, 930, 160))) * rand(0.6, 1.3)
    local l = 0.12 * lean(x, 0) + randn(0, 0.22)
    local c = rand() < 0.08 and mix("#6c5a40", "#8a7352", rand()) or mix("#2c2b24", "#40402f", rand())
    if nb % 6 == 0 or rand() < 0.15 then blade:reload(c, 0.7) end
    blade:stroke({{x, yb}, {x + l * h * 0.4, yb - h * 0.55}, {x + l * h + randn(0, 0.25) * h * 0.3, yb - h}},
      {pressure={rand(0.4, 0.75), 0.0}, ramps={0.04, 0.75}})
    nb = nb + 1
  end
end
-- small groups of reeds at the water's edge, none alike
local stem = brush{kind="rigger", width=1.0, point=1}
local leaf = brush{kind="rigger", width=0.9, point=1}
local pl = brush{kind="round", width=1.4}
local ns = 0
local function group(cx, n, hmax, spread)
  for i = 1, n do
    local x = cx + randn(0, spread)
    local yb = bankcurve(x) + rand(-1, 6)
    local h = hmax * rand(0.45, 1) * rand(0.7, 1)
    local l = 0.08 * lean(x, 0) + randn(0.02, 0.06)
    local tip = {x + l * h, yb - h}
    if i % 4 == 1 then local c = mix("#2b2a23", "#3b382d", rand()); stem:reload(c, 0.85); leaf:reload(c, 0.8) end
    stem:stroke({{x, yb}, {x + l * h * 0.45 + randn(0, 0.02) * h, yb - h * 0.5}, tip}, {pressure={rand(0.6, 0.85), 0.12}, ramps={0.03, 0.25}})
    for k = 1, (rand() < 0.5 and 2 or 1) do
      local t = rand(0.2, 0.65)
      local sx, sy = x + (tip[1] - x) * t, yb - h * t
      local dir = (rand() < 0.5) and -1 or 1
      local L = rand(10, 26) * (h / 70)^0.5
      leaf:stroke({{sx, sy}, {sx + dir * L * 0.55, sy - L * 0.4}, {sx + dir * L, sy - L * 0.1 + rand(0, L * 0.4)}}, {pressure={0.7, 0.02}, ramps={0.05, 0.7}})
    end
    if rand() < 0.45 then
      -- a panicle hanging from the tip: touches down a short curve, heaviest in the middle
      if ns % 3 == 0 then pl:reload(mix("#3c342c", "#4e4236", rand()), 0.85) end
      local s = (h / 80)^0.6
      local side = (l >= 0) and 1 or -1
      local nt = 7
      for k = 0, nt - 1 do
        local u = k / (nt - 1)
        local px = tip[1] + side * (1.5 * u + 2.2 * u * u) * s
        local py = tip[2] + (1 + 7 * u) * s
        pl:touch(px + randn(0, 0.3), py, {pressure=0.35 + 0.3 * math.sin(math.pi * u), drag={side * 0.8 * s, 1.6 * s}})
      end
    end
    ns = ns + 1
  end
end
group(38, 16, 95, 16)
group(150, 11, 70, 12)
group(262, 6, 42, 8)
group(752, 5, 38, 7)
group(872, 13, 80, 14)
group(968, 9, 64, 10)
-- the bank's body: darker blades through it, larger toward me, a few catching the last light
local nb2 = 0
for i = 1, 700 do
  local x = rand(-5, 1005)
  local yb = rand(bankcurve(x) + 8, 700)
  local depth = smoothstep(bankcurve(x), 690, yb)
  if rand() < 0.35 + 0.5 * dens:at01(x * 1.3, yb) then
    local h = (5 + 22 * depth) * rand(0.5, 1.4)
    local l = 0.12 * lean(x, yb) + randn(0, 0.25)
    local c = rand() < 0.06 and mix("#5a4c38", "#6e5c42", rand()) or mix("#24231e", "#37362b", rand())
    if nb2 % 7 == 0 then blade:reload(c, 0.7) end
    blade:stroke({{x, yb}, {x + l * h * 0.4, yb - h * 0.55}, {x + l * h, yb - h}}, {pressure={0.35 + 0.4 * depth, 0}, ramps={0.05, 0.75}})
    nb2 = nb2 + 1
  end
end
print(nb2, "blades in the bank")
print(nb, "blades,", ns, "reeds")
local t = timesheet(); print(string.format("sitting %.0f min", t.sitting))
