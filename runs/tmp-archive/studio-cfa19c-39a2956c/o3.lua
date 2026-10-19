print(wait(60*12))
local nz = noise{seed=2021, octaves=3, period=16}
local nz2 = noise{seed=2022, octaves=3, period=9}
local lit = massF:lit{soft=0.5}
local cl = crownF:lit{soft=0.6}
fmd = pile{{"yellow ochre",1.6},{"Prussian blue",0.6},{"raw umber",0.5},{"lead white",0.3}, medium=0.04}
-- the right, shaded side of the crown: only a dull green on the tops of its masses
local litR = lit * oakNew
stipple(litR, {pile=fmd, width=3.5, coverage=function(x,y) return clamp(1.0*litR:at(x,y)*(1 - 0.6*cl:at(x,y)) + 0.45*nz(x,y), 0, 1.2) end, pressure={0.35,0.7}, cluster={0.6,5}, feather=0.7, dips={16,0.6,0.2}, clip=oakNew:grow(2), seed=2023})
-- the sunlit side: half-tone on the tops of the masses
stipple(litR, {pile=fm, width=3.5, coverage=function(x,y) return clamp(1.2*litR:at(x,y)*cl:at(x,y) + 0.5*nz2(x,y), 0, 1.4) end, pressure={0.35,0.7}, cluster={0.6,5}, feather=0.7, dips={16,0.6,0.2}, clip=oakNew:grow(2), seed=2024})
