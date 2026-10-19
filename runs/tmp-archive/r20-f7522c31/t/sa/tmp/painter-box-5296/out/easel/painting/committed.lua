-- easel session "painting": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box sargent

--@ chunk 1
local t = tubes(); canvas{size=300, aspect=4, seed=5, linen=15, ground={{pile={{"lead white", 5}, {t[#t - 1], 1}}, um=80, apply="knife"}}}
