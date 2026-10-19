p_bo4_lit = pile{{"raw umber", 3}, {"lead white", 1.8}, {"bone black", 0.6}, {"yellow ochre", 0.5}}
p_bo4_mid = pile{{"raw umber", 3.5}, {"bone black", 1.2}, {"lead white", 1}, {"red earth", 0.8}}
p_bo4_sh  = pile{{"raw umber", 2.5}, {"bone black", 2}, {"red earth", 0.6}, {"Prussian blue", 0.3}}
p_bo4_dk  = pile{{"bone black", 3}, {"raw umber", 1.5}, {"Prussian blue", 0.5}, {"red earth", 0.3}}
cloth_r = cloth:roughen(9, 70, 12)

-- the old bowl's wings stick out past the new profile: put the cloth back
work((ellipse(358,506,44,30):soften(16) + ellipse(802,506,44,30):soften(16))*cloth_r,
     {pile=p_clm4, hand="broad", coverage=2.4, fill=true, load=1.0, pressure={1.0,0.9},
      dips={1,1.0,0.0}, angle=0.3, clip=true})

rim_o  = ellipse(580, 500, 200, 64)
skirt  = poly({{392,506},{396,532},{408,560},{430,583},{462,600},{504,613},{544,621},
               {580,625},{616,621},{656,613},{698,600},{730,583},{752,560},{764,532},{768,506}}, true)
bowl   = (rim_o + skirt):roughen(3, 55, 7)
inner  = ellipse(580, 500, 182, 53):roughen(2, 45, 11)
wall   = bowl - inner
rimb   = rim_o - inner

work(bowl, {pile=p_bo4_mid, hand="broad", coverage=3.0, fill=true, load=1.0,
     pressure={1.0,1.0}, dips={1,1.0,0.0}, angle=0.4, clip=true})
work(inner, {pile=p_bo4_dk, tool="filbert 16", length={40,90}, coverage=2.4, fill=true,
     load=1.0, pressure={0.9,0.8}, dips={1,1.0,0.0}, angle=0.2, clip=true})
work(inner * ellipse(580, 466, 170, 40):soften(26), {pile=p_bo4_dk, tool="filbert 16",
     length={30,64}, coverage=1.6, fill=true, load=1.0, pressure={0.9,0.8},
     dips={1,1.0,0.0}, clip=true})
work(wall * ellipse(452, 540, 150, 118):soften(58), {pile=p_bo4_lit, tool="filbert 16",
     length={40,90}, coverage=1.9, fill=true, load=1.0, pressure={0.95,0.8},
     dips={1,1.0,0.0}, angle=0.5, clip=true})
work(wall * ellipse(722, 584, 155, 118):soften(60), {pile=p_bo4_sh, tool="filbert 16",
     length={40,90}, coverage=2.0, fill=true, load=1.0, pressure={0.95,0.8},
     dips={1,1.0,0.0}, angle=0.5, clip=true})
work(bowl * below(function() return 590 end):soften(20), {pile=p_bo4_dk, tool="filbert 16",
     length={30,64}, coverage=1.5, fill=true, load=1.0, pressure={0.9,0.8},
     dips={1,1.0,0.0}, angle=1.2, clip=true})
work(rimb * ellipse(474, 538, 126, 86):soften(42), {pile=p_bo4_lit, tool="filbert 12",
     length={30,64}, coverage=1.7, fill=true, load=1.0, pressure={0.95,0.8},
     dips={1,1.0,0.0}, angle=0.3, clip=true})
blend(bowl:soften(5), {angle=0.4})
print("bowl 4", wait(0))
