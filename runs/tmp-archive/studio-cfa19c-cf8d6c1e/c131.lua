wait(60*24*5)
local town = townM4:grow(0.3) + townM + townM2
local cut = rect(0,0,1000,413)
local CM = cloud2M - town
local lit = cloud2F:lit{soft=0.3} * cut
local ang = cloud2F:field("across")
local cMid = pile{{"lead white",7},{"pale smalt",1.3},{"red earth",0.18},{"yellow ochre",0.25},{"raw umber",0.1}, medium=0.1}
local cSh  = pile{{"lead white",4},{"pale smalt",1.6},{"smalt",0.4},{"red earth",0.28},{"raw umber",0.2}, medium=0.1}
local cLt  = pile{{"lead white",14},{"yellow ochre",0.32},{"vermilion",0.045}, medium=0.06}
work(CM, {hand="body", pile=cMid, tool="filbert 8", angle=ang, coverage=2.6, fill=true, clip=true, edge="soft", pressure={0.45,0.7}, seed=1451})
local shW = lit:map(function(v) return smoothstep(0.5, 0.2, v) end)
local belly = mask(function(x,y) return smoothstep(350, 408, y) end)
work(CM:shrink(2) * (shW + belly), {hand="body", pile=cSh, tool="filbert 7", angle=ang, coverage=2.0, fill=true, clip=true, pressure={0.45,0.7}, seed=1452})
local ltW = lit:map(function(v) return smoothstep(0.6, 0.85, v) end) * mask(function(x,y) return smoothstep(385, 330, y) end)
work(CM:shrink(1.5) * ltW, {hand="body", pile=cLt, tool="filbert 6", angle=ang, coverage=2.2, fill=true, clip=true, pressure={0.45,0.7}, seed=1453})
blend(CM:shrink(2), {tool={kind="badger", width=14}, angle=ang, coverage=1.6, clip=true, pressure={0.25,0.45}, seed=1454})
blend(CM:shrink(2), {tool={kind="badger", width=10}, angle=0.35, coverage=0.9, clip=true, pressure={0.2,0.35}, seed=1455})
