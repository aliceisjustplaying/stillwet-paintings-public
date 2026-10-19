-- Fix the mast area: cover the fat column, redraw thin mast, faint warm rim
watermid  = pile{{"lead white", 0.9}, {"cobalt blue", 1.0}, {"raw umber", 0.45}, {"bone black", 0.35}, {"green earth", 0.3}, {"vermilion", 0.1}}
hullpile = pile{{"bone black", 0.6}, {"raw umber", 0.7}, {"cobalt blue", 0.35}, {"lead white", 0.35}, {"vermilion", 0.06}}
warmpale2 = pile{{"lead white", 2.4}, {"vermilion", 0.12}, {"chrome yellow", 0.1}}

col = rect(408, 738, 36, 152)
work(col, {hand="body", pile=watermid, coverage=2.2, fill=true, angle=0.02, pressure={0.6, 0.8}, edge=1})

mb = brush{kind="rigger", width=3.5, point=1, stiffness=0.5}
mb:load(hullpile, 0.95)
mast = outline{{421, 892}, {424, 830}, {427, 748}}
mast:paint(mb, {pressure=0.5, every=2})

nub = ellipse(425, 812, 5, 14)
work(nub, {hand="detail", pile=hullpile, coverage=1.6, fill=true, edge=0.3, clip=true})

rim = hull:rim(4, 1.5) * mask(function(x, y) return x > 428 and 1 or 0 end)
stipple(rim, {pile=warmpale2, width=3, coverage=0.5, pressure={0.2, 0.4}, feather=1})

print("mast fixed")
