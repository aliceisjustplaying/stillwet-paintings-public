snowTop = pile{{"lead white",7},{"pale smalt",0.5},{"yellow ochre",0.12},{"vermilion",0.03}, medium=0.08}
snowSide = pile{{"lead white",4},{"pale smalt",1.6},{"smalt",0.4},{"raw umber",0.15}, medium=0.08}
-- underside of the capstone in its own shadow
local under = cap:mask() * below({{270,387},{320,390},{360,388},{400,390},{430,386}})
work(under, {hand="detail", pile=chamber, coverage=3, pressure={0.5,0.8}, load=0.9, fill=true, angle=0})
-- facets on the front face of the slab: planes turned a little to the sky
local fac = poly({{296,372},{322,366},{350,367},{346,378},{318,382},{298,381}}) + poly({{372,368},{398,370},{412,376},{404,383},{380,381}})
work(fac * cap:mask(), {hand="detail", pile=stoneMid, coverage=2.5, pressure={0.4,0.7}, load=0.7, fill=true, angle=-0.2})
-- cracks
local r = brush{kind="round", width=2, point=1}
r:load(chamber, 0.7)
r:stroke({{352,366},{349,375},{353,383},{350,390}}, {pressure={0.45,0.1}})
r:stroke({{318,383},{330,381},{346,384}}, {pressure={0.35,0.05}})
r:stroke({{402,372},{396,381},{399,389}}, {pressure={0.4,0.05}})
r:stroke({{303,396},{305,410},{302,422}}, {pressure={0.35,0.05}})
r:stroke({{396,398},{399,414}}, {pressure={0.3,0.05}})
-- the snow cap on the slab
local topc = {{272,386},{280,373},{298,364},{330,359.5},{362,360.5},{394,363.5},{417,368.5},{430,379}}
local bot = {}
for i = #topc, 1, -1 do local p = topc[i]; bot[#bot+1] = {p[1] + randn(0,1), p[2] + rand(4.5, 9)} end
local pts = {}
for _,p in ipairs(topc) do pts[#pts+1] = p end
for _,p in ipairs(bot) do pts[#pts+1] = p end
capSnow = poly(pts, true):roughen(0.8, 4, 55)
work(capSnow, {hand="detail", pile=snowTop, coverage=3.5, pressure={0.5,0.8}, load=1, fill=true, angle=0})
-- snow on the fallen stones and the tops of the uprights where they show
local s2 = poly({{442,424},{448,416},{458,412},{472,415},{478,423},{468,421},{456,419},{447,423}}, true) + poly({{246,425},{252,419},{262,417},{269,423},{262,422},{252,424}}, true)
work(s2, {hand="detail", pile=snowTop, coverage=3.5, pressure={0.5,0.8}, load=1, fill=true, angle=0})
