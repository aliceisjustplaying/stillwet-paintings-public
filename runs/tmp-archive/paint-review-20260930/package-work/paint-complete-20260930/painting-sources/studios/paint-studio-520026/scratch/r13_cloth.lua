p_cl_hi  = pile{{"lead white", 9}, {"yellow ochre", 1.2}, {"chrome yellow", 0.3}}
p_cl_mid = pile{{"lead white", 6}, {"yellow ochre", 1.2}, {"raw umber", 0.9}}
p_cl_sh  = pile{{"lead white", 2}, {"raw umber", 4}, {"cobalt blue", 1.0}, {"red earth", 0.6}}
p_cl_dp  = pile{{"raw umber", 4}, {"lead white", 0.8}, {"cobalt blue", 1.2}, {"bone black", 1.0}}

cloth = poly({{22, 594}, {150, 560}, {300, 536}, {470, 517}, {640, 506}, {742, 517},
              {830, 557}, {882, 621}, {858, 692}, {758, 750}, {600, 792}, {420, 813},
              {200, 823}, {40, 820}, {-20, 800}, {-20, 700}, {-4, 640}}, true)
cloth_area = cloth:area()
work(cloth, {pile=p_cl_mid, hand="broad", coverage=3.2, fill=true, load=1.0,
             pressure={1.0,0.85}, dips={3,1.0,0.05}, angle=0.5})
print("cloth base", cloth_area, wait(0))
