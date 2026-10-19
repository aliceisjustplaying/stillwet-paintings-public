-- Water: three fields over the old cream, blended
treedark2 = pile{{"lead white", 0.4}, {"cobalt blue", 0.55}, {"green earth", 0.3}, {"raw umber", 0.6}, {"bone black", 0.65}}
glowwater = pile{{"lead white", 1.2}, {"chrome yellow", 0.4}, {"vermilion", 0.2}, {"cobalt blue", 0.3}, {"raw umber", 0.3}}
watermid  = pile{{"lead white", 0.9}, {"cobalt blue", 1.0}, {"raw umber", 0.45}, {"bone black", 0.35}, {"green earth", 0.3}, {"vermilion", 0.1}}
waterdeep = pile{{"lead white", 0.7}, {"cobalt blue", 0.9}, {"raw umber", 0.6}, {"bone black", 0.55}, {"green earth", 0.35}, {"vermilion", 0.08}}

-- fill treeline holes
holes = ellipse(662, 452, 26, 20) + ellipse(938, 448, 22, 18) + ellipse(940, 462, 18, 14)
work(holes, {hand="detail", pile=treedark2, coverage=2.2, fill=true, edge=0.4, clip=true})

-- water fields
hz = function(x) return 512 + 4 * math.sin(x / 40) end
wg = below(function(x) return 610 + 15 * math.sin(x / 70) end) * above(hz)
work(wg, {hand="broad", pile=glowwater, coverage=2.6, fill=true, angle=0.02, pressure={0.7, 0.9}, edge=1})

wm = below(function(x) return 980 + 25 * math.sin(x / 80) end) * above(hz)
work(wm, {hand="broad", pile=watermid, coverage=2.6, fill=true, angle=0.02, pressure={0.7, 0.9}, edge=1})

wd = below(function(x) return 1260 end)
work(wd, {hand="broad", pile=waterdeep, coverage=2.6, fill=true, angle=0.02, pressure={0.7, 0.9}, edge=1})

print("water in")
