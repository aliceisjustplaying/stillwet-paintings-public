-- the frozen mere
merePts = {{420,560},{470,551},{540,548},{620,547},{700,549},{780,548},{850,551},{905,557},{918,566},{895,578},{840,588},{760,596},{680,601},{600,601},{530,597},{470,590},{428,580},{410,570}}
merem = poly(merePts, true):roughen(1.5, 8, 21)
iceP = pile{{"lead white",2.2},{"smalt",1},{"pale smalt",1},{"bone black",0.22},{"vermilion",0.03}, medium=0.2}
iceGlow = pile{{"lead white",5},{"yellow ochre",0.45},{"vermilion",0.08},{"pale smalt",0.3}, medium=0.2}
work(merem, {hand="body", tool="filbert 5", pile=iceP, angle=0, angle_jitter=0.03, length={30, 90}, coverage=3, fill=true, clip=true, pressure={0.5, 0.8}, seed=271})
-- the glow of the horizon caught on the far half of the ice, in horizontal strokes
local glow = merem * mask(function(x, y) return (y < 566 + 6*math.sin(x/40)) and 1 or 0 end)
work(glow, {hand="body", tool="filbert 4", pile=iceGlow, angle=0, angle_jitter=0.01, length={40, 120}, coverage=1.3, clip=true, pressure={0.35, 0.6}, seed=272})
blend(merem, {angle=0})
