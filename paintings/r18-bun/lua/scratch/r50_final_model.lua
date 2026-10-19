p_bo6_lit = pile{{"raw umber", 2.4}, {"red earth", 1}, {"yellow ochre", 0.8}, {"lead white", 2}}
p_bo6_mid = pile{{"raw umber", 3}, {"red earth", 1.6}, {"yellow ochre", 0.5}, {"bone black", 1}, {"lead white", 0.6}}
p_bo6_sh  = pile{{"raw umber", 2.4}, {"red earth", 1}, {"bone black", 2}, {"Prussian blue", 0.3}}
p_bo6_dk  = pile{{"bone black", 3.2}, {"raw umber", 1.4}, {"Prussian blue", 0.5}, {"red earth", 0.3}}
p_rlit5 = pile{{"vermilion", 3.2}, {"red earth", 2}, {"yellow ochre", 0.8}, {"lead white", 0.5}}
p_rtr2 = pile{{"red earth", 3.5}, {"bone black", 2.6}, {"raw umber", 2.4}, {"vermilion", 0.8}}
p_rsh2 = pile{{"bone black", 3.5}, {"raw umber", 1.8}, {"red earth", 0.8}, {"Prussian blue", 0.4}}
p_rhi2 = pile{{"lead white", 4.5}, {"vermilion", 0.7}, {"red earth", 0.3}, {"yellow ochre", 0.3}}
p_glit5= pile{{"green earth", 2.6}, {"chrome yellow", 1.2}, {"lead white", 2.2}, {"copper green", 0.3}}
p_gtr4 = pile{{"green earth", 4}, {"bone black", 2.8}, {"copper green", 0.6}, {"raw umber", 0.8}}
p_gsh4 = pile{{"bone black", 3.2}, {"green earth", 1.6}, {"Prussian blue", 0.8}}
p_ghi3 = pile{{"lead white", 4.5}, {"chrome yellow", 0.5}, {"green earth", 0.5}}
p_rrfl3= pile{{"red earth", 1.4}, {"lead white", 1.1}, {"yellow ochre", 0.5}, {"vermilion", 0.3}}
p_grfl3= pile{{"yellow ochre", 2.2}, {"lead white", 1.4}, {"green earth", 0.7}}

rim_o  = ellipse(580, 500, 200, 64)
inner  = ellipse(580, 500, 182, 53):roughen(2, 45, 11)
rimb   = rim_o - inner
arc = function(x) return 500 + 53*math.sqrt(math.max(0, 1 - ((x-580)/182)^2)) end
nearrim = below(arc) * rim_o
skirt  = poly({{392,506},{396,532},{408,560},{430,583},{462,600},{504,613},{544,621},
               {580,625},{616,621},{656,613},{698,600},{730,583},{752,560},{764,532},{768,506}}, true)
bowl   = (rim_o + skirt):roughen(3, 55, 7)
wall   = bowl - inner
A = (ellipse(500, 486, 86, 83):roughen(4, 45, 21)) - nearrim
C = (ellipse(690, 496, 78, 76):roughen(3, 40, 27)) - nearrim
B = (ellipse(600, 448, 94, 90):roughen(5, 55, 33)) - nearrim
D = ellipse(300, 655, 100, 96):roughen(4, 50, 3)
E = ellipse(470, 712, 82, 80):roughen(4, 50, 41)
fruit = A + C + B

-- the bowl in warm earthenware
rf = rimb - fruit
work(wall, {pile=p_bo6_mid, hand="broad", coverage=3.2, fill=true, load=1.0, pressure={1.0,1.0},
     dips={1,1.0,0.0}, angle=0.4, clip=true})
work(wall * ellipse(448, 548, 124, 94):soften(50), {pile=p_bo6_lit, tool="filbert 16",
     length={40,90}, coverage=1.5, fill=true, load=1.0, pressure={0.9,0.75},
     dips={1,1.0,0.0}, angle=0.5, clip=true})
work(wall * ellipse(714, 588, 142, 106):soften(52), {pile=p_bo6_sh, tool="filbert 16",
     length={40,90}, coverage=1.7, fill=true, load=1.0, pressure={0.9,0.75},
     dips={1,1.0,0.0}, angle=0.5, clip=true})
work(bowl * below(function() return 580 end):soften(20), {pile=p_bo6_dk, tool="filbert 16",
     length={30,64}, coverage=1.5, fill=true, load=1.0, pressure={0.9,0.8},
     dips={1,1.0,0.0}, angle=1.2, clip=true})
work(rf, {pile=p_bo6_mid, tool="filbert 12", length={30,64}, coverage=2.0, fill=true,
     load=1.0, pressure={0.95,0.8}, dips={1,1.0,0.0}, angle=0.3, clip=true})
work(rf * ellipse(446, 510, 88, 52):soften(28), {pile=p_bo6_lit, tool="filbert 12",
     length={30,64}, coverage=1.3, fill=true, load=1.0, pressure={0.95,0.8},
     dips={1,1.0,0.0}, angle=0.3, clip=true})
work(rf * ellipse(718, 518, 96, 58):soften(32), {pile=p_bo6_sh, tool="filbert 12",
     length={30,64}, coverage=1.6, fill=true, load=1.0, pressure={0.95,0.8},
     dips={1,1.0,0.0}, angle=0.3, clip=true})
blend(bowl:soften(5), {angle=0.4})

ball = function(m, base, lit, tr, sh, refl, cx, cy, r, hi)
  work(m, {pile=base, hand="broad", coverage=4.5, fill=true, load=1.0, pressure={1.0,1.0},
           dips={1,1.0,0.0}, angle=0.3, clip=true})
  work(m * ellipse(cx-0.34*r, cy-0.33*r, 0.52*r, 0.48*r):soften(0.20*r), {pile=lit,
       tool="filbert 16", length={40,90}, coverage=1.6, fill=true, load=1.0,
       pressure={0.95,0.8}, dips={1,1.0,0.0}, angle=0.3, clip=true})
  work(m * ellipse(cx+0.22*r, cy+0.24*r, 0.78*r, 0.74*r):soften(0.20*r), {pile=tr,
       tool="filbert 16", length={40,90}, coverage=1.8, fill=true, load=1.0,
       pressure={0.95,0.8}, dips={1,1.0,0.0}, angle=0.3, clip=true})
  work(m * ellipse(cx+0.58*r, cy+0.54*r, 0.66*r, 0.62*r):soften(0.14*r), {pile=sh,
       tool="filbert 16", length={40,90}, coverage=2.2, fill=true, load=1.0,
       pressure={0.95,0.8}, dips={1,1.0,0.0}, angle=0.3, clip=true})
  work(m * ellipse(cx+0.04*r, cy+0.89*r, 0.74*r, 0.22*r):soften(0.11*r), {pile=refl,
       tool="filbert 12", length={30,64}, coverage=1.3, fill=true, load=1.0,
       pressure={0.95,0.8}, dips={1,1.0,0.0}, angle=1.5, clip=true})
  blend(m:soften(4), {angle=0.3})
  work(ellipse(cx-0.40*r, cy-0.47*r, 0.17*r, 0.13*r):soften(0.06*r) * m:grow(6), {pile=hi,
       tool="filbert 7", length={12,22}, coverage=1.1, fill=false, load=1.0,
       pressure={0.7,0.5}, clip=true})
end
ball(A, p_rbase2, p_rlit5, p_rtr2, p_rsh2, p_rrfl3, 500, 486, 86, p_rhi2)
ball(C, p_rbase2, p_rlit5, p_rtr2, p_rsh2, p_rrfl3, 690, 496, 78, p_rhi2)
ball(D, p_rbase2, p_rlit5, p_rtr2, p_rsh2, p_rrfl3, 300, 655, 100, p_rhi2)
ball(B, p_gb3, p_glit5, p_gtr4, p_gsh4, p_grfl3, 600, 448, 94, p_ghi3)
ball(E, p_gb3, p_glit5, p_gtr4, p_gsh4, p_grfl3, 470, 712, 82, p_ghi3)
print("final modelling", wait(0))
