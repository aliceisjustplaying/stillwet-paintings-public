-- Tone: thin warm golden-grey wash over everything
wash = pile{{"vermilion", 0.5}, {"yellow ochre", 0.4}, {"raw umber", 0.35}, {"bone black", 0.16}, medium=0.75}
darkmix = pile{{"bone black", 0.55}, {"raw umber", 1}, {"cobalt blue", 0.7}, medium=0.2}
all = mask(function(x, y) return 1 end)
work(all, {hand="glaze", pile=wash, coverage=1.0, angle=0.05})
print("toned")
