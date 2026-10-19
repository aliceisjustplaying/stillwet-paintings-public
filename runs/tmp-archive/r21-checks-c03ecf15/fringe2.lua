--@ chunk 1
canvas{size=300, aspect=1, linen={16, 14}, seed=5, ground={{pile={{"lead white", 1}}, um=100, apply="knife", texture=0.1}}}
--@ chunk 2
local ys = {200, 400, 600, 800}
local tubes = {"ultramarine blue", "cerulean blue", "cobalt blue", "raw umber"}
for i, t in ipairs(tubes) do
  local p = pile{{t, 1}}
  local b = brush("filbert", 30)
  b:load(p, 0.9)
  b:stroke({{150, ys[i]}, {850, ys[i]}}, {pressure={0.8, 0.8}})
end
wait(60*24*14)
