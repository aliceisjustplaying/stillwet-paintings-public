p_shc = pile{{"raw umber", 2}, {"bone black", 1.6}, {"red earth", 0.5}, {"Prussian blue", 0.2}}
p_cl_lite4 = pile{{"lead white", 4.2}, {"raw umber", 2.8}, {"yellow ochre", 0.8}, {"red earth", 0.6}}
cloth_r = cloth:roughen(9, 70, 12)
rim_o  = ellipse(580, 500, 200, 64)
inner  = ellipse(580, 500, 182, 53):roughen(2, 45, 11)
arc = function(x) return 500 + 53*math.sqrt(math.max(0, 1 - ((x-580)/182)^2)) end
nearrim = below(arc) * rim_o
skirt  = poly({{392,506},{396,532},{408,560},{430,583},{462,600},{504,613},{544,621},
               {580,625},{616,621},{656,613},{698,600},{730,583},{752,560},{764,532},{768,506}}, true)
bowl   = (rim_o + skirt):roughen(3, 55, 7)
A = (ellipse(500, 486, 86, 83):roughen(4, 45, 21)) - nearrim
C = (ellipse(690, 496, 78, 76):roughen(3, 40, 27)) - nearrim
B = (ellipse(600, 448, 94, 90):roughen(5, 55, 33)) - nearrim
D = ellipse(300, 655, 100, 96):roughen(4, 50, 3)
E = ellipse(470, 712, 82, 80):roughen(4, 50, 41)
fruit = A + B + C + D + E
free = cloth_r * -fruit * -bowl
R = function(pts, w, s) return ribbon(pts, w):soften(s) end

-- the shadows the fruit throw, away from the light, on the cloth only
zone = function(m, p, a, cov) work(m*free, {pile=p, tool="filbert 16", length={40,90},
        coverage=cov, fill=true, load=1.0, pressure={0.9,0.75}, dips={1,1.0,0.0}, angle=a, clip=true}) end
zone(R({{340,714},{424,748}}, 52, 24), p_shc, 0.5, 1.8)
zone(R({{352,728},{468,772}}, 88, 36), p_shc, 0.5, 1.4)
zone(R({{508,760},{584,792}}, 46, 22), p_shc, 0.5, 1.8)
zone(R({{520,772},{624,802}}, 80, 34), p_shc, 0.5, 1.4)
zone(R({{566,636},{684,676},{796,710}}, 82, 36), p_shc, 0.5, 1.6)
zone(R({{524,620},{600,636},{664,628}}, 26, 14), p_shc, 0.2, 2.0)
blend((R({{340,714},{424,748}}, 52, 24) + R({{508,760},{584,792}}, 46, 22) +
       R({{524,620},{600,636},{664,628}}, 26, 14))*free:soften(16), {angle=0.5})

-- the folds of the cloth, on the left and along the front
zone(R({{150,606},{198,676},{232,742}}, 40, 20), p_cl_dk, 1.0, 1.4)
zone(ellipse(24, 792, 88, 48):soften(24), p_cl_dk, 0.3, 1.4)
zone(R({{402,716},{430,772}}, 34, 17), p_cl_dk, 1.4, 1.3)
zone(R({{60,632},{112,702},{166,778}}, 44, 22), p_cl_lite4, 1.1, 1.1)
zone(R({{140,772},{280,790}}, 36, 18), p_cl_lite4, 0.15, 1.0)
zone(R({{40,600},{180,568}}, 38, 20), p_cl_lite4, -0.2, 1.0)
print("shadows and folds", wait(0))
