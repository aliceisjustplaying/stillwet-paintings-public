
--@ chunk 1
canvas{size=440, aspect=1.6, linen=15, seed=7, ground={{pile={{"lead white", 3}, {"yellow ochre", 1}}, um=120, apply="knife"}}}
items = {}
for i = 1, 32 do items[{index = i}] = i end
fs = {}
for i = 1, 8 do fs[function() return i end] = i end
--@ chunk 2
local first = next(items)
local o = {}
for k, v in pairs(items) do o[#o + 1] = v end
for k, v in pairs(fs) do o[#o + 1] = v end
print("first", first.index, table.concat(o, ","))
work(rect(0, 0, 10 * first.index, 1000), {hand="broad", pile=pile{{"bone black", 1}}})
