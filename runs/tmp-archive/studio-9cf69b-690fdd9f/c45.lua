moundShade = pile{{"lead white",3.5},{"pale smalt",1.8},{"smalt",0.5},{"raw umber",0.2},{"vermilion",0.04}, medium=0.12}
local crest = {{0,478},{60,466},{130,446},{210,425},{300,414},{390,418},{470,434},{540,455},{610,471},{700,474}}
local rimBelow = {}
for _,p in ipairs(crest) do rimBelow[#rimBelow+1] = {p[1], p[2] + 5} end
local objects = (stonesM + cap2:mask() + oakThickM + chamberM):grow(0.5)
slopeM = land * below(rimBelow) * above({{0,474},{300,472},{620,476}}) - objects
work(slopeM, {hand="body", pile=moundShade, angle=0.05, coverage=2.5, pressure={0.5,0.8}, fill=true, length={20,50}, clip=true, angle_jitter=0.15})
-- the transition into the field, stippled as he did
stipple(land * rect(0,466,640,34) - objects, {pile=moundShade, width=2.2, coverage=function(x,y) return clamp((496-y)/28, 0, 1)*1.4 end, feather=0.8, pressure={0.3,0.6}, cluster=0.2})
