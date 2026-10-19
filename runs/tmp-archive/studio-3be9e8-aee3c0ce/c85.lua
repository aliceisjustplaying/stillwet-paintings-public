local b = brush{kind="flat", width=10, stiffness=0.6}
local L = jugBody:grow(2) * mask(function(x,y) return 1 - smoothstep(0.42, 0.5, jT(x,y)) end)
for pass = 1, 3 do
  for y = 436, 500, 5 do
    local xl, xr = edgeX(jugL, y), edgeX(jugR, y)
    b:stroke({{xl + (xr-xl)*0.5, y + pass}, {xl - 3, y + pass}}, {pressure={0.8,0.8}, ramps={0.2,0.05}, orient="across", clip=L})
    b:wipe(1)
  end
end
