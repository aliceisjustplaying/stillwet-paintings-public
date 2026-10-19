fgGlz = pile{{"smalt",2},{"raw umber",0.3},{"red earth",0.12}, medium=0.75}
local m1 = below(function(x) return 600 + 12*math.sin(x/140) end)
work(m1, {hand="glaze", pile=fgGlz, angle=0.0, coverage=1.2, angle_jitter=0.05})
blend(m1:grow(-2), {angle=0})
