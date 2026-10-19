p_cl_wd  = pile{{"lead white", 1.2}, {"raw umber", 4}, {"bone black", 1.2}, {"red earth", 0.8}}
p_cl_wdp = pile{{"bone black", 3}, {"raw umber", 2}, {"red earth", 0.5}, {"Prussian blue", 0.3}}
p_cl_hi2 = pile{{"lead white", 10}, {"yellow ochre", 1.2}, {"chrome yellow", 0.2}}
cloth_r = cloth:roughen(9, 70, 12)
R = function(pts, w, s) return ribbon(pts, w):soften(s) end

-- bury the value chart
work(rect(788, 636, 212, 164), {pile=p_tbl, hand="broad", coverage=3.0, fill=true,
     load=1.0, pressure={1.0,1.0}, dips={1,1.0,0.0}, clip=true})
work(rect(788, 636, 212, 164), {pile=p_tbl, hand="broad", coverage=2.4, fill=true,
     load=1.0, pressure={1.0,1.0}, dips={1,1.0,0.0}, clip=true})

-- sink the whole cloth to a mid-light, then lay the hollows into the wet paint
work(cloth_r, {pile=p_clm2, hand="broad", coverage=2.2, fill=true, load=1.0,
     pressure={1.0,1.0}, dips={1,1.0,0.0}, angle=0.5, clip=true})
work(cloth_r, {pile=p_cl_fall, hand="broad", coverage=1.5, fill=true, load=1.0,
     pressure={1.0,1.0}, dips={1,1.0,0.0}, angle=0.5, clip=true})

Z1 = R({{450,600},{380,690},{310,780}}, 110, 60)
Z2 = R({{740,600},{820,690}}, 90, 50)
Z3 = R({{330,570},{480,545}}, 70, 40)
Z4 = ellipse(862, 802, 160, 70):soften(40)
Z5 = ellipse(8, 802, 120, 70):soften(40)
Z6 = R({{300,700},{220,772}}, 70, 40)
zw = function(m, a) work(m*cloth_r, {pile=p_cl_wd, tool="filbert 16", length={40,90},
        coverage=1.7, fill=true, load=1.0, pressure={0.9,0.75}, dips={1,1.0,0.0}, angle=a, clip=true}) end
zw(Z1, -1.0) zw(Z2, 0.95) zw(Z3, -0.15) zw(Z4, 0.2) zw(Z5, 0.3) zw(Z6, -0.9)
work((R({{452,606},{586,634},{716,642}}, 36, 20) + R({{404,682},{366,752}}, 30, 18))*cloth_r,
     {pile=p_cl_wdp, tool="filbert 12", length={30,64}, coverage=1.8, fill=true, load=1.0,
      pressure={0.95,0.8}, dips={1,1.0,0.0}, clip=true})
blend(cloth_r:soften(20), {angle=0.5})

-- the crests, on top, opaque, warm white
kc = function(m, a) work(m*cloth_r, {pile=p_cl_hi2, tool="filbert 12", length={30,64},
        coverage=1.5, fill=true, load=1.0, pressure={1.0,0.9}, dips={1,1.0,0.0}, angle=a, clip=true}) end
kc(R({{30,578},{300,543},{560,518},{700,514}}, 30, 18), -0.08)
kc(R({{370,640},{250,720},{150,790}}, 38, 22), -0.85)
kc(R({{540,660},{545,740}}, 30, 20),  1.50)
kc(R({{700,640},{790,710}}, 34, 20),  0.72)
kc(R({{24,610},{52,672},{72,724}}, 24, 16), 1.15)
kc(R({{858,600},{870,654}}, 24, 16),  1.50)
kc(R({{320,786},{460,804}}, 26, 18),  0.20)
print("cloth 5", wait(0))
