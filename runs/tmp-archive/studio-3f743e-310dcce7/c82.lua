-- Return the slab to the amber sky
goldsky = pile{{"lead white", 1.5}, {"chrome yellow", 0.7}, {"vermilion", 0.25}, {"raw umber", 0.3}, {"cobalt blue", 0.1}}
cloudtone = pile{{"lead white", 2.0}, {"chrome yellow", 0.3}, {"vermilion", 0.15}, {"raw umber", 0.2}}

z = rect(845, 218, 115, 230)
work(z, {hand="body", pile=goldsky, coverage=2.8, fill=true, angle=0.02, pressure={0.75, 0.9}, edge=0.5, clip=true})
blend(z, {coverage=0.8})

cz = rect(830, 240, 130, 180)
work(cz, {hand="scumble", pile=cloudtone, coverage=0.6, angle=0.02, edge=1})
print("slab to gold")
