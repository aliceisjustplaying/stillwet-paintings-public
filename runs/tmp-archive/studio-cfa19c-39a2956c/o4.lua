print(wait(60*8))
local nz = noise{seed=2031, octaves=3, period=10}
local lit = massF:lit{soft=0.15}
local cl = crownF:lit{soft=0.5}
local L = lit * oakNew
stipple(L, {pile=fl3, width=2.6, coverage=function(x,y) return clamp(0.9*L:at(x,y)*(0.25 + 0.75*cl:at(x,y)) + 0.5*nz(x,y), 0, 1.0) end, pressure={0.3,0.6}, drag={1.0,-0.8}, cluster={0.7,4}, feather=0.8, dips={12,0.5,0.2}, clip=oakNew:grow(1), seed=2032})
-- a cooler, silvery sheen on the upper edges of the shaded right-hand masses, where the sky catches the leaves
local sheen = pile{{"lead white",1},{"Prussian blue",0.25},{"yellow ochre",0.5},{"raw umber",0.2}, medium=0.05}
local rimR = (oakNew - oakNew:shrink(7)) * mask(function(x,y) return smoothstep(270, 340, x) * smoothstep(420, 300, y) end)
stipple(rimR, {pile=sheen, width=2, coverage=function(x,y) return clamp(0.35*rimR:at(x,y) + 0.3*nz(x,y), 0, 0.6) end, pressure={0.3,0.55}, drag={1.0,-0.8}, cluster={0.7,3}, feather=0.9, seed=2033})
