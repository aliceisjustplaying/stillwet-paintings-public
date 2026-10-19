-- easel session "scratch": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ engine 8
--@ knife-skim
--@ limbs-join-nearest
--@ blend-feather
--@ brush-skim
--@ blend-at-masks
--@ glaze-film
--@ liquid-film-levels
--@ rag-lift
--@ full-palette-refuses
--@ drain

--@ chunk 1
canvas{aspect=0.8, ground={{apply="knife", pile={{"lead white", 10}, {"yellow ochre", 0.4}, {"raw umber", 0.15}}, texture=0.25, um=120}}, linen={18, 15}, seed=4417, size=480}

--@ chunk 2
for i = 1, 16 do local p = pile{{"lead white", 1}, {"raw umber", i*0.1}, name="p" .. i} end
local ok, err = pcall(function() return pile{{"lead white", 1}, {"raw umber", 0.3}, name="p3"} end)
print(ok, err)
print(palette())

--@ chunk 3
local t = palette()
print(type(t))
local mt = getmetatable(t)
print(mt)
if type(t) == "table" then for k, v in pairs(t) do print(k, v) end end

--@ chunk 4
local ok, q = pcall(function() return pile{{"lead white", 1}, {"raw umber", 0.1}, name="p1"} end)
print(ok, ok and tostring(q) or "")
if ok then palette{scrape={q}} end
print(palette())

--@ chunk 5
local names = {}
for k, v in pairs(_G) do if type(v) == "function" or type(v) == "table" then names[#names+1] = k end end
table.sort(names)
print(table.concat(names, " "))

--@ chunk 6
local ok, e = pcall(function() palette{scrape={{name="p1"}}} end)
print(ok, e)
local ok2, e2 = pcall(function() palette{scrape="p1"} end)
print(ok2, e2)
local ok3, e3 = pcall(function() palette{scrape={1}} end)
print(ok3, e3)
