p_cl_lite2 = pile{{"lead white", 5}, {"raw umber", 2.5}, {"yellow ochre", 0.8}, {"red earth", 0.5}}
p_rlit8 = pile{{"vermilion", 2.4}, {"red earth", 2.6}, {"yellow ochre", 0.8}, {"raw umber", 0.8}}
p_glit8 = pile{{"green earth", 3.2}, {"chrome yellow", 0.9}, {"lead white", 0.9}, {"yellow ochre", 0.4}}
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

-- the glowing sheen patches: back to the fruit's own colour, and no separate highlight
plain = function(m, base, lit, cx, cy, r)
  local hx, hy = cx-0.40*r, cy-0.47*r
  work(ellipse(hx, hy, 0.50*r, 0.42*r):soften(0.14*r) * m, {pile=base, tool="filbert 16",
       length={26,54}, coverage=3.2, fill=true, load=1.0, pressure={1.0,0.85},
       dips={1,1.0,0.0}, clip=true})
  work(m * ellipse(cx-0.32*r, cy-0.31*r, 0.56*r, 0.52*r):soften(0.22*r), {pile=lit,
       tool="filbert 16", length={40,90}, coverage=1.3, fill=true, load=1.0,
       pressure={0.95,0.8}, dips={1,1.0,0.0}, angle=0.3, clip=true})
end
plain(A, p_rbase2, p_rlit8, 500, 486, 86)  plain(C, p_rbase2, p_rlit8, 690, 496, 78)
plain(D, p_rbase2, p_rlit8, 300, 655, 100)
plain(B, p_gb3, p_glit8, 600, 448, 94)  plain(E, p_gb3, p_glit8, 470, 712, 82)

-- the cloth: the white worms back to a soft grey, the folds laid from that
work(cloth_r, {pile=p_clm4, hand="broad", coverage=1.5, fill=true, load=1.0, pressure={1.0,0.9},
     dips={1,1.0,0.0}, angle=0.5, clip=true})
zone = function(m, p, a, cov) work(m*cloth_r, {pile=p, tool="filbert 20", length={50,100},
        coverage=cov, fill=true, load=1.0, pressure={0.9,0.75}, dips={1,1.0,0.0}, angle=a, clip=true}) end
zone(R({{50,586},{300,552},{560,522},{700,514}}, 60, 30), p_cl_lite2, -0.08, 1.2)
zone(R({{62,604},{148,700},{228,792}}, 56, 28), p_cl_lite2, 1.15, 1.2)
zone(R({{300,572},{252,650},{202,730}}, 50, 26), p_cl_lite2, 1.05, 1.1)
zone(R({{336,742},{398,792}}, 44, 22), p_cl_lite2, 0.5, 1.0)
zone(R({{196,778},{380,792},{520,796}}, 40, 22), p_cl_lite2, 0.1, 1.0)
zone(R({{788,578},{848,640},{870,700}}, 46, 24), p_cl_lite2, 0.75, 1.0)
zone(R({{180,620},{150,700},{128,772}}, 46, 24), p_cl_dk, 1.2, 1.4)
zone(ellipse(14, 802, 110, 58):soften(30), p_cl_dk, 0.3, 1.4)
zone(R({{392,700},{404,780}}, 42, 22), p_cl_dk, 1.4, 1.3)
zone(R({{856,566},{880,652}}, 44, 22), p_cl_dk, 1.5, 1.3)
zone(ellipse(800, 792, 150, 62):soften(32), p_cl_dk, 0.2, 1.4)
print("unify", wait(0))
