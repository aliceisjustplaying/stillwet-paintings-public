local fl = poly({{286, 528}, {283, 545}, {278, 558}, {272, 572}, {273, 590}, {326, 590}, {324, 572}, {321, 558}, {319, 545}, {318, 528}}, true)
local col = fl + (oakM2 * rect(255, 470, 100, 131)) + rootM2
work(col, {hand="detail", pile=barkD, angle=-1.5708, coverage=4, fill=true, clip=true, length={6,16}})
work(col * mask(function(x, y) return x < 294 - (y - 470) * 0.12 and 1 or 0 end), {hand="detail", pile=barkDark, angle=-1.5708, coverage=1.5, clip=true, length={6,16}, pressure={0.3,0.6}})
blend(col, {angle=-1.5708, coverage=2, length={15,40}, tool="badger 12", clip=true})
local rim = (col - col:shrink(2.5)) * mask(function(x, y) return x > 306 and 1 or 0 end) - rect(0, 588, 1000, 30)
work(rim, {hand="detail", pile=barkRim, angle=-1.5708, coverage=1.4, clip=true, length={6,16}, pressure={0.3,0.55}})
