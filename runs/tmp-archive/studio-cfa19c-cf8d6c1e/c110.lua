-- a lace of small leaf touches along the crown's outer edge, to break the brushy flicks into foliage
local rim = oakSil:rim(10, 4) * rect(0,80,480,380)
local fdk = pile{{"Prussian blue",1},{"raw umber",1.1},{"yellow ochre",0.9},{"bone black",0.12}, medium=0.05}
local fmd = pile{{"yellow ochre",2},{"Prussian blue",0.5},{"raw umber",0.35},{"lead white",0.45}, medium=0.04}
stipple(rim, {pile=fdk, width=1.8, coverage=0.9, pressure={0.35,0.8}, drag={1.5, -1.2}, twist=0.6, cluster={0.7,5}, feather=0.4, seed=1101})
-- mid-green leaves bridging the yellow lights into the darks, on the lit (left and upper) side
local litSide = oakSil * mask(function(x,y) return smoothstep(0.2, -0.4, ((x-255)/190) + 0.6*((y-290)/185)) end)
stipple(litSide, {pile=fmd, width=1.6, coverage=0.5, pressure={0.35,0.7}, drag={1.2,-1.0}, cluster={0.6,4}, feather=0.5, seed=1102})
