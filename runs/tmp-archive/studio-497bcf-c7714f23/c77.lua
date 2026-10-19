local fg = fore_m - path_m:shrink(1)
local zC = mask(function(x,y) local d = crest_depth(x,y) return d < 0 and 0 or (1 - smoothstep(25, 45, d)) end) * fg
local zM = mask(function(x,y) local d = crest_depth(x,y) return d < 0 and 0 or smoothstep(25, 45, d) * (1 - smoothstep(70, 95, d)) end) * fg
local zD = mask(function(x,y) local d = crest_depth(x,y) return d < 0 and 0 or smoothstep(70, 95, d) end) * fg
work(zC, {hand="body", pile=sC, angle=0.03, coverage=2.0, length={20,50}, pressure={0.5,0.8}, fill=true, clip=fg, edge="found", threshold=0.3})
work(zM, {hand="body", pile=sM, angle=0.05, coverage=2.0, length={25,60}, pressure={0.5,0.8}, fill=true, clip=fg, threshold=0.3})
work(zD, {hand="body", pile=sD, angle=0.08, coverage=2.0, length={25,70}, pressure={0.5,0.85}, fill=true, clip=fg, threshold=0.3})
blend(fg, {angle=0.02, coverage=1.2, clip=true, tool={kind="badger", width=22}, pressure={0.3,0.45}})
pathS2 = pile{{"yellow ochre", 2}, {"lead white", 1.4}, {"raw umber", 1.2}, {"red earth", 0.15}, {"pale smalt", 0.5}, {"green earth", 0.3}, medium=0.08}
work(path_m, {hand="body", pile=pathS2, angle=function(x,y) return -0.45 + (x-360)/800 end, coverage=2.2, length={10,30}, pressure={0.45,0.75}, fill=true, clip=path_m, edge="soft"})
print(wait(0))
