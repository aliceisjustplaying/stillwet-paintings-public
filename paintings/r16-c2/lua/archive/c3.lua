sky1 = pile{{"lead white",3},{"smalt",1.2},{"raw umber",0.25},{"red earth",0.1}}
sky2 = pile{{"lead white",4},{"cobalt blue",0.5},{"red earth",0.25},{"raw umber",0.1}}
sky3 = pile{{"lead white",5},{"yellow ochre",0.8},{"vermilion",0.2},{"cobalt blue",0.1}}
sky4 = pile{{"lead white",6},{"chrome yellow",0.7},{"yellow ochre",0.5},{"vermilion",0.12}}
local n = noise{seed=3, period=300, octaves=3}
local function band(y0, y1) return mask(function(x,y) local w = n(x,y)*18; return (y > y0 + w and y < y1 + w) and 1 or 0 end) end
work(band(-20, 150), {hand="body", tool="filbert 14", pile=sky1, angle=function(x,y) return 0.05*math.sin(x/200) end, coverage=2.5, length={40,110}, fill=true})
work(band(140, 255), {hand="body", tool="filbert 14", pile=sky2, angle=0.02, coverage=2.5, length={40,110}, fill=true})
work(band(245, 345), {hand="body", tool="filbert 14", pile=sky3, angle=-0.02, coverage=2.5, length={40,110}, fill=true})
work(rect(0, 335, 1000, 68), {hand="body", tool="filbert 12", pile=sky4, angle=0, coverage=2.5, length={40,120}, fill=true, clip=rect(0,0,1000,401)})
