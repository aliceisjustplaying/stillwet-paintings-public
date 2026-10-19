--@ chunk 1
canvas{size=100, aspect=1, linen=16, ground={{pile={{"lead white", 1}}, um=50, apply="knife"}}}
--@ chunk 2
p = pile{{"smalt", 1}}
b = brush("round", 4)
b:load(p, 0.8)
local s = b.stroke
s(b, {{100, 100}, {400, 400}})
b["touch"](b, 300, 200)
