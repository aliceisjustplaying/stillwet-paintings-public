kS = pile{{"lead white",5},{"pale smalt",1.5},{"smalt",0.25},{"red earth",0.18},{"raw umber",0.18},{"yellow ochre",0.1}, medium=0.06}
kM = pile{{"lead white",8},{"pale smalt",1.0},{"red earth",0.1},{"yellow ochre",0.25},{"raw umber",0.06}, medium=0.06}
kL = pile{{"lead white",14},{"yellow ochre",0.3},{"vermilion",0.03}, medium=0.05}
local ang = cloud2F:field("across")
work(cSz:grow(2) * cloudC, {hand="body", tool="filbert 5", pile=kS, angle=ang, length={10,28}, coverage=2.6, fill=true, clip=cloudC, pressure={0.5,0.75}, seed=3301})
work(cMz:grow(2) * cloudC, {hand="body", tool="filbert 5", pile=kM, angle=ang, length={10,28}, coverage=2.6, fill=true, clip=cloudC, pressure={0.5,0.75}, seed=3302})
work(cLz:grow(1) * cloudC, {hand="body", tool="filbert 5", pile=kL, angle=ang, length={10,28}, coverage=2.8, fill=true, clip=cloudC, pressure={0.5,0.75}, seed=3303})
