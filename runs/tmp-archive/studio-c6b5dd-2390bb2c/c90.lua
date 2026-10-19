pRip2 = pile{{"lead white",3},{"smalt",1},{"red earth",0.3},{"raw umber",0.5},{"green earth",0.3}, medium=0.25}
pRip3 = pile{{"lead white",4},{"pale smalt",1},{"vermilion",0.1},{"yellow ochre",0.2}, medium=0.2}
local b = brush{kind="flat", width=2.5, stiffness=0.4}
local n = 0
for i = 1, 40 do
  local y = rand(490, 710)
  local t = (y - 480) / 230
  -- lines start from the reflection's right edge and run in toward the left
  local xe = nil
  for x = 480, 0, -3 do if refl2:at(x, y) > 0.5 then xe = x break end end
  if xe then
    local L = rand(30, 90) * (0.5 + t)
    local x1 = xe + rand(-5, 25)
    local x0 = x1 - L
    local p = (math.random() < 0.3) and pRip3 or pRip2
    b:reload(p, rand(0.3, 0.5))
    b:stroke({{x0, y}, {(x0+x1)/2, y + rand(-0.5,0.5)}, {x1, y}}, {pressure={0.15, 0.35}, ramps={0.4,0.2}, orient="across"})
    n = n + 1
  end
end
-- a few long faint lines across the middle of the reflection
for i = 1, 10 do
  local y = rand(520, 700)
  local x0 = rand(0, 150)
  local L = rand(80, 200)
  b:reload(pRip2, 0.3)
  b:stroke({{x0, y}, {x0 + L/2, y + rand(-0.5,0.5)}, {x0 + L, y}}, {pressure={0.1, 0.25}, ramps={0.3,0.3}, orient="across"})
end
print(n)
