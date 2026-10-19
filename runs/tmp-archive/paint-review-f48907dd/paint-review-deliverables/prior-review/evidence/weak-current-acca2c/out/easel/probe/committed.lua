-- easel session "probe": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ engine 2

--@ chunk 1
mt = {}; w = setmetatable({}, mt); w[1] = {tag="survives"}

--@ chunk 2
mt.__mode = "v"; for i = 1, 100000 do local q = {} end; print(w[1] ~= nil); mt.__mode = nil
