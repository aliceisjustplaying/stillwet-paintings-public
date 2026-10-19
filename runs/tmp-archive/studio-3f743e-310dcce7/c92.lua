-- Last small things
watermid3 = pile{{"lead white", 1.0}, {"cobalt blue", 0.95}, {"raw umber", 0.45}, {"bone black", 0.35}, {"green earth", 0.28}, {"vermilion", 0.08}}
hulld = pile{{"bone black", 0.75}, {"raw umber", 0.7}, {"cobalt blue", 0.25}, {"lead white", 0.15}}
warmpale2 = pile{{"lead white", 2.4}, {"vermilion", 0.12}, {"chrome yellow", 0.1}}

knotz = ellipse(424, 806, 8, 15)
work(knotz, {hand="detail", pile=watermid3, coverage=2.4, fill=true, edge=0.3, clip=true})
mb = brush{kind="rigger", width=3, point=1, stiffness=0.5}
mb:load(hulld, 0.95)
mast = outline{{421, 890}, {424, 822}, {427, 746}}
mast:paint(mb, {pressure=0.5, every=2})

hull = poly({{352, 898}, {395, 893}, {440, 889}, {478, 883}, {477, 916}, {432, 922}, {390, 924}, {354, 918}}, true)
sheer = hull * mask(function(x, y) return y < 906 and 1 or 0 end)
stipple(sheer, {pile=warmpale2, width=2.2, coverage=0.25, pressure={0.2, 0.4}, drag={6, 0}, feather=1})

blend(rect(270, 175, 260, 60), {coverage=1.0})
print("last touches")
