p_cl_hi2 = pile{{"lead white", 10}, {"yellow ochre", 0.8}, {"chrome yellow", 0.2}}
cloth_r = cloth:roughen(9, 70, 12)
R = function(pts, w, s) return ribbon(pts, w):soften(s) end

S1 = R({{470,600},{400,690},{330,790}}, 66, 34)
S2 = R({{640,650},{690,730},{716,800}}, 52, 28)
S3 = R({{760,610},{830,680},{872,740}}, 54, 28)
S4 = R({{400,560},{520,535}}, 46, 26)
S5 = R({{120,600},{70,680}}, 40, 24)
S6 = ellipse(16, 800, 110, 60):soften(30)
S7 = ellipse(852, 800, 130, 55):soften(30)
D1 = R({{440,606},{580,634},{716,642}}, 34, 18)
D2 = R({{420,660},{370,740}}, 30, 16)
D3 = R({{800,650},{840,700}}, 26, 14)
C1 = R({{30,578},{300,543},{560,518},{700,514}}, 26, 16)
C2 = R({{360,650},{250,716},{140,786}}, 34, 20)
C3 = R({{540,660},{542,730}}, 28, 18)
C4 = R({{700,640},{780,700}}, 30, 18)
C5 = R({{24,610},{50,670},{70,720}}, 22, 14)
C6 = R({{856,600},{868,652}}, 22, 14)
C7 = R({{300,782},{450,802}}, 24, 16)

lay = function(m, p, a, cov) work(m*cloth_r, {pile=p, hand="body", coverage=cov, fill=true,
      load=1.0, pressure={1.0,1.0}, dips={1,1.0,0.0}, angle=a, length={28,64}, clip=true}) end

lay(S1, p_cl_sh2, -1.05, 2.2) lay(S2, p_cl_sh2,  1.05, 2.2)  lay(S3, p_cl_sh2,  0.90, 2.2)
lay(S4, p_cl_sh2, -0.10, 2.0) lay(S5, p_cl_sh2,  1.25, 2.0)  lay(S6, p_cl_sh2,  0.20, 2.2)
lay(S7, p_cl_sh2,  0.20, 2.2)  lay(D1, p_cl_dp2,  0.10, 2.0) lay(D2, p_cl_dp2, -1.10, 2.0)
lay(D3, p_cl_dp2,  0.90, 2.0)
work(cloth_r * ellipse(920, 860, 480, 340):soften(160), {pile=p_cl_fall, hand="broad",
     coverage=1.8, fill=true, load=1.0, pressure={1.0,1.0}, dips={1,1.0,0.0}, angle=0.5, clip=true})
lay(C1, p_cl_hi2, -0.08, 1.6) lay(C2, p_cl_hi2, -0.85, 1.6) lay(C3, p_cl_hi2,  1.50, 1.4)
lay(C4, p_cl_hi2,  0.72, 1.4) lay(C5, p_cl_hi2,  1.15, 1.4) lay(C6, p_cl_hi2,  1.50, 1.4)
lay(C7, p_cl_hi2,  0.20, 1.4)
print("folds 3", wait(0))
