-- Matched water over the pale patch; clean slate behind the boat
watermid3 = pile{{"lead white", 1.0}, {"cobalt blue", 0.95}, {"raw umber", 0.45}, {"bone black", 0.35}, {"green earth", 0.28}, {"vermilion", 0.08}}

soft = rect(4, 838, 258, 118):soften(22)
work(soft, {hand="body", pile=watermid3, coverage=2.8, fill=true, angle=0.02, pressure={0.75, 0.9}, edge=1, clip=true})
blend(soft, {coverage=0.8})

slate = rect(300, 718, 225, 290)
work(slate, {hand="body", pile=watermid3, coverage=2.8, fill=true, angle=0.02, pressure={0.75, 0.9}, edge=1, clip=true})
work(slate, {hand="scumble", pile=watermid3, coverage=1.2, angle=0.02, edge=1})
blend(slate, {coverage=0.8})
print("clean slate")
