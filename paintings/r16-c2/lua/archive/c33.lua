chanClip = rect(0,515,1000,210) - mudL2 - mudR2
c1 = pile{{"lead white",3},{"cobalt blue",0.55},{"vermilion",0.08},{"red earth",0.22},{"raw umber",0.1}}
c2 = pile{{"lead white",2.2},{"cobalt blue",0.8},{"red earth",0.2},{"raw umber",0.2},{"smalt",0.2}}
c3 = pile{{"lead white",1.6},{"cobalt blue",0.95},{"smalt",0.3},{"red earth",0.2},{"raw umber",0.3}}
local o = {hand="body", tool="filbert 9", angle=0, coverage=3, length={30,90}, fill=true, clip=chanClip, angle_jitter=0.02}
o.pile=c1; work(rect(0,515,1000,60) * chanClip, o)
o.pile=c2; work(rect(0,570,1000,70) * chanClip, o)
o.pile=c3; work(rect(0,635,1000,90) * chanClip, o)
blend(chanClip, {angle=0})
