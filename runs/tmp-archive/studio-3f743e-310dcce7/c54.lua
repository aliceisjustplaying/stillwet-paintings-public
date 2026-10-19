-- Finishing lights (on tacky/dry ground: they grab and stay broken)
bright = pile{{"lead white", 2.2}, {"chrome yellow", 0.5}, {"vermilion", 0.25}}
warmpale2 = pile{{"lead white", 2.4}, {"vermilion", 0.12}, {"chrome yellow", 0.1}}
flarep = pile{{"lead white", 2.6}, {"chrome yellow", 0.6}, {"vermilion", 0.25}}

pathzone = ribbon({{640, 516}, {700, 640}, {660, 830}, {610, 1000}, {575, 1160}, {560, 1250}}, {50, 90, 150, 210, 260, 290})
stipple(pathzone, {pile=bright, width=3.5, coverage=0.3, pressure={0.25, 0.55}, drag={5, 0}, feather=1})

tltop = function(x) return 452 + 24 * math.sin(x / 23 + 1) + 16 * math.sin(x / 61) + 9 * math.sin(x / 13 + 2) end
tlrim = below(tltop) * above(function(x) return tltop(x) - 20 end) * mask(function(x) return x > 540 and 1 or 0 end)
stipple(tlrim, {pile=warmpale2, width=2.5, coverage=0.22, pressure={0.15, 0.4}, feather=1})

work(rect(570, 430, 260, 80), {hand="scumble", pile=flarep, coverage=0.55, angle=0.02, edge=1})

tips = ribbon({{672, 950}, {738, 962}, {806, 955}}, 26)
stipple(tips, {pile=warmpale2, width=2.5, coverage=0.12, pressure={0.15, 0.35}, feather=1})
print("lights in")
