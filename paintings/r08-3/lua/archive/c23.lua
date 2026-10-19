-- a last veil of stippled sky over the upper sky to quiet the streaks, then a thin smalt glaze deepening toward the top
local vary = noise{seed=171, period=110, octaves=3}
local up = mask(function(x, y) return 1 - smoothstep(150, 260, y) end) - oak:mask():grow(2)
stipple(up, {width=2.4, pal=skypal, color=function(x, y) return shift(skycol(x, y), 0.005 * vary(x, y), 0, -0.004) end,
  coverage=function(x, y) return 1.5 + 0.6 * vary:at01(x, y) end, pressure={0.45, 0.85}, dips={18, 0.35, 0.7}, medium=0.55, cluster={0.25, 6}, feather=0.6})
glaze(mask(function(x, y) return 0.25 + 0.75 * (1 - smoothstep(0, 300, y)) end), {color="#4f5776", coats=0.14})
