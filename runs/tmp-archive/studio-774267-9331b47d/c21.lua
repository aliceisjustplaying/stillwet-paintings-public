local z4 = mask(function(x, y) local a = 467 + 1.5*math.sin(x/50); return (y >= a and y < fg(x) + 2) and 1 or 0 end)
Z4 = z4
local zu = z4 - below(function(x) return 482 + 4*math.sin(x/60) end)
local zl = z4 - zu
local pu = pile{{"green earth", 2}, {"yellow ochre", 1.3}, {"chrome yellow", 0.2}, {"lead white", 1}, {"Prussian blue", 0.04}, medium=0.15}
local pl = pile{{"green earth", 2.2}, {"yellow ochre", 1.1}, {"chrome yellow", 0.1}, {"lead white", 0.5}, {"Prussian blue", 0.08}, {"raw umber", 0.15}, medium=0.15}
work(zu, {hand="body", tool="flat 6", pile=pu, angle=0, angle_jitter=0.05, length={30,90}, coverage=2, fill=true, edge="firm", seed=2101})
work(zl, {hand="body", tool="flat 7", pile=pl, angle=0.02, angle_jitter=0.06, length={30,90}, coverage=2, fill=true, edge="firm", seed=2102})
blend(z4, {angle=0, ruler=true, length={80,250}, coverage=1.3, seed=2103})
