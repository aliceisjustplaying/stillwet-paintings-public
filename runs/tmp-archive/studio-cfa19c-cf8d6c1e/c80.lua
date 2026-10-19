local stub = pile{{"lead white",2},{"yellow ochre",1.6},{"green earth",1.4},{"raw umber",0.25},{"pale smalt",0.2}, medium=0.06}
work(M1, {hand="body", tool="filbert 5", pile=stub, angle=function(x,y) return 0.12 + 0.00015*(x-350) end, coverage=2.8, fill=true, pressure={0.45,0.7}, edge="soft", seed=491})
