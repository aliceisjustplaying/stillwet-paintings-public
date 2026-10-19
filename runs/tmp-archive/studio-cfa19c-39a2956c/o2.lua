print(wait(60*24))
print(drying(300,250), drying(200,300))
local mp = {}
local function M(x,y,rx,ry,z,sd) mp[#mp+1] = {body.ellipsoid({x,y,z},{rx,ry,(rx+ry)/2}):rough(ry*0.12, ry*0.9, sd)} end
M(255,150,105,62,10,1)   -- top crown
M(160,240,72,50,0,2)     -- left upper
M(365,245,62,52,-5,3)    -- right upper
M(265,262,70,40,15,4)    -- middle band
M(125,345,68,50,5,5)     -- left mid
M(360,335,72,52,-5,6)    -- right mid
M(265,350,48,32,20,7)    -- centre, in front of the fork
M(150,415,62,38,10,8)    -- left low
M(355,410,70,42,0,9)     -- right low
mp.light = {from={-1,-0.7}, front=0.3, ambient=0.12}
massF = form(mp)
local nz = noise{seed=2011, octaves=3, period=14}
-- shade the lower part of each mass, which darkens the old per-ball lights sitting there
local sh = massF:shadow{soft=0.35} * oakNew
stipple(sh, {pile=fd2, width=3.5, coverage=function(x,y) return clamp(1.2*sh:at(x,y) + 0.4*nz(x,y), 0, 1.5) end, pressure={0.4,0.75}, cluster={0.5,5}, feather=0.6, dips={18,0.6,0.2}, clip=oakNew:grow(3), seed=2012})
