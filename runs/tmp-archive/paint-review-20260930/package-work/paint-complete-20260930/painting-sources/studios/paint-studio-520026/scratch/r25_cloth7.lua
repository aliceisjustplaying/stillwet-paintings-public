p_clm3  = pile{{"lead white", 2}, {"raw umber", 4}, {"red earth", 1}, {"yellow ochre", 0.6}, {"bone black", 0.8}}
p_cl_lite= pile{{"lead white", 8}, {"raw umber", 1.2}, {"yellow ochre", 0.8}}
p_cl_dk  = pile{{"raw umber", 2}, {"bone black", 2}, {"red earth", 0.5}, {"Prussian blue", 0.25}}
p_cl_fall2=pile{{"raw umber", 3}, {"bone black", 1.6}, {"red earth", 0.5}}
cloth_r = cloth:roughen(9, 70, 12)
R = function(pts, w, s) return ribbon(pts, w):soften(s) end

work(cloth_r, {pile=p_clm3, hand="broad", coverage=2.4, fill=true, load=1.0,
     pressure={1.0,1.0}, dips={1,1.0,0.0}, angle=0.5, clip=true})
work(cloth_r, {pile=p_clm3, hand="broad", coverage=1.8, fill=true, load=1.0,
     pressure={1.0,1.0}, dips={1,1.0,0.0}, angle=0.5, clip=true})

zone = function(m, p, a, cov, t) work(m*cloth_r, {pile=p, tool=t or "filbert 20", length={50,100},
        coverage=cov, fill=true, load=1.0, pressure={0.9,0.75}, dips={1,1.0,0.0}, angle=a, clip=true}) end

-- lights: the back-left roll, the left of the group, a crest in front
zone(R({{150,568},{310,592},{400,690}}, 140, 80), p_cl_lite, 0.4, 1.6)
zone(R({{60,650},{180,730},{250,800}}, 120, 70), p_cl_lite, 0.5, 1.5)
zone(R({{520,644},{546,724}}, 60, 34), p_cl_lite, 1.4, 1.4)
zone(R({{700,580},{780,600},{830,650}}, 90, 50), p_cl_lite, 0.7, 1.2)

-- darks: the hollow under the bowl, the right hollow, the back hollow, the corners
zone(R({{520,600},{430,690},{360,780}}, 130, 70), p_cl_dk, -1.0, 1.7)
zone(R({{780,600},{840,700}}, 100, 55), p_cl_dk, 0.95, 1.7)
zone(R({{430,555},{560,530}}, 80, 45), p_cl_dk, -0.15, 1.5)
zone(ellipse(876, 804, 170, 75):soften(45), p_cl_dk, 0.2, 1.7)
zone(ellipse(0, 804, 120, 70):soften(45), p_cl_dk, 0.3, 1.7)
zone(R({{866,570},{880,652}}, 50, 28), p_cl_dk, 1.4, 1.5)
work(cloth_r * ellipse(940, 870, 520, 380):soften(180), {pile=p_cl_fall2, tool="filbert 20",
     length={50,100}, coverage=1.2, fill=true, load=1.0, pressure={0.9,0.75},
     dips={1,1.0,0.0}, angle=0.4, clip=true})
blend(cloth_r:soften(20), {angle=0.5})
print("cloth 7", wait(0))
