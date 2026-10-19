-- Rebuild the yacht, crisp, on the clean water
hullc = pile{{"bone black", 0.55}, {"raw umber", 0.65}, {"cobalt blue", 0.3}, {"lead white", 0.3}}
warmfleck = pile{{"lead white", 2.0}, {"vermilion", 0.3}, {"chrome yellow", 0.15}}
warmpale2 = pile{{"lead white", 2.4}, {"vermilion", 0.12}, {"chrome yellow", 0.1}}

hull = ribbon({{350, 912}, {398, 917}, {442, 911}, {476, 901}}, {22, 30, 24, 7})
work(hull, {hand="body", pile=hullc, coverage=2.6, fill=true, angle=0.02, pressure={0.8, 0.95}, edge=0.25, clip=true})
work(hull, {hand="detail", pile=hullc, coverage=1.5, fill=true, angle=0.02, edge=0.2, clip=true})

cabin = ribbon({{402, 893}, {446, 890}}, 15)
work(cabin, {hand="body", pile=hullc, coverage=1.8, fill=true, angle=0.02, edge=0.3, clip=true})

mb = brush{kind="rigger", width=3.5, point=1, stiffness=0.5}
mb:load(hullc, 0.95)
mast = outline{{421, 893}, {424, 820}, {427, 742}}
mast:paint(mb, {pressure=0.5, every=2})

nub = ellipse(425, 808, 5, 13)
work(nub, {hand="detail", pile=hullc, coverage=1.8, fill=true, edge=0.25, clip=true})

stipple(hull:rim(3, 1) * mask(function(x, y) return x > 430 and 1 or 0 end),
  {pile=warmpale2, width=2.5, coverage=0.12, pressure={0.15, 0.3}, feather=1})

-- broken reflection: short horizontal dark dashes below the hull
reflz = rect(360, 936, 110, 80)
stipple(reflz, {pile=hullc, width=4, coverage=0.25, pressure={0.2, 0.45}, drag={9, 0}, feather=1})
print("yacht rebuilt")
