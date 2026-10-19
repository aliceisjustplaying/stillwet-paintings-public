-- easel session "rebuild-boundary": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.

--@ chunk 1
t = {}; for i = 1, 30 do t['k' .. i] = i end

--@ chunk 2
local sum = 0; for i = 1, 150000000 do sum = sum + i end; assert(sum > 0)

--@ chunk 3
local sum = 0; for i = 1, 150000000 do sum = sum + i end; assert(sum > 0)

--@ chunk 4
local sum = 0; for i = 1, 150000000 do sum = sum + i end; assert(sum > 0)
