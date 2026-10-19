-- easel session "painting": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.

--@ chunk 1
print("hi")

--@ chunk 2
print(canvas)

--@ chunk 3
canvas{size=400, aspect=1.25, linen=15, ground={{pile={{"lead white", 1}}, um=100, apply="knife"}}}

--@ chunk 4
p = pile{{"bone black", 1}}; b = brush("round", 8); b:load(p, 0.9); b:stroke({{150, 300}, {500, 330}, {850, 300}}, {pressure={0.9, 0.7}})
