print(wait(60*24))
local g2 = pile{{"raw umber",1},{"bone black",0.4},{"lead white",1.0},{"pale smalt",0.35}, medium=0.05}
local g3 = pile{{"raw umber",1},{"bone black",0.5},{"lead white",0.5},{"pale smalt",0.3},{"green earth",0.3}, medium=0.05}
local ang = stF:field("across")
local lower = stoneM * mask(function(x,y) return smoothstep(-0.2, 0.45, (x-92)/60 + (y-676)/22) end)
local lower2 = stoneM * mask(function(x,y) return smoothstep(0.3, 0.9, (x-92)/60 + (y-676)/22) end)
work(lower, {hand="body", tool="filbert 3", pile=g2, angle=ang, coverage=2.6, fill=true, clip=true, pressure={0.5,0.75}, seed=3521})
work(lower2, {hand="body", tool="filbert 3", pile=g3, angle=ang, coverage=2.4, fill=true, clip=true, pressure={0.5,0.75}, seed=3522})
blend(stoneM:shrink(1), {tool={kind="badger", width=6}, angle=-0.6, coverage=0.8, clip=true, pressure={0.2,0.35}, seed=3523})
