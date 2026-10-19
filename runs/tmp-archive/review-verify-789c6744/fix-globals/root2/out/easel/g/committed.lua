-- easel session "g": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ engine 2

--@ chunk 1
canvas{size=440, aspect=1.5, linen=15, seed=2, ground={{pile={{"lead white", 3}, {"red earth", 1}}, um=110, apply="knife"}}}

--@ chunk 2
local dm = nil
dm = 3
OSKY = 1; OB = {2, 3}; OTOP = OB[2]
for i = 1, 3 do
  FY = i
end
p = pile{{"lead white", 1}}
b = brush("round", 4)
function tree(x) return x end
