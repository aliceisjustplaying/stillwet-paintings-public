-- Cloud bank shaping: cool knit on top edge, violet shadow under the left
coolknit = pile{{"lead white", 1.4}, {"cobalt blue", 0.5}, {"vermilion", 0.25}, {"raw umber", 0.2}}
undersh  = pile{{"lead white", 1}, {"cobalt blue", 0.4}, {"vermilion", 0.3}, {"bone black", 0.15}, {"raw umber", 0.3}}

c150 = function(x) return 150 + 25 * math.sin(x / 120 + 1) end
c268 = function(x) return 268 + 22 * math.sin(x / 95 + 2) end
c292 = function(x) return 292 + 25 * math.sin(x / 105 + 3) end
c378 = function(x) return 378 + 20 * math.sin(x / 85) end

kz = above(c150) * below(c268) * mask(function(x) return x < 600 and 1 or 0.4 end)
work(kz, {hand="scumble", pile=coolknit, coverage=1.2, angle=0.05, edge=1})

uz = above(c292) * below(c378) * mask(function(x) return x < 520 and 1 or 0.3 end)
work(uz, {hand="scumble", pile=undersh, coverage=1.1, angle=0.05, edge=1})

blend(kz, {coverage=0.6})
blend(uz, {coverage=0.6})
print("bank shaped")
