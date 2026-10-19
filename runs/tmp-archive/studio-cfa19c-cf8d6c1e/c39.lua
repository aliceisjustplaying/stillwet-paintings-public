fm = pile{{"yellow ochre",2},{"Prussian blue",0.45},{"raw umber",0.3},{"lead white",0.5}, medium=0.04}
local nz = noise{seed=44, octaves=3, period=16}
local half = oakF:lit{soft=0.5}
stipple(half:grow(3), {pile=fm, width=4, coverage=function(x,y) return clamp(1.1*half:at(x,y) + 0.5*nz(x,y), 0, 1.5) end, pressure={0.35,0.7}, cluster={0.55, 5}, feather=0.7, dips={16,0.6,0.2}, seed=241})
