skyHoleHi = pile{{"lead white", 8}, {"pale smalt", 0.6}, {"chrome yellow", 0.15}, medium=0.05}
skyHoleLo = pile{{"lead white", 8}, {"chrome yellow", 0.7}, {"yellow ochre", 0.15}, medium=0.05}
local inner = foliM:shrink(5) - oakM2:grow(2)
stipple(inner * rect(0, 0, 1000, 310), {pile=skyHoleHi, width=2.6, coverage=0.18, cluster={0.9, 4}, pressure={0.3, 0.7}, dips={12, 0.6, 0}})
stipple(inner * rect(0, 310, 1000, 200), {pile=skyHoleLo, width=2.6, coverage=0.18, cluster={0.9, 4}, pressure={0.3, 0.7}, dips={12, 0.6, 0}})
