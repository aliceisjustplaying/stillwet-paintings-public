local avoid = (MAN + WOMAN):grow(1) + BOULD:grow(0.5)
local dk = pile{{"green earth", 1.4}, {"raw umber", 0.9}, {"Prussian blue", 0.08}, {"bone black", 0.08}, medium=0.12}
local md = pile{{"green earth", 1.6}, {"yellow ochre", 0.9}, {"raw umber", 0.3}, {"Prussian blue", 0.03}, medium=0.12}
local lt = pile{{"yellow ochre", 1.2}, {"green earth", 1}, {"lead white", 0.5}, {"chrome yellow", 0.12}, medium=0.12}
local bl = brush{kind="round", width=1.4, point=1, stiffness=0.5}
local count = 0
local piles = {dk, dk, md, md, lt}
local cur = nil
for i=1,2600 do
  local x = rand(-5, 1005)
  local t = rand(0, 1)^0.7
  local y = lerp(fg(x) + 45, 650, t)
  if avoid:at(x, y) < 0.3 then
    local depth = (y - 560)/90
    local L = lerp(3, 15, clamp(depth, 0, 1)) * rand(0.6, 1.3)
    local w = lerp(0.5, 1.3, clamp(depth, 0, 1))
    local p = piles[math.random(1, 5)]
    if p ~= cur or bl:fullness() < 0.15 then bl:reload(p, 0.5); cur = p end
    local a = -math.pi/2 + randn(0, 0.3) + 0.15
    local bend = randn(0, 0.2)
    local ex, ey = x + L*math.cos(a), y + L*math.sin(a)
    local mx, my = x + 0.5*L*math.cos(a - bend), y + 0.5*L*math.sin(a - bend)
    bl:stroke({{x, y}, {mx, my}, {ex + bend*L*0.3, ey}}, {pressure={bl:pressure_for(w), 0}, ramps={0.05, 0.7}, clip=-avoid})
    count = count + 1
  end
end
print(count)
