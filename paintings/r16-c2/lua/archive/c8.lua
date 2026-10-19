mudDark = pile{{"raw umber",2},{"red earth",0.4},{"bone black",0.3},{"lead white",0.4}, medium=0.1}
mudMid = pile{{"raw umber",1.5},{"red earth",0.4},{"lead white",1},{"cobalt blue",0.2}, medium=0.1}
barP = pile{{"raw umber",1},{"lead white",1.3},{"cobalt blue",0.35},{"red earth",0.25}}
work(mudL, {hand="body", tool="filbert 10", pile=mudDark, angle=function(x,y) return 0.12 + 0.3*(x/600) end, coverage=2.5, length={30,80}, fill=true, edge={found=0.5, soft=0.4, lost=0.1, period=50}})
work(mudR, {hand="body", tool="filbert 10", pile=mudDark, angle=-0.25, coverage=2.5, length={30,80}, fill=true, edge={found=0.5, soft=0.5, period=50}})
work(bar, {hand="detail", tool="round 4", pile=barP, angle=0, coverage=2, length={10,30}, fill=true})
work(barR, {hand="detail", tool="round 5", pile=barP, angle=-0.03, coverage=2, length={10,30}, fill=true})
