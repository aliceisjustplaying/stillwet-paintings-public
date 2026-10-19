-- easel session "audit": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.

--@ chunk 1
t = {}; for i = 1, 40 do t['k' .. i*7919] = i end; function order(t) local o={} for k,v in pairs(t) do o[#o+1]=v end return table.concat(o, ',') end; before=order(t); print(before)

--@ chunk 2
print(order(t)); print(before == order(t))
