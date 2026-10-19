p_bo7_mid = pile{{"raw umber", 2.6}, {"red earth", 2.2}, {"yellow ochre", 0.8}, {"bone black", 0.8}}
p_bo8_lit = pile{{"raw umber", 2.4}, {"red earth", 1.8}, {"yellow ochre", 1}, {"lead white", 1}}
p_bo7_sh  = pile{{"red earth", 1.8}, {"raw umber", 1.8}, {"bone black", 2}, {"yellow ochre", 0.3}}
p_bo6_dk  = pile{{"bone black", 3.2}, {"raw umber", 1.4}, {"Prussian blue", 0.5}, {"red earth", 0.3}}
p_bint   = pile{{"raw umber", 2}, {"bone black", 1.8}, {"red earth", 0.8}}
p_shd3   = pile{{"raw umber", 2.2}, {"bone black", 1.6}, {"red earth", 0.5}, {"Prussian blue", 0.2}}
cloth_r = cloth:roughen(9, 70, 12)
rim_o  = ellipse(580, 500, 200, 64)
inner  = ellipse(580, 500, 182, 53):roughen(2, 45, 11)
rimb   = rim_o - inner
arc = function(x) return 500 + 53*math.sqrt(math.max(0, 1 - ((x-580)/182)^2)) end
nearrim = below(arc) * rim_o
skirt  = poly({{392,506},{396,532},{408,560},{430,583},{462,600},{504,613},{544,621},
               {580,625},{616,621},{656,613},{698,600},{730,583},{752,560},{764,532},{768,506}}, true)
bowl   = (rim_o + skirt):roughen(3, 55, 7)
wall   = bowl - inner
A = (ellipse(500, 486, 86, 83):roughen(5, 40, 21)) - nearrim
C = (ellipse(690, 496, 78, 76):roughen(4, 35, 27)) - nearrim
B = (ellipse(600, 448, 94, 90):roughen(6, 50, 33)) - nearrim
D = ellipse(300, 655, 100, 96):roughen(5, 45, 3)
E = ellipse(470, 712, 82, 80):roughen(4, 45, 41)
fruit = A + B + C + D + E
free = cloth_r * -fruit * -bowl
R = function(pts, w, s) return ribbon(pts, w):soften(s) end
rf = rimb - fruit

work(wall, {pile=p_bo7_mid, hand="broad", coverage=2.2, fill=true, load=1.0, pressure={1.0,1.0},
     dips={1,1.0,0.0}, angle=0.4, clip=true})
work(wall * ellipse(444, 544, 112, 84):soften(44), {pile=p_bo8_lit, tool="filbert 16",
     length={40,90}, coverage=1.4, fill=true, load=1.0, pressure={0.9,0.75},
     dips={1,1.0,0.0}, angle=0.5, clip=true})
work(wall * ellipse(716, 590, 138, 102):soften(48), {pile=p_bo7_sh, tool="filbert 16",
     length={40,90}, coverage=1.7, fill=true, load=1.0, pressure={0.9,0.75},
     dips={1,1.0,0.0}, angle=0.5, clip=true})
work(bowl * below(function() return 578 end):soften(20), {pile=p_bo6_dk, tool="filbert 16",
     length={30,64}, coverage=1.4, fill=true, load=1.0, pressure={0.9,0.8},
     dips={1,1.0,0.0}, angle=1.2, clip=true})
work(rf, {pile=p_bo7_mid, tool="filbert 12", length={30,64}, coverage=1.8, fill=true,
     load=1.0, pressure={0.95,0.8}, dips={1,1.0,0.0}, angle=0.3, clip=true})
work(rf * ellipse(442, 506, 82, 46):soften(24), {pile=p_bo8_lit, tool="filbert 12",
     length={30,64}, coverage=1.4, fill=true, load=1.0, pressure={0.95,0.8},
     dips={1,1.0,0.0}, angle=0.3, clip=true})
work(rf * ellipse(724, 514, 90, 52):soften(28), {pile=p_bo7_sh, tool="filbert 12",
     length={30,64}, coverage=1.5, fill=true, load=1.0, pressure={0.95,0.8},
     dips={1,1.0,0.0}, angle=0.3, clip=true})
work(inner * -(rim_o:grow(-4)), {pile=p_bint, tool="filbert 16", length={40,90}, coverage=1.6,
     fill=true, load=1.0, pressure={0.9,0.75}, dips={1,1.0,0.0}, clip=true})
blend(bowl:soften(5), {angle=0.4})
-- the bowl sits in its own shadow
work(R({{588,634},{702,672},{812,706}}, 78, 32)*free, {pile=p_shd3, tool="filbert 20",
     length={50,100}, coverage=1.8, fill=true, load=1.0, pressure={0.9,0.75},
     dips={1,1.0,0.0}, angle=0.5, clip=true})
work(R({{520,618},{600,634},{668,626}}, 24, 13)*free, {pile=p_bo6_dk, tool="filbert 12",
     length={30,64}, coverage=2.0, fill=true, load=1.0, pressure={0.95,0.8},
     dips={1,1.0,0.0}, angle=0.2, clip=true})
-- the tall green apple's yellow top back toward green
work(B * ellipse(566, 400, 70, 60):soften(24), {pile=p_gb3, tool="filbert 16",
     length={30,64}, coverage=1.1, fill=true, load=1.0, pressure={0.9,0.7},
     dips={1,1.0,0.0}, clip=true})
print("bowl forward", wait(0))
