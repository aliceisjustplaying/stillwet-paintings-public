p_rlit8 = pile{{"vermilion", 2.4}, {"red earth", 2.6}, {"yellow ochre", 0.8}, {"raw umber", 0.8}}
p_glit8 = pile{{"green earth", 3.2}, {"chrome yellow", 0.9}, {"lead white", 0.9}, {"yellow ochre", 0.4}}
p_edge_r= pile{{"yellow ochre", 2.5}, {"vermilion", 0.8}, {"red earth", 0.8}}
p_edge_g= pile{{"yellow ochre", 2}, {"chrome yellow", 0.8}, {"green earth", 0.8}}
p_shc2 = pile{{"raw umber", 1.8}, {"bone black", 1.8}, {"red earth", 0.4}, {"Prussian blue", 0.2}}
cloth_r = cloth:roughen(9, 70, 12)
rim_o  = ellipse(580, 500, 200, 64)
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

-- the hard edge-light lines back to a soft turn of the light
soft = function(m, base, lit, edge, cx, cy, r)
  work(m:grow(4), {pile=base, hand="broad", coverage=1.2, fill=true, load=1.0, pressure={1.0,0.9},
       dips={1,1.0,0.0}, angle=0.3, clip=m:grow(4)})
  work(m * ellipse(cx-0.34*r, cy-0.33*r, 0.64*r, 0.60*r):soften(0.28*r), {pile=lit,
       tool="filbert 16", length={40,90}, coverage=1.2, fill=true, load=1.0,
       pressure={0.95,0.8}, dips={1,1.0,0.0}, angle=0.3, clip=true})
  work((m:grow(2) - m) * ellipse(cx-0.58*r, cy-0.58*r, 0.74*r, 0.74*r), {pile=edge,
       tool="filbert 12", length={18,40}, coverage=0.5, fill=true, load=1.0,
       pressure={0.8,0.6}, dips={1,1.0,0.0}, angle=0.6, clip=true})
end
soft(A, p_rbase2, p_rlit8, p_edge_r, 500, 486, 86)
soft(C, p_rbase2, p_rlit8, p_edge_r, 690, 496, 78)
soft(D, p_rbase2, p_rlit8, p_edge_r, 300, 655, 100)
soft(B, p_gb3, p_glit8, p_edge_g, 600, 448, 94)
soft(E, p_gb3, p_glit8, p_edge_g, 470, 712, 82)

-- the contact shadows: a pool just under each fruit, not a ring round it
fixc = function(m, cx, cy, r)
  work((m:grow(20):soften(12) - m) * ellipse(cx+0.12*r, cy+0.80*r, 1.1*r, 0.62*r) * free,
       {pile=p_clm4, hand="broad", coverage=1.4, fill=true, load=1.0, pressure={1.0,0.9},
        dips={1,1.0,0.0}, angle=0.4, clip=true})
  work(ellipse(cx+0.22*r, cy+0.98*r, 0.62*r, 0.26*r):soften(11) * free, {pile=p_shc2,
       tool="filbert 16", length={30,64}, coverage=2.0, fill=true, load=1.0,
       pressure={0.9,0.75}, dips={1,1.0,0.0}, angle=0.3, clip=true})
  work(ellipse(cx+0.34*r, cy+1.06*r, 0.9*r, 0.34*r):soften(16) * free, {pile=p_shc2,
       tool="filbert 20", length={40,90}, coverage=1.3, fill=true, load=1.0,
       pressure={0.85,0.7}, dips={1,1.0,0.0}, angle=0.4, clip=true})
end
fixc(D, 300, 655, 100)  fixc(E, 470, 712, 82)
print("soften", wait(0))
