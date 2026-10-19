gz3 = pile{{"raw umber",1},{"bone black",0.25},{"green earth",0.5},{"red earth",0.1}, medium=0.62}
local base = marsh - creek:grow(1.5)
local g1 = base * below(function(x) return 538 + 10*math.sin(x/71) end)
local g2 = base * mask(function(x,y) local d = (y-640)/80 + math.abs(x-560)/700; return d > 0.45 and 1 or 0 end)
work(g1, {hand="glaze", pile=gz3, angle=0.02, coverage=1.2, clip=g1})
work(g2, {hand="glaze", pile=gz3, angle=-0.04, coverage=1.0, clip=g2})
local bm = base * below(function(x) return 530 + 10*math.sin(x/71) end)
blend(bm, {angle=0}); blend(bm, {angle=-0.15})
