p_bo5_lit = pile{{"raw umber", 2.6}, {"lead white", 2.2}, {"bone black", 0.5}, {"yellow ochre", 0.5}}
p_bo5_mid = pile{{"raw umber", 3.2}, {"bone black", 1.4}, {"lead white", 0.8}, {"red earth", 0.7}}
cloth_r = cloth:roughen(9, 70, 12)
rim_o  = ellipse(580, 500, 200, 64)
inner  = ellipse(580, 500, 182, 53):roughen(2, 45, 11)
rimb   = rim_o - inner
skirt  = poly({{392,506},{396,532},{408,560},{430,583},{462,600},{504,613},{544,621},
               {580,625},{616,621},{656,613},{698,600},{730,583},{752,560},{764,532},{768,506}}, true)
bowl   = (rim_o + skirt):roughen(3, 55, 7)
wall   = bowl - inner
R = function(pts, w, s) return ribbon(pts, w):soften(s) end
D = ellipse(300, 655, 100, 96):roughen(4, 50, 3)
E = ellipse(470, 712, 82, 80):roughen(4, 50, 41)

-- clean the old shadow smear off the cloth
work(rect(486, 600, 340, 168):soften(30) * cloth_r * -E:grow(10) * -D:grow(10),
     {pile=p_clm4, hand="broad", coverage=2.6, fill=true, load=1.0, pressure={1.0,0.9},
      dips={1,1.0,0.0}, angle=0.4, clip=true})
-- the bowl's form, laid in again
work(wall, {pile=p_bo5_mid, hand="broad", coverage=3.5, fill=true, load=1.0, pressure={1.0,1.0},
     dips={1,1.0,0.0}, angle=0.4, clip=true})
work(wall * ellipse(456, 546, 140, 104):soften(56), {pile=p_bo5_lit, tool="filbert 16",
     length={40,90}, coverage=1.8, fill=true, load=1.0, pressure={0.95,0.8},
     dips={1,1.0,0.0}, angle=0.5, clip=true})
work(wall * ellipse(716, 586, 148, 110):soften(56), {pile=p_bo4_sh, tool="filbert 16",
     length={40,90}, coverage=2.0, fill=true, load=1.0, pressure={0.95,0.8},
     dips={1,1.0,0.0}, angle=0.5, clip=true})
work(bowl * below(function() return 582 end):soften(20), {pile=p_bo4_dk, tool="filbert 16",
     length={30,64}, coverage=1.6, fill=true, load=1.0, pressure={0.9,0.8},
     dips={1,1.0,0.0}, angle=1.2, clip=true})
work(rimb, {pile=p_bo5_mid, tool="filbert 12", length={30,64}, coverage=1.4, fill=true,
     load=1.0, pressure={0.95,0.8}, dips={1,1.0,0.0}, angle=0.3, clip=true})
work(rimb * ellipse(452, 514, 100, 58):soften(32), {pile=p_bo5_lit, tool="filbert 12",
     length={30,64}, coverage=1.6, fill=true, load=1.0, pressure={0.95,0.8},
     dips={1,1.0,0.0}, angle=0.3, clip=true})
blend(bowl:soften(5), {angle=0.4})
-- the bowl's shadow: close, at the foot, and away to the lower right
work(R({{560,634},{680,674},{792,708}}, 78, 34)*cloth_r, {pile=p_shw, tool="filbert 20",
     length={50,100}, coverage=1.7, fill=true, load=1.0, pressure={0.9,0.75},
     dips={1,1.0,0.0}, angle=0.5, clip=true})
work(R({{524,622},{600,638},{660,630}}, 24, 13)*cloth_r, {pile=p_bo4_dk, tool="filbert 12",
     length={30,64}, coverage=2.0, fill=true, load=1.0, pressure={0.95,0.8},
     dips={1,1.0,0.0}, angle=0.2, clip=true})
blend((R({{560,634},{680,674},{792,708}}, 78, 34) + R({{524,622},{600,638},{660,630}}, 24, 13))
      * cloth_r:soften(16), {angle=0.5})
print("bowl 7", wait(0))
