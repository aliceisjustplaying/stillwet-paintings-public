print(wait(30*60))
hedgeD = pile{{"green earth", 2.5}, {"raw umber", 1.0}, {"lead white", 0.9}, {"pale smalt", 0.7}, {"yellow ochre", 0.5}, {"Prussian blue", 0.06}, medium=0.1}
local h = hedgerow:shrink(0.4)
stipple(h, {pile=hedgeD, width=1.7, coverage=4, pressure={0.4,0.7}, clip=hedgerow, cluster=0.3})
-- sunlit tops, upper left edges of the clumps
local tops = hedgerow - hedgerow:offset(-1.6) 
local lit = tops * mask(function(x,y) return 1 end)
stipple(lit, {pile=hedgeFL, width=1.4, coverage=1.2, pressure={0.35,0.55}, clip=hedgerow, cluster={0.6, 5}, feather=0.6})
print(wait(0))
