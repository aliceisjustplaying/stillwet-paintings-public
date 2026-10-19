blend(boulderM:shrink(1), {angle=-1.4, coverage=2.5, length={8,18}, tool="badger 12"})
-- a facet: a lighter plane on the left shoulder and one on the right, catching sky
local f1 = poly({{778, 648}, {784, 638}, {798, 634}, {796, 648}, {786, 656}}, false) * boulderM
local f2 = poly({{836, 636}, {852, 642}, {858, 656}, {846, 652}}, false) * boulderM
work(f1 + f2, {hand="detail", pile=stoneMid, angle=-0.8, coverage=1.5, clip=true, length={3,8}, pressure={0.3,0.6}})
