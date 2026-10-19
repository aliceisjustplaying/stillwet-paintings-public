pA2 = pile{{"lead white",3},{"smalt",2.5},{"Prussian blue",0.2},{"red earth",0.08}}
pB2 = pile{{"lead white",5},{"smalt",1.3},{"vermilion",0.12},{"yellow ochre",0.1}}
pD2 = pile{{"lead white",4},{"chrome yellow",1.1},{"vermilion",0.4},{"red earth",0.08}}
local opt = function(p, cov) return {hand="body", tool="filbert 14", pile=p, angle=0.02, angle_jitter=0.1, coverage=cov, fill=true, length={70,180}} end
work(skyA:shrink(4), opt(pA2, 2.5))
work(skyB:shrink(4), opt(pB2, 2))
work(skyD:shrink(3), opt(pD2, 2.5))
