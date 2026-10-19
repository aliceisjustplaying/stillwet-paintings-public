gz2 = pile{{"raw umber",1},{"bone black",0.35},{"green earth",0.6}, medium=0.6}
local base = marsh - creek:grow(1.5)
local g1 = base * below(function(x) return 560 + 10*math.sin(x/71) end)
local g2 = base * mask(function(x,y) local d = (y-620)/90 + math.abs(x-560)/900; return d > 0.35 and 1 or 0 end)
work(g1, {hand="glaze", pile=gz2, angle=0.03, coverage=1.3, clip=g1})
work(g2, {hand="glaze", pile=gz2, angle=-0.05, coverage=1.4, clip=g2})
local bm = base * below(function(x) return 545 + 10*math.sin(x/71) end)
blend(bm, {angle=0}); blend(bm, {angle=0.2})
