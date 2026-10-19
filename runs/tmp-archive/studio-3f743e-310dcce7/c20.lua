-- Darker, greyer slate for the top band
slate2 = pile{{"lead white", 1}, {"cobalt blue", 0.9}, {"bone black", 0.45}, {"raw umber", 0.5}, {"vermilion", 0.15}}
topband = above(function(x) return 185 + 30 * math.sin(x / 150) + 14 * math.sin(x / 57 + 2) end)
work(topband, {hand="broad", pile=slate2, coverage=2.6, fill=true, angle=0.04, dips={70, 0.95, 0}, edge=0.7})
print("slate v2")
