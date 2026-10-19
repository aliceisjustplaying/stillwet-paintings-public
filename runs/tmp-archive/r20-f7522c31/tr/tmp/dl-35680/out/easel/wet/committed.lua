-- easel session "wet": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.

--@ chunk 1
canvas{size=300, aspect=4, seed=5, linen=15, ground={{pile={{"lead white", 5}, {"yellow ochre", 1}}, um=80, apply="knife"}}}

--@ chunk 2
work(rect(0, 0, 1000, 250), {hand="broad", pile=pile{{"lead white", 2}, {"bone black", 1}, {"cobalt blue", 1}, medium=0.4}, coverage=4})

--@ chunk 3
print(drying(500, 125))
