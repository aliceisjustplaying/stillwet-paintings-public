riseCurve = {{-10,578},{80,566},{180,558},{280,564},{380,582},{460,600},{540,622},{620,640},{720,662},{820,690},{900,714},{1010,730}}
landM = below(function(x) return HZ + 1 end)
riseM = below(riseCurve)
u1 = pile{{"raw umber",1},{"yellow ochre",1.2},{"green earth",2}, medium=0.45}
u2 = pile{{"raw umber",2},{"green earth",1.5},{"bone black",0.25},{"yellow ochre",0.5}, medium=0.45}
work(landM - riseM, {hand="broad", pile=u1, angle=0.02, coverage=1.6, fill=true, pressure={0.4,0.6}, seed=51})
work(riseM, {hand="broad", pile=u2, angle=-0.05, coverage=1.6, fill=true, pressure={0.4,0.6}, seed=52})
