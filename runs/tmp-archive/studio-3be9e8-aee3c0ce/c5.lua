bgOlive = pile{{"raw umber",2},{"bone black",0.7},{"yellow ochre",0.8},{"green earth",1},{"lead white",0.4}, medium=0.1}
bgLight = pile{{"raw umber",2},{"yellow ochre",1.2},{"green earth",0.8},{"lead white",1.4},{"bone black",0.2}, medium=0.1}
local m = wall - jug:grow(2)
work(m, {hand="body", tool="filbert 14", pile=bgOlive, coverage=1.6, angle=function(x,y) return 0.9 + 0.4*math.sin(x/170 + y/230) end, edge="firm", fill=true, length={30,80}})
local n = noise{seed=5, period=180}
local light = mask(function(x,y) local d = math.sqrt(((x-760)/330)^2 + ((y-250)/260)^2); return clamp(1.1 - d + 0.25*n(x,y), 0, 1) end) * m
work(light, {hand="scumble", tool="filbert 14", pile=bgLight, coverage=1.2, threshold=0.25, edge="soft"})
blend(m, {angle=0.9})
