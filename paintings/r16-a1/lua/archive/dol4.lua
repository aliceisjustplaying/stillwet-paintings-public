rkA = pile{{"raw umber",2},{"bone black",0.8},{"smalt",0.6},{"lead white",0.12}, medium=0.05}
rkB = pile{{"raw umber",2},{"red earth",0.3},{"bone black",0.5},{"lead white",0.25}, medium=0.05}
rkC = pile{{"lead white",1.2},{"raw umber",1},{"smalt",0.7},{"bone black",0.2}, medium=0.05}
work(UPM + CAPM, {hand="detail", pile=rkA, coverage=3, fill=true, angle=math.pi/2, load=1, pressure={0.6,0.9}})
-- warm patches and cooler facets, granite blotches
local n = noise{seed=5, period=18, octaves=3}
stipple(UPM + CAPM, {pile=rkB, width=3, coverage=function(x,y) return 0.8*clamp(n(x,y)+0.2,0,1) end, pressure={0.4,0.7}})
-- upper face of the capstone catches cool skylight
local capTop = CAPM * above(function(x) return 452 + 4*math.sin(x/23) end)
work(capTop, {hand="detail", pile=rkC, coverage=1.5, fill=false, angle=0.05, pressure={0.3,0.6}})
