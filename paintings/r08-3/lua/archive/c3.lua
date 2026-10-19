skypal = pal:only{"lead white", "smalt", "pale smalt", "red earth", "yellow ochre", "vermilion", "raw umber"}
local glowx = 690
skycol = function(x, y)
  local t = y / HZ
  local g = math.exp(-((x - glowx) / 330)^2)
  local c = gradient({{0, "#5f6680"}, {0.3, "#7f8399"}, {0.55, "#a8a3ad"}, {0.78, "#cdb8b4"}, {0.92, "#dfcbb3"}, {1, "#e4d6b6"}}, t)
  return mix(c, "#ecdcb4", 0.35 * g * smoothstep(0.55, 1, t))
end
skym = above(function(x) return HZ + 14 end)
work(skym, {hand="broad", color=skycol, angle=function(x, y) return 0.03 * math.sin(x / 140 + y / 90) end,
  coverage=5, medium=0.3, load=0.8, pal=skypal, length={60, 180}})
-- no blend: the stipple will fuse it
