print(wait(60*6))
local nz = noise{seed=3621, octaves=3, period=9}
local lit = massF:lit{soft=0.3} * oakNew * mask(function(x,y) return smoothstep(300, 340, x) end)
stipple(lit, {pile=fmd, width=2.8, coverage=function(x,y) return clamp(0.7*lit:at(x,y) + 0.45*nz(x,y), 0, 0.9) end, pressure={0.3,0.65}, drag={1.0,-0.8}, cluster={0.65,4}, feather=0.8, dips={14,0.5,0.2}, clip=oakNew:grow(1), seed=3622})
