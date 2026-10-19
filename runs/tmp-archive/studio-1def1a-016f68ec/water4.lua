WbC = pile{{"lead white",1.5},{"smalt",0.9},{"red earth",0.35},{"raw umber",0.6},{"yellow ochre",0.1}}
local zone = rect(150,466,370,118):roughen(10,50,5) - spit2:grow(2) - hull2:mask():grow(1)
local function band(y0,y1) return rect(0,y0,1000,y1-y0):roughen(5,60,y0+3) end
local o = {hand="body", tool="filbert 6", angle=0, angle_jitter=0.01, coverage=2.5, length={30,90}, fill=true, clip=zone}
o.pile=Wa2; work(zone*band(462,494), o)
o.pile=Wb2; work(zone*band(488,545), o)
o.pile=WbC; work(zone*band(538,590), o)
blend(zone:shrink(4), {angle=0})
