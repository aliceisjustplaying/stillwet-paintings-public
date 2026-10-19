p_cal = pile{{"red earth", 2}, {"bone black", 1.4}, {"raw umber", 1.4}}
p_stm = pile{{"raw umber", 1.6}, {"bone black", 1.4}, {"red earth", 0.9}}
rim_o  = ellipse(580, 500, 200, 64)
arc = function(x) return 500 + 53*math.sqrt(math.max(0, 1 - ((x-580)/182)^2)) end
nearrim = below(arc) * rim_o
A = (ellipse(500, 486, 86, 83):roughen(4, 45, 21)) - nearrim
C = (ellipse(690, 496, 78, 76):roughen(3, 40, 27)) - nearrim
B = (ellipse(600, 448, 94, 90):roughen(5, 55, 33)) - nearrim
D = ellipse(300, 655, 100, 96):roughen(4, 50, 3)
E = ellipse(470, 712, 82, 80):roughen(4, 50, 41)

spot = function(m, lit, hi, cx, cy, r)
  local hx, hy = cx-0.40*r, cy-0.47*r
  work(ellipse(hx, hy, 0.30*r, 0.24*r):soften(0.08*r) * m, {pile=lit, tool="filbert 12",
       length={20,44}, coverage=2.0, fill=true, load=1.0, pressure={0.9,0.7},
       dips={1,1.0,0.0}, clip=true})
  work(ellipse(hx, hy, 0.19*r, 0.15*r):soften(0.07*r) * m, {pile=hi, tool="filbert 8",
       length={12,26}, coverage=1.2, fill=true, load=1.0, pressure={0.75,0.55},
       dips={1,1.0,0.0}, clip=true})
  work(ellipse(hx+0.03*r, hy-0.02*r, 0.09*r, 0.07*r):soften(0.03*r) * m, {pile=hi,
       tool={kind="round", width=7, point=1}, length={10,20}, coverage=1.0, fill=true,
       load=1.0, pressure={0.5,0.35}, clip=true})
end
spot(A, p_rlit5, p_rhi2, 500, 486, 86)
spot(C, p_rlit5, p_rhi2, 690, 496, 78)
spot(D, p_rlit5, p_rhi2, 300, 655, 100)
spot(B, p_glit5, p_ghi3, 600, 448, 94)
spot(E, p_glit5, p_ghi3, 470, 712, 82)

-- calyx and stalk for each
rg = brush{kind="round", width=8, point=0.9}
cal = function(m, cx, cy, r)
  work(ellipse(cx+0.02*r, cy-0.97*r, 0.15*r, 0.07*r):soften(0.03*r) * m:grow(8),
       {pile=p_cal, tool={kind="round", width=8, point=1}, length={10,20}, coverage=1.2,
        fill=true, load=1.0, pressure={0.6,0.4}, clip=true})
end
cal(A, 500, 486, 86) cal(C, 690, 496, 78) cal(D, 300, 655, 100)
cal(B, 600, 448, 94) cal(E, 470, 712, 82)
rg:load(p_stm, 1.0)
rg:stroke({{504, 410}, {509, 396}, {515, 382}}, {pressure={1.0,0.55,0.05}})
rg:reload(p_stm, 1.0); rg:stroke({{605, 360}, {611, 346}, {618, 332}}, {pressure={1.0,0.55,0.05}})
rg:reload(p_stm, 1.0); rg:stroke({{694, 424}, {700, 410}, {707, 396}}, {pressure={1.0,0.55,0.05}})
rg:reload(p_stm, 1.0); rg:stroke({{304, 564}, {309, 550}, {316, 536}}, {pressure={1.0,0.55,0.05}})
rg:reload(p_stm, 1.0); rg:stroke({{474, 638}, {479, 624}, {486, 610}}, {pressure={1.0,0.55,0.05}})
print("highlights and stalks", wait(0))
