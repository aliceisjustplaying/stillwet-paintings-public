p_bo7_sh  = pile{{"red earth", 1.8}, {"raw umber", 1.8}, {"bone black", 2}, {"yellow ochre", 0.3}}
p_bounce2= pile{{"red earth", 1.8}, {"lead white", 0.7}, {"yellow ochre", 0.5}}
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
fruit = A + B + C
work(ellipse(450, 590, 96, 40):soften(20) * wall, {pile=p_bo7_sh, tool="filbert 16",
     length={40,90}, coverage=2.2, fill=true, load=1.0, pressure={0.95,0.8},
     dips={1,1.0,0.0}, angle=0.7, clip=true})
work(ellipse(446, 588, 84, 30):soften(18) * wall, {pile=p_bounce2, tool="filbert 20",
     length={50,100}, coverage=0.5, fill=false, load=0.8, pressure={0.7,0.55},
     angle=0.7, clip=true})
print("bounce fixed", wait(0))
