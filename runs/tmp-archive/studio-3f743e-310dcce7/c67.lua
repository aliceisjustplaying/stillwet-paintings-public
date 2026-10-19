-- Rims and streak calming (dry zones)
waterdeep = pile{{"lead white", 0.7}, {"cobalt blue", 0.9}, {"raw umber", 0.6}, {"bone black", 0.55}, {"green earth", 0.35}, {"vermilion", 0.08}}

rims = rect(0, 516, 12, 620) + rect(988, 516, 12, 620) + rect(0, 1120, 30, 132) + rect(970, 1120, 30, 132)
work(rims, {hand="body", pile=waterdeep, coverage=2.2, fill=true, angle=0.02, pressure={0.7, 0.9}, edge=1})

streakz = rect(0, 850, 260, 100)
work(streakz, {hand="scumble", pile=waterdeep, coverage=0.7, angle=0.02, edge=1})
print("rims and streak")
