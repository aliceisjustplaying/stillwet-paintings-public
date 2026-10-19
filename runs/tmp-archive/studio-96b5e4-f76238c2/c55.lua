s_top = pile{{"lead white",2.5},{"smalt",1},{"cobalt blue",0.5},{"raw umber",0.35},{"red earth",0.05}, medium=0.15}
local T = rect(0,0,1000,85)
work(T, {hand="broad", pile=s_top, angle=function(x,y) return 0.03*math.sin(x/150) end, coverage=1.6, tool="filbert 14", load_at=function(x,y) return clamp(0.55*(1 - y/85), 0.03, 0.55) end, pressure={0.35,0.6}})
local BT = rect(0,0,1000,125)
blend(BT, {angle=0}); blend(BT, {angle=0.1})
