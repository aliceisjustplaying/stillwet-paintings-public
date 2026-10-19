p_dkc = pile{{"raw umber", 3}, {"bone black", 3.6}, {"Prussian blue", 1.2}, {"cobalt blue", 0.4}}
p_tblB= pile{{"raw umber", 5}, {"red earth", 1.6}, {"yellow ochre", 0.8}, {"bone black", 1.2}}
p_tblL= pile{{"raw umber", 4}, {"red earth", 1.8}, {"yellow ochre", 1.3}, {"bone black", 0.4}}

work(rect(620, 0, 380, 500):soften(180), {pile=p_dkc, hand="broad", coverage=3.0, fill=true,
     load=1.0, pressure={1.0,0.85}, dips={3,1.0,0.05}})

tbl = below(function(x) return 468 - 0.04*x end):soften(7)
work(tbl, {pile=p_tblB, hand="broad", coverage=3.0, fill=true, load=1.0,
           pressure={1.0,0.85}, dips={3,1.0,0.05}, angle=0.25})
work(below(function(x) return 468 - 0.04*x end) * ellipse(300, 640, 520, 300):soften(170),
     {pile=p_tblL, hand="broad", coverage=2.6, fill=true, load=1.0,
      pressure={1.0,0.85}, dips={3,1.0,0.05}, angle=0.25})
print("table", wait(0))
