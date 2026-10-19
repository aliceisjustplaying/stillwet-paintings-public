wait(24*60)
local snow = SNOW - STREAMM:shrink(1.5)
work(snow, {hand="body", tool="filbert 6", color=snowcol, medium=0.14, coverage=5.5, load=0.95, length={24, 80},
  angle=function(x, y) local d = clamp((y - HZ) / (H - HZ), 0, 1); return 0.02 + d * 0.22 * drift(x * 1.3, y + 40) end,
  angle_jitter=0.06, pressure={0.8, 0.6}})
blend(snow * below(function(x) return HZ + 40 end), {angle=0.02, coverage=1.2})
