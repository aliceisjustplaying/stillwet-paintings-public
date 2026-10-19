-- One cream glow mass, soft edges, then leave it alone
skyfixp = pile{{"lead white", 2.6}, {"chrome yellow", 0.5}, {"vermilion", 0.22}, {"raw umber", 0.1}}
softcream = rect(838, 250, 145, 240):soften(24)
work(softcream, {hand="body", pile=skyfixp, coverage=2.4, fill=true, angle=0.02, pressure={0.7, 0.85}, edge=1, clip=true})
work(softcream, {hand="scumble", pile=skyfixp, coverage=1.0, angle=0.02, edge=1})
blend(softcream, {coverage=0.8})
print("glow unified")
