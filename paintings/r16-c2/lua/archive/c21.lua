local nu = noise{seed=61, period=140, octaves=4, stretch={0.03, 5}}
local nm = noise{seed=62, period=90, octaves=4, stretch={-0.01, 7}}
local nl = noise{seed=63, period=80, octaves=3, stretch={0, 8}}
cU = mask(function(x,y) if y < 10 or y > 185 then return 0 end; local fade = smoothstep(10,50,y) * (1 - smoothstep(140,185,y)); return (nu(x,y)*fade > 0.18) and 1 or 0 end):roughen(3, 12, 64)
cM = mask(function(x,y) if y < 195 or y > 250 then return 0 end; local fade = smoothstep(195,212,y) * (1 - smoothstep(228,250,y)) * (1 - smoothstep(700,900,x)); return (nm(x,y)*0.6 + fade*0.7 > 0.55) and 1 or 0 end):roughen(2.5, 10, 65)
cL = mask(function(x,y) if y < 270 or y > 335 then return 0 end; local fade = smoothstep(270,285,y) * (1 - smoothstep(315,335,y)); return (nl(x,y)*0.8 + fade*0.5 > 0.55) and 1 or 0 end):roughen(2, 10, 66)
cuP = pile{{"lead white",1.6},{"cobalt blue",0.6},{"red earth",0.4},{"raw umber",0.35}}
cmP = pile{{"lead white",1.8},{"cobalt blue",0.45},{"red earth",0.45},{"vermilion",0.1},{"raw umber",0.3}}
clP = pile{{"lead white",3},{"vermilion",0.35},{"yellow ochre",0.45}}
work(cU * skyClip, {hand="body", tool="filbert 8", pile=cuP, angle=0.03, coverage=2, length={30,90}, fill=true, clip=skyClip, edge={soft=0.6, lost=0.3, found=0.1, period=40}})
work(cM * skyClip, {hand="body", tool="filbert 6", pile=cmP, angle=-0.01, coverage=2, length={30,90}, fill=true, clip=skyClip, edge={soft=0.6, lost=0.2, found=0.2, period=40}})
work(cL * skyClip, {hand="detail", tool="round 4", pile=clP, angle=0, coverage=2, length={20,50}, fill=true, clip=skyClip})
