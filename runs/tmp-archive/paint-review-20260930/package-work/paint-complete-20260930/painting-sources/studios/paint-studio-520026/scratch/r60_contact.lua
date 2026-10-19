p_shc  = pile{{"raw umber", 2}, {"bone black", 1.6}, {"red earth", 0.5}, {"Prussian blue", 0.2}}
p_shd  = pile{{"raw umber", 2.4}, {"bone black", 1.2}, {"red earth", 0.6}, {"Prussian blue", 0.2}}
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

-- the tight shadow each fruit sits in, right at its base
contact = function(m, cx, cy, r, cov)
  local c = ((m:grow(11):soften(9) - m) * ellipse(cx+0.10*r, cy+0.80*r, 1.05*r, 0.55*r)
             * free)
  work(c, {pile=p_shc, tool="filbert 16", length={30,64}, coverage=cov, fill=true, load=1.0,
           pressure={0.9,0.75}, dips={1,1.0,0.0}, angle=0.4, clip=true})
  return c
end
c1 = contact(D, 300, 655, 100, 2.0)
c2 = contact(E, 470, 712, 82, 2.0)
c3 = contact(A, 500, 486, 86, 1.6)
c4 = contact(B, 600, 448, 94, 1.6)
c5 = contact(C, 690, 496, 78, 1.6)
blend((c1+c2+c5):soften(14), {angle=0.5})
-- and the bowl's, along the foot and away to the right
work(R({{586,632},{700,670},{812,704}}, 76, 32)*free, {pile=p_shd, tool="filbert 20",
     length={50,100}, coverage=1.8, fill=true, load=1.0, pressure={0.9,0.75},
     dips={1,1.0,0.0}, angle=0.5, clip=true})
work(R({{520,618},{600,634},{668,626}}, 24, 13)*free, {pile=p_shc, tool="filbert 12",
     length={30,64}, coverage=2.2, fill=true, load=1.0, pressure={0.95,0.8},
     dips={1,1.0,0.0}, angle=0.2, clip=true})

-- the cloth's folds: mid shadows, not soot
zone = function(m, p, a, cov) work(m*free, {pile=p, tool="filbert 20", length={50,100},
        coverage=cov, fill=true, load=1.0, pressure={0.9,0.75}, dips={1,1.0,0.0}, angle=a, clip=true}) end
zone(R({{150,606},{198,676},{232,742}}, 40, 20), p_shd, 1.0, 1.6)
zone(ellipse(24, 792, 88, 48):soften(24), p_shd, 0.3, 1.6)
zone(R({{402,716},{430,772}}, 34, 17), p_shd, 1.4, 1.5)
zone(R({{60,632},{112,702},{166,778}}, 44, 22), p_cl_lite4, 1.1, 1.2)
zone(R({{140,772},{280,790}}, 36, 18), p_cl_lite4, 0.15, 1.1)
zone(R({{40,600},{180,568}}, 38, 20), p_cl_lite4, -0.2, 1.1)
zone(R({{800,600},{852,660}}, 40, 20), p_cl_lite4, 0.8, 1.0)
print("contact shadows", wait(0))
