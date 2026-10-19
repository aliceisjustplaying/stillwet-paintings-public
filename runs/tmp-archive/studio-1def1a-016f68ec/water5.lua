Wd = pile{{"lead white",0.8},{"smalt",1},{"raw umber",0.8},{"red earth",0.2},{"Prussian blue",0.08}}
waterAll = rect(0,457,1000,220) - spit2:shrink(3) - hull2:mask():grow(0.5)
local function band(y0,y1,s) return rect(0,y0,1000,y1-y0):roughen(10,140,s) end
local o = {hand="body", tool="filbert 8", angle=0, angle_jitter=0.012, coverage=2.5, length={60,160}, fill=true, clip=waterAll}
o.pile=Wa2; work(waterAll*band(455,496,1), o)
o.pile=WbC; work(waterAll*band(490,545,2), o)
o.pile=Wd;  work(waterAll*band(538,680,3), o)
blend(waterAll*rect(0,480,1000,80), {angle=0})
