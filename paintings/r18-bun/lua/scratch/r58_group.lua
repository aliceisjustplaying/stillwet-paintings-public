p_cl_lite3 = pile{{"lead white", 4.2}, {"raw umber", 2.8}, {"yellow ochre", 0.8}, {"red earth", 0.6}}
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
A = (ellipse(500, 486, 86, 83):roughen(4, 45, 21)) - nearrim
C = (ellipse(690, 496, 78, 76):roughen(3, 40, 27)) - nearrim
B = (ellipse(600, 448, 94, 90):roughen(5, 55, 33)) - nearrim
D = ellipse(300, 655, 100, 96):roughen(4, 50, 3)
E = ellipse(470, 712, 82, 80):roughen(4, 50, 41)
fruit = A + B + C + D + E
free = cloth_r * -fruit * -bowl
R = function(pts, w, s) return ribbon(pts, w):soften(s) end

-- the cloth, where it is not covered by the bowl or the fruit
work(free, {pile=p_clm4, hand="broad", coverage=1.2, fill=true, load=1.0, pressure={1.0,0.9},
     dips={1,1.0,0.0}, angle=0.5, clip=true})
zone = function(m, p, a, cov) work(m*free, {pile=p, tool="filbert 20", length={50,100},
        coverage=cov, fill=true, load=1.0, pressure={0.9,0.75}, dips={1,1.0,0.0}, angle=a, clip=true}) end
zone(R({{40,592},{290,556},{430,536}}, 54, 28), p_cl_lite3, -0.08, 1.1)
zone(R({{62,604},{148,700},{228,792}}, 52, 26), p_cl_lite3, 1.15, 1.1)
zone(R({{196,778},{380,792},{520,796}}, 38, 20), p_cl_lite3, 0.1, 1.0)
zone(R({{790,578},{848,640},{870,700}}, 44, 22), p_cl_lite3, 0.75, 1.0)
zone(R({{180,620},{150,700},{128,772}}, 44, 22), p_cl_dk, 1.2, 1.2)
zone(ellipse(14, 802, 108, 56):soften(28), p_cl_dk, 0.3, 1.3)
zone(R({{392,700},{404,780}}, 40, 20), p_cl_dk, 1.4, 1.2)
zone(R({{856,566},{880,652}}, 42, 20), p_cl_dk, 1.5, 1.2)
zone(ellipse(800, 792, 148, 60):soften(30), p_cl_dk, 0.2, 1.3)

-- the bowl
rf = rimb - fruit
work(wall, {pile=p_bo7_mid, hand="broad", coverage=2.6, fill=true, load=1.0, pressure={1.0,1.0},
     dips={1,1.0,0.0}, angle=0.4, clip=true})
work(wall * ellipse(448, 546, 118, 88):soften(46), {pile=p_bo8_lit, tool="filbert 16",
     length={40,90}, coverage=1.1, fill=true, load=1.0, pressure={0.9,0.75},
     dips={1,1.0,0.0}, angle=0.5, clip=true})
work(wall * ellipse(714, 588, 140, 104):soften(50), {pile=p_bo7_sh, tool="filbert 16",
     length={40,90}, coverage=1.7, fill=true, load=1.0, pressure={0.9,0.75},
     dips={1,1.0,0.0}, angle=0.5, clip=true})
work(bowl * below(function() return 580 end):soften(20), {pile=p_bo6_dk, tool="filbert 16",
     length={30,64}, coverage=1.3, fill=true, load=1.0, pressure={0.9,0.8},
     dips={1,1.0,0.0}, angle=1.2, clip=true})
work(rf, {pile=p_rim_mid, tool="filbert 12", length={30,64}, coverage=2.2, fill=true,
     load=1.0, pressure={0.95,0.8}, dips={1,1.0,0.0}, angle=0.3, clip=true})
work(rf * ellipse(444, 508, 84, 48):soften(26), {pile=p_bo8_lit, tool="filbert 12",
     length={30,64}, coverage=1.2, fill=true, load=1.0, pressure={0.95,0.8},
     dips={1,1.0,0.0}, angle=0.3, clip=true})
work(inner * -(rim_o:grow(-4)), {pile=p_bint, tool="filbert 16", length={40,90}, coverage=2.0,
     fill=true, load=1.0, pressure={0.9,0.75}, dips={1,1.0,0.0}, clip=true})
blend(bowl:soften(5), {angle=0.4})

-- the five fruit, the way that reads
ball = function(m, base, lit, tr, sh, refl, cx, cy, r)
  work(m, {pile=base, hand="broad", coverage=4.0, fill=true, load=1.0, pressure={1.0,1.0},
           dips={1,1.0,0.0}, angle=0.3, clip=true})
  work(m * ellipse(cx-0.32*r, cy-0.31*r, 0.56*r, 0.52*r):soften(0.22*r), {pile=lit,
       tool="filbert 16", length={40,90}, coverage=1.3, fill=true, load=1.0,
       pressure={0.95,0.8}, dips={1,1.0,0.0}, angle=0.3, clip=true})
  work(m * ellipse(cx+0.22*r, cy+0.24*r, 0.78*r, 0.74*r):soften(0.20*r), {pile=tr,
       tool="filbert 16", length={40,90}, coverage=1.7, fill=true, load=1.0,
       pressure={0.95,0.8}, dips={1,1.0,0.0}, angle=0.3, clip=true})
  work(m * ellipse(cx+0.56*r, cy+0.52*r, 0.68*r, 0.64*r):soften(0.15*r), {pile=sh,
       tool="filbert 16", length={40,90}, coverage=2.0, fill=true, load=1.0,
       pressure={0.95,0.8}, dips={1,1.0,0.0}, angle=0.3, clip=true})
  work(m * ellipse(cx+0.04*r, cy+0.90*r, 0.72*r, 0.20*r):soften(0.10*r), {pile=refl,
       tool="filbert 12", length={30,64}, coverage=0.9, fill=true, load=1.0,
       pressure={0.8,0.6}, dips={1,1.0,0.0}, angle=1.5, clip=true})
  blend(m:soften(4), {angle=0.3})
end
ball(A, p_rbase2, p_rlit8, p_rtr2, p_rsh3, p_rrfl6, 500, 486, 86)
ball(C, p_rbase2, p_rlit8, p_rtr2, p_rsh3, p_rrfl6, 690, 496, 78)
ball(D, p_rbase2, p_rlit8, p_rtr2, p_rsh3, p_rrfl6, 300, 655, 100)
ball(B, p_gb3, p_glit8, p_gtr4, p_gsh5, p_grfl6, 600, 448, 94)
ball(E, p_gb3, p_glit8, p_gtr4, p_gsh5, p_grfl6, 470, 712, 82)
print("group", wait(0))
