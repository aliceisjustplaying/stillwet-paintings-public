skyClip = rect(0,0,1000,401) - trees:grow(0.5)
s1 = pile{{"lead white",1.8},{"cobalt blue",1},{"smalt",0.3},{"red earth",0.2},{"raw umber",0.2}}
s2 = pile{{"lead white",3},{"cobalt blue",0.5},{"vermilion",0.1},{"red earth",0.2}}
s3 = pile{{"lead white",4},{"yellow ochre",0.55},{"vermilion",0.22},{"cobalt blue",0.05}}
s4 = pile{{"lead white",6},{"chrome yellow",0.8},{"yellow ochre",0.3},{"vermilion",0.08}}
local n = noise{seed=51, period=280, octaves=3}
local function band(y0, y1) return mask(function(x,y) local w = n(x,y)*15; return (y > y0 + w and y < y1 + w) and 1 or 0 end) end
local o = {hand="body", tool="filbert 14", angle=0, coverage=2.5, length={50,130}, fill=true, clip=skyClip, angle_jitter=0.05}
o.pile=s1; work(band(-30,125) * skyClip, o)
o.pile=s2; work(band(115,245) * skyClip, o)
o.pile=s3; work(band(235,330) * skyClip, o)
o.pile=s4; o.tool="filbert 12"; work(rect(0,320,1000,82) * skyClip, o)
