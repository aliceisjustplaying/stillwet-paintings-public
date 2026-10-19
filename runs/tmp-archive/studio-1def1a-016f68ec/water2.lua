print(drying(500,550))
Wa = pile{{"lead white",3},{"yellow ochre",0.7},{"chrome yellow",0.3},{"red earth",0.15},{"smalt",0.2},{"raw umber",0.1}}
Wb = pile{{"lead white",2},{"smalt",0.7},{"red earth",0.4},{"raw umber",0.35},{"yellow ochre",0.2}}
Wc = pile{{"lead white",1.3},{"smalt",1},{"raw umber",0.55},{"red earth",0.2},{"Prussian blue",0.04}}
water2 = rect(0,449,1000,230) - spit:shrink(6) - hull:mask():grow(1)
local function band(y0,y1) return rect(0,y0,1000,y1-y0):roughen(8,90,y0+1) end
work(water2*band(446,520), {hand="body", pile=Wa, angle=0, angle_jitter=0.015, coverage=2.5, length={50,140}, fill=true})
work(water2*band(508,592), {hand="body", pile=Wb, angle=0, angle_jitter=0.015, coverage=2.5, length={50,140}, fill=true})
work(water2*band(580,680), {hand="body", pile=Wc, angle=0, angle_jitter=0.015, coverage=2.5, length={50,140}, fill=true})
blend(water2, {angle=0})
