bgMid = pile{{"raw umber",2},{"bone black",0.5},{"yellow ochre",1},{"green earth",1},{"lead white",0.8}, medium=0.1}
local m = wall - jug:grow(2)
local zone = mask(function(x,y) local d = math.sqrt(((x-760)/420)^2 + ((y-260)/330)^2); return clamp(1.3 - d, 0, 1) end) * m
work(zone, {hand="body", tool="filbert 14", pile=bgMid, coverage=1.5, threshold=0.2, angle=function(x,y) return 1.0 + 0.3*math.sin(x/140) end, edge="soft", length={30,70}})
blend(zone:grow(30) * m, {angle=0.4})
blend(zone:grow(30) * m, {angle=2.0})
