-- Clean the bow, firm the mast, whisper the warm rim
hullpile = pile{{"bone black", 0.6}, {"raw umber", 0.7}, {"cobalt blue", 0.35}, {"lead white", 0.35}, {"vermilion", 0.06}}
warmpale2 = pile{{"lead white", 2.4}, {"vermilion", 0.12}, {"chrome yellow", 0.1}}

hull = ribbon({{350, 912}, {398, 917}, {442, 911}, {476, 901}}, {22, 30, 24, 7})
bowm = hull * mask(function(x, y) return x > 424 and 1 or 0 end)
work(bowm, {hand="body", pile=hullpile, coverage=2.2, fill=true, angle=0.02, pressure={0.65, 0.85}, edge=0.3, clip=true})

mb = brush{kind="rigger", width=3.5, point=1, stiffness=0.5}
mb:load(hullpile, 0.95)
mast = outline{{421, 890}, {425, 820}, {427, 748}}
mast:paint(mb, {pressure=0.55, every=2})

flecks = hull:rim(3, 1) * mask(function(x, y) return x > 432 and 1 or 0 end)
stipple(flecks, {pile=warmpale2, width=2.5, coverage=0.15, pressure={0.15, 0.3}, feather=1})

-- quiet the mottled halo beside the mast
halo = rect(404, 760, 46, 130)
blend(halo, {coverage=0.8})

print("bow cleaned")
