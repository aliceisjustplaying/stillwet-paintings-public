grD = pile{{"green earth", 2}, {"raw umber", 1.6}, {"Prussian blue", 0.25}, {"yellow ochre", 0.6}, {"bone black", 0.1}, {"lead white", 0.2}, medium=0.1}
grM = pile{{"green earth", 2.5}, {"yellow ochre", 1.4}, {"raw umber", 0.8}, {"Prussian blue", 0.12}, {"lead white", 0.7}, medium=0.1}
grL = pile{{"yellow ochre", 2}, {"green earth", 1.5}, {"lead white", 1.4}, {"chrome yellow", 0.25}, {"raw umber", 0.2}, medium=0.1}
fg_grass = fore_m - path_m:shrink(2) - figs:grow(0.5)
local near = fg_grass * mask(function(x,y) return crest_depth(x,y) > 55 and 1 or 0 end)
local midz = fg_grass * mask(function(x,y) local d = crest_depth(x,y) return (d > 18 and d <= 55) and 1 or 0 end)
local farz = fg_grass * mask(function(x,y) local d = crest_depth(x,y) return (d > 1 and d <= 18) and 1 or 0 end)
local up = function(x,y) return -math.pi/2 + 0.25*math.sin(x/23 + y/31) end
local tool = {kind="round", width=2.2, point=0.9}
work(near, {hand="hatch", pile=grD, tool=tool, angle=up, length={8,20}, coverage=1.3, pressure={0.5,0.8}, ramps={0.05,0.7}, clip=fg_grass})
work(midz, {hand="hatch", pile=grD, tool={kind="round", width=1.7, point=0.9}, angle=up, length={5,11}, coverage=1.2, pressure={0.45,0.75}, ramps={0.05,0.7}, clip=fg_grass})
work(farz, {hand="hatch", pile=grM, tool={kind="round", width=1.3, point=0.9}, angle=up, length={3,6}, coverage=1.0, pressure={0.4,0.7}, ramps={0.05,0.7}, clip=fg_grass})
print(wait(0))
