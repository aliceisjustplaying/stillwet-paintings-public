bankPts = {{0,556},{80,553},{160,558},{260,568},{360,578},{460,584},{560,587},{660,586},{760,580},{860,574},{940,569},{1000,566}}
bankM2 = below(bankPts):roughen(2.5, 12, 3)
local add = bankM2 - bankM
work(add:grow(1), {hand="body", pile=bankP, angle=0, coverage=3, fill=true, length={15,40}, clip=true})
work(bankM2 * rect(0, 540, 1000, 80), {hand="body", pile=bankP, angle=-0.05, coverage=1.5, fill=true, length={20,50}})
