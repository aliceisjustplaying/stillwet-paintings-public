wait(60*24*3)
local town = (townM + townM2)
local cut = rect(0,0,1000,413)
local CM = cloud2M - town
local lit = cloud2F:lit{soft=0.3} * cut
local cMid = pile{{"lead white",7},{"pale smalt",1.2},{"red earth",0.15},{"yellow ochre",0.25},{"raw umber",0.08}, medium=0.12}
local cSh  = pile{{"lead white",4.5},{"pale smalt",1.5},{"smalt",0.35},{"red earth",0.25},{"raw umber",0.18}, medium=0.12}
local cLt  = pile{{"lead white",14},{"yellow ochre",0.3},{"vermilion",0.04}, medium=0.08}
local ang = cloud2F:field("across")
work(CM, {hand="body", pile=cMid, tool="filbert 8", angle=ang, coverage=2.4, fill=true, edge="soft", pressure={0.45,0.7}, seed=1191})
local shW = lit:map(function(v) return smoothstep(0.5, 0.25, v) end)
local belly = mask(function(x,y) return smoothstep(345, 405, y) end)
work(CM * (shW + belly), {hand="body", pile=cSh, tool="filbert 8", angle=ang, coverage=2.0, fill=true, edge="soft", pressure={0.45,0.7}, seed=1192})
local ltW = lit:map(function(v) return smoothstep(0.62, 0.85, v) end) * mask(function(x,y) return smoothstep(380, 330, y) end)
work(CM:shrink(1) * ltW, {hand="body", pile=cLt, tool="filbert 6", angle=ang, coverage=2.0, fill=true, edge="soft", pressure={0.45,0.7}, seed=1193})
blend(CM:shrink(1), {tool={kind="badger", width=18}, angle=ang, coverage=1.6, pressure={0.25,0.45}, seed=1194})
blend(CM:shrink(1), {tool={kind="badger", width=14}, angle=0.35, coverage=1.0, pressure={0.2,0.35}, seed=1195})
