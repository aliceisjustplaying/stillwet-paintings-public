p_deep2 = pile{{"raw umber", 4}, {"bone black", 3.2}, {"red earth", 0.7}, {"yellow ochre", 0.35}, {"cobalt blue", 0.45}}
work(rect(470, 0, 530, 520):soften(340), {pile=p_deep2, hand="broad", coverage=3.0, fill=true,
     load=1.0, pressure={1.0,0.85}, dips={3,1.0,0.05}})
work(rect(520, 400, 480, 400):soften(240), {pile=p_deep2, hand="broad", coverage=3.0, fill=true,
     load=1.0, pressure={1.0,0.85}, dips={3,1.0,0.05}})
blend(rect(0, 0, 1000, 500):soften(60), {angle=0.4})
print("wall right", wait(0))
