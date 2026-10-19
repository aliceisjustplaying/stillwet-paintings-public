-- Stray pink flecks + foreground spit
hullpile2 = pile{{"bone black", 0.7}, {"raw umber", 0.8}, {"cobalt blue", 0.3}, {"lead white", 0.3}}
spitdark  = pile{{"raw umber", 1}, {"bone black", 0.45}, {"green earth", 0.35}, {"cobalt blue", 0.2}, {"lead white", 0.25}}

strays = ellipse(474, 887, 9, 7) + ellipse(418, 922, 12, 8) + ellipse(408, 916, 8, 6) + ellipse(441, 926, 6, 4)
work(strays, {hand="detail", pile=hullpile2, coverage=2.0, fill=true, edge=0.3, clip=true})

spit = below(function(x) return 1130 + 26 * math.sin(x / 90 + 1) + 14 * math.sin(x / 38 + 2) - 0.28 * x end)
work(spit, {hand="broad", pile=spitdark, coverage=2.6, fill=true, angle=0.05, pressure={0.7, 0.9}, edge=0.7})
print("spit in")
