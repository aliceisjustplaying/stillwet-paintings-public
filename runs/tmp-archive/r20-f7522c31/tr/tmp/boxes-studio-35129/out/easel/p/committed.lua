-- easel session "p": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box sargent

--@ chunk 1
canvas{size=300, aspect=4, seed=5, linen=15, ground={{pile={{"lead white", 5}, {"yellow ochre", 1}}, um=80, apply="knife"}}}

--@ chunk 2
b = brush("round", 4); b:load(pile{{"rose madder", 1}, {"ultramarine blue", 1}, {"zinc white", 2}}, 0.9); for i = 1, 6 do b:stroke({{100 + i * 110, 200}, {150 + i * 110, 60}}) end
