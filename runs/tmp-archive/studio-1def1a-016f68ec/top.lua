topGlaze = pile{{"smalt",1},{"raw umber",0.5},{"red earth",0.15},{"lead white",0.2}, medium=0.75}
local topm = mask(function(x,y) return clamp((90 - y)/50, 0, 1) end)
work(topm, {hand="glaze", pile=topGlaze, angle=0.02, coverage=1.0})
blend(rect(0,0,1000,120), {angle=0.02})
blend(rect(0,0,1000,130), {angle=-0.02})
