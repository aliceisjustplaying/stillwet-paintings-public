-- easel session "painting": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box hopper
--@ engine 2

--@ chunk 1
canvas{size=200, aspect=1.5, linen=12, seed=7,
        ground={{pile={{"lead white", 3}, {"yellow ochre", 1}}, um=60, apply="knife", texture=0.3}}}

p = pile{{"cadmium yellow", 2}, {"burnt sienna", 1}}
b = brush("filbert", 8)
b:load(p, 0.8)
b:stroke({{120, 640}, {320, 520}, {560, 470}, {760, 520}},
  {pressure={0.9, 0.4}, ramps={0.05, 0.4}, orient="across"})
print("fullness", b:fullness(), "W", W, "H", H)
print(drying(400, 530))
