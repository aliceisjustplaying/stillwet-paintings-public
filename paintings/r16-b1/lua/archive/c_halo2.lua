local halo = ellipse(156, 448, 34, 22):roughen(2, 8, 1301) - foliM:grow(0.3) - riverC:grow(0.6) - oakM2:grow(1)
hillMist = pile{{"lead white", 6}, {"smalt", 1.8}, {"vermilion", 0.2}, {"raw umber", 0.35}, medium=0.2}
farMist = pile{{"lead white", 2.6}, {"green earth", 2.6}, {"smalt", 0.9}, {"raw umber", 0.9}, medium=0.15}
nearMist = pile{{"green earth", 2}, {"yellow ochre", 1.2}, {"lead white", 1.2}, {"raw umber", 0.8}, {"smalt", 0.2}, medium=0.15}
local A = halo * mask(function(x, y) return y < flatY(x) - 0.5 and 1 or 0 end)
local B = halo * mask(function(x, y) return (y >= flatY(x) - 0.5 and y < 453) and 1 or 0 end)
local C = halo * mask(function(x, y) return y >= 453 and 1 or 0 end)
work(A, {hand="detail", pile=hillMist, angle=0, coverage=3.5, fill=true, clip=true, length={4,10}})
work(B, {hand="detail", pile=farMist, angle=0, coverage=3.5, fill=true, clip=true, length={4,10}})
work(C, {hand="detail", pile=nearMist, angle=0, coverage=3.5, fill=true, clip=true, length={4,10}})
blend(A, {angle=0, coverage=2, length={8,20}, tool="badger 12", clip=true})
blend(B + C, {angle=0, coverage=2, length={8,20}, tool="badger 12", clip=true})
