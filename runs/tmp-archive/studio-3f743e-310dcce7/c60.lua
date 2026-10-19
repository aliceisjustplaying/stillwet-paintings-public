-- Give the right treeline its texture back
treedark2 = pile{{"lead white", 0.4}, {"cobalt blue", 0.55}, {"green earth", 0.3}, {"raw umber", 0.6}, {"bone black", 0.65}}
treedark3 = pile{{"lead white", 0.3}, {"cobalt blue", 0.5}, {"green earth", 0.3}, {"raw umber", 0.65}, {"bone black", 0.75}}
gold3  = pile{{"lead white", 3}, {"chrome yellow", 0.6}, {"vermilion", 0.2}}
hz = function(x) return 512 + 4 * math.sin(x / 40) end
stretch = rect(548, 388, 350, 140) * above(hz)

work(stretch, {hand="scumble", pile=treedark2, coverage=1.3, angle=0.02, edge=0.4})
speck = below(function(x) return 500 end) * stretch
stipple(speck, {pile=treedark3, width=4, coverage=0.7, pressure={0.25, 0.5}, feather=1})

tltop = function(x) return 452 + 20 * math.sin(x / 31 + 2) + 14 * math.sin(x / 67) end
topruff = below(function(x) return tltop(x) + 10 end) * above(function(x) return tltop(x) - 10 end) * stretch
stipple(topruff, {pile=treedark3, width=4, coverage=1.0, pressure={0.3, 0.6}, feather=1})

canopy = below(function(x) return tltop(x) + 26 end) * above(function(x) return tltop(x) - 2 end) * stretch
stipple(canopy, {pile=gold3, width=3, coverage=0.12, pressure={0.15, 0.4}, feather=1})
print("texture back")
