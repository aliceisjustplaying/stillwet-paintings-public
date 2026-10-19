rest(16); sitting{hours=6}
-- the foreground sunk: transparent umber and a little black, deeper toward the bottom edge, uneven
local gn = noise{seed=161, period=150}
local fg = mask(function(x, y)
  local t = smoothstep(bankTop(x) + 30, 714, y)
  return clamp(t * (0.75 + 0.35 * gn(x, y)), 0, 1)
end)
glaze(fg, {color="#2e2618", coats=0.45, pigment="transparent"})
-- the strip under the willow's foot, a shade deeper
local foot = mask(function(x, y) return math.exp(-((x - 508) / 75) ^ 2) * math.exp(-((y - 618) / 14) ^ 2) end)
glaze(foot, {color="#2a2419", coats=0.3, pigment="transparent"})
