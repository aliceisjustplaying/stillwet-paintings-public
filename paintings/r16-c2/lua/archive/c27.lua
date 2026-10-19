mA = pile{{"raw umber",2},{"bone black",0.5},{"red earth",0.5},{"lead white",0.2}}
mB = pile{{"raw umber",1.5},{"red earth",0.4},{"lead white",0.6},{"cobalt blue",0.2}}
mC = pile{{"raw umber",1},{"lead white",1.3},{"cobalt blue",0.3},{"red earth",0.3},{"vermilion",0.05}}
local inner = mudL:shrink(20)
local rimZ = (mudL - mudL:shrink(26)) * rect(14,0,1000,694)
local o = {hand="body", tool="filbert 9", angle=function(x,y) return 0.04 end, coverage=2.5, length={30,90}, fill=true, clip=mudL, angle_jitter=0.04}
o.pile = mA; work(inner * rect(0,630,1000,100), o)
o.pile = mB; work(inner * rect(0,560,1000,85), o)
o.pile = mC; o.tool="filbert 6"; o.length={15,50}; work(rimZ, o)
blend(mudL, {angle=0.03})
