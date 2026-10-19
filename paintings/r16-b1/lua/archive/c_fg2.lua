stoneMid = pile{{"raw umber", 1.5}, {"bone black", 0.6}, {"lead white", 0.6}, {"smalt", 0.2}, {"green earth", 0.3}, medium=0.05}
work(boulderM, {hand="body", pile=stoneMid, angle=-0.3, coverage=3, fill=true, clip=true, length={4,10}, tool="filbert 4"})
local low = boulderM * mask(function(x, y) return (y > 645 + math.abs(x - 815) * 0.12) and 1 or 0 end)
work(low, {hand="body", pile=stoneD, angle=-0.2, coverage=3, fill=true, clip=true, length={4,10}, tool="filbert 4"})
blend(boulderM, {angle=-1.2, coverage=1.5, length={8,20}, tool="badger 12"})
local top = (boulderM - boulderM:shrink(3.5)) * mask(function(x, y) return (y < 642) and 1 or 0 end)
work(top, {hand="detail", pile=stoneP, angle=0, coverage=2, clip=true, length={3,8}, pressure={0.3, 0.6}})
local top2 = (boulderM - boulderM:shrink(1.5)) * mask(function(x, y) return (y < 636) and 1 or 0 end)
work(top2, {hand="detail", pile=stoneLit, angle=0, coverage=1.2, clip=true, length={3,8}, pressure={0.25, 0.5}})
