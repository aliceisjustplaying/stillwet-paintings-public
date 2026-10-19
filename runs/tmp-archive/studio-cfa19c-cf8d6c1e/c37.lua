local nz = noise{seed=33, octaves=3, period=22}
local fringe = oakSil:grow(10) - oakSil:shrink(3)
stipple(fringe, {pile=fd, width=3.5, coverage=function(x,y) local d = oakSil:at(x,y); return clamp(0.25 + 0.9*d + 0.6*nz(x,y), 0, 1.6) end, pressure={0.35,0.75}, cluster={0.6, 5}, feather=0.8, dips={18,0.6,0.2}, seed=231})
