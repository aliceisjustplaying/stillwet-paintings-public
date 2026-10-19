local objects = (stonesM + cap2:mask() + oakThickM + chamberM):grow(1)
local band = land * rect(0,462,630,28) - objects
stipple(band, {pile=moundShade, width=2.5, coverage=function(x,y) return clamp((488-y)/22, 0, 1)*2.0 end, feather=0.7, pressure={0.35,0.65}, cluster=0.3})
blend(land * rect(0,455,630,40) - objects, {angle=0.02})
