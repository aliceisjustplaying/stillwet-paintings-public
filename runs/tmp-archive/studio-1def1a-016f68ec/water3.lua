Wa2 = pile{{"lead white",3},{"yellow ochre",0.8},{"chrome yellow",0.3},{"red earth",0.15},{"smalt",0.25},{"raw umber",0.15}}
Wb2 = pile{{"lead white",2},{"smalt",0.8},{"red earth",0.45},{"raw umber",0.45},{"yellow ochre",0.15}}
Wc2 = pile{{"lead white",1},{"smalt",1},{"raw umber",0.7},{"red earth",0.2},{"Prussian blue",0.06}}
water3 = rect(0,449,1000,230) - spit:shrink(6) - hull:mask():grow(1)
local function band(y0,y1) return rect(0,y0,1000,y1-y0):roughen(8,90,y0+7) end
local o = {hand="body", angle=0, angle_jitter=0.015, coverage=2.5, length={50,140}, fill=true, clip=water3}
o.pile=Wa2; work(water3*band(446,505), o)
o.pile=Wb2; work(water3*band(492,578), o)
o.pile=Wc2; work(water3*band(565,680), o)
blend(water3, {angle=0})
