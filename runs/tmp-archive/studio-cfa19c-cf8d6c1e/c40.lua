print(wait(6*60))
fl3 = pile{{"yellow ochre",2},{"chrome yellow",0.6},{"Prussian blue",0.2},{"lead white",1.3}, medium=0.03}
local nz = noise{seed=55, octaves=3, period=12}
local lit = oakF:lit{soft=0.15}
stipple(lit, {pile=fl3, width=3, coverage=function(x,y) return clamp(0.8*lit:at(x,y) + 0.5*nz(x,y), 0, 1.1) end, pressure={0.3,0.6}, cluster={0.6, 4}, feather=0.8, dips={14,0.5,0.2}, seed=251})
