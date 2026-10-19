-- Proper hull silhouette, no balloon
hulld = pile{{"bone black", 0.75}, {"raw umber", 0.7}, {"cobalt blue", 0.25}, {"lead white", 0.15}}
warmpale2 = pile{{"lead white", 2.4}, {"vermilion", 0.12}, {"chrome yellow", 0.1}}
watermid3 = pile{{"lead white", 1.0}, {"cobalt blue", 0.95}, {"raw umber", 0.45}, {"bone black", 0.35}, {"green earth", 0.28}, {"vermilion", 0.08}}

-- knock back the old lens and bump with water, then draw the hull poly
oldboat = rect(330, 878, 170, 56)
work(oldboat, {hand="body", pile=watermid3, coverage=2.4, fill=true, angle=0.02, pressure={0.75, 0.9}, edge=1, clip=true})
blend(oldboat, {coverage=0.7})

hullpoly = poly({{352, 898}, {395, 893}, {440, 889}, {478, 883}, {477, 916}, {432, 922}, {390, 924}, {354, 918}}, true)
work(hullpoly, {hand="body", pile=hulld, coverage=2.6, fill=true, angle=0.02, pressure={0.85, 0.95}, edge=0.2, clip=true})
work(hullpoly, {hand="detail", pile=hulld, coverage=1.5, fill=true, angle=0.02, edge=0.2, clip=true})

-- warm sheer line
sheer = below(function(x) return 897 - 0.032 * x end) * above(function(x) return 887 - 0.032 * x end)
       * mask(function(x) return x > 354 and x < 476 and 1 or 0 end)
stipple(sheer, {pile=warmpale2, width=2.2, coverage=0.3, pressure={0.2, 0.4}, drag={6, 0}, feather=1})

-- smaller knot on the mast
mb = brush{kind="rigger", width=3, point=1, stiffness=0.5}
mb:load(hulld, 0.95)
mb:stroke({{424, 800}, {425, 790}}, {pressure=0.6, ramps={0.2, 0.2}})

-- reflection dashes
stipple(rect(360, 934, 110, 76), {pile=hulld, width=4, coverage=0.3, pressure={0.25, 0.5}, drag={9, 0}, feather=1})
print("hull redrawn")
