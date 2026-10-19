litCloud = pile{{"lead white",4},{"vermilion",0.3},{"chrome yellow",0.25},{"yellow ochre",0.3}}
litCloud2 = pile{{"lead white",5},{"chrome yellow",0.5},{"vermilion",0.15}}
local n = 0
local x = -20
while x < 780 do
  local len = rand(40, 150)
  local y = 232 + 0.004*x + randn(0, 2.5)
  local b = brush{kind="flat", width=rand(1.5, 3), stiffness=0.35}
  b:load(litCloud, rand(0.2, 0.4))
  local pts = {}
  for k=0,5 do local t=k/5; pts[#pts+1] = {x + len*t, y + math.sin(t*2.5 + x)*1.5} end
  b:stroke(pts, {pressure={0.35, 0.05}, ramps={0.3, 0.5}})
  x = x + len + rand(10, 70); n = n + 1
end
for i = 1, 9 do
  local x = rand(80, 700); local y = rand(280, 318); local len = rand(40, 120)
  local b = brush{kind="flat", width=rand(1.2, 2.2), stiffness=0.35}
  b:load(litCloud2, rand(0.2, 0.35))
  b:stroke({{x, y}, {x + len*0.5, y - 0.5}, {x + len, y + 0.3}}, {pressure={0.3, 0.05}, ramps={0.3, 0.5}})
end
print(n)
