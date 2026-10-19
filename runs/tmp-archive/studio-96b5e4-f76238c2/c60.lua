s_top2 = pile{{"lead white",2},{"smalt",1},{"cobalt blue",0.6},{"raw umber",0.4},{"red earth",0.06}, medium=0.15}
local T = rect(0,0,1000,70)
work(T, {hand="broad", pile=s_top2, angle=function(x,y) return 0.03*math.sin(x/170+1) end, coverage=1.6, tool="filbert 14", load_at=function(x,y) return clamp(0.6*(1 - y/70)^1.3, 0.02, 0.6) end, pressure={0.35,0.6}})
local BT = rect(0,0,1000,110)
blend(BT, {angle=0}); blend(BT, {angle=-0.08})
