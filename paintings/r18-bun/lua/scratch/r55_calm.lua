p_glit6 = pile{{"green earth", 3}, {"chrome yellow", 1}, {"lead white", 1.2}, {"yellow ochre", 0.4}}
p_rlit6 = pile{{"vermilion", 3}, {"red earth", 2.2}, {"yellow ochre", 0.7}, {"lead white", 0.3}}
p_sheen_r = pile{{"yellow ochre", 2.5}, {"vermilion", 1}, {"red earth", 1}}
p_sheen_g = pile{{"yellow ochre", 2}, {"chrome yellow", 1}, {"green earth", 1}}
p_rf7 = pile{{"red earth", 1.6}, {"raw umber", 0.8}, {"lead white", 0.2}}
p_rf8 = pile{{"green earth", 1.4}, {"yellow ochre", 0.8}, {"raw umber", 0.4}}
rim_o  = ellipse(580, 500, 200, 64)
arc = function(x) return 500 + 53*math.sqrt(math.max(0, 1 - ((x-580)/182)^2)) end
nearrim = below(arc) * rim_o
A = (ellipse(500, 486, 86, 83):roughen(4, 45, 21)) - nearrim
C = (ellipse(690, 496, 78, 76):roughen(3, 40, 27)) - nearrim
B = (ellipse(600, 448, 94, 90):roughen(5, 55, 33)) - nearrim
D = ellipse(300, 655, 100, 96):roughen(4, 50, 3)
E = ellipse(470, 712, 82, 80):roughen(4, 50, 41)

calm = function(m, base, lit, sheen, refl, cx, cy, r)
  local hx, hy = cx-0.40*r, cy-0.47*r
  work(ellipse(hx, hy, 0.44*r, 0.36*r):soften(0.12*r) * m, {pile=base, tool="filbert 14",
       length={24,50}, coverage=3.0, fill=true, load=1.0, pressure={1.0,0.85},
       dips={1,1.0,0.0}, clip=true})
  work(m * ellipse(cx-0.34*r, cy-0.33*r, 0.52*r, 0.48*r):soften(0.20*r), {pile=lit,
       tool="filbert 16", length={40,90}, coverage=1.4, fill=true, load=1.0,
       pressure={0.95,0.8}, dips={1,1.0,0.0}, angle=0.3, clip=true})
  work(m * ellipse(cx+0.04*r, cy+0.90*r, 0.78*r, 0.26*r):soften(0.11*r), {pile=base,
       tool="filbert 14", length={24,50}, coverage=2.8, fill=true, load=1.0,
       pressure={1.0,0.85}, dips={1,1.0,0.0}, angle=1.5, clip=true})
  work(m * ellipse(cx+0.04*r, cy+0.90*r, 0.64*r, 0.15*r):soften(0.06*r), {pile=refl,
       tool="filbert 12", length={18,36}, coverage=0.7, fill=true, load=1.0,
       pressure={0.75,0.55}, dips={1,1.0,0.0}, angle=1.5, clip=true})
  s = brush{kind="round", width=15, point=0.35, hair=0.9, stiffness=0.45}
  s:load(sheen, 0.75)
  s:touch(hx, hy, {pressure=0.5, drag={0.06*r, -0.04*r}})
end
calm(A, p_rbase2, p_rlit6, p_sheen_r, p_rf7, 500, 486, 86)
calm(C, p_rbase2, p_rlit6, p_sheen_r, p_rf7, 690, 496, 78)
calm(D, p_rbase2, p_rlit6, p_sheen_r, p_rf7, 300, 655, 100)
calm(B, p_gb3, p_glit6, p_sheen_g, p_rf8, 600, 448, 94)
calm(E, p_gb3, p_glit6, p_sheen_g, p_rf8, 470, 712, 82)
print("calm", wait(0))
