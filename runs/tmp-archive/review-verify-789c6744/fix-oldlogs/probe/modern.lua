--@ chunk 1
canvas{size=300, aspect=1.5, linen=15, seed=3, ground={{pile={{"lead white", 3}, {"yellow ochre", 1}}, um=80, apply="knife"}}}
--@ chunk 2
w = world{horizon=300}
print(pcall(function() return w:sky{} end))
print(pcall(function() return w.clouds end), w.nothing, rawequal(w.sky, nil))
print(pcall(function() return mix("#000000", "#ffffff", 0.5) end))
print(pcall(function() return canvas{style="friedrich"} end))
print(pcall(function() return work(everywhere(), {hand="body", color="#808080"}) end))
print(pcall(function() b = brush("round", 4); b:load("#303030") end))
print(pcall(function() return stipple(everywhere(), {color="#808080"}) end))
p = pile{{"lead white", 1}}
work(rect(100, 100, 200, 200), {hand="body", pile=p})
