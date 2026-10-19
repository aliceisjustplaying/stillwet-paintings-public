p_mid3 = pile{{"red earth", 4}, {"vermilion", 1.5}, {"raw umber", 1.5}, {"yellow ochre", 0.4}}
p_lit3 = pile{{"red earth", 3}, {"vermilion", 2.2}, {"yellow ochre", 0.9}, {"lead white", 0.7}}
p_sh3  = pile{{"raw umber", 2}, {"bone black", 2}, {"red earth", 1.5}, {"Prussian blue", 0.3}}
p_dk3  = pile{{"bone black", 3}, {"raw umber", 1.2}, {"red earth", 0.6}, {"Prussian blue", 0.4}}
p_refl3= pile{{"red earth", 1.5}, {"lead white", 1.5}, {"vermilion", 0.3}, {"yellow ochre", 0.5}}
p_hi3  = pile{{"lead white", 4}, {"vermilion", 1}, {"red earth", 0.5}, {"yellow ochre", 0.3}}
p_mot_a= pile{{"yellow ochre", 2}, {"red earth", 2}, {"vermilion", 0.8}}
p_mot_b= pile{{"red earth", 3}, {"bone black", 1}, {"vermilion", 0.5}}

D = ellipse(300, 655, 100, 96):roughen(4, 50, 3)
work(D, {pile=p_mid3, hand="broad", coverage=3.2, fill=true, load=1.0, pressure={1.0,1.0},
         dips={1,1.0,0.0}, angle=0.3, clip=true})
work(D * ellipse(272, 628, 76, 72):soften(30), {pile=p_lit3, tool="filbert 16", length={40,90},
     coverage=1.5, fill=true, load=1.0, pressure={0.95,0.8}, dips={1,1.0,0.0}, angle=0.3, clip=true})
work(D * ellipse(352, 706, 80, 76):soften(20), {pile=p_sh3, tool="filbert 16", length={40,90},
     coverage=2.0, fill=true, load=1.0, pressure={0.95,0.8}, dips={1,1.0,0.0}, angle=0.3, clip=true})
work(D * ellipse(368, 720, 58, 54):soften(16), {pile=p_dk3, tool="filbert 16", length={30,64},
     coverage=1.6, fill=true, load=1.0, pressure={0.95,0.8}, dips={1,1.0,0.0}, angle=0.3, clip=true})
work(D * ellipse(304, 744, 76, 26):soften(12), {pile=p_refl3, tool="filbert 12", length={30,64},
     coverage=1.3, fill=true, load=1.0, pressure={0.95,0.8}, dips={1,1.0,0.0}, angle=1.5, clip=true})
blend(D:soften(5), {angle=0.3})
-- fine flecks of skin colour, stippled so they read as texture and not as spots
stipple(D, {pile=p_mot_a, width=2, coverage=0.45, pressure={0.5,0.35}, cluster={0.5, 26}, clip=true})
stipple(D, {pile=p_mot_b, width=2, coverage=0.35, pressure={0.5,0.35}, cluster={0.5, 30}, clip=true})
work(ellipse(260, 608, 20, 16):soften(7) * D:grow(6), {pile=p_hi3, tool="filbert 6",
     length={10,22}, coverage=1.0, fill=true, load=1.0, pressure={0.85,0.6}, clip=true})
print("apple D 3", wait(0))
