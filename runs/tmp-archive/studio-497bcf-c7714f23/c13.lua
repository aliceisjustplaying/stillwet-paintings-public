millp = pile{{"lead white", 3}, {"pale smalt", 2}, {"smalt", 0.6}, {"raw umber", 0.7}, {"red earth", 0.2}, medium=0.15}
local r = brush{kind="round", width=1.4, point=0.9}
r:load(millp, 0.6)
local hx, hy = 737, 400
for i, a in ipairs({-0.75, 0.82, 2.39, -2.33}) do
  local L = 27
  local ex, ey = hx + L*math.cos(a), hy + L*math.sin(a)
  r:stroke({{hx,hy},{ex,ey}}, {pressure={0.55,0.35}, ramps={0.05,0.1}})
  -- the sail frame, offset a little to one side of the stock
  local nx, ny = -math.sin(a)*2.2, math.cos(a)*2.2
  r:stroke({{hx+nx+ 6*math.cos(a), hy+ny+6*math.sin(a)},{ex+nx,ey+ny}}, {pressure={0.3,0.25}, ramps={0.1,0.1}})
  if i % 2 == 0 then r:load(millp, 0.5) end
end
print(wait(0))
