-- Amber sky above, tall dark headland below, burning rim between
amber2 = pile{{"lead white", 1.0}, {"chrome yellow", 0.5}, {"vermilion", 0.25}, {"raw umber", 0.55}, {"cobalt blue", 0.1}}
cloudtone = pile{{"lead white", 2.0}, {"chrome yellow", 0.3}, {"vermilion", 0.15}, {"raw umber", 0.2}}
treedark3 = pile{{"lead white", 0.3}, {"cobalt blue", 0.5}, {"green earth", 0.3}, {"raw umber", 0.65}, {"bone black", 0.75}}
bright = pile{{"lead white", 2.2}, {"chrome yellow", 0.5}, {"vermilion", 0.25}}

ambez = rect(450, 215, 550, 140)
work(ambez, {hand="body", pile=amber2, coverage=2.8, fill=true, angle=0.02, pressure={0.75, 0.9}, edge=1, clip=true})
blend(ambez, {coverage=0.8})
work(rect(460, 250, 530, 90), {hand="scumble", pile=cloudtone, coverage=0.5, angle=0.02, edge=1})

hz = function(x) return 512 + 4 * math.sin(x / 40) end
headz = below(function(x) return 348 + 12 * math.sin(x / 61 + 2) end) * above(hz) * rect(440, 330, 560, 220)
work(headz, {hand="body", pile=treedark3, coverage=3.0, fill=true, angle=0.02, pressure={0.8, 0.95}, edge=0.2, clip=true})
work(headz, {hand="scumble", pile=treedark3, coverage=1.6, angle=0.02, edge=0.25})

rimz = below(function(x) return 360 + 12 * math.sin(x / 61 + 2) end) * above(function(x) return 336 + 12 * math.sin(x / 61 + 2) end) * rect(450, 320, 550, 60)
stipple(rimz, {pile=bright, width=3, coverage=0.5, pressure={0.25, 0.55}, feather=1})
print("headland resolved")
