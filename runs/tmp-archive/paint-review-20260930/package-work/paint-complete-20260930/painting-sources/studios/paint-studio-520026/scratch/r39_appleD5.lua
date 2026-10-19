D = ellipse(300, 655, 100, 96):roughen(4, 50, 3)
work(D, {pile=p_mid4, hand="broad", coverage=4.0, fill=true, load=1.0, pressure={1.0,1.0},
         dips={1,1.0,0.0}, angle=0.3, clip=true})
work(D, {pile=p_mid4, hand="broad", coverage=4.0, fill=true, load=1.0, pressure={1.0,1.0},
         dips={1,1.0,0.0}, angle=0.2, clip=true})
work(D, {pile=p_mid4, tool="filbert 16", length={40,90}, coverage=2.0, fill=true, load=1.0,
         pressure={1.0,0.9}, dips={1,1.0,0.0}, angle=0.3, clip=true})
work(D * ellipse(268, 622, 66, 62):soften(28), {pile=p_lit4, tool="filbert 16", length={40,90},
     coverage=1.7, fill=true, load=1.0, pressure={0.95,0.8}, dips={1,1.0,0.0}, angle=0.3, clip=true})
work(D * ellipse(326, 676, 86, 82):soften(24), {pile=p_tr4, tool="filbert 16", length={40,90},
     coverage=1.7, fill=true, load=1.0, pressure={0.95,0.8}, dips={1,1.0,0.0}, angle=0.3, clip=true})
work(D * ellipse(360, 710, 72, 68):soften(18), {pile=p_sh4, tool="filbert 16", length={40,90},
     coverage=2.0, fill=true, load=1.0, pressure={0.95,0.8}, dips={1,1.0,0.0}, angle=0.3, clip=true})
work(D * ellipse(304, 744, 76, 24):soften(12), {pile=p_refl4, tool="filbert 12", length={30,64},
     coverage=1.4, fill=true, load=1.0, pressure={0.95,0.8}, dips={1,1.0,0.0}, angle=1.5, clip=true})
blend(D:soften(5), {angle=0.3})
work(ellipse(260, 608, 19, 15):soften(7) * D:grow(6), {pile=p_hi4, tool="filbert 5",
     length={10,20}, coverage=1.6, fill=false, load=1.0, pressure={0.8,0.6}, clip=true})
print("apple D 5", wait(0))
