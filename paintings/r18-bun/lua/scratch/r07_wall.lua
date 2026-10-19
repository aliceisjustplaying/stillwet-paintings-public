p_wB = pile{{"raw umber", 4}, {"bone black", 3}, {"red earth", 1.2}, {"Prussian blue", 0.5}}
p_wL = pile{{"raw umber", 4}, {"bone black", 2}, {"red earth", 1.6}, {"yellow ochre", 0.9}}
p_wLL= pile{{"raw umber", 3.5}, {"bone black", 1.4}, {"red earth", 1.8}, {"yellow ochre", 1.6}, {"lead white", 0.6}}

wr = rect(0, 0, 1000, 500)
pool1 = ellipse(430, 290, 540, 400):soften(200)
pool2 = ellipse(400, 320, 380, 270):soften(150)
pool3 = ellipse(355, 335, 235, 160):soften(105)

work(wr, {pile=p_wB, hand="broad", coverage=3.5, fill=true, load=1.0, pressure={1.0,0.85}, dips={3,1.0,0.05}})
work(pool1, {pile=p_wL, hand="broad", coverage=3.0, fill=true, load=1.0, pressure={1.0,0.85}, dips={3,1.0,0.05}})
work(pool2, {pile=p_wL, hand="broad", coverage=2.4, fill=true, load=1.0, pressure={1.0,0.85}, dips={3,1.0,0.05}})
work(pool3, {pile=p_wLL, hand="broad", coverage=1.8, fill=true, load=1.0, pressure={1.0,0.85}, dips={3,1.0,0.05}})
blend(wr:soften(50), {angle=0.4})
print("wall solid", wait(0))
