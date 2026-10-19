-- a second, stronger dusk glaze on the near ground: deepen the foreground so the eye goes to the lit distance
fgGlaze3 = pile{{"smalt",2.2},{"bone black",0.45},{"red earth",0.15},{"raw umber",0.2},{"lead white",0.25}, medium=0.8}
local n = noise{seed=821, period=120, octaves=3}
local m = landm * mask(function(x, y) return y > 600 and 1 or 0 end) - postM:grow(1.5) - merem:grow(1)
work(m, {hand="glaze", pile=fgGlaze3, angle=0.05, angle_jitter=0.05, clip=true,
   load_at=function(x, y) local t = smoothstep(605, 714, y); return (0.05 + 0.6 * t) * (0.8 + 0.3 * n(x, y)) end,
   pressure={0.3, 0.5}, coverage=1.6, seed=822})
