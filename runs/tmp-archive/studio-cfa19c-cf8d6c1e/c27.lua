riverM = poly({{1010,527},{900,514},{780,499},{680,481},{600,467},{520,457},{440,449.5},{380,446.5},{330,445},{330,445.6},{380,448.5},{440,455},{510,465},{590,478},{670,495},{770,515},{890,533},{1010,550}}, true)
local land = below(function(x) return 446 end) - farM:shrink(1)
g1 = pile{{"lead white",4},{"green earth",2},{"pale smalt",1},{"yellow ochre",1.2}, medium=0.08}
g2 = pile{{"yellow ochre",3},{"Prussian blue",0.25},{"lead white",2},{"green earth",1}, medium=0.08}
g3 = pile{{"yellow ochre",3},{"Prussian blue",0.45},{"lead white",1},{"raw umber",0.3}, medium=0.08}
local z1 = (land * rect(-10,440,1020,42)) - riverM
local z2 = (land * rect(-10,476,1020,70)) - riverM - riseM
local z3 = (land * rect(-10,538,1020,190)) - riverM - riseM
work(z1, {hand="body", tool="filbert 6", pile=g1, angle=0, angle_jitter=0.03, coverage=2.2, fill=true, pressure={0.45,0.65}, seed=161})
work(z2, {hand="body", tool="filbert 8", pile=g2, angle=function(x,y) return 0.12*math.sin(x/260)+0.02 end, coverage=2.2, fill=true, pressure={0.45,0.7}, seed=162})
work(z3, {hand="body", tool="filbert 10", pile=g3, angle=function(x,y) return 0.18 end, coverage=2.2, fill=true, pressure={0.45,0.7}, seed=163})
blend((land - riverM - riseM) * rect(-10,440,1020,280), {angle=0.03, coverage=1.2, seed=164})
