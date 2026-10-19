barkD = pile{{"raw umber",2},{"bone black",0.5},{"smalt",0.5},{"lead white",0.35}, medium=0.1}
twigP = pile{{"raw umber",2},{"bone black",0.35},{"smalt",0.6},{"lead white",0.7}, medium=0.15}
local trunkflare = poly({{372,514},{380,505},{385,490},{386,470},{388,440},{423,440},{424,470},{426,490},{432,505},{442,514}}, true)
OAKthick = tree_thick_mask(OAK, 3.5) + trunkflare
work(OAKthick, {hand="detail", pile=barkD, coverage=3, fill=true, angle=math.pi/2})
print(tree_paint_thin(OAK, barkD, 3.5, function(l) return l.ws[1] >= 1.6 end))
print(tree_paint_thin(OAK, twigP, 3.5, function(l) return l.ws[1] < 1.6 end))
