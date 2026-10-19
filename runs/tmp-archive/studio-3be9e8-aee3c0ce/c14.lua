lf = form{ {body.ellipsoid({610,592,0},{72,46,45}):turn({610,592,0},0,0,-0.08)}, {body.ellipsoid({718,553,0},{64,38,40}):turn({718,553,0},0,0,0.1)}, light={from={-1,-0.6}, front=0.5, ambient=0.2} }
lMid = pile{{"chrome yellow",3},{"yellow ochre",0.6},{"lead white",0.8}}
lShadow = pile{{"yellow ochre",2},{"raw umber",1},{"green earth",1},{"chrome yellow",0.6}}
lLight = pile{{"chrome yellow",2},{"lead white",2}}
local val = mask(function(x,y) return lf:value(x,y) end)
work(lemons, {hand="body", tool="filbert 7", pile=lMid, coverage=2.2, angle=function(x,y) return lf:across(x,y) end, length={15,35}, edge="firm", fill=true})
local sh = lemons * val:map(function(v) return clamp((0.4 - v)/0.12, 0, 1) end)
work(sh, {hand="body", tool="filbert 6", pile=lShadow, coverage=1.4, angle=function(x,y) return lf:across(x,y) end, length={12,30}, edge="soft", threshold=0.35})
local li = lemons * val:map(function(v) return clamp((v - 0.68)/0.1, 0, 1) end)
work(li, {hand="body", tool="filbert 5", pile=lLight, coverage=1.4, angle=function(x,y) return lf:across(x,y) end, length={10,25}, edge="soft", threshold=0.4})
