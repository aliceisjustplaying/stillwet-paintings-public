wDk = pile{{"green earth", 2}, {"raw umber", 1.4}, {"Prussian blue", 0.2}, {"lead white", 0.6}, {"yellow ochre", 0.4}, medium=0.1}
wSil = pile{{"lead white", 4}, {"green earth", 1.5}, {"pale smalt", 1}, {"yellow ochre", 0.5}, {"raw umber", 0.15}, medium=0.1}
wTg = pile{{"lead white", 2}, {"raw umber", 1.5}, {"pale smalt", 1.0}, {"bone black", 0.15}, medium=0.1}
wTd = pile{{"raw umber", 2}, {"bone black", 0.4}, {"pale smalt", 0.6}, {"lead white", 0.5}, medium=0.1}
willows = {}
local S = function(y) return (y - 438) * 0.149 end
local xs = {578, 628, 671, 719, 771, 818, 872, 921, 972}
for i, x0 in ipairs(xs) do
  local yb = 516 - (x0 - 560) * 0.018 + ((i*37)%5 - 2) * 0.4
  local s = S(yb) * 0.85
  local seed = i + 100
  local x = x0 + ((i*53)%9 - 4)
  local th = 2.0 * s
  local lean = ((seed * 31) % 7 - 3) * 0.03 * s
  willows[i] = {x=x, yb=yb, s=s, top=yb - th, lean=lean, seed=seed}
end
local wand = brush{kind="rigger", width=1.3, point=1}
local wand2 = brush{kind="round", width=1.6, point=0.8}
for i, w in ipairs(willows) do
  local kx, ky = w.x + w.lean, w.top + 0.5
  local size = w.s * (1.7 + 0.5 * ((i * 17) % 5) / 4)
  -- dark wands fanning up from the knuckle
  wand2:load(wDk, 0.7)
  local n = 22
  for k = 1, n do
    local a = -math.pi/2 + rand(-0.95, 0.95)
    local L = size * rand(0.55, 1.05) * (1 - 0.25 * math.abs(a + math.pi/2))
    local bend = rand(-0.12, 0.12)
    local p1 = {kx + rand(-1, 1), ky}
    local p2 = {kx + L*0.5*math.cos(a - bend), ky + L*0.5*math.sin(a - bend)}
    local p3 = {kx + L*math.cos(a + bend), ky + L*math.sin(a + bend)}
    wand2:stroke({p1, p2, p3}, {pressure={0.75, 0.05}, ramps={0.05, 0.6}})
    if k % 6 == 0 then wand2:load(wDk, 0.6) end
  end
  -- silvery wands, leaves catching light on the left and top
  wand:load(wSil, 0.6)
  for k = 1, 16 do
    local a = -math.pi/2 + rand(-0.9, 0.5)
    local L = size * rand(0.5, 1.0)
    local st = rand(0.25, 0.5)
    local p1 = {kx + L*st*math.cos(a), ky + L*st*math.sin(a)}
    local p3 = {kx + L*math.cos(a + rand(-0.1,0.1)), ky + L*math.sin(a + rand(-0.1,0.1))}
    wand:stroke({p1, p3}, {pressure={0.8, 0.1}, ramps={0.1, 0.5}})
    if k % 5 == 0 then wand:load(wSil, 0.5) end
  end
  -- trunk: grey lit side and a dark right side, a knuckle at the top
  local tw = 0.45 * w.s
  local tb = brush{kind="round", width=math.max(1.6, tw*0.6), point=0.3}
  tb:load(wTg, 0.6)
  tb:stroke({{w.x - tw*0.2, w.yb}, {w.x - tw*0.15 + w.lean, w.top + 1}}, {pressure={0.7, 0.6}})
  tb:load(wTd, 0.6)
  tb:stroke({{w.x + tw*0.3, w.yb}, {w.x + tw*0.3 + w.lean, w.top + 1}}, {pressure={0.55, 0.45}})
  tb:touch(kx, w.top + 0.5, {pressure=0.8})
end
print(wait(0))
