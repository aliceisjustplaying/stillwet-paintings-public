local town = townM4:grow(1.5) + townM:grow(1) + townM2:grow(1)
local cut = rect(0,0,1000,414)
local ring = ((cloud2M:grow(11) - cloud2M:shrink(1)) * cut) - town
local lit = cloud2F:lit{soft=0.3}
local cMid = pile{{"lead white",7},{"pale smalt",1.3},{"red earth",0.18},{"yellow ochre",0.25},{"raw umber",0.1}, medium=0.1}
local cLt  = pile{{"lead white",14},{"yellow ochre",0.32},{"vermilion",0.045}, medium=0.06}
local litSide = lit:map(function(v) return smoothstep(0.35, 0.6, v) end)
work(ring * litSide, {hand="detail", pile=cLt, tool={kind="filbert", width=4}, angle=cloud2F:field("edge"), coverage=2.5, fill=true, clip=true, edge="found", pressure={0.45,0.7}, seed=1461})
work(ring - litSide, {hand="detail", pile=cMid, tool={kind="filbert", width=4}, angle=cloud2F:field("edge"), coverage=2.5, fill=true, clip=true, edge="found", pressure={0.45,0.7}, seed=1462})
blend((cloud2M:grow(10) * cut) - town, {tool={kind="badger", width=8}, angle=cloud2F:field("across"), coverage=1.4, clip=true, pressure={0.2,0.4}, seed=1463})
