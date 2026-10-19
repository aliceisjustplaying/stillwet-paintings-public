crownF = form{ {body.ellipsoid({255,290,0},{190,185,150})}, light={from={-1,-0.5}, front=0.3, ambient=0.1} }
local nz = noise{seed=66, octaves=3, period=20}
local sh = crownF:shadow{soft=0.5} * oakSil
fd2 = pile{{"Prussian blue",1},{"raw umber",1.2},{"yellow ochre",0.8},{"bone black",0.2}, medium=0.1}
stipple(sh, {pile=fd2, width=4.5, coverage=function(x,y) return clamp(1.3*sh:at(x,y) + 0.4*nz(x,y), 0, 1.6) end, pressure={0.4,0.75}, cluster={0.5, 5}, feather=0.6, dips={18,0.6,0.2}, seed=271})
-- the underside of each lower mass in deep shade
local under = oakSil * mask(function(x,y) return smoothstep(380, 470, y) end)
stipple(under, {pile=fd2, width=4.5, coverage=function(x,y) return clamp(1.2*under:at(x,y) + 0.3*nz(x,y), 0, 1.4) end, pressure={0.4,0.75}, cluster={0.5, 5}, feather=0.6, dips={18,0.6,0.2}, seed=272})
