-- Yacht: hull from a ribbon, cabin, furled sail, rigger mast
hullpile = pile{{"bone black", 0.6}, {"raw umber", 0.7}, {"cobalt blue", 0.35}, {"lead white", 0.35}, {"vermilion", 0.06}}
warmside = pile{{"lead white", 1.2}, {"vermilion", 0.35}, {"chrome yellow", 0.2}, {"raw umber", 0.15}}

hull = ribbon({{350, 912}, {398, 917}, {442, 911}, {476, 901}}, {22, 30, 24, 7})
work(hull, {hand="body", pile=hullpile, coverage=2.4, fill=true, angle=0.02, pressure={0.6, 0.8}, edge=0.4})

cabin = ribbon({{400, 894}, {446, 891}}, 15)
work(cabin, {hand="body", pile=hullpile, coverage=1.8, fill=true, angle=0.02, edge=0.5})

sail = ribbon({{424, 886}, {427, 800}, {428, 745}}, 7)
work(sail, {hand="body", pile=hullpile, coverage=1.6, fill=true, angle=0.02, edge=0.5})

mb = brush{kind="rigger", width=3.5, point=1, stiffness=0.5}
mb:load(hullpile, 0.95)
mast = outline{{420, 904}, {424, 830}, {427, 745}}
mast:paint(mb, {pressure=0.85, every=2})

hs = hull:rim(5, 2) * mask(function(x, y) return x > 424 and 1 or 0 end)
work(hs, {hand="scumble", pile=warmside, coverage=0.8, angle=0.02, edge=1})

print("yacht in")
