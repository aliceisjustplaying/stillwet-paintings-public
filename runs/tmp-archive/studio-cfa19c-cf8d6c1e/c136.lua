wait(8*60)
local R = mask(function(x,y) return smoothstep(380, 345, y) end)
local nz = noise{seed=144, octaves=3, period=16}
local half = oakF:lit{soft=0.5}
stipple(half:grow(3) * R, {pile=fm, width=4, coverage=function(x,y) return clamp(1.1*half:at(x,y) + 0.5*nz(x,y), 0, 1.5) end, pressure={0.35,0.7}, cluster={0.55, 5}, feather=0.7, dips={16,0.6,0.2}, seed=1501})
wait(6*60)
local nz2 = noise{seed=155, octaves=3, period=12}
local lit = oakF:lit{soft=0.15}
stipple(lit * R, {pile=fl3, width=3, coverage=function(x,y) return clamp(0.8*lit:at(x,y) + 0.5*nz2(x,y), 0, 1.1) end, pressure={0.3,0.6}, cluster={0.6, 4}, feather=0.8, dips={14,0.5,0.2}, seed=1502})
