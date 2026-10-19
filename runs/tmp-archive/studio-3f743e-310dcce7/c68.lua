-- Cover the dark speckle swarm with matched water
watermid2 = pile{{"lead white", 1.05}, {"cobalt blue", 0.85}, {"raw umber", 0.35}, {"bone black", 0.28}, {"green earth", 0.25}, {"vermilion", 0.08}}
z = rect(0, 828, 270, 140)
work(z, {hand="body", pile=watermid2, coverage=2.4, fill=true, angle=0.02, pressure={0.7, 0.9}, edge=1, clip=true})
work(z, {hand="scumble", pile=watermid2, coverage=1.2, angle=0.02, edge=1})
blend(z, {coverage=0.8})
print("swarm covered")
print("boat:", drying(420, 910), "bank:", drying(600, 1150))
