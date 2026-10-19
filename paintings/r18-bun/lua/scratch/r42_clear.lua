p_rbase = pile{{"red earth", 4}, {"bone black", 3}, {"raw umber", 2.5}, {"vermilion", 0.6}}
p_rlit2 = pile{{"red earth", 3}, {"bone black", 2}, {"raw umber", 2}, {"vermilion", 1.2}, {"yellow ochre", 0.4}}
p_rmid2 = pile{{"red earth", 3}, {"bone black", 1.6}, {"raw umber", 1.8}, {"vermilion", 1.6}, {"yellow ochre", 0.6}}
cloth_r = cloth:roughen(9, 70, 12)
R = function(pts, w, s) return ribbon(pts, w):soften(s) end

-- the value charts left swatches on the cloth in front of the bowl
work(rect(414, 626, 364, 140):soften(24) * cloth_r, {pile=p_clm4, hand="broad", coverage=4.5,
     fill=true, load=1.0, pressure={1.0,1.0}, dips={1,1.0,0.0}, angle=0.4, clip=true})
work(R({{414,660},{560,700},{700,726}}, 80, 40) * cloth_r, {pile=p_cl_dk, tool="filbert 20",
     length={50,100}, coverage=1.6, fill=true, load=1.0, pressure={0.9,0.75},
     dips={1,1.0,0.0}, angle=0.5, clip=true})
-- the bowl's shadow again, over the cleared ground
work(R({{520,626},{650,662},{782,700}}, 92, 40)*cloth_r, {pile=p_bo4_dk, tool="filbert 20",
     length={50,100}, coverage=1.8, fill=true, load=1.0, pressure={0.9,0.75},
     dips={1,1.0,0.0}, angle=0.5, clip=true})
work(R({{536,628},{644,652}}, 44, 22)*cloth_r, {pile=p_stem, tool="filbert 12",
     length={30,64}, coverage=1.8, fill=true, load=1.0, pressure={0.95,0.8},
     dips={1,1.0,0.0}, angle=0.4, clip=true})
-- apple D again, a value darker all round
D = ellipse(300, 655, 100, 96):roughen(4, 50, 3)
work(D, {pile=p_rbase, hand="broad", coverage=4.5, fill=true, load=1.0, pressure={1.0,1.0},
         dips={1,1.0,0.0}, angle=0.3, clip=true})
work(D * ellipse(270, 626, 68, 64):soften(28), {pile=p_rlit2, tool="filbert 16", length={40,90},
     coverage=1.5, fill=true, load=1.0, pressure={0.95,0.8}, dips={1,1.0,0.0}, angle=0.3, clip=true})
work(D * ellipse(300, 660, 76, 72):soften(24), {pile=p_rmid2, tool="filbert 16", length={40,90},
     coverage=1.4, fill=true, load=1.0, pressure={0.95,0.8}, dips={1,1.0,0.0}, angle=0.3, clip=true})
work(D * ellipse(330, 684, 84, 80):soften(22), {pile=p_rtr, tool="filbert 16", length={40,90},
     coverage=1.7, fill=true, load=1.0, pressure={0.95,0.8}, dips={1,1.0,0.0}, angle=0.3, clip=true})
work(D * ellipse(362, 712, 70, 66):soften(16), {pile=p_rsh, tool="filbert 16", length={40,90},
     coverage=1.8, fill=true, load=1.0, pressure={0.95,0.8}, dips={1,1.0,0.0}, angle=0.3, clip=true})
work(D * ellipse(304, 744, 76, 24):soften(12), {pile=p_rrfl, tool="filbert 12", length={30,64},
     coverage=1.4, fill=true, load=1.0, pressure={0.95,0.8}, dips={1,1.0,0.0}, angle=1.5, clip=true})
blend(D:soften(5), {angle=0.3})
work(ellipse(262, 612, 19, 15):soften(7) * D:grow(6), {pile=p_rhi, tool="filbert 5",
     length={10,20}, coverage=1.5, fill=false, load=1.0, pressure={0.8,0.6}, clip=true})
print("apple D 7", wait(0))
