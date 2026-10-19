wClip = rect(0,401,1000,320) - mudL - mudR - bar - barR
w1 = pile{{"lead white",6},{"chrome yellow",0.8},{"yellow ochre",0.35},{"vermilion",0.08},{"raw umber",0.06}}
w2 = pile{{"lead white",4},{"yellow ochre",0.55},{"vermilion",0.22},{"cobalt blue",0.1},{"raw umber",0.05}}
w3 = pile{{"lead white",3},{"cobalt blue",0.5},{"vermilion",0.1},{"red earth",0.25},{"raw umber",0.08}}
local o = {hand="body", tool="filbert 10", angle=0, coverage=3, length={40,120}, fill=true, clip=wClip, angle_jitter=0.02}
o.pile=w1; work(rect(0,401,1000,42) * wClip, o)
o.pile=w2; work(rect(0,438,1000,52) * wClip, o)
o.pile=w3; o.tool="filbert 12"; work(rect(0,486,1000,80) * wClip, o)
