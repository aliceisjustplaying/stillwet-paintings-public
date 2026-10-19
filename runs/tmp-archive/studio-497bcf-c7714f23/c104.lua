eM = pile{{"green earth", 2.5}, {"raw umber", 1.0}, {"Prussian blue", 0.25}, {"yellow ochre", 0.8}, {"lead white", 0.5}, medium=0.1}
local o = outline{{1004,716},{842,716,"c"},{846,690},{853,662},{849,636},{858,610},{866,584},{880,560},{897,548},{912,530},{922,508},{936,494},{952,496},{963,482},{980,474},{996,468},{1004,470,"c"}, char="soft", seed=151, lobe=9, amount=1.3, closed=true}
elder2 = (o:mask() + elder) * rect(0, 0, 1000, 714)
stipple(elder2, {pile=eD, width=3.0, coverage=3.2, pressure={0.45,0.75}, clip=elder2, cluster=0.25})
-- mid-green sprays over the upper left (the light comes from the left), dragged outward-downward like pinnate leaves
local lit = elder2 * mask(function(x,y) return ((x - 960) * -0.7 + (y - 600) * -0.5) > -20 and 1 or 0 end)
stipple(lit, {pile=eM, width=2.4, coverage=1.6, pressure={0.4,0.7}, clip=elder2, cluster={0.6, 9}, drag={3, 0.5}, twist=0.6, feather=0.4})
print(wait(0))
