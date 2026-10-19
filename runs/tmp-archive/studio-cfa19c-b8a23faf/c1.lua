-- the shaded right side of the crown: break the flat dark into leaf clusters, each with a dull top
local cl = {}
local function C(x,y,rx,ry,sd) cl[#cl+1] = {body.ellipsoid({x,y,0},{rx,ry,(rx+ry)/2}):rough(ry*0.18, ry*0.8, sd)} end
C(318,205,22,15,1) C(352,222,20,14,2) C(336,250,18,12,3) C(372,262,22,15,4)
C(300,272,16,11,5) C(392,300,20,14,6) C(350,292,24,14,7) C(318,318,18,12,8)
C(404,338,18,13,9) C(366,332,22,14,10) C(330,356,20,13,11) C(390,372,22,14,12)
C(300,388,18,12,13) C(352,392,24,14,14) C(410,410,18,12,15) C(330,425,22,13,16)
C(376,430,20,12,17) C(298,440,16,10,18) C(386,240,14,10,19) C(342,450,18,9,20)
cl.light = {from={-1,-0.8}, front=0.25, ambient=0.05}
clF = form(cl)
local R = oakNew:shrink(2) * mask(function(x,y) return smoothstep(285, 310, x) end)
local nz = noise{seed=4101, octaves=3, period=7}
local lit = (clF:lit{soft=0.25} * R):map(function(v) return smoothstep(0.35, 0.85, v) end)
dullG = pile{{"yellow ochre",1.4},{"Prussian blue",0.45},{"raw umber",0.6},{"lead white",0.35},{"green earth",0.4}, medium=0.04}
stipple(lit, {pile=dullG, width=2.4, coverage=function(x,y) return clamp(0.9*lit:at(x,y) + 0.45*nz(x,y), 0, 1.1) end, pressure={0.3,0.6}, drag={1.0,-0.8}, twist=0.5, cluster={0.7,3}, feather=0.8, dips={12,0.5,0.2}, clip=R, seed=4102})
