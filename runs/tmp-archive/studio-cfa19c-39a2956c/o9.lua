print(wait(60*8))
local nz = noise{seed=3411, octaves=3, period=8}
local top = boughM * mask(function(x,y) return smoothstep(446, 430, y) end)
stipple(top, {pile=fmd, width=2.6, coverage=function(x,y) return clamp(0.6*top:at(x,y) + 0.5*nz(x,y), 0, 1) end, pressure={0.3,0.65}, drag={1.0,-0.8}, cluster={0.6,3}, feather=0.7, seed=3412})
-- lift some of the tree's lower edge into leaves so the limb emerges into the crown, not under it
