-- Heavy dark over the smothered treeline stretch
treedark3 = pile{{"lead white", 0.3}, {"cobalt blue", 0.5}, {"green earth", 0.3}, {"raw umber", 0.65}, {"bone black", 0.75}}
tltop = function(x) return 452 + 24 * math.sin(x / 23 + 1) + 16 * math.sin(x / 61) + 9 * math.sin(x / 13 + 2) end
hz = function(x) return 512 + 4 * math.sin(x / 40) end
zone = below(tltop) * above(hz) * rect(555, 400, 300, 130)
work(zone, {hand="body", pile=treedark3, coverage=3.0, fill=true, angle=0.02, pressure={0.8, 0.95}, edge=0.25, clip=true})
work(zone, {hand="scumble", pile=treedark3, coverage=2.0, angle=0.02, edge=0.3})
print("treeline restored")
