p_bo3_mid = pile{{"raw umber", 4}, {"red earth", 2}, {"bone black", 1}, {"yellow ochre", 0.6}}
p_bo3_lit = pile{{"raw umber", 2}, {"red earth", 1.2}, {"yellow ochre", 1}, {"lead white", 2.2}}
p_bo3_sh  = pile{{"raw umber", 2.5}, {"red earth", 1}, {"bone black", 1.5}, {"Prussian blue", 0.3}}
p_bo3_dk  = pile{{"bone black", 3}, {"raw umber", 1.5}, {"Prussian blue", 0.4}, {"red earth", 0.4}}

rim_o  = ellipse(580, 500, 200, 64)
skirt  = poly({{392,506},{396,532},{408,560},{430,583},{462,600},{504,613},{544,621},
               {580,625},{616,621},{656,613},{698,600},{730,583},{752,560},{764,532},{768,506}}, true)
bowl   = (rim_o + skirt):roughen(3, 55, 7)
inner  = ellipse(580, 500, 182, 53):roughen(2, 45, 11)
wall   = bowl - inner
rimb   = rim_o - inner

work(bowl, {pile=p_bo3_mid, tool="filbert 20", length={40,90}, coverage=2.8, fill=true,
     load=1.0, pressure={1.0,1.0}, dips={1,1.0,0.0}, angle=0.4, clip=true})
-- inside: dark, deepest at the back
work(inner, {pile=p_bo3_dk, tool="filbert 16", length={40,90}, coverage=2.0, fill=true,
     load=1.0, pressure={0.9,0.8}, dips={1,1.0,0.0}, angle=0.2, clip=true})
-- the outside: light over the left shoulder, dying away to the right and under
work(wall * ellipse(448, 542, 155, 122):soften(62), {pile=p_bo3_lit, tool="filbert 16",
     length={40,90}, coverage=1.7, fill=true, load=1.0, pressure={0.95,0.8},
     dips={1,1.0,0.0}, angle=0.5, clip=true})
work(wall * ellipse(720, 586, 160, 120):soften(64), {pile=p_bo3_sh, tool="filbert 16",
     length={40,90}, coverage=1.9, fill=true, load=1.0, pressure={0.95,0.8},
     dips={1,1.0,0.0}, angle=0.5, clip=true})
work(bowl * below(function() return 592 end):soften(20), {pile=p_bo3_dk, tool="filbert 16",
     length={30,64}, coverage=1.5, fill=true, load=1.0, pressure={0.9,0.8},
     dips={1,1.0,0.0}, angle=1.2, clip=true})
-- the rim: a narrow light on the front-left arc only
work(rimb * ellipse(480, 540, 130, 90):soften(46), {pile=p_bo3_lit, tool="filbert 12",
     length={30,64}, coverage=1.6, fill=true, load=1.0, pressure={0.95,0.8},
     dips={1,1.0,0.0}, angle=0.3, clip=true})
blend(bowl:soften(5), {angle=0.4})
print("bowl 3", wait(0))
