local pts = {}
for _, p in ipairs(jugL) do pts[#pts+1] = p end
pts[#pts+1] = {360, 608}
for i = #jugR, 1, -1 do pts[#pts+1] = jugR[i] end
pts[#pts+1] = {360, 176}
jugBody = poly(pts, true)
spout = poly({{300,186},{268,170},{258,172},{285,195},{302,205}}, true)
handle = ribbon({{420,236},{468,234},{505,256},{510,300},{492,355},{474,392}}, {22,22,20,18,16,14})
jug = jugBody + spout + handle
lemon1 = ellipse(610, 592, 72, 46)
lemon2 = poly({{652,560},{672,527},{720,515},{765,527},{782,558},{770,582},{720,590},{668,582}}, true)
lemons = lemon1 + lemon2
table_top = rect(0, 521, 1000, 169)
front = rect(0, 690, 1000, 110)
wall = rect(0, 0, 1000, 521)
print(jug:area(), lemons:area())
