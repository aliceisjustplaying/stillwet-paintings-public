-- a cool dusk glaze over the near ground: darkens the snow toward us and dulls the golden grass
fgGlaze2 = pile{{"smalt",2.5},{"bone black",0.3},{"red earth",0.12},{"lead white",0.5}, medium=0.78}
local m = landm * mask(function(x, y) return y > 505 and 1 or 0 end) - sprMask:grow(2) - figM:grow(1)
work(m, {hand="glaze", pile=fgGlaze2, angle=0, angle_jitter=0.04, clip=true,
   load_at=function(x, y) local t = smoothstep(505, 714, y); return 0.04 + 0.6 * t ^ 1.3 end,
   pressure={0.3, 0.5}, coverage=1.6, seed=741})
blend(m, {angle=0})
