skyglaze = pile{{"smalt",3},{"bone black",0.25},{"lead white",0.6},{"red earth",0.08}, medium=0.8}
work(rect(-20, -20, 1040, 300), {hand="glaze", pile=skyglaze, angle=0, angle_jitter=0.03,
   load_at=function(x, y) local t = 1 - smoothstep(-10, 290, y); return 0.02 + 0.7 * t * t end,
   pressure={0.3, 0.5}, coverage=1.6, seed=71})
blend(rect(-20, -20, 1040, 320), {angle=0})
