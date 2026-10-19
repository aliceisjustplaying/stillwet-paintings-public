p_rsh3 = pile{{"red earth", 2}, {"raw umber", 2.4}, {"bone black", 1.8}, {"yellow ochre", 0.3}}
p_gsh5 = pile{{"green earth", 2}, {"raw umber", 1.6}, {"bone black", 2.2}, {"yellow ochre", 0.3}}
p_bo7_mid = pile{{"raw umber", 2.6}, {"red earth", 2.2}, {"yellow ochre", 0.8}, {"bone black", 0.8}}
p_bo7_lit = pile{{"raw umber", 2}, {"red earth", 1.6}, {"yellow ochre", 1.2}, {"lead white", 1.6}}
p_bo7_sh  = pile{{"red earth", 1.8}, {"raw umber", 1.8}, {"bone black", 2}, {"yellow ochre", 0.3}}
p_bint   = pile{{"raw umber", 2}, {"bone black", 1.8}, {"red earth", 0.8}}
p_rrfl4  = pile{{"red earth", 1.6}, {"lead white", 0.7}, {"yellow ochre", 0.5}}
p_grfl4  = pile{{"yellow ochre", 1.8}, {"lead white", 0.8}, {"green earth", 0.6}}
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

-- the bowl, warm earthenware, and the rim that stays clear of the fruit
rf = rimb - fruit
work(wall, {pile=p_bo7_mid, hand="broad", coverage=2.6, fill=true, load=1.0, pressure={1.0,1.0},
     dips={1,1.0,0.0}, angle=0.4, clip=true})
work(wall * ellipse(448, 546, 120, 90):soften(48), {pile=p_bo7_lit, tool="filbert 16",
     length={40,90}, coverage=1.5, fill=true, load=1.0, pressure={0.9,0.75},
     dips={1,1.0,0.0}, angle=0.5, clip=true})
work(wall * ellipse(714, 588, 140, 104):soften(50), {pile=p_bo7_sh, tool="filbert 16",
     length={40,90}, coverage=1.8, fill=true, load=1.0, pressure={0.9,0.75},
     dips={1,1.0,0.0}, angle=0.5, clip=true})
work(rf, {pile=p_bo7_mid, tool="filbert 12", length={30,64}, coverage=2.6, fill=true,
     load=1.0, pressure={0.95,0.8}, dips={1,1.0,0.0}, angle=0.3, clip=true})
work(rf * ellipse(444, 508, 84, 48):soften(26), {pile=p_bo7_lit, tool="filbert 12",
     length={30,64}, coverage=1.3, fill=true, load=1.0, pressure={0.95,0.8},
     dips={1,1.0,0.0}, angle=0.3, clip=true})
work(rf * ellipse(722, 516, 92, 54):soften(30), {pile=p_bo7_sh, tool="filbert 12",
     length={30,64}, coverage=1.6, fill=true, load=1.0, pressure={0.95,0.8},
     dips={1,1.0,0.0}, angle=0.3, clip=true})
work(inner * -rim_o:grow(-6), {pile=p_bint, tool="filbert 16", length={40,90}, coverage=1.8,
     fill=true, load=1.0, pressure={0.9,0.75}, dips={1,1.0,0.0}, clip=true})
blend(bowl:soften(5), {angle=0.4})

-- the cores, warm instead of blue, and the reflected light quieter
core = function(m, sh, refl, cx, cy, r)
  work(m * ellipse(cx+0.58*r, cy+0.54*r, 0.70*r, 0.66*r):soften(0.16*r), {pile=sh,
       tool="filbert 16", length={40,90}, coverage=1.7, fill=true, load=1.0,
       pressure={0.95,0.8}, dips={1,1.0,0.0}, angle=0.3, clip=true})
  work(m * ellipse(cx+0.04*r, cy+0.89*r, 0.72*r, 0.20*r):soften(0.10*r), {pile=refl,
       tool="filbert 12", length={30,64}, coverage=1.2, fill=true, load=1.0,
       pressure={0.9,0.7}, dips={1,1.0,0.0}, angle=1.5, clip=true})
end
core(A, p_rsh3, p_rrfl4, 500, 486, 86)  core(C, p_rsh3, p_rrfl4, 690, 496, 78)
core(D, p_rsh3, p_rrfl4, 300, 655, 100)
core(B, p_gsh5, p_grfl4, 600, 448, 94)  core(E, p_gsh5, p_grfl4, 470, 712, 82)

-- the beaded highlights: cover them, and lay a soft light patch instead
gloss = function(m, lit, hi, cx, cy, r, glint)
  local hx, hy = cx-0.40*r, cy-0.47*r
  work(ellipse(hx, hy, 0.32*r, 0.26*r):soften(0.09*r) * m, {pile=lit, tool="filbert 12",
       length={24,50}, coverage=2.2, fill=true, load=1.0, pressure={0.9,0.7},
       dips={1,1.0,0.0}, clip=true})
  work(ellipse(hx, hy, 0.21*r, 0.16*r):soften(0.08*r) * m, {pile=hi, tool="filbert 10",
       length={16,32}, coverage=0.9, fill=false, load=1.0, pressure={0.7,0.5},
       dips={1,1.0,0.0}, clip=true})
  if glint then
    fb = brush{kind="round", width=5, point=1}
    fb:load(hi, 0.7)
    fb:touch(hx+0.02*r, hy-0.03*r, {pressure=0.45, drag={2,-1.5}})
  end
end
gloss(A, p_rlit5, p_rhi2, 500, 486, 86, true)  gloss(C, p_rlit5, p_rhi2, 690, 496, 78, false)
gloss(D, p_rlit5, p_rhi2, 300, 655, 100, true)
gloss(B, p_glit5, p_ghi3, 600, 448, 94, true)  gloss(E, p_glit5, p_ghi3, 470, 712, 82, false)
print("warmth", wait(0))
