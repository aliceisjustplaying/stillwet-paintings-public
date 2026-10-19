local z = (bankM2 - above(function(x) return crestY(x)+4 end)) - keepOut
fgUp = pile{{"raw umber", 2.2}, {"green earth", 2.4}, {"yellow ochre", 0.5}, {"bone black", 0.5}, medium=0.08}
fgLow = pile{{"raw umber", 2.2}, {"green earth", 1.8}, {"bone black", 0.9}, {"Prussian blue", 0.1}, medium=0.08}
local up = z * above(function(x) return crestY(x) + 45 end)
local low = z - above(function(x) return crestY(x) + 35 end)
work(up, {hand="body", pile=fgUp, angle=-1.45, coverage=3.2, fill=true, clip=true, length={8,20}, tool="filbert 8"})
work(low, {hand="body", pile=fgLow, angle=-1.45, coverage=3.2, fill=true, clip=true, length={10,26}, tool="filbert 10"})
blend(z, {angle=-1.5, coverage=2, length={20,40}, tool="badger 20"})
