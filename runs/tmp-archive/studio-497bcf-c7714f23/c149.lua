print(drying(500,455))
ryeU = pile{{"lead white", 3.2}, {"yellow ochre", 2}, {"green earth", 1.1}, {"pale smalt", 0.7}, {"raw umber", 0.1}, medium=0.1}
ryeD = pile{{"lead white", 2.4}, {"yellow ochre", 2.2}, {"green earth", 1.3}, {"pale smalt", 0.4}, {"raw umber", 0.25}, {"chrome yellow", 0.08}, medium=0.1}
local b = below({{-10,441.8},{1010,441.8}})
local rye = rect(186, 441.8, 830, 34) * b - lime_sil2:grow(0.5) - hedgerow:shrink(0.8) - willow_heads - rect(830,440,200,60) * elder2:grow(1)
local u = rye * mask(function(x,y) return 1 - smoothstep(449, 460, y) end)
local d = rye * mask(function(x,y) return smoothstep(449, 460, y) end)
work(u, {hand="body", pile=ryeU, angle=0, coverage=1.8, length={15,45}, pressure={0.4,0.65}, fill=true, clip=rye, threshold=0.3})
work(d, {hand="body", pile=ryeD, angle=0, coverage=1.8, length={15,45}, pressure={0.4,0.65}, fill=true, clip=rye, threshold=0.3})
blend(rye, {angle=0, coverage=1.4, clip=true, tool={kind="badger", width=12}, pressure={0.3,0.45}})
print(wait(0))
