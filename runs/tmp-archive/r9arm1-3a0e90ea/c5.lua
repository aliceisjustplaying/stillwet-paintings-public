wait(24*60)
local bandn = noise{seed=5, octaves=5, period=26}
BAND = (below(function(x) return farline(x) + 1.5 * bandn(x, 0) end) * above(function(x) return HZ + 4 end)):roughen(0.6, 9, 3, 0.5)
work(BAND, {hand="body", tool="filbert 2.5", length={5, 16}, coverage=4.5, medium=0.2, angle=0.0, angle_jitter=0.08, pressure={0.7, 0.6},
  edge={found=0.15, soft=0.6, lost=0.25, period=30, seed=4},
  color=function(x, y)
    local g = math.exp(-((x - GLOW) / 300)^2)
    return mix(mix("#7b7580", "#978c8b", g), "#a7a3aa", smoothstep(HZ - 14, HZ + 4, y) * 0.55)
  end})
blend(BAND, {angle=0, coverage=1.2})
