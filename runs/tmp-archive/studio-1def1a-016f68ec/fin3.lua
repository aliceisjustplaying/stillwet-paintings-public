work(ellipse(795,425,6,6) + ellipse(872,421,6,6), {hand="detail", pile=treeD, coverage=3, fill=true, clip=true})
cornerGlaze = pile{{"raw umber",1},{"smalt",1},{"Prussian blue",0.08},{"red earth",0.15}, medium=0.72}
local corner = mask(function(x,y) return clamp(((y-600)/60) + ((x-600)/400) - 0.3, 0, 1) end) - spit3:grow(3)
work(corner, {hand="glaze", pile=cornerGlaze, angle=0, coverage=1.0})
