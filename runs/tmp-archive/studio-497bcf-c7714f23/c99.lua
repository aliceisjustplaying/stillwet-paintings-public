ryeL = pile{{"lead white", 3}, {"yellow ochre", 2}, {"green earth", 1.4}, {"pale smalt", 0.5}, {"chrome yellow", 0.1}, medium=0.1}
local b = below({{-10,441.5},{1010,441.5}})
local rye = rect(170, 441.5, 840, 32) * b - lime_sil2:grow(0.5) - roof:grow(0.5) - hedgerow:grow(0.3) - willow_heads
local up = rye * mask(function(x,y) return 1 - smoothstep(446, 466, y) end)
work(up, {hand="scumble", pile=ryeL, angle=0, coverage=1.4, length={20,50}, pressure={0.3,0.5}, load=0.4, clip=rye, threshold=0.25})
blend(rye, {angle=0, coverage=1.2, clip=true, tool={kind="badger", width=12}, pressure={0.3,0.45}})
print(wait(0))
