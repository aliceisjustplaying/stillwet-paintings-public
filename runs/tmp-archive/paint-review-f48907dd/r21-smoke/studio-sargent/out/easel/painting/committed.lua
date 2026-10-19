-- easel session "painting": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box sargent
--@ engine 2

--@ chunk 1
canvas{size=200, aspect=1, linen=14, ground={{pile={{"lead white",1}}, um=100, apply="brush"}}}
print(tostring({}), string.dump == nil, pcall(load, "\27Lua"))

--@ chunk 2
print("hello from a chunk")
