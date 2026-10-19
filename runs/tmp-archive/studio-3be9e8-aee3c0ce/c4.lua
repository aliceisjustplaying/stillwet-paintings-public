bgDark = pile{{"raw umber",3},{"bone black",1},{"red earth",0.6}, medium=0.2}
bgWarm = pile{{"raw umber",3},{"yellow ochre",1.2},{"lead white",0.6},{"bone black",0.4}, medium=0.15}
local n = noise{seed=11, period=300}
local m = wall - jug:grow(2)
work(m, {hand="broad", pile=bgDark, coverage=2.2, angle=function(x,y) return 0.6 + 0.5*n(x,y) end, edge="firm", fill=true})
