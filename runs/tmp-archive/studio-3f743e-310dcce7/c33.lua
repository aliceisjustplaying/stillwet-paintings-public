-- The moored yacht
hullpile = pile{{"bone black", 0.6}, {"raw umber", 0.7}, {"cobalt blue", 0.35}, {"lead white", 0.35}, {"vermilion", 0.06}}
warmside = pile{{"lead white", 1.2}, {"vermilion", 0.35}, {"chrome yellow", 0.2}, {"raw umber", 0.15}}

hull = body_of{spine = {{352, 912}, {398, 916}, {442, 910}, {474, 902}}, widths = {26, 34, 26, 8}, char="firm"}
work(hull:mask(), {hand="body", pile=hullpile, coverage=2.2, fill=true, angle=0.02, pressure={0.6, 0.8}, edge=0.5})

cabin = ribbon({{398, 893}, {444, 890}}, 16)
work(cabin, {hand="body", pile=hullpile, coverage=1.6, fill=true, angle=0.02, edge=0.6})

-- furled sail along the mast
sail = ribbon({{424, 886}, {427, 800}, {428, 745}}, 7)
work(sail, {hand="body", pile=hullpile, coverage=1.4, fill=true, angle=0.02, edge=0.6})

-- mast: a rigger line, tapering
mb = brush{kind="rigger", width=3.5, point=1, stiffness=0.5}
mb:load(hullpile, 0.95)
mast = outline{{420, 902}, {424, 830}, {427, 745}}
mast:paint(mb, {pressure={0.85, 0.5}, every=2})

-- warm side scumble where the light path is
hs = hull:mask():rim(6, 2)
work(hs * mask(function(x, y) return x > 420 and 1 or 0 end), {hand="scumble", pile=warmside, coverage=0.8, angle=0.02, edge=1})

print("yacht in")
