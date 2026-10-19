-- Darkening glaze over the pale patch, soft edges
veil2 = pile{{"cobalt blue", 0.7}, {"bone black", 0.25}, {"raw umber", 0.45}, {"green earth", 0.2}, medium=0.6}
soft = rect(4, 838, 258, 118):soften(22)
work(soft, {hand="body", pile=veil2, coverage=0.9, angle=0.02, edge=1, clip=true})
work(soft, {hand="scumble", pile=veil2, coverage=0.5, angle=0.02, edge=1})
blend(soft, {coverage=0.7})
print("glazed")
