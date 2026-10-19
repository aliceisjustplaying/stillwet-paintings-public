local band = (col:grow(12) * below(function(x) return 477 end)) - refl2:grow(1)
local z1 = band * above(function(x) return 522 end)
local z2 = band * below(function(x) return 522 end) * above(function(x) return 612 end)
local z3 = band * below(function(x) return 612 end)
fA2 = pile{{"lead white",4},{"chrome yellow",1.0},{"vermilion",0.25},{"raw umber",0.12}}
fB2 = pile{{"lead white",4},{"smalt",0.9},{"vermilion",0.15},{"red earth",0.15},{"raw umber",0.15}}
fC2 = pile{{"lead white",3},{"smalt",1.3},{"Prussian blue",0.03},{"raw umber",0.3}}
local o = function(p) return {hand="body", tool="filbert 8", pile=p, angle=0, angle_jitter=0.03, coverage=2.5, load=0.8, fill=true, length={25,50}, clip=true, pressure={0.4,0.7}} end
work(z1, o(fA2)); work(z2, o(fB2)); work(z3, o(fC2))
blend(band:grow(6) - refl2:grow(2), {angle=0, angle_jitter=0.02, tool="badger 16", length={30,60}})
blend((band * (rect(0,510,1000,24) + rect(0,600,1000,24))):grow(4) - refl2:grow(2), {angle=1.5, tool="badger 10", length={12,26}})
