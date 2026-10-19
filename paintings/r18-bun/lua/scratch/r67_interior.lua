p_bint2 = pile{{"raw umber", 1.6}, {"bone black", 2.4}, {"red earth", 0.5}, {"Prussian blue", 0.3}}
p_bint3 = pile{{"bone black", 3.2}, {"raw umber", 1.2}, {"Prussian blue", 0.5}}
p_rim_mid = pile{{"raw umber", 2.4}, {"red earth", 1.4}, {"bone black", 1.6}, {"yellow ochre", 0.3}}
rim_o  = ellipse(580, 500, 200, 64)
inner  = ellipse(580, 500, 182, 53):roughen(2, 45, 11)
rimb   = rim_o - inner
arc = function(x) return 500 + 53*math.sqrt(math.max(0, 1 - ((x-580)/182)^2)) end
nearrim = below(arc) * rim_o
skirt  = poly({{392,506},{396,532},{408,560},{430,583},{462,600},{504,613},{544,621},
               {580,625},{616,621},{656,613},{698,600},{730,583},{752,560},{764,532},{768,506}}, true)
bowl   = (rim_o + skirt):roughen(3, 55, 7)
A = (ellipse(500, 486, 86, 83):roughen(5, 40, 21)) - nearrim
C = (ellipse(690, 496, 78, 76):roughen(4, 35, 27)) - nearrim
B = (ellipse(600, 448, 94, 90):roughen(6, 50, 33)) - nearrim
fruit = A + B + C
rf = rimb - fruit

-- the inside of the bowl: in shadow, deepest at the back
work(inner * -fruit, {pile=p_bint2, hand="broad", coverage=2.4, fill=true, load=1.0,
     pressure={1.0,1.0}, dips={1,1.0,0.0}, angle=0.2, clip=true})
work(inner * -fruit * ellipse(580, 470, 172, 44):soften(24), {pile=p_bint3, tool="filbert 16",
     length={30,64}, coverage=1.4, fill=true, load=1.0, pressure={0.9,0.75},
     dips={1,1.0,0.0}, clip=true})
-- a little light let into the inside from the near rim
work(inner * -fruit * ellipse(500, 542, 120, 26):soften(16), {pile=p_rim_mid, tool="filbert 12",
     length={24,50}, coverage=0.9, fill=true, load=1.0, pressure={0.85,0.65},
     dips={1,1.0,0.0}, angle=0.3, clip=true})
-- the scratchy bright line on the right of the rim back into the rim
work(rf * ellipse(724, 514, 92, 54):soften(28), {pile=p_rim_mid, tool="filbert 12",
     length={30,64}, coverage=1.6, fill=true, load=1.0, pressure={0.95,0.8},
     dips={1,1.0,0.0}, angle=0.3, clip=true})
print("interior", wait(0))
