-- Bands 3+4: warm grey to pale gold, laid fast and generously
skyC = pile{{"lead white", 2.6}, {"cobalt blue", 0.5}, {"vermilion", 0.9}, {"chrome yellow", 1.1}}
b3 = below(function(x) return 395 + 35 * math.sin(x / 110 + 3) + 16 * math.sin(x / 41 + 1) end)
work(b3, {hand="broad", pile=skyC, coverage=2.2, fill=true, angle=0.05, dips={80, 0.95, 0}, edge=0.6})
print("band 3")
