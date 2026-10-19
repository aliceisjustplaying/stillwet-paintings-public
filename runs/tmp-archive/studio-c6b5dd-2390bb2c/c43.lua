pCore = pile{{"lead white",1.6},{"smalt",1},{"red earth",0.5},{"raw umber",0.35}}
local cores = (cloudM:shrink(5)) * mask(function(x,y) return 1 end)
work(cores, {hand="body", tool="filbert 5", pile=pCore, angle=0, angle_jitter=0.03, coverage=1.3, load=0.6, length={60,200}, pressure={0.15,0.45}, edge="soft"})
