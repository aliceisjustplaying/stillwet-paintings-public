local sil = BOULD
local warm = pile{{"lead white", 1.6}, {"yellow ochre", 0.35}, {"raw umber", 0.25}, {"red earth", 0.04}, medium=0.1}
local ridge = sil * mask(function(x, y)
  local top = 572 + 0.004*(x - 800)^2
  return (BF:value(x, y) > 0.62 and y < top + 7 + 3*math.sin(x/5) and x < 830) and 1 or 0 end)
stipple(ridge, {pile=warm, width=1.3, coverage=0.9, cluster=0.5, drag={1.2, -0.3}, clip=true, seed=10101})
-- grass over the foot of the stones
local dk = pile{{"green earth", 1.4}, {"raw umber", 0.9}, {"Prussian blue", 0.08}, {"bone black", 0.08}, medium=0.12}
local md = pile{{"green earth", 1.6}, {"yellow ochre", 0.9}, {"raw umber", 0.3}, medium=0.12}
local bl = brush{kind="round", width=1.3, point=1, stiffness=0.5}
for i=1,260 do
  local x = rand(740, 990)
  local yb = nil
  -- find the stone's lower edge at this x
  for y = 640, 560, -1 do if sil:at(x, y) > 0.5 then yb = y; break end end
  if yb then
    local y = yb + rand(-2, 4)
    local L = rand(4, 11)
    bl:reload((i % 3 == 0) and md or dk, 0.5)
    local a = -math.pi/2 + randn(0, 0.3)
    bl:stroke({{x, y}, {x + L*0.5*math.cos(a + 0.1), y + L*0.5*math.sin(a + 0.1)}, {x + L*math.cos(a), y + L*math.sin(a)}}, {pressure={bl:pressure_for(0.9), 0}, ramps={0.05, 0.7}})
  end
end
