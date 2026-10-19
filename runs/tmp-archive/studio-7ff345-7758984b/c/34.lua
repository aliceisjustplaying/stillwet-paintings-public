iceGlaze = pile{{"smalt",2},{"Prussian blue",0.15},{"bone black",0.35},{"lead white",0.5}, medium=0.7}
work(merem, {hand="glaze", tool="filbert 10", pile=iceGlaze, angle=0, angle_jitter=0.01, clip=true,
   load_at=function(x, y) local t = smoothstep(552, 598, y); return 0.08 + 0.7 * t end,
   pressure={0.3, 0.5}, coverage=1.8, length={60, 160}, seed=341})
blend(merem, {angle=0})
