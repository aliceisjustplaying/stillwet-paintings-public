--@ chunk 1
canvas{size=400, aspect=1.25, linen=15, ground={{pile={{"lead white", 1}}, um=100, apply="knife"}}}
--@ chunk 2
sky = pile{{"ultramarine", 1}, {"lead white", 6}}
big = brush{kind="flat", width=24}
function streak(y, n)
  for i = 1, n do
    local x = rand() * 400
    stroke{brush=big, pile=sky, from={x, y}, to={x + 60, y}}
  end
end
--@ chunk 3
horizon = mask{below=320}
ridge, snow = pile{{"burnt umber", 1}}, pile{{"lead white", 1}}
local tmp = 3
print(wait(60 * 24))
