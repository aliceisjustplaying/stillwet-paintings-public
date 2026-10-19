-- easel session "painting": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box sargent

--@ chunk 1
canvas{size=300, aspect=1.25, linen=15, ground={{pile={{"lead white", 5}, {"Mars red", 1}}, um=80, apply="knife"}}}

--@ chunk 2
b = brush("filbert", 6); b:load(pile{{"rose madder", 1}, {"cerulean blue", 1}, {"zinc white", 2}, medium=0.2}, 0.9); for i = 1, 12 do b:stroke({{100 + i * 60, 700}, {140 + i * 60, 300}}) end; wait(60)

--@ chunk 3
work(rect(100, 100, 800, 150), {hand="glaze", pile=pile{{"viridian", 1}, {"Indian yellow", 1}, medium=0.7}})

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
