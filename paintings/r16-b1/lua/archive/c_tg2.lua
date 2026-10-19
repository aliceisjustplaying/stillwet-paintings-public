local fl = poly({{286, 528}, {283, 545}, {278, 558}, {272, 572}, {273, 590}, {326, 590}, {324, 572}, {321, 558}, {319, 545}, {318, 528}}, true)
local col = fl + (oakM2 * rect(255, 476, 100, 125)) + rootM2
blend(col, {angle=-1.5708, coverage=3, length={30, 80}, tool="badger 20", clip=true})
blend(col, {angle=-1.4, coverage=2, length={20, 50}, tool="badger 20", clip=true})
