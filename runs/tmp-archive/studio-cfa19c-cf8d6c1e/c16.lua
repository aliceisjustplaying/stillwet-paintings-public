cg = pile{{"lead white",4},{"smalt",2},{"red earth",0.35},{"raw umber",0.25}, medium=0.25}
local sh = cloudF:shadow{soft=0.25} * rect(0,0,1000,404)
work(sh, {hand="body", tool="filbert 7", pile=cg, angle=function(x,y) return cloudF:across(x,y) end, coverage=1.8, fill=true, pressure={0.35,0.6}, edge="soft", seed=81})
-- the flat underside: a band of deeper grey along the base
local base = (cloudM * rect(0,372,1000,34)):soften(4)
work(base, {hand="body", tool="filbert 6", pile=cg, angle=0.02, coverage=1.5, pressure={0.35,0.55}, edge="soft", seed=82})
blend(cloudM, {angle=0.1, coverage=1.2, seed=83})
