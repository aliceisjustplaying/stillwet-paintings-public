-- Dark slate at the top of the sky
slate = pile{{"lead white", 1.2}, {"cobalt blue", 1.6}, {"bone black", 0.2}, {"raw umber", 0.25}}
topband = above(function(x) return 185 + 30 * math.sin(x / 150) + 14 * math.sin(x / 57 + 2) end)
work(topband, {hand="broad", pile=slate, coverage=2.4, fill=true, angle=0.04, dips={70, 0.95, 0}, edge=0.7})
print("slate top")
