p_rhi3 = pile{{"lead white", 2}, {"vermilion", 1}, {"red earth", 0.8}, {"yellow ochre", 0.3}}
p_ghi4 = pile{{"lead white", 2.5}, {"green earth", 1.2}, {"chrome yellow", 0.4}, {"yellow ochre", 0.4}}
p_rrfl6 = pile{{"red earth", 1.5}, {"raw umber", 1}, {"lead white", 0.3}, {"vermilion", 0.2}}
p_grfl6 = pile{{"green earth", 1.4}, {"yellow ochre", 0.8}, {"raw umber", 0.5}}
rim_o  = ellipse(580, 500, 200, 64)
arc = function(x) return 500 + 53*math.sqrt(math.max(0, 1 - ((x-580)/182)^2)) end
nearrim = below(arc) * rim_o
A = (ellipse(500, 486, 86, 83):roughen(4, 45, 21)) - nearrim
C = (ellipse(690, 496, 78, 76):roughen(3, 40, 27)) - nearrim
B = (ellipse(600, 448, 94, 90):roughen(5, 55, 33)) - nearrim
D = ellipse(300, 655, 100, 96):roughen(4, 50, 3)
E = ellipse(470, 712, 82, 80):roughen(4, 50, 41)

-- cover the old highlight and bounce, then lay them again small and quiet
fixup = function(m, base, lit, hi, refl, cx, cy, r, glint)
  local hx, hy = cx-0.40*r, cy-0.47*r
  work(ellipse(hx, hy, 0.40*r, 0.34*r):soften(0.10*r) * m, {pile=base, tool="filbert 14",
       length={24,50}, coverage=3.0, fill=true, load=1.0, pressure={1.0,0.85},
       dips={1,1.0,0.0}, clip=true})
  work(ellipse(hx, hy, 0.26*r, 0.20*r):soften(0.08*r) * m, {pile=lit, tool="filbert 12",
       length={18,36}, coverage=2.0, fill=true, load=1.0, pressure={0.9,0.7},
       dips={1,1.0,0.0}, clip=true})
  work(m * ellipse(cx+0.04*r, cy+0.90*r, 0.76*r, 0.24*r):soften(0.10*r), {pile=base,
       tool="filbert 14", length={24,50}, coverage=2.6, fill=true, load=1.0,
       pressure={1.0,0.85}, dips={1,1.0,0.0}, angle=1.5, clip=true})
  work(m * ellipse(cx+0.04*r, cy+0.90*r, 0.66*r, 0.16*r):soften(0.07*r), {pile=refl,
       tool="filbert 12", length={18,36}, coverage=1.0, fill=true, load=1.0,
       pressure={0.8,0.6}, dips={1,1.0,0.0}, angle=1.5, clip=true})
  s1 = brush{kind="round", width=17, point=0.3, hair=0.9, stiffness=0.4}
  s1:load(hi, 0.3)
  s1:touch(hx, hy, {pressure=0.32, drag={0.07*r, -0.05*r}})
  if glint then
    s2 = brush{kind="round", width=3.5, point=1}
    s2:load(hi, 0.8)
    s2:touch(hx+0.02*r, hy-0.03*r, {pressure=0.5})
  end
end
fixup(A, p_rbase2, p_rlit5, p_rhi3, p_rrfl6, 500, 486, 86, true)
fixup(C, p_rbase2, p_rlit5, p_rhi3, p_rrfl6, 690, 496, 78, false)
fixup(D, p_rbase2, p_rlit5, p_rhi3, p_rrfl6, 300, 655, 100, true)
fixup(B, p_gb3, p_glit5, p_ghi4, p_grfl6, 600, 448, 94, true)
fixup(E, p_gb3, p_glit5, p_ghi4, p_grfl6, 470, 712, 82, false)
print("gloss 2", wait(0))
