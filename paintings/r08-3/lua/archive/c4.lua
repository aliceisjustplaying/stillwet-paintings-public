wait(40)
local vary = noise{seed=41, period=90, octaves=3}
stipple(above(function(x) return HZ + 4 end), {width=2.6, pal=skypal,
  color=function(x, y) return shift(skycol(x, y), 0.012 * vary(x, y), 0.004 * vary(y, x), 0) end,
  coverage=function(x, y) return 1.6 + 0.8 * vary:at01(x, y) end,
  pressure={0.45, 0.85}, dips={18, 0.35, 0.7}, medium=0.55, cluster={0.25, 6}, feather=0.6})
