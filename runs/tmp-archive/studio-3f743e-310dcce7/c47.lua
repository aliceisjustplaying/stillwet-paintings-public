-- Firm the spit edge, knock back floaters, finish boat strays
spitdark  = pile{{"raw umber", 1}, {"bone black", 0.45}, {"green earth", 0.35}, {"cobalt blue", 0.2}, {"lead white", 0.25}}
watermid  = pile{{"lead white", 0.9}, {"cobalt blue", 1.0}, {"raw umber", 0.45}, {"bone black", 0.35}, {"green earth", 0.3}, {"vermilion", 0.1}}
hullpile2 = pile{{"bone black", 0.7}, {"raw umber", 0.8}, {"cobalt blue", 0.3}, {"lead white", 0.3}}

spit = below(function(x) return 1150 + 26 * math.sin(x / 90 + 1) + 14 * math.sin(x / 38 + 2) - 0.28 * x end)
work(spit, {hand="body", pile=spitdark, coverage=1.8, fill=true, angle=0.05, pressure={0.7, 0.9}, edge=0.15})

floaters = ellipse(172, 950, 22, 8) + ellipse(30, 1100, 30, 12) + ellipse(20, 980, 16, 30)
work(floaters, {hand="body", pile=watermid, coverage=1.6, fill=true, angle=0.02, edge=1})

strays2 = ellipse(468, 886, 14, 9) + ellipse(478, 896, 10, 7) + ellipse(452, 891, 9, 6)
work(strays2, {hand="detail", pile=hullpile2, coverage=2.2, fill=true, edge=0.25, clip=true})
print("cleanup done")
