local R = mask(function(x,y) return smoothstep(385, 350, y) end)
local rim = oakSil:rim(10, 4) * rect(0,80,480,380) * R
local fdk = pile{{"Prussian blue",1},{"raw umber",1.1},{"yellow ochre",0.9},{"bone black",0.12}, medium=0.05}
stipple(rim, {pile=fdk, width=1.8, coverage=0.9, pressure={0.35,0.8}, drag={1.5, -1.2}, twist=0.6, cluster={0.7,5}, feather=0.4, seed=1521})
-- sprays of leaves reaching out from the masses into the gaps and the sky
local nz = noise{seed=177, octaves=3, period=9}
local spray = (oakSil:grow(7) - oakSil:shrink(1)) * R * mask(function(x,y) return clamp(nz(x,y)*1.6, 0, 1) end)
stipple(spray, {pile=fdk, width=2.2, coverage=0.8, pressure={0.35,0.75}, drag={1.2,-1.0}, twist=0.6, cluster={0.7,4}, feather=0.6, seed=1522})
local litSide = oakSil * R * mask(function(x,y) return smoothstep(0.2, -0.4, ((x-255)/190) + 0.6*((y-290)/185)) end)
stipple(litSide, {pile=fm, width=1.6, coverage=0.45, pressure={0.35,0.7}, drag={1.2,-1.0}, cluster={0.6,4}, feather=0.5, seed=1523})
