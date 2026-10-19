local m = (ellipse(222, 158, 30, 13):roughen(5, 10, 141, 0) + ellipse(246, 180, 13, 10):roughen(4, 8, 142, 0) + ellipse(262, 170, 8, 6):roughen(3, 6, 143, 0))
stipple(m, {pile=pTC, width=5, coverage=3.2, pressure={0.6,0.95}, dips={14,0.9,0.2}, drag={2.5, 0.7}, twist=0.6, cluster={0.3,4}, clip=m:grow(1.5)})
trees = trees + m
-- sliver under the bank
local sl = rect(290, 468, 190, 12) * mask(function(x,y) return 1 end) - openW:grow(2)
local sl2 = sl * (refl2:grow(6))
work(sl2, {hand="detail", tool={kind="flat", width=4}, pile=pR1, coverage=4, load=0.95, fill=true})
