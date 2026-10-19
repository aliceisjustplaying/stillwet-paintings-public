p_clm2  = pile{{"lead white", 4.5}, {"raw umber", 2.0}, {"yellow ochre", 0.9}, {"cobalt blue", 0.3}}
p_cl_sh2= pile{{"raw umber", 5}, {"lead white", 1.2}, {"cobalt blue", 1.3}, {"bone black", 0.6}}
p_cl_dp2= pile{{"bone black", 2}, {"raw umber", 3}, {"Prussian blue", 0.8}, {"lead white", 0.3}}
cloth_r = cloth:roughen(9, 70, 12)

work(cloth_r, {pile=p_clm2, hand="broad", coverage=2.4, fill=true, load=1.0,
     pressure={1.0,1.0}, dips={1,1.0,0.0}, angle=0.5, clip=true})
blend(cloth_r:soften(18), {angle=0.5})

R = function(pts, w, s) return ribbon(pts, w):soften(s) end
L1 = R({{500,608},{330,700},{140,790}}, 62, 30)
L2 = R({{480,640},{392,722},{332,802}}, 44, 24)
L3 = R({{598,640},{620,722},{642,802}}, 52, 26)
L4 = R({{664,638},{744,712},{824,782}}, 56, 28)
L5 = R({{30,580},{300,545},{560,520},{700,516}}, 44, 26)
L6 = R({{18,600},{56,662},{88,732}}, 38, 22)
S1 = R({{432,690},{352,760},{302,812}}, 50, 26)
S2 = R({{662,700},{702,762},{742,816}}, 44, 24)
S3 = R({{832,650},{872,722}}, 44, 24)
S4 = R({{352,600},{302,650}}, 44, 24)
S5 = R({{432,600},{570,630},{720,640}}, 46, 26)
S6 = ellipse(834, 800, 145, 62):soften(34)
S7 = ellipse(36, 800, 115, 60):soften(34)
D1 = R({{452,606},{580,634},{706,642}}, 28, 16)
D2 = R({{420,716},{366,772}}, 30, 16)

lay = function(m, p, a, cov) work(m*cloth_r, {pile=p, hand="body", coverage=cov, fill=true,
      load=1.0, pressure={1.0,1.0}, dips={1,1.0,0.0}, angle=a, length={30,70}, clip=true}) end

lay(L1, p_cl_hi, -0.62, 2.0)  lay(L2, p_cl_hi, -1.02, 1.8)  lay(L3, p_cl_hi,  1.42, 1.8)
lay(L4, p_cl_hi,  0.61, 1.8)  lay(L5, p_cl_hi, -0.08, 1.8)  lay(L6, p_cl_hi,  1.20, 1.6)
lay(S1, p_cl_sh2, -1.05, 2.2) lay(S2, p_cl_sh2,  0.80, 2.0)  lay(S3, p_cl_sh2,  1.30, 2.0)
lay(S4, p_cl_sh2,  0.30, 2.0)  lay(S5, p_cl_sh2,  0.12, 2.0)  lay(S6, p_cl_sh2,  0.20, 2.2)
lay(S7, p_cl_sh2,  0.30, 2.2)  lay(D1, p_cl_dp2,  0.12, 2.0) lay(D2, p_cl_dp2, -1.05, 2.0)
blend(cloth_r:soften(18), {angle=0.5})
print("folds 2", wait(0))
