p_bo4_mid = pile{{"raw umber", 3.5}, {"bone black", 1.2}, {"lead white", 1}, {"red earth", 0.8}}
cloth_r = cloth:roughen(9, 70, 12)
rim_o  = ellipse(580, 500, 200, 64)
skirt  = poly({{392,506},{396,532},{408,560},{430,583},{462,600},{504,613},{544,621},
               {580,625},{616,621},{656,613},{698,600},{730,583},{752,560},{764,532},{768,506}}, true)
bowl   = (rim_o + skirt):roughen(3, 55, 7)
inner  = ellipse(580, 500, 182, 53):roughen(2, 45, 11)
wall   = bowl - inner
rimb   = rim_o - inner

work((ellipse(356,506,48,34):soften(16) + ellipse(804,506,48,34):soften(16) + ellipse(580,648,120,26):soften(18))*cloth_r,
     {pile=p_clm4, hand="broad", coverage=5.0, fill=true, load=1.0, pressure={1.0,1.0},
      dips={1,1.0,0.0}, angle=0.3, clip=true})
work(bowl, {pile=p_bo4_mid, hand="broad", coverage=4.0, fill=true, load=1.0,
     pressure={1.0,1.0}, dips={1,1.0,0.0}, angle=0.4, clip=true})
work(bowl, {pile=p_bo4_mid, hand="broad", coverage=3.0, fill=true, load=1.0,
     pressure={1.0,1.0}, dips={1,1.0,0.0}, angle=0.4, clip=true})
work(inner, {pile=p_bo4_dk, hand="broad", coverage=3.0, fill=true, load=1.0,
     pressure={1.0,1.0}, dips={1,1.0,0.0}, angle=0.2, clip=true})
print("bowl base opaque", wait(0))
