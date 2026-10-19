p_rlit7 = pile{{"vermilion", 3}, {"red earth", 2.2}, {"yellow ochre", 0.7}, {"lead white", 0.3}}
p_glit7 = pile{{"green earth", 3}, {"chrome yellow", 1}, {"lead white", 1.2}, {"yellow ochre", 0.4}}
cloth_r = cloth:roughen(9, 70, 12)
rim_o  = ellipse(580, 500, 200, 64)
arc = function(x) return 500 + 53*math.sqrt(math.max(0, 1 - ((x-580)/182)^2)) end
nearrim = below(arc) * rim_o
A = (ellipse(500, 486, 86, 83):roughen(4, 45, 21)) - nearrim
C = (ellipse(690, 496, 78, 76):roughen(3, 40, 27)) - nearrim
B = (ellipse(600, 448, 94, 90):roughen(5, 55, 33)) - nearrim
D = ellipse(300, 655, 100, 96):roughen(4, 50, 3)
E = ellipse(470, 712, 82, 80):roughen(4, 50, 41)
R = function(pts, w, s) return ribbon(pts, w):soften(s) end

-- the sheen, laid as a denser patch of the fruit's own light colour
sheen = function(m, lit, cx, cy, r)
  local hx, hy = cx-0.40*r, cy-0.47*r
  work(ellipse(hx, hy, 0.46*r, 0.38*r):soften(0.12*r) * m, {pile=lit, tool="filbert 14",
       length={24,50}, coverage=2.4, fill=true, load=1.0, pressure={1.0,0.85},
       dips={1,1.0,0.0}, clip=true})
  s = brush{kind="round", width=14, point=0.4, hair=0.9, stiffness=0.5}
  s:load(lit, 1.0)
  s:touch(hx, hy, {pressure=0.55, drag={0.05*r, -0.035*r}})
end
sheen(A, p_rlit7, 500, 486, 86)  sheen(C, p_rlit7, 690, 496, 78)  sheen(D, p_rlit7, 300, 655, 100)
sheen(B, p_glit7, 600, 448, 94)  sheen(E, p_glit7, 470, 712, 82)

-- the cloth: knocked to one value, then its folds laid cleanly on top
work(cloth_r, {pile=p_clm4, hand="broad", coverage=0.8, fill=true, load=1.0, pressure={1.0,0.9},
     dips={1,1.0,0.0}, angle=0.5, clip=true})
zone = function(m, p, a, cov, t) work(m*cloth_r, {pile=p, tool=t or "filbert 20", length={50,100},
        coverage=cov, fill=true, load=1.0, pressure={0.9,0.75}, dips={1,1.0,0.0}, angle=a, clip=true}) end
-- lights: the rolls and ridges that face the window
zone(R({{50,586},{300,552},{560,522},{700,514}}, 60, 30), p_cl_lite, -0.08, 1.4)
zone(R({{62,604},{148,700},{228,792}}, 56, 28), p_cl_lite, 1.15, 1.4)
zone(R({{300,572},{252,650},{202,730}}, 50, 26), p_cl_lite, 1.05, 1.3)
zone(R({{336,742},{398,792}}, 44, 22), p_cl_lite, 0.5, 1.2)
zone(R({{196,778},{380,792},{520,796}}, 40, 22), p_cl_lite, 0.1, 1.2)
zone(R({{788,578},{848,640},{870,700}}, 46, 24), p_cl_lite, 0.75, 1.2)
-- darks: the hollows between them
zone(R({{180,620},{150,700},{128,772}}, 46, 24), p_cl_dk, 1.2, 1.5)
zone(ellipse(14, 802, 110, 58):soften(30), p_cl_dk, 0.3, 1.5)
zone(R({{392,700},{404,780}}, 42, 22), p_cl_dk, 1.4, 1.4)
zone(R({{856,566},{880,652}}, 44, 22), p_cl_dk, 1.5, 1.4)
zone(ellipse(800, 792, 150, 62):soften(32), p_cl_dk, 0.2, 1.5)
zone(R({{240,752},{214,798}}, 34, 18), p_cl_dk, 1.0, 1.3)
print("sheen and cloth", wait(0))
