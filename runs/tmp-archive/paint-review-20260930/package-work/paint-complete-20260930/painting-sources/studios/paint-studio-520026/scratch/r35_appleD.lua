p_r_mid  = pile{{"vermilion", 5}, {"red earth", 3}, {"raw umber", 1.2}, {"yellow ochre", 0.6}}
p_r_lit  = pile{{"vermilion", 5}, {"red earth", 1.5}, {"yellow ochre", 1.2}, {"lead white", 1.2}}
p_r_sh   = pile{{"vermilion", 2}, {"red earth", 2.5}, {"raw umber", 2}, {"bone black", 1.2}}
p_r_dk   = pile{{"red earth", 2}, {"raw umber", 2}, {"bone black", 2}, {"Prussian blue", 0.5}}
p_r_refl = pile{{"red earth", 1.5}, {"lead white", 1.6}, {"vermilion", 0.6}, {"yellow ochre", 0.5}}
p_r_hi   = pile{{"vermilion", 3}, {"lead white", 3}, {"yellow ochre", 0.8}, {"red earth", 0.5}}

D = ellipse(300, 655, 100, 96):roughen(4, 50, 3)
work(D, {pile=p_r_mid, hand="broad", coverage=4.0, fill=true, load=1.0, pressure={1.0,1.0},
         dips={1,1.0,0.0}, angle=0.3, clip=true})
work(D * ellipse(268, 616, 84, 80):soften(28), {pile=p_r_lit, tool="filbert 16", length={40,90},
     coverage=2.0, fill=true, load=1.0, pressure={0.95,0.8}, dips={1,1.0,0.0}, angle=0.3, clip=true})
work(D * ellipse(342, 702, 92, 86):soften(24), {pile=p_r_sh, tool="filbert 16", length={40,90},
     coverage=2.2, fill=true, load=1.0, pressure={0.95,0.8}, dips={1,1.0,0.0}, angle=0.3, clip=true})
work(D * ellipse(358, 716, 74, 70):soften(20), {pile=p_r_dk, tool="filbert 16", length={30,64},
     coverage=1.8, fill=true, load=1.0, pressure={0.95,0.8}, dips={1,1.0,0.0}, angle=0.3, clip=true})
work(D * ellipse(306, 738, 84, 32):soften(15), {pile=p_r_refl, tool="filbert 12", length={30,64},
     coverage=1.6, fill=true, load=1.0, pressure={0.95,0.8}, dips={1,1.0,0.0}, angle=1.5, clip=true})
blend(D:soften(5), {angle=0.3})
work(ellipse(264, 612, 25, 21):soften(9) * D:grow(4), {pile=p_r_hi, tool="filbert 8",
     length={16,34}, coverage=1.4, fill=true, load=1.0, pressure={0.9,0.7}, clip=true})
print("apple D", wait(0))
