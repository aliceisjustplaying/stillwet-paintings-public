p_cl_lit6 = pile{{"lead white", 5}, {"raw umber", 2.4}, {"yellow ochre", 0.8}, {"red earth", 0.5}}
p_shd4   = pile{{"raw umber", 2.2}, {"bone black", 1.6}, {"red earth", 0.5}, {"Prussian blue", 0.2}}
p_rimlit = pile{{"raw umber", 1.5}, {"red earth", 0.8}, {"yellow ochre", 0.8}, {"lead white", 0.9}}
p_bo6_dk = pile{{"bone black", 3.2}, {"raw umber", 1.4}, {"Prussian blue", 0.5}, {"red earth", 0.3}}
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

fl = brush{kind="filbert", width=6}
fl:load(p_cl_lit6, 1.0)
fl:stroke({{68, 636}, {110, 702}, {152, 766}}, {pressure={0.85, 0.8, 0.5}, clip=free})
fl:reload(p_cl_lit6, 1.0)
fl:stroke({{150, 774}, {228, 784}, {300, 792}}, {pressure={0.8, 0.75, 0.45}, clip=free})
fl:reload(p_cl_lit6, 1.0)
fl:stroke({{798, 598}, {826, 630}, {852, 662}}, {pressure={0.85, 0.8, 0.5}, clip=free})
fl:reload(p_cl_lit6, 1.0)
fl:stroke({{36, 596}, {110, 580}, {178, 566}}, {pressure={0.8, 0.75, 0.45}, clip=free})
fd = brush{kind="filbert", width=6}
fd:load(p_shd4, 1.0)
fd:stroke({{148, 606}, {196, 674}, {232, 748}}, {pressure={0.85, 0.8, 0.5}, clip=free})
fd:reload(p_shd4, 1.0)
fd:stroke({{862, 572}, {874, 614}, {880, 654}}, {pressure={0.85, 0.8, 0.5}, clip=free})
fd:reload(p_shd4, 1.0)
fd:stroke({{300, 796}, {350, 780}, {392, 764}}, {pressure={0.8, 0.75, 0.45}, clip=free})
-- a thin bright line along the bowl's near-left rim, and the dark under its foot
rb = brush{kind="filbert", width=5}
rb:load(p_rimlit, 1.0)
rb:stroke({{386, 486}, {400, 506}, {432, 524}, {474, 536}}, {pressure={0.9, 0.85, 0.7, 0.4},
            clip=(rim_o - ellipse(580, 500, 182, 53)) * -fruit})
rb:reload(p_rimlit, 1.0)
rb:stroke({{700, 546}, {740, 528}, {772, 508}}, {pressure={0.8, 0.7, 0.4},
            clip=(rim_o - ellipse(580, 500, 182, 53)) * -fruit})
bb = brush{kind="filbert", width=7}
bb:load(p_bo6_dk, 1.0)
bb:stroke({{532, 624}, {600, 634}, {664, 626}}, {pressure={0.9, 0.85, 0.5}, clip=free})
print("accents", wait(0))
