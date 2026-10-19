p_w4   = pile{{"bone black", 3}, {"raw umber", 2.2}, {"Prussian blue", 0.7}, {"cobalt blue", 0.35}, {"red earth", 0.4}}
p_w4_l = pile{{"raw umber", 2.6}, {"bone black", 1.4}, {"yellow ochre", 0.7}, {"lead white", 0.5}, {"red earth", 0.5}}
p_tb4  = pile{{"raw umber", 3.5}, {"bone black", 1.8}, {"red earth", 1}, {"Prussian blue", 0.3}}
tline = function(x) return 468 - 0.04*x end
wr = rect(0, 0, 1000, 476):soften(24)
tbl = below(tline):soften(8)

work(wr, {pile=p_w4, hand="broad", coverage=2.8, fill=true, load=1.0, pressure={1.0,1.0},
          dips={1,1.0,0.0}, angle=0.9, clip=true})
work(tbl, {pile=p_tb4, hand="broad", coverage=2.8, fill=true, load=1.0, pressure={1.0,1.0},
          dips={1,1.0,0.0}, angle=0.25, clip=true})
pool1 = ellipse(400, 300, 520, 380):soften(190)
pool2 = ellipse(390, 330, 350, 250):soften(140)
pool3 = ellipse(350, 350, 210, 145):soften(100)
work(pool1 * wr, {pile=p_w4_l, hand="broad", coverage=2.4, fill=true, load=1.0,
     pressure={1.0,0.9}, dips={1,1.0,0.0}, angle=0.6, clip=true})
work(pool2 * wr, {pile=p_w4_l, hand="broad", coverage=1.8, fill=true, load=1.0,
     pressure={1.0,0.9}, dips={1,1.0,0.0}, angle=0.6, clip=true})
work(pool3 * wr, {pile=p_w4_l, hand="broad", coverage=1.4, fill=true, load=1.0,
     pressure={1.0,0.9}, dips={1,1.0,0.0}, angle=0.6, clip=true})
work(tbl * ellipse(230, 580, 430, 210):soften(150), {pile=p_w4_l, hand="broad", coverage=1.5,
     fill=true, load=1.0, pressure={1.0,0.9}, dips={1,1.0,0.0}, angle=0.25, clip=true})
blend(wr:soften(24), {angle=0.5})
print("background", wait(0))
