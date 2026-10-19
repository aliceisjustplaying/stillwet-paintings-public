-- easel session "gate": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.

--@ chunk 1
x = 1

--@ chunk 2
assert(x == 1)
