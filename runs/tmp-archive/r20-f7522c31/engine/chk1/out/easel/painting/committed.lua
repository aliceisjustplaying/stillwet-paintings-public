-- easel session "painting": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box sargent

--@ chunk 1
canvas{size=300, aspect=1.25, linen=15, ground={{pile={{"lead white", 5}, {"Mars red", 1}}, um=80, apply="knife"}}}

--@ chunk 2
b = brush("filbert", 6); b:load(pile{{"rose madder", 1}, {"cerulean blue", 1}, {"zinc white", 2}, medium=0.2}, 0.9); for i = 1, 12 do b:stroke({{100 + i * 60, 700}, {140 + i * 60, 300}}) end; wait(60)

--@ chunk 3
work(rect(100, 100, 800, 150), {hand="glaze", pile=pile{{"viridian", 1}, {"Indian yellow", 1}, medium=0.7}})
