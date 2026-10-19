-- deepen the upper sky toward the zenith of a winter dusk, keeping the young moon clear
skyGlaze2 = pile{{"smalt",3},{"bone black",0.3},{"red earth",0.12},{"vermilion",0.04},{"lead white",0.4}, medium=0.8}
local m = rect(-20, -20, 1040, 360) - moonM:grow(1.2)
work(m, {hand="glaze", pile=skyGlaze2, angle=0, angle_jitter=0.03, clip=true,
   load_at=function(x, y) local t = 1 - smoothstep(-10, 340, y); return 0.02 + 0.75 * t * t end,
   pressure={0.3, 0.5}, coverage=1.6, seed=641})
blend(m, {angle=0})
blend(m, {angle=0.05})
