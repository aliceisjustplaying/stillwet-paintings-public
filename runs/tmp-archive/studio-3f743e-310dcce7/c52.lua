-- Veils to knit the boat zone into the water
veil = pile{{"bone black", 0.25}, {"cobalt blue", 0.4}, {"raw umber", 0.4}, {"green earth", 0.2}, medium=0.65}

veilrect = rect(372, 930, 76, 118)
work(veilrect, {hand="body", pile=veil, coverage=0.9, angle=0.02, edge=1})

veilmast = rect(404, 742, 42, 170)
work(veilmast, {hand="body", pile=veil, coverage=0.8, angle=0.02, edge=1})

veilstreak = rect(280, 888, 90, 46)
work(veilstreak, {hand="body", pile=veil, coverage=0.7, angle=0.02, edge=1})

blend(veilrect, {coverage=0.7})
blend(veilmast, {coverage=0.7})
print("veils laid")
