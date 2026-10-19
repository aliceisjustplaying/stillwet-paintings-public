local wm = rect(0,500,1000,180) - spit:shrink(6) - reflM2:grow(3)
local trans = wm * mask(function(x,y) return clamp(1-(y-505)/60,0,1) end)
work(trans, {hand="body", pile=Wb2, angle=0, angle_jitter=0.01, coverage=2, length={60,160}, pressure={0.3,0.6}, threshold=0.2})
-- ripple lights
local b = brush("filbert", 4)
local ys = uneven(26, 520, 665, 0.6, 0.4, 81)
for i, y in ipairs(ys) do
  local nseg = math.random(2,4)
  for k = 1, nseg do
    local x0 = rand(-40, 1000)
    local L = rand(60, 220) * (1 - (y-520)/300)
    local pile_ = (math.random() < 0.6) and Wb2 or skyA
    b:reload(pile_, rand(0.3,0.6))
    local w = rand(0.5, 2)
    b:stroke({{x0, y}, {x0 + L*0.5, y + w*0.5}, {x0 + L, y + rand(-1,1)}}, {pressure={rand(0.2,0.45), 0.05}, ramps={0.1,0.5}, clip=wm})
  end
end
