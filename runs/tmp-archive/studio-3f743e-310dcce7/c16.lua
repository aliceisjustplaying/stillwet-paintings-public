-- Sky band 1: top of sky, cool warm-grey blue
skyA = pile{{"lead white", 1}, {"cobalt blue", 2.5}, {"vermilion", 2}, {"chrome yellow", 2}}
top = below(function(x) return 190 + 30 * math.sin(x / 150) + 14 * math.sin(x / 57 + 2) end)
work(top, {hand="broad", pile=skyA, coverage=1.6, fill=true, angle=0.04, dips={70, 0.95, 0}, edge=0.5})
print("band 1")
