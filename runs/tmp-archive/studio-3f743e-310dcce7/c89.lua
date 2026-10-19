-- Bank, path, boat over the veil
spitdark  = pile{{"raw umber", 1}, {"bone black", 0.5}, {"green earth", 0.35}, {"cobalt blue", 0.2}, {"lead white", 0.25}}
bright = pile{{"lead white", 2.2}, {"chrome yellow", 0.5}, {"vermilion", 0.25}}
flare  = pile{{"lead white", 1.6}, {"chrome yellow", 0.35}, {"vermilion", 0.2}, {"cobalt blue", 0.12}}
hulld = pile{{"bone black", 0.75}, {"raw umber", 0.7}, {"cobalt blue", 0.25}, {"lead white", 0.15}}

spit_edge = function(x) return 1150 + 26 * math.sin(x / 90 + 1) + 14 * math.sin(x / 38 + 2) - 0.28 * x end
bank = below(spit_edge)
work(bank, {hand="body", pile=spitdark, coverage=2.4, fill=true, angle=0.05, pressure={0.75, 0.9}, edge=0.5, clip=true})
work(bank, {hand="scumble", pile=spitdark, coverage=1.2, angle=0.05, edge=0.6})

lowpath = ribbon({{640, 516}, {700, 640}, {660, 830}, {610, 1000}, {560, 1250}}, {30, 60, 110, 180, 230})
work(lowpath, {hand="body", pile=bright, coverage=1.6, fill=true, angle=0.02, pressure={0.6, 0.8}, edge=1})
wide2 = ribbon({{640, 516}, {705, 650}, {665, 850}, {605, 1040}, {565, 1250}}, {70, 130, 220, 300, 360})
work(wide2, {hand="broad", pile=flare, coverage=0.7, fill=false, angle=0.02, pressure={0.5, 0.7}, edge=1})

hull = poly({{352, 898}, {395, 893}, {440, 889}, {478, 883}, {477, 916}, {432, 922}, {390, 924}, {354, 918}}, true)
work(hull, {hand="body", pile=hulld, coverage=2.6, fill=true, angle=0.02, pressure={0.85, 0.95}, edge=0.2, clip=true})
work(hull, {hand="detail", pile=hulld, coverage=1.4, fill=true, angle=0.02, edge=0.2, clip=true})
mb = brush{kind="rigger", width=3.5, point=1, stiffness=0.5}
mb:load(hulld, 0.95)
mast = outline{{421, 892}, {424, 820}, {427, 744}}
mast:paint(mb, {pressure=0.55, every=2})
stipple(rect(360, 934, 110, 76), {pile=hulld, width=4, coverage=0.3, pressure={0.25, 0.5}, drag={9, 0}, feather=1})
print("bank, path, boat re-stated")
