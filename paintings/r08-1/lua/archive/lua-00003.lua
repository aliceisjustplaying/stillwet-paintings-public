-- the sky, first lay-in: thin, long horizontal passes, cold above, warm at the horizon
skyn = noise{seed=51, octaves=3, period=340, stretch={0.05, 5}}
function skycol(x, y)
  local t = clamp(y / (HZ - 10), 0, 1) + 0.03*skyn(x, y)
  return gradient({{0, "#667891"}, {0.28, "#8795a8"}, {0.55, "#a9b2b3"}, {0.74, "#c7c6b2"}, {0.88, "#dccbab"}, {1, "#e2c1a0"}}, t)
end
SKYM = above(function(x) return hills(x) + 8 end)
work(SKYM, {hand="broad", color=skycol, angle=function(x, y) return 0.02*skyn(y, x) end, coverage=4.2, medium=0.3})
blend(SKYM, {angle=0})
