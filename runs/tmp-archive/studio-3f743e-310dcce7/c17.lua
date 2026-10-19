-- Band 2: cool grey-mauve upper-middle sky
skyB = pile{{"lead white", 2.2}, {"cobalt blue", 1.3}, {"vermilion", 0.8}, {"chrome yellow", 0.5}}
b2 = below(function(x) return 300 + 40 * math.sin(x / 130 + 1) + 18 * math.sin(x / 47) end)
work(b2, {hand="broad", pile=skyB, coverage=1.7, fill=true, angle=0.05, dips={70, 0.95, 0}, edge=0.6})
print("band 2")
