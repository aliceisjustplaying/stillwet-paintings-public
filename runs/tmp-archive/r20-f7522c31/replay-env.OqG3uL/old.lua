-- easel session "painting": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box sargent

--@ chunk 1
canvas{size=300, aspect=1.25, seed=3, linen=15, ground={{pile={{"lead white", 4}, {"cadmium red", 1}}, um=80, apply="knife"}}}

--@ chunk 2
b = brush("round", 4); b:load(pile{{"emerald green", 1}}, 0.8); b:stroke({{200, 300}, {800, 320}})

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
