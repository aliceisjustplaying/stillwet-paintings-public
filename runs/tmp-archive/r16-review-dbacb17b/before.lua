-- easel session "audit": a painting replayed chunk by chunk.
--   easel run paintings/lua/audit.lua
-- Each "--@ chunk" line starts one chunk as it was run at the easel.

--@ chunk 1
canvas{size=100,aspect=4,linen=15,ground={{pile={{"lead white",1}},um=50,apply="knife"}}}
