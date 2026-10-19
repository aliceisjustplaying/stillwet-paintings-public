thatch = pile{{"raw umber", 1.5}, {"yellow ochre", 1.2}, {"lead white", 2.0}, {"pale smalt", 0.8}, {"red earth", 0.2}, medium=0.1}
thatchL = pile{{"yellow ochre", 1.5}, {"raw umber", 0.8}, {"lead white", 3.0}, {"pale smalt", 0.4}, {"red earth", 0.15}, medium=0.1}
wallW = pile{{"lead white", 6}, {"yellow ochre", 0.3}, {"pale smalt", 0.35}, medium=0.1}
wallS = pile{{"lead white", 3}, {"pale smalt", 1}, {"raw umber", 0.5}, medium=0.1}
hedge = pile{{"green earth", 2.5}, {"raw umber", 0.9}, {"lead white", 1.2}, {"pale smalt", 0.7}, {"yellow ochre", 0.5}, medium=0.1}
roof = poly({{54,462},{68,447},{150,445},{162,459},{162,463},{54,464}})
roofEnd = poly({{54,462},{68,447},{75,447},{66,463}})
walls = rect(57, 462, 103, 8)
gableLit = rect(57, 462, 12, 8)
work(roof, {hand="detail", pile=thatch, angle=0.0, coverage=2.5, length={3,9}, fill=true, clip=true, edge="found"})
work(roofEnd, {hand="detail", pile=thatchL, angle=-0.8, coverage=2.2, length={2,6}, fill=true, clip=true, edge="found"})
work(walls, {hand="detail", pile=wallS, angle=0, coverage=2.5, length={2,6}, fill=true, clip=true, edge="found"})
work(gableLit, {hand="detail", pile=wallW, angle=0, coverage=2.5, length={2,5}, fill=true, clip=true, edge="found"})
-- a hedge along the yard, a dark low mass
local hm = poly({{0,472},{0,462},{12,460},{25,462},{38,459},{52,463},{56,471}}, true) + poly({{160,471},{162,463},{175,461},{190,463},{205,460},{222,463},{232,468},{234,473}}, true)
hm = hm:roughen(1.2, 4, 91)
stipple(hm, {pile=hedge, width=2.0, coverage=4, pressure={0.4,0.7}, clip=hm, cluster=0.3})
print(wait(0))
