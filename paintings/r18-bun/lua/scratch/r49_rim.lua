p_bo5_lit = pile{{"raw umber", 2.6}, {"lead white", 2.2}, {"bone black", 0.5}, {"yellow ochre", 0.5}}
p_bo5_mid = pile{{"raw umber", 3.2}, {"bone black", 1.4}, {"lead white", 0.8}, {"red earth", 0.7}}
rim_o  = ellipse(580, 500, 200, 64)
inner  = ellipse(580, 500, 182, 53):roughen(2, 45, 11)
rimb   = rim_o - inner
arc = function(x) return 500 + 53*math.sqrt(math.max(0, 1 - ((x-580)/182)^2)) end
nearrim = below(arc) * rim_o
A = (ellipse(500, 486, 86, 83):roughen(4, 45, 21)) - nearrim
C = (ellipse(690, 496, 78, 76):roughen(3, 40, 27)) - nearrim
B = (ellipse(600, 448, 94, 90):roughen(5, 55, 33)) - nearrim
fruit = A + C + B
skirt  = poly({{392,506},{396,532},{408,560},{430,583},{462,600},{504,613},{544,621},
               {580,625},{616,621},{656,613},{698,600},{730,583},{752,560},{764,532},{768,506}}, true)
bowl   = (rim_o + skirt):roughen(3, 55, 7)
wall   = bowl - inner

-- the rim again, this time keeping clear of the fruit
rf = rimb - fruit
work(rf, {pile=p_bo5_mid, tool="filbert 12", length={30,64}, coverage=2.0, fill=true,
     load=1.0, pressure={0.95,0.8}, dips={1,1.0,0.0}, angle=0.3, clip=true})
work(rf * ellipse(448, 512, 92, 54):soften(30), {pile=p_bo5_lit, tool="filbert 12",
     length={30,64}, coverage=1.2, fill=true, load=1.0, pressure={0.95,0.8},
     dips={1,1.0,0.0}, angle=0.3, clip=true})
work(rf * ellipse(716, 520, 100, 60):soften(34), {pile=p_bo4_sh, tool="filbert 12",
     length={30,64}, coverage=1.5, fill=true, load=1.0, pressure={0.95,0.8},
     dips={1,1.0,0.0}, angle=0.3, clip=true})
-- the body: a softer turn from the lit shoulder into the shadow
work(wall * ellipse(452, 550, 128, 96):soften(52), {pile=p_bo5_lit, tool="filbert 16",
     length={40,90}, coverage=1.2, fill=true, load=1.0, pressure={0.9,0.75},
     dips={1,1.0,0.0}, angle=0.5, clip=true})
work(wall * ellipse(712, 588, 140, 104):soften(52), {pile=p_bo4_sh, tool="filbert 16",
     length={40,90}, coverage=1.6, fill=true, load=1.0, pressure={0.9,0.75},
     dips={1,1.0,0.0}, angle=0.5, clip=true})
blend(bowl:soften(5), {angle=0.4})

-- the three fruit once more, on top of the rim
ball = function(m, base, lit, tr, sh, refl, cx, cy, r)
  work(m, {pile=base, hand="broad", coverage=4.5, fill=true, load=1.0, pressure={1.0,1.0},
           dips={1,1.0,0.0}, angle=0.3, clip=true})
  work(m * ellipse(cx-0.34*r, cy-0.33*r, 0.52*r, 0.48*r):soften(0.20*r), {pile=lit,
       tool="filbert 16", length={40,90}, coverage=1.4, fill=true, load=1.0,
       pressure={0.95,0.8}, dips={1,1.0,0.0}, angle=0.3, clip=true})
  work(m * ellipse(cx+0.22*r, cy+0.24*r, 0.78*r, 0.74*r):soften(0.20*r), {pile=tr,
       tool="filbert 16", length={40,90}, coverage=1.7, fill=true, load=1.0,
       pressure={0.95,0.8}, dips={1,1.0,0.0}, angle=0.3, clip=true})
  work(m * ellipse(cx+0.58*r, cy+0.54*r, 0.66*r, 0.62*r):soften(0.14*r), {pile=sh,
       tool="filbert 16", length={40,90}, coverage=2.0, fill=true, load=1.0,
       pressure={0.95,0.8}, dips={1,1.0,0.0}, angle=0.3, clip=true})
  work(m * ellipse(cx+0.04*r, cy+0.89*r, 0.74*r, 0.22*r):soften(0.11*r), {pile=refl,
       tool="filbert 12", length={30,64}, coverage=1.3, fill=true, load=1.0,
       pressure={0.95,0.8}, dips={1,1.0,0.0}, angle=1.5, clip=true})
  blend(m:soften(4), {angle=0.3})
end
ball(A, p_rbase2, p_rlit3, p_rtr, p_rsh, p_rrfl2, 500, 486, 86)
ball(C, p_rbase2, p_rlit3, p_rtr, p_rsh, p_rrfl2, 690, 496, 78)
ball(B, p_gb3, p_gl3, p_gt3, p_gs2, p_gr2, 600, 448, 94)
print("rim and fruit", wait(0))
