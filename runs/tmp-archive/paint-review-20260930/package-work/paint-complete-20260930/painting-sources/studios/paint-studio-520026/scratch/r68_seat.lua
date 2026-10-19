p_bo7_sh  = pile{{"red earth", 1.8}, {"raw umber", 1.8}, {"bone black", 2}, {"yellow ochre", 0.3}}
p_bo6_dk  = pile{{"bone black", 3.2}, {"raw umber", 1.4}, {"Prussian blue", 0.5}, {"red earth", 0.3}}
p_bounce = pile{{"red earth", 1.4}, {"lead white", 1.2}, {"yellow ochre", 0.5}}
p_shd5   = pile{{"raw umber", 2.2}, {"bone black", 1.6}, {"red earth", 0.5}, {"Prussian blue", 0.2}}
cloth_r = cloth:roughen(9, 70, 12)
rim_o  = ellipse(580, 500, 200, 64)
inner  = ellipse(580, 500, 182, 53):roughen(2, 45, 11)
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

-- the bowl's wall turns down and away, with the cloth's light bouncing on its lower left
work(wall * below(function() return 560 end):soften(18), {pile=p_bo7_sh, tool="filbert 16",
     length={40,90}, coverage=1.7, fill=true, load=1.0, pressure={0.9,0.75},
     dips={1,1.0,0.0}, angle=0.9, clip=true})
work(wall * below(function() return 598 end):soften(16), {pile=p_bo6_dk, tool="filbert 16",
     length={30,64}, coverage=1.3, fill=true, load=1.0, pressure={0.9,0.75},
     dips={1,1.0,0.0}, angle=1.3, clip=true})
work(wall * ellipse(450, 590, 90, 34):soften(22), {pile=p_bounce, tool="filbert 12",
     length={24,50}, coverage=0.9, fill=true, load=1.0, pressure={0.85,0.65},
     dips={1,1.0,0.0}, angle=0.7, clip=true})
-- and the front apple sits down into the cloth
work(ellipse(322, 748, 78, 30):soften(14) * free, {pile=p_shd5, tool="filbert 16",
     length={30,64}, coverage=2.0, fill=true, load=1.0, pressure={0.9,0.75},
     dips={1,1.0,0.0}, angle=0.3, clip=true})
print("seated", wait(0))
