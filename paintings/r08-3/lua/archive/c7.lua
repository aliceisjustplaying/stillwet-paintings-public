dry()
local hn = noise{seed=51, period=60, octaves=5}
farhill = function(x) return 447 - 13 * math.exp(-((x - 330) / 80)^2) - 7 * math.exp(-((x - 470)/50)^2) - 3*math.exp(-((x-250)/40)^2) + 1.6 * hn(x, 0) end
hills = below(farhill) * above(function(x) return HZ + 2 end) * mask(function(x, y) return smoothstep(170, 215, x) end)
stipple(hills, {width=2.2, pal=skypal, color=function(x, y) return mix("#a6a2b4", "#bab2b8", smoothstep(432, 452, y)) end,
  coverage=3.2, pressure={0.5, 0.9}, dips={14, 0.4, 0.7}, medium=0.45, cluster={0.2, 4}, feather=0.5})
