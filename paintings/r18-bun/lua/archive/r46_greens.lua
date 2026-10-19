p_gb2 = pile{{"green earth", 5}, {"bone black", 1.2}, {"chrome yellow", 0.8}, {"red earth", 0.4}, {"lead white", 1}}
p_gl2 = pile{{"green earth", 3.5}, {"chrome yellow", 1.4}, {"lead white", 1.6}, {"yellow ochre", 0.4}}
p_gt2 = pile{{"green earth", 5}, {"bone black", 2}, {"chrome yellow", 0.5}, {"raw umber", 0.6}}
p_gs2 = pile{{"green earth", 2.2}, {"bone black", 2.8}, {"Prussian blue", 0.6}}
p_gr2 = pile{{"yellow ochre", 2}, {"lead white", 1.6}, {"green earth", 0.8}}
p_gh2 = pile{{"lead white", 4}, {"chrome yellow", 0.6}, {"green earth", 0.6}}
cloth_r = cloth:roughen(9, 70, 12)
rim_o  = ellipse(580, 500, 200, 64)
arc = function(x) return 500 + 53*math.sqrt(math.max(0, 1 - ((x-580)/182)^2)) end
nearrim = below(arc) * rim_o

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

-- the rim is too bright and cuts across the fruit; take it down a step
work((rim_o - ellipse(580, 500, 182, 53)) * -nearrim, {pile=p_bo4_mid, tool="filbert 12",
     length={30,64}, coverage=1.4, fill=true, load=1.0, pressure={0.95,0.8},
     dips={1,1.0,0.0}, angle=0.3, clip=true})
work(rim_o * ellipse(455, 505, 130, 80):soften(44), {pile=p_bo4_lit, tool="filbert 12",
     length={30,64}, coverage=1.3, fill=true, load=1.0, pressure={0.95,0.8},
     dips={1,1.0,0.0}, angle=0.3, clip=true})

A = (ellipse(500, 486, 86, 83):roughen(4, 45, 21)) - nearrim
C = (ellipse(690, 496, 78, 76):roughen(3, 40, 27)) - nearrim
B = (ellipse(600, 448, 94, 90):roughen(5, 55, 33)) - nearrim
ball(A, p_rbase2, p_rlit3, p_rtr, p_rsh, p_rrfl2, 500, 486, 86)
ball(C, p_rbase2, p_rlit3, p_rtr, p_rsh, p_rrfl2, 690, 496, 78)
ball(B, p_gb2, p_gl2, p_gt2, p_gs2, p_gr2, 600, 448, 94)

E = ellipse(470, 712, 82, 80):roughen(4, 50, 41)
work(ellipse(512, 768, 84, 26):soften(22) * cloth_r * -E:grow(6), {pile=p_gs2, tool="filbert 16",
     length={40,90}, coverage=1.8, fill=true, load=1.0, pressure={0.9,0.75},
     dips={1,1.0,0.0}, angle=0.5, clip=true})
ball(E, p_gb2, p_gl2, p_gt2, p_gs2, p_gr2, 470, 712, 82)
print("fruit 2", wait(0))
