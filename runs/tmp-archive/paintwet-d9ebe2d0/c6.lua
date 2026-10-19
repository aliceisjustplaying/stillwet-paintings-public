-- the sky, same sitting: unequal horizontal bands of thin paint brought down over the wet range top
-- (it overlaps the crest by 3 units) and 14 units into the promontory, where the firs will stand over it.
gn = noise{seed=17, octaves=3, period=260}
glow = function(x, y)
  local gx = math.exp(-((x - SUNX)/(300 + 70*gn(x, 0)))^2)
  return gx * smoothstep(HZ - 330, HZ - 20, y)
end
skycol = function(x, y)
  local t = clamp(y / HZ, 0, 1)
  local c = gradient({{0,"#47536c"},{0.25,"#5f6a82"},{0.5,"#8b8d9c"},{0.66,"#a8999c"},{0.8,"#c6b39e"},{1,"#d2bd98"}}, t)
  return mix(c, "#ecd49e", 0.6*glow(x, y))
end
sn = noise{seed=31, octaves=3, period=190, stretch={0, 7}}
skyB = function(x, y) local v = sn(x, y) return shift(skycol(x, y), 0.02*v, 0.003*v, 0.008*v) end
skyS = mask(function(x, y) return y < crest(x) + 3 and 1 or 0 end) - promM:shrink(14)
work(skyS, {hand="broad", color=skyB, angle=0, angle_jitter=0.02, length={120, 320}, coverage=3.8, medium=0.3, load=0.75,
  pal=skypal, clip=skyS:grow(2):blur(1.5)})
blend(skyS, {angle=0, coverage=1.2, length={150, 400}, clip=skyS:grow(1):blur(1)})
local t = timesheet() print(string.format("%.0f min this sitting", t.sitting))
