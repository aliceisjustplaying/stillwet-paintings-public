-- easel session "scratch": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box hopper
--@ engine 5

--@ chunk 1
canvas{aspect=1.6, ground={{apply="knife", pile={{"lead white", 10}, {"yellow ochre", 0.25}}, texture=0.3, um=90}}, linen={18, 16}, seed=4127, size=900}

--@ chunk 2
local recs = {
 {"turps", pile{{"red earth",1},{"bone black",3},{"burnt sienna",0.6},{"ultramarine blue",0.6}, turps=0.3}},
 {"m0", pile{{"red earth",1},{"bone black",3},{"burnt sienna",0.6},{"ultramarine blue",0.6}}},
 {"m15", pile{{"red earth",1},{"bone black",3},{"burnt sienna",0.6},{"ultramarine blue",0.6}, medium=0.15}},
 {"m30", pile{{"red earth",1},{"bone black",3},{"burnt sienna",0.6},{"ultramarine blue",0.6}, medium=0.3}},
 {"sky m15", pile{{"ultramarine blue",2},{"viridian",1.2},{"bone black",2},{"lead white",0.7}, medium=0.15}},
 {"black m15", pile{{"bone black",3},{"ultramarine blue",1}, medium=0.15}},
}
for i, r in ipairs(recs) do
  work(rect(30 + (i-1)*160, 50, 130, 500), {hand="body", pile=r[2], coverage=2.5, fill=true, clip=true})
end
wait(10*24*60)
