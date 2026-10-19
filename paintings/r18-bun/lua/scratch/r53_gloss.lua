p_rim_mid = pile{{"raw umber", 2.4}, {"red earth", 1.4}, {"bone black", 1.6}, {"yellow ochre", 0.3}}
p_bo8_lit = pile{{"raw umber", 2.4}, {"red earth", 1.8}, {"yellow ochre", 1}, {"lead white", 1}}
p_rrfl5  = pile{{"red earth", 1.4}, {"raw umber", 0.6}, {"lead white", 0.3}}
p_grfl5  = pile{{"green earth", 1.2}, {"yellow ochre", 1}, {"lead white", 0.4}}
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
rf = rimb - fruit

work(rf, {pile=p_rim_mid, tool="filbert 12", length={30,64}, coverage=2.0, fill=true,
     load=1.0, pressure={0.95,0.8}, dips={1,1.0,0.0}, angle=0.3, clip=true})
work(rf * ellipse(444, 508, 84, 48):soften(26), {pile=p_bo8_lit, tool="filbert 12",
     length={30,64}, coverage=1.2, fill=true, load=1.0, pressure={0.95,0.8},
     dips={1,1.0,0.0}, angle=0.3, clip=true})
work(wall * ellipse(448, 546, 118, 88):soften(46), {pile=p_bo8_lit, tool="filbert 16",
     length={40,90}, coverage=1.0, fill=true, load=1.0, pressure={0.9,0.75},
     dips={1,1.0,0.0}, angle=0.5, clip=true})
blend(bowl:soften(5), {angle=0.4})

-- quieter bounce light along the bottoms
qf = function(m, p, cx, cy, r)
  work(m * ellipse(cx+0.04*r, cy+0.89*r, 0.72*r, 0.20*r):soften(0.10*r), {pile=p,
       tool="filbert 12", length={30,64}, coverage=1.5, fill=true, load=1.0,
       pressure={0.9,0.7}, dips={1,1.0,0.0}, angle=1.5, clip=true})
end
qf(A, p_rrfl5, 500, 486, 86) qf(C, p_rrfl5, 690, 496, 78) qf(D, p_rrfl5, 300, 655, 100)
qf(B, p_grfl5, 600, 448, 94) qf(E, p_grfl5, 470, 712, 82)

-- the beading: cover it with the fruit's own body colour, then one soft touch
sb = brush{kind="round", width=30, point=0.25, hair=0.9, stiffness=0.35, splay=0.25}
gloss = function(m, base, hi, cx, cy, r, glint)
  local hx, hy = cx-0.40*r, cy-0.47*r
  work(ellipse(hx, hy, 0.34*r, 0.28*r):soften(0.10*r) * m, {pile=base, tool="filbert 14",
       length={24,50}, coverage=3.0, fill=true, load=1.0, pressure={1.0,0.85},
       dips={1,1.0,0.0}, clip=true})
  sb:load(hi, 0.3)
  sb:touch(hx, hy, {pressure=0.3, drag={0.10*r, -0.07*r}, twist=0.2})
  if glint then
    fb = brush{kind="round", width=4, point=1}
    fb:load(hi, 0.75)
    fb:touch(hx+0.03*r, hy-0.04*r, {pressure=0.5, drag={1.5,-1}})
  end
end
gloss(A, p_rbase2, p_rhi2, 500, 486, 86, true)  gloss(C, p_rbase2, p_rhi2, 690, 496, 78, false)
gloss(D, p_rbase2, p_rhi2, 300, 655, 100, true)
gloss(B, p_gb3, p_ghi3, 600, 448, 94, true)  gloss(E, p_gb3, p_ghi3, 470, 712, 82, false)
print("gloss", wait(0))
