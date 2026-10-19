-- Darken the hull; light catches the sheer
hulld = pile{{"bone black", 0.7}, {"raw umber", 0.7}, {"cobalt blue", 0.25}, {"lead white", 0.2}}
warmpale2 = pile{{"lead white", 2.4}, {"vermilion", 0.12}, {"chrome yellow", 0.1}}

hull = ribbon({{350, 912}, {398, 917}, {442, 911}, {476, 901}}, {22, 30, 24, 7})
work(hull, {hand="body", pile=hulld, coverage=2.0, fill=true, angle=0.02, pressure={0.8, 0.95}, edge=0.25, clip=true})

sheer = below(function(x) return 910 - 0.03 * x end) * above(function(x) return 886 - 0.03 * x end)
       * mask(function(x) return x > 352 and x < 478 and 1 or 0 end)
stipple(sheer, {pile=warmpale2, width=2.5, coverage=0.22, pressure={0.2, 0.4}, drag={6, 0}, feather=1})
print("hull darkened")
