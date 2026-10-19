local R = riverM
local rA = pile{{"lead white",9},{"pale smalt",0.9},{"yellow ochre",0.3}, medium=0.07}
local rB = pile{{"lead white",7},{"pale smalt",1.5},{"cobalt blue",0.35},{"yellow ochre",0.05}, medium=0.07}
local rC = pile{{"lead white",5.5},{"pale smalt",1.5},{"cobalt blue",0.7},{"smalt",0.2}, medium=0.07}
-- far part reflects the pale horizon, the near part the bluer sky higher up
work(R * mask(function(x,y) return smoothstep(640,560,x) end), {hand="body", tool="filbert 3", pile=rA, angle=0.12, coverage=2.6, fill=true, clip=true, pressure={0.45,0.7}, seed=461})
work(R * mask(function(x,y) return smoothstep(560,640,x)*smoothstep(860,780,x) end), {hand="body", tool="filbert 3", pile=rB, angle=0.15, coverage=2.6, fill=true, clip=true, pressure={0.45,0.7}, seed=462})
work(R * mask(function(x,y) return smoothstep(780,860,x) end), {hand="body", tool="filbert 4", pile=rC, angle=0.15, coverage=2.6, fill=true, clip=true, pressure={0.45,0.7}, seed=463})
blend(R:shrink(0.5), {tool={kind="badger", width=10}, angle=0.14, coverage=1.2, seed=464})
