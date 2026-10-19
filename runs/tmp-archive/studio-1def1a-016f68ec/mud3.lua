mudCool = pile{{"raw umber",1},{"bone black",0.3},{"smalt",0.45},{"lead white",0.3},{"red earth",0.1}}
mudWarm = pile{{"raw umber",1},{"bone black",0.35},{"red earth",0.35},{"lead white",0.08}}
local upper = spit3 * mask(function(x,y) local v = 1 - ((y-590) - 0.33*x)/25; return clamp(v,0,1) end)
local lower = spit3 - upper
local o = {hand="body", tool="filbert 8", angle=function(x,y) return 0.15 + x/2500 end, angle_jitter=0.08, coverage=3, length={30,90}, fill=true, clip=spit3}
o.pile = mudCool; work(upper, o)
o.pile = mudWarm; work(lower, o)
