sC = pile{{"green earth", 3}, {"yellow ochre", 1.6}, {"raw umber", 1.0}, {"Prussian blue", 0.15}, {"lead white", 0.9}, {"smalt", 0.3}, medium=0.08}
sM = pile{{"green earth", 3}, {"yellow ochre", 1.2}, {"raw umber", 1.5}, {"Prussian blue", 0.2}, {"lead white", 0.5}, medium=0.08}
sD = pile{{"green earth", 2}, {"raw umber", 2.2}, {"yellow ochre", 0.8}, {"Prussian blue", 0.3}, {"bone black", 0.25}, {"lead white", 0.15}, medium=0.08}
local zC = mask(function(x,y) local d = crest_depth(x,y) return d < 0 and 0 or (1 - smoothstep(25, 45, d)) end)
local zM = mask(function(x,y) local d = crest_depth(x,y) return d < 0 and 0 or smoothstep(25, 45, d) * (1 - smoothstep(70, 95, d)) end)
local zD = mask(function(x,y) local d = crest_depth(x,y) return d < 0 and 0 or smoothstep(70, 95, d) end)
work(zC, {hand="body", pile=sC, angle=0.03, coverage=2.2, length={20,50}, pressure={0.55,0.85}, fill=true, clip=fore_m, edge="found", threshold=0.3})
work(zM, {hand="body", pile=sM, angle=0.05, coverage=2.2, length={25,60}, pressure={0.55,0.85}, fill=true, clip=fore_m, threshold=0.3})
work(zD, {hand="body", pile=sD, angle=0.08, coverage=2.2, length={25,70}, pressure={0.55,0.9}, fill=true, clip=fore_m, threshold=0.3})
blend(fore_m, {angle=0.02, coverage=1.5, clip=true, tool={kind="badger", width=26}, pressure={0.3,0.5}})
print(wait(0))
