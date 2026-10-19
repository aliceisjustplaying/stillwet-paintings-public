p_r_mid2 = pile{{"red earth", 4}, {"vermilion", 2}, {"raw umber", 1.5}, {"yellow ochre", 0.5}}
p_r_lit2 = pile{{"red earth", 2.4}, {"vermilion", 3}, {"yellow ochre", 1.4}, {"lead white", 1.2}}
p_r_sh2  = pile{{"red earth", 2}, {"raw umber", 2}, {"bone black", 1.4}, {"vermilion", 0.5}}
p_r_dk2  = pile{{"raw umber", 1.5}, {"bone black", 2.2}, {"red earth", 1}, {"Prussian blue", 0.3}}
p_r_refl2= pile{{"red earth", 1.2}, {"lead white", 2}, {"vermilion", 0.4}, {"yellow ochre", 0.6}}
p_hi3    = pile{{"lead white", 5}, {"vermilion", 0.8}, {"red earth", 0.4}, {"yellow ochre", 0.3}}
p_r_y    = pile{{"yellow ochre", 3}, {"red earth", 1}, {"vermilion", 0.5}}
p_r_c    = pile{{"red earth", 3}, {"vermilion", 1}, {"bone black", 0.6}, {"Prussian blue", 0.3}}

D = ellipse(300, 655, 100, 96):roughen(4, 50, 3)
work(D, {pile=p_r_mid2, hand="broad", coverage=3.0, fill=true, load=1.0, pressure={1.0,1.0},
         dips={1,1.0,0.0}, angle=0.3, clip=true})
work(D * ellipse(276, 632, 78, 74):soften(30), {pile=p_r_lit2, tool="filbert 16", length={40,90},
     coverage=1.7, fill=true, load=1.0, pressure={0.95,0.8}, dips={1,1.0,0.0}, angle=0.3, clip=true})
work(D * ellipse(322, 680, 88, 84):soften(26), {pile=p_r_sh2, tool="filbert 16", length={40,90},
     coverage=1.9, fill=true, load=1.0, pressure={0.95,0.8}, dips={1,1.0,0.0}, angle=0.3, clip=true})
work(D * ellipse(352, 708, 76, 72):soften(22), {pile=p_r_dk2, tool="filbert 16", length={30,64},
     coverage=1.6, fill=true, load=1.0, pressure={0.95,0.8}, dips={1,1.0,0.0}, angle=0.3, clip=true})
work(D * ellipse(304, 742, 80, 28):soften(14), {pile=p_r_refl2, tool="filbert 12", length={30,64},
     coverage=1.5, fill=true, load=1.0, pressure={0.95,0.8}, dips={1,1.0,0.0}, angle=1.5, clip=true})
blend(D:soften(5), {angle=0.3})
-- the apple's own colour varies: warm patches where the sun struck, crimson elsewhere
work(D * ellipse(258, 600, 58, 50):soften(26), {pile=p_r_y, tool="filbert 20", length={40,90},
     coverage=0.9, fill=true, load=1.0, pressure={0.85,0.7}, dips={1,1.0,0.0}, angle=0.3, clip=true})
work(D * ellipse(340, 640, 64, 58):soften(30), {pile=p_r_c, tool="filbert 20", length={40,90},
     coverage=0.9, fill=true, load=1.0, pressure={0.85,0.7}, dips={1,1.0,0.0}, angle=0.3, clip=true})
work(D * ellipse(250, 690, 46, 40):soften(24), {pile=p_r_y, tool="filbert 16", length={30,64},
     coverage=0.7, fill=true, load=1.0, pressure={0.85,0.7}, clip=true})
work(ellipse(262, 610, 22, 18):soften(8) * D:grow(6), {pile=p_hi3, tool="filbert 7",
     length={12,26}, coverage=1.3, fill=true, load=1.0, pressure={0.9,0.7}, clip=true})
print("apple D 2", wait(0))
