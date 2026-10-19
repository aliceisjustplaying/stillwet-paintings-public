-- fold lights
L1 = ribbon({{20,586},{180,556},{360,532},{520,518},{650,512}}, 46):soften(26)
L2 = ribbon({{350,596},{250,650},{150,712},{60,782}}, 64):soften(30)
L3 = ribbon({{300,580},{210,606},{120,640},{30,690}}, 40):soften(24)
L4 = ribbon({{520,650},{490,712},{455,790}}, 58):soften(28)
L5 = ribbon({{740,545},{800,590},{848,650}}, 52):soften(26)
L6 = ribbon({{862,600},{878,650},{862,700}}, 34):soften(20)
-- fold shadows
S1 = ribbon({{420,548},{560,528},{690,522}}, 44):soften(24)
S2 = ribbon({{330,600},{360,650},{400,700}}, 46):soften(24)
S3 = ribbon({{600,676},{640,730},{672,792}}, 44):soften(24)
S4 = ribbon({{700,610},{760,660},{800,712}}, 50):soften(26)
S5 = ellipse(806, 792, 150, 70):soften(40)
S6 = ellipse(52, 792, 130, 78):soften(46)
-- deepest, under the bowl
D1 = ribbon({{400,596},{520,620},{650,634},{762,626}}, 40):soften(22)
D2 = ribbon({{402,700},{344,752},{302,796}}, 36):soften(20)

lay = function(m, p, a) work(m*cloth, {pile=p, hand="body", coverage=2.2, fill=true,
      load=1.0, pressure={1.0,1.0}, dips={1,1.0,0.0}, angle=a, length={30,70}}) end

lay(L1, p_cl_hi, -0.12)  lay(L3, p_cl_hi, -0.40)  lay(L2, p_cl_hi, -0.60)
lay(L4, p_cl_hi, -1.14)  lay(L5, p_cl_hi,  0.77)  lay(L6, p_cl_hi,  1.57)
lay(S1, p_cl_sh, -0.16)  lay(S2, p_cl_sh,  1.10)  lay(S3, p_cl_sh,  1.16)
lay(S4, p_cl_sh,  0.87)  lay(S5, p_cl_sh,  0.10)  lay(S6, p_cl_sh,  0.30)
lay(D1, p_cl_dp,  0.10)  lay(D2, p_cl_dp,  1.24)
blend(cloth:soften(18), {angle=0.5})
print("folds", wait(0))
