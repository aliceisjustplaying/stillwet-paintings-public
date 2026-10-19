avoidMid = riverM:grow(0.5) + willowSil:grow(1) + oakM:grow(1) + oakSil:grow(2) + trunkM:grow(1) + riseM
hayP = pile{{"yellow ochre",3},{"lead white",2},{"green earth",0.6},{"chrome yellow",0.15}, medium=0.06}
freshP = pile{{"yellow ochre",2.5},{"Prussian blue",0.3},{"lead white",1.4},{"green earth",0.8}, medium=0.06}
farStripP = pile{{"lead white",3},{"yellow ochre",1.5},{"green earth",1.5},{"pale smalt",0.4}, medium=0.06}
M1 = poly({{350,474},{460,480},{560,490},{660,508},{760,528},{880,552},{1010,578},{1010,612},{880,586},{760,560},{660,538},{560,516},{460,500},{350,490}}, true) - avoidMid
F2 = poly({{430,453},{520,459},{600,465},{700,476},{800,488},{900,498},{1010,508},{1010,520},{900,509},{800,499},{700,486},{600,472},{520,464},{430,457}}, true) - avoidMid
work(F2, {hand="body", tool="filbert 3", pile=farStripP, angle=function(x,y) return 0.1 + 0.0001*(x-430) end, coverage=2.5, fill=true, pressure={0.4,0.6}, edge="soft", seed=361})
work(M1, {hand="body", tool="filbert 5", pile=hayP, angle=function(x,y) return 0.1 + 0.00015*(x-350) end, coverage=2.5, fill=true, pressure={0.4,0.65}, edge="soft", seed=362})
