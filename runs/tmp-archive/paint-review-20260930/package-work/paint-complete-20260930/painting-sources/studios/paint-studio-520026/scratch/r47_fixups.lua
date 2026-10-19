p_gb3 = pile{{"green earth", 5}, {"bone black", 1.4}, {"copper green", 1.2}, {"chrome yellow", 0.5}, {"lead white", 1}}
p_gl3 = pile{{"green earth", 3}, {"chrome yellow", 1.2}, {"lead white", 1.6}, {"copper green", 0.4}}
p_gt3 = pile{{"green earth", 4}, {"bone black", 2.4}, {"copper green", 0.8}, {"raw umber", 0.8}}
p_stem2 = pile{{"raw umber", 2}, {"bone black", 1.2}, {"red earth", 0.8}}
p_shw  = pile{{"raw umber", 2.2}, {"bone black", 2}, {"red earth", 0.4}}
cloth_r = cloth:roughen(9, 70, 12)
rim_o  = ellipse(580, 500, 200, 64)
rimb   = rim_o - ellipse(580, 500, 182, 53)
arc = function(x) return 500 + 53*math.sqrt(math.max(0, 1 - ((x-580)/182)^2)) end
nearrim = below(arc) * rim_o
R = function(pts, w, s) return ribbon(pts, w):soften(s) end

-- the old bowl's wings off the sides, back to cloth
work((ellipse(374, 506, 40, 26):soften(12) + ellipse(788, 504, 40, 26):soften(12))*cloth_r,
     {pile=p_clm4, hand="broad", coverage=4.0, fill=true, load=1.0, pressure={1.0,1.0},
      dips={1,1.0,0.0}, clip=true})
-- the bowl's shadow, redone warm and smooth
work(R({{508,622},{650,660},{790,700}}, 96, 42)*cloth_r, {pile=p_shw, tool="filbert 20",
     length={50,100}, coverage=2.2, fill=true, load=1.0, pressure={0.9,0.75},
     dips={1,1.0,0.0}, angle=0.5, clip=true})
work(R({{534,626},{648,652}}, 46, 22)*cloth_r, {pile=p_bo4_dk, tool="filbert 16",
     length={30,64}, coverage=1.6, fill=true, load=1.0, pressure={0.9,0.75},
     dips={1,1.0,0.0}, angle=0.4, clip=true})
blend((R({{508,622},{650,660},{790,700}}, 96, 42) + R({{534,626},{648,652}}, 46, 22))*cloth_r:soften(20),
      {angle=0.5})
-- the rim down a step, with a narrow light left on the near-left arc only
work(rimb, {pile=p_bo4_mid, tool="filbert 12", length={30,64}, coverage=1.6, fill=true,
     load=1.0, pressure={0.95,0.8}, dips={1,1.0,0.0}, angle=0.3, clip=true})
work(rimb * ellipse(452, 512, 96, 56):soften(34), {pile=p_bo4_lit, tool="filbert 12",
     length={30,64}, coverage=1.3, fill=true, load=1.0, pressure={0.95,0.8},
     dips={1,1.0,0.0}, angle=0.3, clip=true})

-- the two green apples again, deeper
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
B = (ellipse(600, 448, 94, 90):roughen(5, 55, 33)) - nearrim
E = ellipse(470, 712, 82, 80):roughen(4, 50, 41)
ball(B, p_gb3, p_gl3, p_gt3, p_gs2, p_gr2, 600, 448, 94)
ball(E, p_gb3, p_gl3, p_gt3, p_gs2, p_gr2, 470, 712, 82)

-- stalks
rg = brush{kind="round", width=7, point=0.95}
rg:load(p_stem2, 1.0)
rg:stroke({{503, 414}, {509, 398}, {514, 384}}, {pressure={1.0,0.6,0.05}})
rg:reload(p_stem2, 1.0)
rg:stroke({{605, 368}, {612, 352}, {618, 338}}, {pressure={1.0,0.6,0.05}})
rg:reload(p_stem2, 1.0)
rg:stroke({{474, 644}, {480, 628}, {486, 614}}, {pressure={1.0,0.6,0.05}})
rg:reload(p_stem2, 1.0)
rg:stroke({{692, 430}, {698, 416}, {704, 404}}, {pressure={1.0,0.6,0.05}})
print("fixups", wait(0))
