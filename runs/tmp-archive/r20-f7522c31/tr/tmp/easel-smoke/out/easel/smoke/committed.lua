-- easel session "smoke": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.

--@ chunk 1
canvas{size=300, aspect=5, linen={16, 14}, seed=3, ground={{pile={{"lead white", 2}, {"red earth", 1}}, um=100, apply="knife"}, {pile={{"lead white", 6}, {"raw umber", 1}}, um=50, apply="brush"}}}

--@ chunk 2

a = pile{{"lead white", 6}, {"yellow ochre", 2}, {"vermilion", 0.3}, medium=0.2}
c = pile{{"lead white", 4}, {"cobalt blue", 1}, medium=0.35}
print(a, c)
work(rect(100, 100, 300, 250), {hand="body", pile=c, coverage=3})
b = brush("filbert", 8)
b:load(a, 0.9)
for i = 0, 5 do b:stroke({{520, 120 + 40 * i}, {880, 140 + 40 * i}}, {pressure={0.8, 0.3}}) end
print(wait(24 * 60))
print(drying(300, 200))
