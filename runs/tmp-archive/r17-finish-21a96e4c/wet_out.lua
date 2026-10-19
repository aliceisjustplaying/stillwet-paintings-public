-- easel session "painting": a painting replayed chunk by chunk.

--@ chunk 1
canvas{size=300, aspect=1, linen=15, ground={{pile={{"lead white",1}},um=100,apply="knife"}}}
b = brush("flat", 20); b:load(pile{{"bone black",3}}); b:stroke({100,200,400,200})
print(drying(250,200))

--@ chunk (finishing)
-- finishing, applied after the session by scripts/finish_painting
local function when_dry(f)
  for _ = 1, 120 do
    local ok, e = pcall(f)
    if ok then return end
    if not tostring(e):find('not all dry', 1, true) then error(e, 0) end
    wait(30 * 24 * 60)
  end
  error('still not dry after ten years', 0)
end
when_dry(function() varnish{coats=0.4} end)
when_dry(function() cracks{} end)
when_dry(function() relief() end)

print(drying(250,200), wait(0))
