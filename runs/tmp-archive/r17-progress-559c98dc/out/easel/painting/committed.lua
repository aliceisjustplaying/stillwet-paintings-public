-- easel session "painting": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.

--@ chunk 1
canvas{size=300, aspect=1.25, linen=15, ground={{pile={{"lead white",1}},um=80,apply="knife"}}}

--@ chunk 2
b=brush("round",4); b:load(pile{{"raw umber",1}},0.8); b:stroke({{100,100},{200,200}})
