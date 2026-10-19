cloth_r = cloth:roughen(9, 70, 12)
R = function(pts, w, s) return ribbon(pts, w):soften(s) end
zone = function(m, p, a, cov) work(m*cloth_r, {pile=p, tool="filbert 20", length={50,100},
        coverage=cov, fill=true, load=1.0, pressure={0.9,0.75}, dips={1,1.0,0.0}, angle=a, clip=true}) end

work(cloth_r, {pile=p_clm4, hand="broad", coverage=1.3, fill=true, load=1.0, pressure={1.0,0.9},
     dips={1,1.0,0.0}, angle=0.5, clip=true})
-- put the fold structure back on top of the darker cloth
zone(R({{150,568},{310,592},{400,690}}, 140, 80), p_cl_lite, 0.4, 1.3)
zone(R({{60,650},{180,730},{250,800}}, 120, 70), p_cl_lite, 0.5, 1.2)
zone(R({{520,644},{546,724}}, 60, 34), p_cl_lite, 1.4, 1.1)
zone(R({{700,580},{780,600},{830,650}}, 90, 50), p_cl_lite, 0.7, 1.0)
zone(R({{520,600},{430,690},{360,780}}, 130, 70), p_cl_dk, -1.0, 1.4)
zone(R({{780,600},{840,700}}, 100, 55), p_cl_dk, 0.95, 1.4)
zone(R({{430,555},{560,530}}, 80, 45), p_cl_dk, -0.15, 1.3)
zone(ellipse(876, 804, 170, 75):soften(45), p_cl_dk, 0.2, 1.4)
zone(ellipse(0, 804, 120, 70):soften(45), p_cl_dk, 0.3, 1.4)
work(cloth_r * ellipse(940, 870, 520, 380):soften(180), {pile=p_cl_fall2, tool="filbert 20",
     length={50,100}, coverage=1.2, fill=true, load=1.0, pressure={0.9,0.75},
     dips={1,1.0,0.0}, angle=0.4, clip=true})
print("cloth down", wait(0))
