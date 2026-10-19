-- Marry the three hard boundaries
amber2 = pile{{"lead white", 1.0}, {"chrome yellow", 0.5}, {"vermilion", 0.25}, {"raw umber", 0.55}, {"cobalt blue", 0.1}}
cloudtone = pile{{"lead white", 2.0}, {"chrome yellow", 0.3}, {"vermilion", 0.15}, {"raw umber", 0.2}}
treedark3 = pile{{"lead white", 0.3}, {"cobalt blue", 0.5}, {"green earth", 0.3}, {"raw umber", 0.65}, {"bone black", 0.75}}
skymid2 = pile{{"lead white", 1.3}, {"cobalt blue", 0.8}, {"raw umber", 0.35}, {"vermilion", 0.2}}
hz = function(x) return 512 + 4 * math.sin(x / 40) end

ambLz = rect(420, 218, 70, 135):soften(16)
work(ambLz, {hand="scumble", pile=cloudtone, coverage=0.9, angle=0.02, edge=1})
work(ambLz, {hand="scumble", pile=amber2, coverage=0.7, angle=0.02, edge=1})
blend(ambLz, {coverage=0.9})

topz2 = rect(450, 193, 550, 46):soften(14)
work(topz2, {hand="scumble", pile=skymid2, coverage=0.6, angle=0.02, edge=1})
blend(topz2, {coverage=0.9})

headl = below(function(x) return 448 + 18 * math.sin(x / 31 + 2) + 10 * math.sin(x / 67) end)
       * above(hz) * rect(300, 330, 190, 220)
work(headl, {hand="body", pile=treedark3, coverage=2.2, fill=true, angle=0.02, pressure={0.75, 0.9}, edge=0.4, clip=true})

tope = below(function(x) return 358 + 12 * math.sin(x / 61 + 2) end) * above(function(x) return 340 + 12 * math.sin(x / 61 + 2) end) * rect(440, 330, 560, 40)
stipple(tope, {pile=treedark3, width=4, coverage=0.9, pressure={0.3, 0.6}, feather=1})
print("married")
