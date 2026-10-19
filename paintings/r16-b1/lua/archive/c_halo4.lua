local halo = ellipse(156, 448, 34, 22):roughen(2, 8, 1301) - foliM:grow(0.3) - riverC:grow(0.6) - oakM2:grow(1)
local C = halo * mask(function(x, y) return y >= 453 and 1 or 0 end)
nearMist3 = pile{{"green earth", 2}, {"yellow ochre", 1.1}, {"lead white", 1.6}, {"raw umber", 0.85}, {"smalt", 0.3}, medium=0.15}
work(C, {hand="detail", pile=nearMist3, angle=0, coverage=3.5, fill=true, clip=true, length={4,10}})
blend(C, {angle=0, coverage=2, length={8,20}, tool="badger 12", clip=true})
