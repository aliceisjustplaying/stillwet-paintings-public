bankTop = pile{{"raw umber", 2.2}, {"green earth", 2.5}, {"yellow ochre", 1}, {"bone black", 0.35}, {"lead white", 0.2}, medium=0.08}
bankMidP = pile{{"raw umber", 2.5}, {"green earth", 2}, {"yellow ochre", 0.5}, {"bone black", 0.6}, {"Prussian blue", 0.1}, medium=0.08}
bankLow = pile{{"raw umber", 2.5}, {"green earth", 1.5}, {"bone black", 1}, {"Prussian blue", 0.15}, medium=0.08}
local bn = noise{seed=51, octaves=3, period=90}
local z1 = below(function(x) return 612 + 14*bn(x, 1) end)
local z2 = below(function(x) return 660 + 16*bn(x, 2) end)
local bk = bankM2 - oakM2:shrink(1)
local ang = function(x, y) return -1.35 + 0.25*bn(x, y) end
work(bk - z1, {hand="body", pile=bankTop, angle=ang, coverage=2.5, fill=true, length={10,24}, edge="firm"})
work(bk * z1 - z2, {hand="body", pile=bankMidP, angle=ang, coverage=2.5, fill=true, length={12,28}})
work(bk * z2, {hand="body", pile=bankLow, angle=ang, coverage=2.5, fill=true, length={14,32}})
