local band = mask(function(x, y) local f = far(x); return (y > f - 3.5 - 1.5*math.sin(x/9) and y < f + 1) and 1 or 0 end) * (rect(-10,0,140,700) + rect(180,0,160,700) + rect(410,0,150,700) + rect(740,0,130,700) + rect(890,0,130,700))
local extra = (ellipse(268, far(268)-7, 7, 8) + ellipse(338, far(338)-6, 8, 6) + ellipse(352, far(352)-4, 6, 4)):roughen(1.2, 6, 5)
FARTREES = FARTREES + band:roughen(1, 6, 7) + extra
local haze = pile{{"pale smalt", 2}, {"lead white", 3}, {"green earth", 0.3}, {"raw umber", 0.12}, {"vermilion", 0.01}, medium=0.15}
stipple(FARTREES, {pile=haze, width=2, coverage=2.2, cluster=0.2, clip=true, seed=1401})
