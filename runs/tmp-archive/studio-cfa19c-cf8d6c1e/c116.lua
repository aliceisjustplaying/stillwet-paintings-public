local keep = oakSil:shrink(2.5)
skyB = pile{{"lead white",4},{"cobalt blue",1.2},{"smalt",1.0},{"pale smalt",0.6},{"raw umber",0.05}, medium=0.1}
work(ellipse(245,108,16,7) - keep, {hand="body", pile=skyB, tool={kind="filbert", width=4}, angle=0.05, coverage=2.5, fill=true, edge="soft", pressure={0.45,0.7}, seed=1181})
