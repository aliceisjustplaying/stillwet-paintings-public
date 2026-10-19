local skyside = above(function(x) return 455 end)
local outer = (trees:grow(14) - trees) * skyside
pDark2 = pile{{"Prussian blue",0.4},{"yellow ochre",1.2},{"raw umber",1.5},{"bone black",0.4}}
stipple(outer, {pile=pDark2, width=4, coverage=function(x,y) return 0.5 end, cluster={0.8, 10}, pressure={0.3,0.6}, dips={10,0.6,0.3}, feather=0.5, drag={3, 1.2}})
