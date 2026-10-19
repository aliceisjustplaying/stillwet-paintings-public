local drift = below(function(x) return 439.5 + (x - 158) * 0.5 end)
local patch = (ellipse(184, 456, 32, 13) * drift):soften(2.5)
stipple(patch, {width=1.8, pal=snowpal, color=function(x, y) return mix("#cdcecf", "#c6c8cc", smoothstep(440, 475, y)) end, coverage=2.2,
  pressure={0.45, 0.85}, dips={14, 0.4, 0.7}, medium=0.3, cluster={0.2, 4}, feather=0.7})
