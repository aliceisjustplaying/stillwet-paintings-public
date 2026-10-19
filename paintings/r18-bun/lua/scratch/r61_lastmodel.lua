p_rsh4 = pile{{"red earth", 1.8}, {"raw umber", 2.2}, {"bone black", 2}, {"yellow ochre", 0.3}}
p_gsh6 = pile{{"green earth", 1.8}, {"raw umber", 1.5}, {"bone black", 2.4}, {"yellow ochre", 0.3}}
p_edge_r= pile{{"yellow ochre", 2.5}, {"vermilion", 0.8}, {"red earth", 0.8}}
p_edge_g= pile{{"yellow ochre", 2}, {"chrome yellow", 0.8}, {"green earth", 0.8}}
p_shc2 = pile{{"raw umber", 1.8}, {"bone black", 1.8}, {"red earth", 0.4}, {"Prussian blue", 0.2}}
cloth_r = cloth:roughen(9, 70, 12)
rim_o  = ellipse(580, 500, 200, 64)
inner  = ellipse(580, 500, 182, 53):roughen(2, 45, 11)
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

-- each fruit gets a proper dark side
deep = function(m, sh, cx, cy, r)
  work(m * ellipse(cx+0.50*r, cy+0.46*r, 0.72*r, 0.68*r):soften(0.16*r), {pile=sh,
       tool="filbert 16", length={40,90}, coverage=2.0, fill=true, load=1.0,
       pressure={0.95,0.8}, dips={1,1.0,0.0}, angle=0.3, clip=true})
end
deep(A, p_rsh4, 500, 486, 86)  deep(C, p_rsh4, 690, 496, 78)  deep(D, p_rsh4, 300, 655, 100)
deep(B, p_gsh6, 600, 448, 94)  deep(E, p_gsh6, 470, 712, 82)

-- a warm edge-light on the lit side of each fruit
edge = function(m, p, cx, cy, r)
  local e = (m:grow(3) - m:shrink(3)) * ellipse(cx-0.62*r, cy-0.62*r, 0.92*r, 0.92*r)
  work(e, {pile=p, tool="filbert 10", length={16,36}, coverage=1.3, fill=true, load=1.0,
           pressure={0.9,0.7}, dips={1,1.0,0.0}, angle=0.6, clip=true})
end
edge(A, p_edge_r, 500, 486, 86)  edge(C, p_edge_r, 690, 496, 78)  edge(D, p_edge_r, 300, 655, 100)
edge(B, p_edge_g, 600, 448, 94)  edge(E, p_edge_g, 470, 712, 82)

-- the contact shadows, wider and darker
contact = function(m, cx, cy, r)
  work((m:grow(17):soften(11) - m) * ellipse(cx+0.12*r, cy+0.82*r, 1.1*r, 0.6*r) * free,
       {pile=p_shc2, tool="filbert 16", length={30,64}, coverage=2.2, fill=true, load=1.0,
        pressure={0.9,0.75}, dips={1,1.0,0.0}, angle=0.4, clip=true})
end
contact(D, 300, 655, 100)  contact(E, 470, 712, 82)
contact(A, 500, 486, 86)   contact(B, 600, 448, 94)  contact(C, 690, 496, 78)
print("deep, edge light, contact", wait(0))
