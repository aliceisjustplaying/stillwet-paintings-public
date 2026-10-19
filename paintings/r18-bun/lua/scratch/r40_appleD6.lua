p_rmid = pile{{"red earth", 3}, {"bone black", 2}, {"raw umber", 2}, {"vermilion", 1.2}, {"yellow ochre", 0.4}}
p_rlit = pile{{"red earth", 4}, {"vermilion", 1.6}, {"yellow ochre", 0.8}, {"lead white", 0.5}, {"raw umber", 1}}
p_rtr  = pile{{"red earth", 4}, {"bone black", 3}, {"raw umber", 2.5}, {"vermilion", 0.6}}
p_rsh  = pile{{"bone black", 3}, {"raw umber", 2}, {"red earth", 1}, {"Prussian blue", 0.3}}
p_rrfl = pile{{"red earth", 1.2}, {"lead white", 1.5}, {"yellow ochre", 0.5}}
p_rhi  = pile{{"lead white", 3.5}, {"vermilion", 0.9}, {"red earth", 0.4}, {"yellow ochre", 0.3}}
p_stem = pile{{"bone black", 2}, {"raw umber", 2}, {"red earth", 0.6}}
cloth_r = cloth:roughen(9, 70, 12)

D = ellipse(300, 655, 100, 96):roughen(4, 50, 3)
-- the shadow it throws on the cloth, away from the light
work(ellipse(352, 722, 100, 34):soften(30) * cloth_r * -D:grow(8), {pile=p_rsh, tool="filbert 20",
     length={50,100}, coverage=2.0, fill=true, load=1.0, pressure={0.9,0.75},
     dips={1,1.0,0.0}, angle=0.5, clip=true})
work(ellipse(318, 736, 66, 20):soften(12) * cloth_r * -D:grow(4), {pile=p_stem, tool="filbert 12",
     length={30,64}, coverage=2.0, fill=true, load=1.0, pressure={0.95,0.8},
     dips={1,1.0,0.0}, angle=0.5, clip=true})
-- the apple
work(D, {pile=p_rmid, hand="broad", coverage=4.5, fill=true, load=1.0, pressure={1.0,1.0},
         dips={1,1.0,0.0}, angle=0.3, clip=true})
work(D * ellipse(268, 622, 66, 62):soften(28), {pile=p_rlit, tool="filbert 16", length={40,90},
     coverage=1.6, fill=true, load=1.0, pressure={0.95,0.8}, dips={1,1.0,0.0}, angle=0.3, clip=true})
work(D * ellipse(326, 676, 86, 82):soften(24), {pile=p_rtr, tool="filbert 16", length={40,90},
     coverage=1.6, fill=true, load=1.0, pressure={0.95,0.8}, dips={1,1.0,0.0}, angle=0.3, clip=true})
work(D * ellipse(360, 710, 72, 68):soften(18), {pile=p_rsh, tool="filbert 16", length={40,90},
     coverage=1.9, fill=true, load=1.0, pressure={0.95,0.8}, dips={1,1.0,0.0}, angle=0.3, clip=true})
work(D * ellipse(304, 744, 76, 24):soften(12), {pile=p_rrfl, tool="filbert 12", length={30,64},
     coverage=1.4, fill=true, load=1.0, pressure={0.95,0.8}, dips={1,1.0,0.0}, angle=1.5, clip=true})
blend(D:soften(5), {angle=0.3})
work(ellipse(262, 612, 19, 15):soften(7) * D:grow(6), {pile=p_rhi, tool="filbert 5",
     length={10,20}, coverage=1.5, fill=false, load=1.0, pressure={0.8,0.6}, clip=true})
-- stalk and calyx
sb = brush{kind="round", width=7, point=0.9}
sb:load(p_stem, 0.95)
sb:stroke({{301, 574}, {307, 560}, {316, 546}}, {pressure={0.95,0.7,0.1}, clip=D:grow(14)})
print("apple D 6", wait(0))
