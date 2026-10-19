local avoid = (MAN + WOMAN):grow(1) + BOULD:grow(0.5)
local dk = pile{{"green earth", 1.4}, {"raw umber", 0.9}, {"Prussian blue", 0.08}, {"bone black", 0.08}, medium=0.12}
local dk2 = pile{{"green earth", 1.6}, {"raw umber", 0.6}, {"Prussian blue", 0.12}, {"yellow ochre", 0.3}, medium=0.12}
local md = pile{{"green earth", 1.6}, {"yellow ochre", 0.9}, {"raw umber", 0.3}, {"Prussian blue", 0.03}, medium=0.12}
local bl = brush{kind="round", width=1.4, point=1, stiffness=0.5}
local cl = worley{seed=12, period=18, jitter=0.9}
local piles = {dk, dk2, dk2, md}
local cur = nil
local count = 0
for i=1,5200 do
  local x = rand(-5, 1005)
  local t = rand(0, 1)^0.8
  local y = lerp(fg(x) + 40, 652, t)
  if avoid:at(x, y) < 0.3 then
    local depth = clamp((y - 560)/90, 0, 1)
    local L = lerp(3, 13, depth) * rand(0.6, 1.3)
    local w = lerp(0.45, 1.1, depth)
    local p = piles[math.random(1, 4)]
    if p ~= cur or bl:fullness() < 0.15 then bl:reload(p, 0.5); cur = p end
    local c = cl:at(x, y)
    local lean = 0.25*math.sin(x/37 + y/23)
    local a = -math.pi/2 + lean + randn(0, 0.28)
    local bend = randn(0, 0.2)
    local ex, ey = x + L*math.cos(a), y + L*math.sin(a)
    local mx, my = x + 0.5*L*math.cos(a - bend), y + 0.5*L*math.sin(a - bend)
    bl:stroke({{x, y}, {mx, my}, {ex + bend*L*0.3, ey}}, {pressure={bl:pressure_for(w), 0}, ramps={0.05, 0.7}, clip=-avoid})
    count = count + 1
  end
end
print(count)
