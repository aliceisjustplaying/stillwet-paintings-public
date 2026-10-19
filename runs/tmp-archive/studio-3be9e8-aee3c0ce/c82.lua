local b = brush{kind="flat", width=10, stiffness=0.6}
local R = jugBody * mask(function(x,y) return smoothstep(0.4, 0.5, jT(x,y)) end)
for pass = 1, 2 do
  for y = 500, 604, 5 do
    local xl, xr = edgeX(jugL, y), edgeX(jugR, y)
    b:stroke({{xr + 2, y + pass}, {xl + (xr-xl)*0.42, y + pass}}, {pressure={0.8,0.6}, ramps={0.05,0.3}, orient="across", clip=R})
    b:wipe(1)
  end
end
