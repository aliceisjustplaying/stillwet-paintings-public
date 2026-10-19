pathS = pile{{"lead white",3},{"raw umber",0.7},{"yellow ochre",0.8},{"pale smalt",0.35},{"green earth",0.2}, medium=0.1}
pathS2 = pile{{"lead white",4},{"raw umber",0.5},{"yellow ochre",0.9},{"pale smalt",0.2}, medium=0.1}
pathSh = pile{{"lead white",1.5},{"raw umber",0.9},{"yellow ochre",0.5},{"pale smalt",0.4},{"green earth",0.4}, medium=0.1}
work(PATH:grow(1.5), {hand="body", pile=pathS, tool="filbert 5", angle=-1.0, length={8,20}, coverage=2.0, fill=true, clip=true, edge="found"})
blend(PATH:grow(1.5), {angle=-1.0, coverage=1.2, tool={kind="badger", width=12}})
-- lit patches: dry-ish sand in the middle distance
local lit = PATH * mask(function(x,y) return smoothstep(0.45,0.65, noise{seed=19,period=24}:at01(x,y*1.6)) end)
work(lit, {hand="scumble", pile=pathS2, tool="filbert 4", coverage=1.0, clip=PATH, load=0.35})
print(wait(0))
