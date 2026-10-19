p_rbase2 = pile{{"red earth", 3}, {"bone black", 1.6}, {"raw umber", 1.8}, {"vermilion", 1.6}, {"yellow ochre", 0.6}}
p_rlit3  = pile{{"vermilion", 2.5}, {"red earth", 2.5}, {"yellow ochre", 1}, {"lead white", 0.6}}
p_rrfl2  = pile{{"red earth", 1.2}, {"lead white", 1}, {"yellow ochre", 0.5}, {"vermilion", 0.3}}
D = ellipse(300, 655, 100, 96):roughen(4, 50, 3)
work(D, {pile=p_rbase2, hand="broad", coverage=4.5, fill=true, load=1.0, pressure={1.0,1.0},
         dips={1,1.0,0.0}, angle=0.3, clip=true})
work(D * ellipse(270, 626, 68, 64):soften(28), {pile=p_rlit3, tool="filbert 16", length={40,90},
     coverage=1.5, fill=true, load=1.0, pressure={0.95,0.8}, dips={1,1.0,0.0}, angle=0.3, clip=true})
work(D * ellipse(330, 684, 84, 80):soften(22), {pile=p_rtr, tool="filbert 16", length={40,90},
     coverage=1.7, fill=true, load=1.0, pressure={0.95,0.8}, dips={1,1.0,0.0}, angle=0.3, clip=true})
work(D * ellipse(362, 712, 70, 66):soften(16), {pile=p_rsh, tool="filbert 16", length={40,90},
     coverage=1.8, fill=true, load=1.0, pressure={0.95,0.8}, dips={1,1.0,0.0}, angle=0.3, clip=true})
work(D * ellipse(304, 744, 74, 22):soften(11), {pile=p_rrfl2, tool="filbert 12", length={30,64},
     coverage=1.3, fill=true, load=1.0, pressure={0.95,0.8}, dips={1,1.0,0.0}, angle=1.5, clip=true})
blend(D:soften(5), {angle=0.3})
work(ellipse(262, 612, 19, 15):soften(7) * D:grow(6), {pile=p_rhi, tool="filbert 5",
     length={10,20}, coverage=1.5, fill=false, load=1.0, pressure={0.8,0.6}, clip=true})
rg = brush{kind="round", width=7, point=0.95}
rg:load(p_stem, 1.0)
rg:stroke({{302, 576}, {308, 561}, {317, 546}}, {pressure={1.0,0.65,0.05}})
print("apple D 8", wait(0))
