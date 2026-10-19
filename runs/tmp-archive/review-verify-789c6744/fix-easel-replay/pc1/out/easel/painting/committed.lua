-- easel session "painting": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.

--@ chunk 1
canvas{size=300, aspect=1.25, seed=3, linen=15, ground={{pile={{"lead white", 4}, {"red earth", 1}}, um=80, apply="knife"}}}

--@ chunk 2
t = {}; for i=1,30 do t["k"..i]=i end; b = brush("round", 4); b:load(pile{{"bone black", 1}}, 0.8); b:stroke({{200, 300}, {800, 320}})

--@ chunk 3
local y, i = {}, 0; for k in pairs(t) do i = i + 1; y[k] = 20 * i end; b:stroke({{100, y.k1}, {900, y.k1}})
