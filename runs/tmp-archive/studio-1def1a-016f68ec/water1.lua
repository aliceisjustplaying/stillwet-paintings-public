spit = outline{{-20,556},{60,548},{140,547},{230,560},{320,590},{400,630},{450,690},{-20,690}, closed=true, char="soft", seed=5}:mask()
W1 = pile{{"lead white",3},{"yellow ochre",0.8},{"chrome yellow",0.4},{"red earth",0.1},{"smalt",0.12}}
W2 = pile{{"lead white",3},{"yellow ochre",0.3},{"red earth",0.25},{"smalt",0.55},{"raw umber",0.2}}
W3 = pile{{"lead white",2},{"smalt",1},{"raw umber",0.35},{"red earth",0.15}}
local water = rect(0,436,1000,240) - spit:shrink(4)
local function band(y0,y1) return rect(0,y0,1000,y1-y0):roughen(8,80,y0) end
work(water*band(434,500), {hand="body", pile=W1, angle=0, angle_jitter=0.02, coverage=2.5, length={40,120}, fill=true})
work(water*band(488,572), {hand="body", pile=W2, angle=0, angle_jitter=0.02, coverage=2.5, length={40,120}, fill=true})
work(water*band(560,680), {hand="body", pile=W3, angle=0, angle_jitter=0.02, coverage=2.5, length={40,120}, fill=true})
blend(water, {angle=0})
