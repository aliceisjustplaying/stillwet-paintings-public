-- easel session "painting": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box sargent

--@ chunk 1
canvas{size=300, aspect=1.25, seed=3, linen=15, ground={{pile={{"lead white", 4}, {"cadmium red", 1}}, um=80, apply="knife"}}}

--@ chunk 2
b = brush("round", 4); b:load(pile{{"emerald green", 1}}, 0.8); b:stroke({{200, 300}, {800, 320}})
