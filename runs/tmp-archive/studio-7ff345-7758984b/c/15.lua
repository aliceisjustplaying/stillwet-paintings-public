landglaze = pile{{"smalt",3},{"bone black",0.35},{"lead white",0.8},{"red earth",0.1}, medium=0.75}
work(landm * rect(-20, 440, 1040, 300), {hand="glaze", pile=landglaze, angle=0, angle_jitter=0.03,
   load_at=function(x, y) local t = smoothstep(480, 714, y); return 0.03 + 0.75 * t end,
   pressure={0.3, 0.5}, coverage=1.6, seed=151})
blend(landm * rect(-20, 440, 1040, 300), {angle=0})
