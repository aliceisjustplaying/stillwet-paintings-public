-- the ice worked over the dry lay-in: thin long streaks of polished ice glazed darker, and a few pale
-- drifted lines of snow laid with a small brush, all running flat to the horizon
local KEEP = -(CROSSM + FIGM):grow(0.8)
local pn = noise{seed=201, octaves=4, period=260, stretch={0.0, 45}, warp={300, 1.5}}
local function tpond(x, y) return clamp((y - shore(x)) / (bank(x) - shore(x)), 0, 1) end
POLISH = mask(function(x, y) local t = tpond(x, y)
  return smoothstep(0.6, 0.66, pn:at01(x, y) + 0.08*t) * (0.6 + 0.4*t) end) * POND * KEEP
glaze(POLISH:blur(0.6), {color="#4b5663", coats=0.4})
-- snow lines: short and long dry strokes of a small round, flat, lighter toward the far shore
local sb = brush{kind="round", width=1.6}
for i = 1, 150 do
  local x = rand(-20, 1000)
  local t = rand()^1.4
  local y = lerp(shore(x) + 3, bank(x) + 2, t)
  if i % 6 == 1 then sb:reload(mix(mix("#d2c8bd", "#aeb2ba", t), "#8e949c", rand(0.15, 0.4)), rand(0.3, 0.55)) end
  local L = rand(20, 110) * (1 - 0.4*t)
  local pts = {{x, y}, {x + L/2, y + randn(0, 0.35)}, {x + L, y + randn(0, 0.5)}}
  sb:stroke(pts, {pressure={0.05, rand(0.2, 0.45), 0.03}, ramps={rand(0.3, 0.5), rand(0.35, 0.6)}, clip=POND * KEEP})
end
