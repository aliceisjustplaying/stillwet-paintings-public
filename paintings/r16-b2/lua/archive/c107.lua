local R = (ellipse(338,430,20,18) + ellipse(362,436,10,10)) * above(function(x) return 446 end) - TOWN2:grow(1)
local b = brush{kind="round", width=1, point=0.8}
local n = 0
for k=1,400 do
  local x,y = rand(315,375), rand(408,446)
  if R:at(x,y) > 0.5 and n < 90 then
    n = n + 1
    if n % 8 == 1 then b:load((n%3==0) and fmid or treep, 0.4) end
    local a = -1.1 + randn(0,0.5); local L = rand(1.5,3.5)
    b:stroke({{x,y},{x+math.cos(a)*L, y+math.sin(a)*L}}, {pressure={b:pressure_for(0.9), b:pressure_for(0.3)}})
  end
end
