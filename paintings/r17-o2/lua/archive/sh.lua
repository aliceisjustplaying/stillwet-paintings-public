local shA = poly({{140,590},{190,586},{250,596},{330,596},{372,584},{392,588},{368,606},{300,613},{220,612},{150,604}}, true):roughen(3,25,640,0):soften(4) - hull2:shrink(3)
local g = pile{{"raw umber",2},{"red earth",0.35},{"yellow ochre",0.1}, medium=0.75}
work(shA, {hand="glaze", tool={kind="filbert", width=10, stiffness=0.3}, pile=g, angle=0.02, coverage=1.4, pressure={0.2,0.35}, edge="lost"})
