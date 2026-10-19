local keep = oakSil:shrink(2.5)
skyA = pile{{"lead white",7},{"pale smalt",1.5},{"cobalt blue",0.55},{"smalt",0.15},{"yellow ochre",0.06}, medium=0.1}
work(ellipse(245,108,16,7) - keep, {hand="body", pile=skyA, tool={kind="filbert", width=4}, angle=0.05, coverage=2.5, fill=true, edge="soft", pressure={0.45,0.7}, seed=1171})
work(ellipse(200,125,10,6) - keep, {hand="body", pile=skyA, tool={kind="filbert", width=4}, angle=0.05, coverage=2.5, fill=true, edge="soft", pressure={0.45,0.7}, seed=1172})
