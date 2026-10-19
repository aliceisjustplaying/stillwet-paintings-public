print(wait(60*24))
local sDk = pile{{"raw umber",1},{"bone black",0.35},{"lead white",0.7},{"pale smalt",0.3},{"green earth",0.2}, medium=0.05}
local sMd = pile{{"lead white",1.4},{"raw umber",0.9},{"bone black",0.2},{"yellow ochre",0.25},{"pale smalt",0.2}, medium=0.05}
local sLt = pile{{"lead white",2.4},{"raw umber",0.45},{"yellow ochre",0.35},{"bone black",0.05}, medium=0.05}
local ang = stF:field("across")
work(stoneM, {hand="body", tool="filbert 3", pile=sMd, angle=ang, coverage=3, fill=true, clip=true, pressure={0.5,0.75}, seed=3511})
local sh = stF:shadow{soft=0.35} * stoneM
work(sh, {hand="body", tool="filbert 3", pile=sDk, angle=ang, coverage=2.4, clip=true, pressure={0.45,0.7}, seed=3512})
local lt = (stF:lit{soft=0.25} * stoneM):map(function(v) return smoothstep(0.55, 0.9, v) end)
work(lt, {hand="detail", pile=sLt, tool={kind="round", width=2.2, point=0.3}, angle=ang, coverage=1.8, clip=true, pressure={0.45,0.7}, seed=3513})
blend(stoneM:shrink(1), {tool={kind="badger", width=6}, angle=-0.6, coverage=0.8, clip=true, pressure={0.2,0.35}, seed=3514})
