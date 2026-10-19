trunkGl = pile{{"raw umber", 1.6}, {"bone black", 0.8}, {"green earth", 0.4}, {"Prussian blue", 0.05}, medium=0.55}
local fl = poly({{286, 528}, {283, 545}, {278, 558}, {272, 572}, {273, 590}, {326, 590}, {324, 572}, {321, 558}, {319, 545}, {318, 528}}, true)
local col = fl + (oakM2 * rect(255, 476, 100, 125)) + rootM2
work(col, {hand="glaze", pile=trunkGl, angle=-1.5708, coverage=1.3, clip=true, length={40, 110}, load_at=function(x, y) return clamp(0.55 + (305 - x) * 0.012, 0.3, 0.85) end})
work(col * mask(function(x, y) return x < 293 and 1 or 0 end), {hand="glaze", pile=trunkGl, angle=-1.5708, coverage=1.0, clip=true, length={40, 110}, load_at=0.6})
