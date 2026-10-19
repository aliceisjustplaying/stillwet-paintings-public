-- granite boulder, lower right
stoneP = pile{{"lead white", 1}, {"raw umber", 1.2}, {"bone black", 0.4}, {"smalt", 0.2}, {"yellow ochre", 0.2}, medium=0.05}
stoneD = pile{{"raw umber", 1.6}, {"bone black", 0.9}, {"green earth", 0.4}, {"lead white", 0.25}, medium=0.05}
stoneLit = pile{{"lead white", 2}, {"raw umber", 0.7}, {"yellow ochre", 0.4}, {"smalt", 0.2}, medium=0.05}
lichenP = pile{{"yellow ochre", 1.5}, {"lead white", 1}, {"green earth", 0.6}, {"raw umber", 0.3}, medium=0.05}
local o = outline{{770, 668, "c"}, {776, 646}, {795, 632}, {822, 629}, {846, 638}, {858, 655}, {862, 670, "c"}, char="broken", seed=41, closed=true}
boulderM = o:mask()
work(boulderM, {hand="body", pile=stoneP, angle=-0.4, coverage=3, fill=true, clip=true, length={4,10}, tool="filbert 4"})
local bsh = boulderM * mask(function(x, y) return (y > 652 + (x - 770) * 0.05) and 1 or 0 end)
work(bsh, {hand="body", pile=stoneD, angle=-0.2, coverage=2.5, fill=true, clip=true, length={4,10}, tool="filbert 4"})
blend(boulderM, {angle=-0.3, coverage=1.5, length={8,20}, tool="badger 12"})
