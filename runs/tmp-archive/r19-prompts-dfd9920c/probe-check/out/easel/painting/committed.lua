-- easel session "painting": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.

--@ chunk 1
canvas{size=300, aspect=0.8, linen=15, ground={{pile={{"lead white", 1}}, um=80, apply="knife"}}}

--@ chunk 2
b = brush("filbert", 8); p = pile{{"raw umber", 1}}; b:load(p, 0.8); b:stroke({{120, 640}, {260, 470}, {430, 420}}, {pressure={0.9, 0.3}, ramps={0.05, 0.4}})

--@ chunk 3
h = pencil("2H"); h:rule({120, 700}, {860, 180}, {pressure=0.3}); m = below(function(x) return 150 + 0.6 * x end); print(m:area())

--@ chunk 4
s = body.ellipsoid({400, 500, 0}, {120, 90, 80}):turn({400, 500, 0}, 0.3, 0.1, 0); k = body.block({650, 520, 0}, {160, 60, 90}, 3); t = terrain{area={250, 200, 650, 500}, height=function(x, y) return 10 * math.sin(x / 60) end}; f = form{ {s, dist=0.3}, {k}, light={from={-1, -0.7}, front=0.5, ambient=0.2} }; print(f:value(400, 500))

--@ chunk 5
w = world{eye=1.6, fov=45}; s2 = w:spot(500, 900); w, n = w:place(s2, body.block(s2:p(0, 0.5, 0), s2:size(1, 1, 1), s2:m(0.05))); v = w:view(); print(n, v:bodies_mask{n}:area())

--@ chunk 6
work(m, {hand="body", pile=p, coverage=1})
