-- Blend the water, close the rims, deepen the bottom
waterzone = below(function(x) return 512 + 4 * math.sin(x / 40) end)
blend(waterzone, {coverage=1.0})

waterdeep = pile{{"lead white", 0.7}, {"cobalt blue", 0.9}, {"raw umber", 0.6}, {"bone black", 0.55}, {"green earth", 0.35}, {"vermilion", 0.08}}
rims = rect(0, 514, 14, 740) + rect(986, 514, 14, 740) + rect(0, 1226, 1000, 26)
work(rims, {hand="body", pile=waterdeep, coverage=2.4, fill=true, angle=0.02, pressure={0.7, 0.9}, edge=1})
print("water blended, rims closed")
