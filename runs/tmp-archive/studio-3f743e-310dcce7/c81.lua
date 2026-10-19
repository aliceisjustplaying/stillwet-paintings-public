-- Feather cream edge; mast knot off; left sliver; sparkles
skyfixp = pile{{"lead white", 2.6}, {"chrome yellow", 0.5}, {"vermilion", 0.22}, {"raw umber", 0.1}}
watermid3 = pile{{"lead white", 1.0}, {"cobalt blue", 0.95}, {"raw umber", 0.45}, {"bone black", 0.35}, {"green earth", 0.28}, {"vermilion", 0.08}}
deep3 = pile{{"lead white", 0.6}, {"cobalt blue", 1.0}, {"raw umber", 0.7}, {"bone black", 0.6}, {"green earth", 0.4}, {"vermilion", 0.08}}
hulld = pile{{"bone black", 0.75}, {"raw umber", 0.7}, {"cobalt blue", 0.25}, {"lead white", 0.15}}
bright = pile{{"lead white", 2.2}, {"chrome yellow", 0.5}, {"vermilion", 0.25}}

-- feather the cream cloud bank's right edge into the gold sky
fe = rect(868, 235, 90, 200):soften(30)
work(fe, {hand="scumble", pile=skyfixp, coverage=0.8, angle=0.02, edge=1})
work(rect(880, 250, 70, 170), {hand="scumble", pile=skyfixp, coverage=1.2, angle=0.02, edge=1})
blend(fe, {coverage=0.8})

-- mast knot off
knot = ellipse(424, 808, 10, 18)
work(knot, {hand="detail", pile=watermid3, coverage=2.2, fill=true, edge=0.3, clip=true})
mb = brush{kind="rigger", width=3.5, point=1, stiffness=0.5}
mb:load(hulld, 0.95)
mast = outline{{421, 892}, {424, 820}, {427, 744}}
mast:paint(mb, {pressure=0.55, every=2})

-- left sliver
work(rect(0, 516, 22, 630), {hand="body", pile=deep3, coverage=2.2, fill=true, angle=0.02, pressure={0.7, 0.9}, edge=1})
blend(rect(0, 516, 40, 630), {coverage=0.7})

-- sparkles down the path core
sparkz = ribbon({{640, 516}, {700, 640}, {660, 830}, {610, 1000}, {560, 1250}}, {26, 44, 70, 100, 130})
stipple(sparkz, {pile=bright, width=3.5, coverage=0.35, pressure={0.3, 0.6}, drag={7, 0}, feather=1})
print("final touches")
