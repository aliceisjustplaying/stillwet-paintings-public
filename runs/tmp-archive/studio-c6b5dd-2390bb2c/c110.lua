print(wait(24*60))
local T = trees + shrubM
rimM = (T - T:shrink(5)) * mask(function(x,y) return (T:at(x+9, y-3) < 0.5) and 1 or 0 end) * rect(0, 30, 520, 410) - rect(200,140,80,50)
pRim = pile{{"yellow ochre",2},{"red earth",0.4},{"lead white",0.8},{"chrome yellow",0.3},{"raw umber",0.3}}
stipple(rimM, {pile=pRim, width=2.5, coverage=0.45, pressure={0.3,0.6}, dips={10,0.6,0.3}, drag={1.5, 0.3}, twist=0.6, cluster={0.7,6}, feather=0.5})
