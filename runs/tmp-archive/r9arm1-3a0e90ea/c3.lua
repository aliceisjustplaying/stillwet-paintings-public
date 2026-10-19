skyn = noise{seed=17, octaves=3, period=380, stretch={0.02, 5}}
GLOW = 250
function skycol(x, y)
  local t = clamp(y / HZ, 0, 1)
  local g = math.exp(-((x - GLOW) / 330)^2)           -- where the sun went down
  local band = skyn(x, y) * 0.04
  local c = gradient({{0, "#5d6c86"}, {0.35, "#8190a6"}, {0.62, "#b1b3bb"}, {0.8, "#cdbfb6"}, {1, "#dcc8ae"}}, t + band)
  local warm = gradient({{0, "#6c7890"}, {0.45, "#a4a8b4"}, {0.7, "#d9c7b0"}, {0.88, "#ecd7a8"}, {1, "#f0dca6"}}, t + band)
  return mix(c, warm, g * smoothstep(0.2, 0.9, t) * 0.9)
end
skym = above(function(x) return farline(x) + 10 end)
work(skym, {hand="broad", color=skycol, angle=function(x, y) return 0.02 * skyn(x * 2, y) end, coverage=4.5, medium=0.28, length={80, 240}})
blend(skym, {angle=0.01})
