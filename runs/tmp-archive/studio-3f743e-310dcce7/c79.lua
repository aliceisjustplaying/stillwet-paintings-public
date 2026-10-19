-- Hull dark again, mast and cabin crisp
hulld = pile{{"bone black", 0.75}, {"raw umber", 0.7}, {"cobalt blue", 0.25}, {"lead white", 0.15}}
hull = ribbon({{350, 912}, {398, 917}, {442, 911}, {476, 901}}, {22, 30, 24, 7})
work(hull, {hand="body", pile=hulld, coverage=2.4, fill=true, angle=0.02, pressure={0.85, 0.95}, edge=0.25, clip=true})
work(hull, {hand="detail", pile=hulld, coverage=1.4, fill=true, angle=0.02, edge=0.2, clip=true})

cabin = ribbon({{402, 893}, {446, 890}}, 15)
work(cabin, {hand="body", pile=hulld, coverage=1.6, fill=true, angle=0.02, edge=0.3, clip=true})

mb = brush{kind="rigger", width=3.5, point=1, stiffness=0.5}
mb:load(hulld, 0.95)
mast = outline{{421, 892}, {424, 820}, {427, 744}}
mast:paint(mb, {pressure=0.55, every=2})
nub = ellipse(425, 808, 5, 13)
work(nub, {hand="detail", pile=hulld, coverage=1.6, fill=true, edge=0.25, clip=true})
print("boat dark and crisp")
