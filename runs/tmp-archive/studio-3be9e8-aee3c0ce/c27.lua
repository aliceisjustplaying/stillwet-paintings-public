lemon1 = ellipse(610,592,72,46):soften(1.5) + ribbon({{668,586},{681,584},{690,583}},{22,12,5}) + ribbon({{552,600},{542,601},{535,602}},{18,10,4})
lemon2 = poly({{652,560},{672,527},{720,515},{765,527},{782,550},{775,575},{720,590},{668,582}}, true) + ribbon({{775,548},{788,545},{796,544}},{20,11,5})
lemons = lemon1 + lemon2
lBase = pile{{"chrome yellow",3},{"lead white",1},{"yellow ochre",0.3}}
local b = brush("filbert", 8)
work(lemon2 - lemon1, {tool=b, pile=lBase, coverage=2.5, angle=function(x,y) return lf:across(x,y) end, length={15,35}, edge="firm", clip=true, fill=true})
work(lemon1, {tool=b, pile=lBase, coverage=2.5, angle=function(x,y) return lf:across(x,y) end, length={15,35}, edge="firm", clip=true, fill=true})
