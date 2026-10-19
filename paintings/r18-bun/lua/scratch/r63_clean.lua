p_rlit9 = pile{{"vermilion", 2.2}, {"red earth", 2.8}, {"yellow ochre", 0.7}, {"raw umber", 1}}
p_rtr3 = pile{{"red earth", 3.2}, {"bone black", 2.4}, {"raw umber", 2.4}, {"vermilion", 0.7}}
p_rsh5 = pile{{"red earth", 1.6}, {"raw umber", 2.4}, {"bone black", 2.2}, {"yellow ochre", 0.3}}
p_glit9= pile{{"green earth", 3.2}, {"chrome yellow", 0.8}, {"lead white", 0.8}, {"yellow ochre", 0.3}}
p_gtr5 = pile{{"green earth", 3.6}, {"bone black", 2.6}, {"copper green", 0.5}, {"raw umber", 1}}
p_gsh7 = pile{{"green earth", 1.6}, {"raw umber", 1.6}, {"bone black", 2.6}, {"yellow ochre", 0.3}}
p_rrf9 = pile{{"red earth", 1.5}, {"raw umber", 0.8}, {"lead white", 0.2}}
p_grf9 = pile{{"green earth", 1.3}, {"yellow ochre", 0.7}, {"raw umber", 0.4}}
rim_o  = ellipse(580, 500, 200, 64)
arc = function(x) return 500 + 53*math.sqrt(math.max(0, 1 - ((x-580)/182)^2)) end
nearrim = below(arc) * rim_o
A = (ellipse(500, 486, 86, 83):roughen(5, 40, 21)) - nearrim
C = (ellipse(690, 496, 78, 76):roughen(4, 35, 27)) - nearrim
B = (ellipse(600, 448, 94, 90):roughen(6, 50, 33)) - nearrim
D = ellipse(300, 655, 100, 96):roughen(5, 45, 3)
E = ellipse(470, 712, 82, 80):roughen(4, 45, 41)

ball = function(m, base, lit, tr, sh, refl, cx, cy, r)
  work(m, {pile=base, hand="broad", coverage=2.2, fill=true, load=1.0, pressure={1.0,1.0},
           dips={1,1.0,0.0}, angle=0.3, clip=true})
  work(m * ellipse(cx-0.34*r, cy-0.33*r, 0.62*r, 0.58*r):soften(0.28*r), {pile=lit,
       tool="filbert 16", length={40,90}, coverage=1.4, fill=true, load=1.0,
       pressure={0.95,0.8}, dips={1,1.0,0.0}, angle=0.3, clip=true})
  work(m * ellipse(cx+0.20*r, cy+0.22*r, 0.80*r, 0.76*r):soften(0.22*r), {pile=tr,
       tool="filbert 16", length={40,90}, coverage=1.7, fill=true, load=1.0,
       pressure={0.95,0.8}, dips={1,1.0,0.0}, angle=0.3, clip=true})
  work(m * ellipse(cx+0.52*r, cy+0.48*r, 0.72*r, 0.68*r):soften(0.16*r), {pile=sh,
       tool="filbert 16", length={40,90}, coverage=2.0, fill=true, load=1.0,
       pressure={0.95,0.8}, dips={1,1.0,0.0}, angle=0.3, clip=true})
  work(m * ellipse(cx+0.04*r, cy+0.90*r, 0.70*r, 0.20*r):soften(0.10*r), {pile=refl,
       tool="filbert 12", length={30,64}, coverage=0.9, fill=true, load=1.0,
       pressure={0.8,0.6}, dips={1,1.0,0.0}, angle=1.5, clip=true})
  -- the shadow-side edge lets go into the dark behind it
  work((m:grow(7):soften(6) - m) * ellipse(cx+0.62*r, cy+0.58*r, 0.95*r, 0.95*r), {pile=sh,
       tool="filbert 14", length={20,44}, coverage=0.7, fill=true, load=1.0,
       pressure={0.8,0.6}, dips={1,1.0,0.0}, edge="soft", clip=true})
  blend(m:soften(4), {angle=0.3})
end
ball(A, p_rbase2, p_rlit9, p_rtr3, p_rsh5, p_rrf9, 500, 486, 86)
ball(C, p_rbase2, p_rlit9, p_rtr3, p_rsh5, p_rrf9, 690, 496, 78)
ball(D, p_rbase2, p_rlit9, p_rtr3, p_rsh5, p_rrf9, 300, 655, 100)
ball(B, p_gb3, p_glit9, p_gtr5, p_gsh7, p_grf9, 600, 448, 94)
ball(E, p_gb3, p_glit9, p_gtr5, p_gsh7, p_grf9, 470, 712, 82)
print("clean fruit", wait(0))
