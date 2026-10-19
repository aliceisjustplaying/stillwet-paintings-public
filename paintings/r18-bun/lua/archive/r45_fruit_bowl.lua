p_rb3 = pile{{"red earth", 3}, {"bone black", 1.4}, {"raw umber", 1.6}, {"vermilion", 1.8}, {"yellow ochre", 0.7}, {"lead white", 0.5}}
p_rl4 = pile{{"vermilion", 2.6}, {"red earth", 2.4}, {"yellow ochre", 1}, {"lead white", 1}}
p_gb  = pile{{"green earth", 4}, {"bone black", 1.2}, {"yellow ochre", 1.6}, {"chrome yellow", 1.2}, {"lead white", 1.4}}
p_gl  = pile{{"green earth", 3}, {"yellow ochre", 1.6}, {"chrome yellow", 1}, {"lead white", 2}}
p_gt  = pile{{"green earth", 4.5}, {"bone black", 1.8}, {"yellow ochre", 1}, {"chrome yellow", 0.7}}
p_gs  = pile{{"green earth", 2.4}, {"bone black", 2.6}, {"Prussian blue", 0.5}, {"raw umber", 0.8}}
p_gr  = pile{{"yellow ochre", 1.6}, {"lead white", 1.6}, {"green earth", 0.6}}
p_gh  = pile{{"lead white", 4}, {"chrome yellow", 0.8}, {"yellow ochre", 0.6}, {"green earth", 0.5}}

rim_o  = ellipse(580, 500, 200, 64)
arc = function(x) return 500 + 53*math.sqrt(math.max(0, 1 - ((x-580)/182)^2)) end
nearrim = below(arc) * rim_o
inner  = ellipse(580, 500, 182, 53):roughen(2, 45, 11)

ball = function(m, base, lit, tr, sh, refl, cx, cy, r)
  work(m, {pile=base, hand="broad", coverage=4.5, fill=true, load=1.0, pressure={1.0,1.0},
           dips={1,1.0,0.0}, angle=0.3, clip=true})
  work(m * ellipse(cx-0.30*r, cy-0.29*r, 0.68*r, 0.64*r):soften(0.28*r), {pile=lit,
       tool="filbert 16", length={40,90}, coverage=1.5, fill=true, load=1.0,
       pressure={0.95,0.8}, dips={1,1.0,0.0}, angle=0.3, clip=true})
  work(m * ellipse(cx+0.30*r, cy+0.29*r, 0.84*r, 0.80*r):soften(0.22*r), {pile=tr,
       tool="filbert 16", length={40,90}, coverage=1.7, fill=true, load=1.0,
       pressure={0.95,0.8}, dips={1,1.0,0.0}, angle=0.3, clip=true})
  work(m * ellipse(cx+0.62*r, cy+0.57*r, 0.70*r, 0.66*r):soften(0.16*r), {pile=sh,
       tool="filbert 16", length={40,90}, coverage=1.8, fill=true, load=1.0,
       pressure={0.95,0.8}, dips={1,1.0,0.0}, angle=0.3, clip=true})
  work(m * ellipse(cx+0.04*r, cy+0.89*r, 0.74*r, 0.22*r):soften(0.11*r), {pile=refl,
       tool="filbert 12", length={30,64}, coverage=1.3, fill=true, load=1.0,
       pressure={0.95,0.8}, dips={1,1.0,0.0}, angle=1.5, clip=true})
  blend(m:soften(4), {angle=0.3})
end

A = (ellipse(500, 486, 86, 83):roughen(4, 45, 21)) - nearrim
C = (ellipse(690, 496, 78, 76):roughen(3, 40, 27)) - nearrim
B = (ellipse(600, 448, 94, 90):roughen(5, 55, 33)) - nearrim
ball(A, p_rb3, p_rl4, p_rtr, p_rsh, p_rrfl2, 500, 486, 86)
ball(C, p_rb3, p_rl4, p_rtr, p_rsh, p_rrfl2, 690, 496, 78)
ball(B, p_gb,  p_gl,  p_gt,  p_gs,  p_gr,  600, 448, 94)
print("fruit in the bowl", wait(0))
