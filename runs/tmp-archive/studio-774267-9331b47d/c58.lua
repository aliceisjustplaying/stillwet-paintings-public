local g1 = WATER:grow(2.2) * rect(500, 0, 26, 700)
local g2 = WATER:grow(2.2) * rect(757, 0, 19, 700)
local p1 = pile{{"green earth", 1.9}, {"yellow ochre", 1.3}, {"chrome yellow", 0.16}, {"lead white", 1.0}, {"Prussian blue", 0.02}, medium=0.15}
local p2 = pile{{"green earth", 1.7}, {"yellow ochre", 1.25}, {"chrome yellow", 0.13}, {"lead white", 1.0}, {"pale smalt", 0.12}, medium=0.15}
work(g1, {hand="detail", tool={kind="round", width=2, point=0.3}, pile=p1, angle=0, coverage=3.5, fill=true, seed=5801})
work(g2, {hand="detail", tool={kind="round", width=2, point=0.3}, pile=p2, angle=0, coverage=3.5, fill=true, seed=5802})
