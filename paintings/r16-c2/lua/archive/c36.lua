mudAll2 = mudL2 + mudR2
mudD = pile{{"raw umber",2},{"bone black",0.6},{"cobalt blue",0.3},{"lead white",0.45}}
mudDM = pile{{"raw umber",1.5},{"bone black",0.3},{"cobalt blue",0.35},{"lead white",1},{"red earth",0.2}}
mudL3 = pile{{"raw umber",1},{"lead white",1.8},{"cobalt blue",0.45},{"red earth",0.25},{"vermilion",0.05}}
local o = {hand="body", tool="filbert 9", angle=0.01, coverage=2.8, length={30,100}, fill=true, clip=mudAll2, angle_jitter=0.03}
o.pile=mudD; work(mudAll2 * rect(0,640,1000,90), o)
o.pile=mudDM; work(mudAll2 * rect(0,596,1000,50), o)
o.pile=mudL3; o.tool="filbert 7"; work(mudAll2 * rect(0,555,1000,45), o)
blend(mudAll2, {angle=0})
blend(mudAll2, {angle=0.06})
