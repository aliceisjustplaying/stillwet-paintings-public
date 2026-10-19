warmSheen = pile{{"lead white",4},{"yellow ochre",0.45},{"vermilion",0.15},{"cobalt blue",0.15},{"raw umber",0.05}}
violetSheen = pile{{"lead white",3},{"cobalt blue",0.5},{"red earth",0.25},{"raw umber",0.1}}
local nL = 0
local y = 569
while y < 640 do
  local depth = (y - 560) / 80
  local w = 0.9 + 2.2*depth
  local x = rand(-30, 200)
  while x < 1000 do
    local len = rand(60, 260) * (0.7 + depth)
    local x2 = x + len
    local b = brush{kind="flat", width=w, stiffness=0.4}
    if y < 600 then b:load(warmSheen, rand(0.35, 0.6)) else b:load(violetSheen, rand(0.3, 0.55)) end
    local pts = {}
    for k=0,6 do local t=k/6; pts[#pts+1] = {lerp(x,x2,t), y + randn(0,0.25*w) + math.sin(t*3+x)*0.6} end
    if rand(0,1) < 0.7 then b:stroke(pts, {pressure={rand(0.3,0.6), 0.05}, ramps={0.1, 0.5}, clip=mud4:shrink(1.5)}); nL = nL + 1 end
    x = x2 + rand(30, 160)
  end
  y = y + 3.5 + 9*depth^1.4 + rand(0, 3)
end
print(nL)
