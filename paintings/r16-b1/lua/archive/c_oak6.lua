foliDark2 = pile{{"raw umber", 2.5}, {"green earth", 1}, {"yellow ochre", 1}, {"Prussian blue", 0.25}, {"bone black", 0.6}, medium=0.1}
stipple(foliM, {pile=foliDark2, width=3, coverage=1.6, cluster={0.5, 5}, pressure={0.4, 0.8}, dips={30, 0.7, 0}})
-- leaves scattered beyond the clump edges
local fringe = foliM:grow(7) - foliM
stipple(fringe, {pile=foliDark2, width=2.2, coverage=0.5, cluster={0.7, 4}, pressure={0.3, 0.7}, feather=0.5, dips={30, 0.6, 0}})
