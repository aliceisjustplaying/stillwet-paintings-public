p_stm  = pile{{"raw umber", 1.6}, {"bone black", 1.4}, {"red earth", 0.9}}
p_gzw  = pile{{"raw umber", 2.5}, {"bone black", 1.2}, {"red earth", 0.5}, medium=0.3}
p_gzc  = pile{{"bone black", 2.5}, {"raw umber", 1.5}, {"Prussian blue", 0.5}, medium=0.35}
p_cl_mid5 = pile{{"lead white", 3.4}, {"raw umber", 3}, {"yellow ochre", 0.7}, {"red earth", 0.6}}
p_cl_lit5 = pile{{"lead white", 5}, {"raw umber", 2.6}, {"yellow ochre", 0.8}, {"red earth", 0.5}}
p_shd2 = pile{{"raw umber", 2.2}, {"bone black", 1.5}, {"red earth", 0.5}, {"Prussian blue", 0.2}}
cloth_r = cloth:roughen(9, 70, 12)
rim_o  = ellipse(580, 500, 200, 64)
arc = function(x) return 500 + 53*math.sqrt(math.max(0, 1 - ((x-580)/182)^2)) end
nearrim = below(arc) * rim_o
skirt  = poly({{392,506},{396,532},{408,560},{430,583},{462,600},{504,613},{544,621},
               {580,625},{616,621},{656,613},{698,600},{730,583},{752,560},{764,532},{768,506}}, true)
bowl   = (rim_o + skirt):roughen(3, 55, 7)
A = (ellipse(500, 486, 86, 83):roughen(5, 40, 21)) - nearrim
C = (ellipse(690, 496, 78, 76):roughen(4, 35, 27)) - nearrim
B = (ellipse(600, 448, 94, 90):roughen(6, 50, 33)) - nearrim
D = ellipse(300, 655, 100, 96):roughen(5, 45, 3)
E = ellipse(470, 712, 82, 80):roughen(4, 45, 41)
fruit = A + B + C + D + E
free = cloth_r * -fruit * -bowl
R = function(pts, w, s) return ribbon(pts, w):soften(s) end
tline = function(x) return 468 - 0.04*x end

-- the smudges on the cloth back to cloth, then real folds
work((R({{140,596},{192,668},{228,742}}, 46, 24) + R({{396,706},{428,776}}, 40, 20) +
      ellipse(20, 792, 92, 50):soften(26) + R({{852,562},{878,650}}, 44, 22))*free,
     {pile=p_cl_mid5, hand="broad", coverage=1.4, fill=true, load=1.0, pressure={1.0,0.9},
      dips={1,1.0,0.0}, angle=0.5, clip=true})
zone = function(m, p, a, cov) work(m*free, {pile=p, tool="filbert 20", length={50,100},
        coverage=cov, fill=true, load=1.0, pressure={0.9,0.75}, dips={1,1.0,0.0}, angle=a, clip=true}) end
zone(R({{56,626},{108,700},{162,782}}, 40, 20), p_cl_lit5, 1.1, 1.2)
zone(R({{148,772},{290,790}}, 34, 18), p_cl_lit5, 0.15, 1.1)
zone(R({{34,596},{176,566}}, 36, 18), p_cl_lit5, -0.2, 1.1)
zone(R({{796,596},{850,658}}, 38, 20), p_cl_lit5, 0.8, 1.1)
zone(R({{146,602},{196,672},{232,748}}, 34, 17), p_shd2, 1.0, 1.3)
zone(ellipse(18, 794, 82, 44):soften(22), p_shd2, 0.3, 1.3)
zone(R({{400,714},{430,778}}, 30, 15), p_shd2, 1.4, 1.2)
zone(R({{858,566},{880,652}}, 34, 17), p_shd2, 1.5, 1.2)

-- the fruit sit in a shadow again
fixc = function(m, cx, cy, r)
  work(ellipse(cx+0.20*r, cy+0.97*r, 0.66*r, 0.28*r):soften(12) * free, {pile=p_shd2,
       tool="filbert 16", length={30,64}, coverage=2.0, fill=true, load=1.0,
       pressure={0.9,0.75}, dips={1,1.0,0.0}, angle=0.3, clip=true})
  work(ellipse(cx+0.32*r, cy+1.05*r, 0.95*r, 0.36*r):soften(17) * free, {pile=p_shd2,
       tool="filbert 20", length={40,90}, coverage=1.3, fill=true, load=1.0,
       pressure={0.85,0.7}, dips={1,1.0,0.0}, angle=0.4, clip=true})
end
fixc(D, 300, 655, 100)  fixc(E, 470, 712, 82)
fixc(A, 500, 486, 86)   fixc(B, 600, 448, 94)  fixc(C, 690, 496, 78)

-- the stalks, laid last so nothing covers them
rg = brush{kind="round", width=8, point=0.9}
rg:load(p_stm, 1.0); rg:stroke({{504, 410}, {509, 396}, {515, 382}}, {pressure={1.0,0.55,0.05}})
rg:reload(p_stm, 1.0); rg:stroke({{605, 358}, {611, 344}, {618, 330}}, {pressure={1.0,0.55,0.05}})
rg:reload(p_stm, 1.0); rg:stroke({{694, 424}, {700, 410}, {707, 396}}, {pressure={1.0,0.55,0.05}})
rg:reload(p_stm, 1.0); rg:stroke({{304, 562}, {309, 548}, {316, 534}}, {pressure={1.0,0.55,0.05}})
rg:reload(p_stm, 1.0); rg:stroke({{474, 636}, {479, 622}, {486, 608}}, {pressure={1.0,0.55,0.05}})

-- a warm glaze over the group, a cool veil over the room behind it
work(bowl + fruit, {hand="glaze", pile=p_gzw, coverage=1.0, angle=0.4, clip=true})
work(rect(0, 0, 1000, 476):soften(30) - bowl - fruit, {hand="glaze", pile=p_gzc,
     coverage=0.9, angle=0.9, clip=true})
work(below(tline):soften(10) - cloth_r, {hand="glaze", pile=p_gzc, coverage=0.8,
     angle=0.25, clip=true})
print("finish", wait(0))
