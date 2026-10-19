p_cl_base = pile{{"lead white", 5}, {"raw umber", 3}, {"yellow ochre", 1}, {"red earth", 0.5}}
p_cl_lite = pile{{"lead white", 8}, {"raw umber", 1.2}, {"yellow ochre", 0.8}}
p_cl_wd   = pile{{"lead white", 1.2}, {"raw umber", 4}, {"bone black", 1.2}, {"red earth", 0.8}}
p_cl_fall = pile{{"raw umber", 2.5}, {"bone black", 1.2}, {"Prussian blue", 0.5}, {"lead white", 0.6}}
cloth_r = cloth:roughen(9, 70, 12)
R = function(pts, w, s) return ribbon(pts, w):soften(s) end

work(cloth_r, {pile=p_cl_base, hand="broad", coverage=2.4, fill=true, load=1.0,
     pressure={1.0,1.0}, dips={1,1.0,0.0}, angle=0.5, clip=true})

Lt1 = R({{180,570},{330,600},{420,700}}, 150, 80)
Lt2 = R({{150,720},{270,782}}, 120, 70)
Lt3 = R({{530,650},{548,730}}, 64, 36)
zone = function(m, p, a) work(m*cloth_r, {pile=p, tool="filbert 20", length={50,100},
        coverage=1.5, fill=true, load=1.0, pressure={0.9,0.75}, dips={1,1.0,0.0}, angle=a, clip=true}) end
zone(Lt1, p_cl_lite, 0.4) zone(Lt2, p_cl_lite, 0.5) zone(Lt3, p_cl_lite, 1.4)

Sh1 = R({{520,600},{430,690},{360,780}}, 130, 70)
Sh2 = R({{780,600},{840,700}}, 100, 55)
Sh3 = R({{430,555},{560,530}}, 80, 45)
Sh4 = ellipse(872, 802, 170, 75):soften(45)
Sh5 = ellipse(0, 802, 120, 70):soften(45)
Sh6 = R({{866,570},{880,652}}, 50, 28)
zone(Sh1, p_cl_wd, -1.0) zone(Sh2, p_cl_wd, 0.95) zone(Sh3, p_cl_wd, -0.15)
zone(Sh4, p_cl_wd, 0.2) zone(Sh5, p_cl_wd, 0.3) zone(Sh6, p_cl_wd, 1.4)
work(cloth_r * ellipse(940, 870, 520, 380):soften(180), {pile=p_cl_fall, tool="filbert 20",
     length={50,100}, coverage=1.3, fill=true, load=1.0, pressure={0.9,0.75},
     dips={1,1.0,0.0}, angle=0.4, clip=true})
blend(cloth_r:soften(20), {angle=0.5})
print("cloth 6", wait(0))
