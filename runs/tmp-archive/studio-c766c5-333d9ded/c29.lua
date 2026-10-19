open = ellipse(640,538,126,32)
open_in = ellipse(640,538,113,25)
rimband = (open - open_in) * bowlmask
pin = pile{{"raw umber",1.6},{"lead white",2.5},{"smalt",1}}
prim = pile{{"lead white",5},{"yellow ochre",0.5},{"pale smalt",0.25}}
pdarkbowl = pile{{"raw umber",2.5},{"lead white",1.5},{"smalt",1}}
pshd = pile{{"raw umber",2},{"smalt",1.6},{"lead white",1.6},{"bone black",0.15}}
work(open_in, {hand="body", pile=pin, clip=true, coverage=2.6, angle=0.2, seed=221})
idark = open_in * mask(function(x,y) return clamp((y-520)/70,0,1) end)
work(idark, {hand="body", pile=pdarkbowl, clip=true, coverage=2.2, seed=222})
work(rimband, {hand="body", pile=prim, clip=true, coverage=2.6, angle=0.2, seed=223})
owall = bowlmask - open
gsh = mask(function(x,y) return clamp((x-620)/300, 0, 1) end):soften(20)
work(owall * gsh, {hand="body", pile=pshd, clip=true, coverage=2.2, angle=0.6, seed=224})
glit = mask(function(x,y) return clamp(1-(x-500)/160,0,1) end) * owall
work(glit, {hand="body", pile=prim, clip=true, coverage=1.8, angle=0.6, seed=225})
