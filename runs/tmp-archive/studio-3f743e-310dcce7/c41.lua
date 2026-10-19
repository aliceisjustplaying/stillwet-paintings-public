-- Bow over tacky paint: solid dark, two passes
hullpile = pile{{"bone black", 0.6}, {"raw umber", 0.7}, {"cobalt blue", 0.35}, {"lead white", 0.35}, {"vermilion", 0.06}}
hullpile2 = pile{{"bone black", 0.7}, {"raw umber", 0.8}, {"cobalt blue", 0.3}, {"lead white", 0.3}}

hull = ribbon({{350, 912}, {398, 917}, {442, 911}, {476, 901}}, {22, 30, 24, 7})
bowm = hull * mask(function(x, y) return x > 420 and 1 or 0 end)
work(bowm, {hand="body", pile=hullpile, coverage=2.6, fill=true, angle=0.02, pressure={0.75, 0.95}, edge=0.25, clip=true})
work(bowm, {hand="detail", pile=hullpile2, coverage=1.6, fill=true, angle=0.02, edge=0.2, clip=true})
print("bow covered")
