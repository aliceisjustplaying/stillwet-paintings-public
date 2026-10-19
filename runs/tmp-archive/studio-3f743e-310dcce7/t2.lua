hullpile = pile{{"bone black", 0.6}, {"raw umber", 0.7}, {"cobalt blue", 0.35}, {"lead white", 0.35}, {"vermilion", 0.06}}
probe = rect(430, 880, 40, 40)
work(probe, {hand="body", pile=hullpile, coverage=2.2, fill=true, angle=0.02, pressure={0.65, 0.85}, edge=0.3, clip=true})
print("probe painted")
