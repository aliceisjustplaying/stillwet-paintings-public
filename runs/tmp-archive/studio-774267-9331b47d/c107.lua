local wool = pile{{"lead white", 2}, {"yellow ochre", 0.25}, {"raw umber", 0.12}, medium=0.08}
local woolsh = pile{{"lead white", 1}, {"raw umber", 0.4}, {"pale smalt", 0.3}, medium=0.08}
local dk = pile{{"raw umber", 1}, {"bone black", 0.3}, {"pale smalt", 0.2}, medium=0.08}
local t = brush{kind="round", width=1.6, point=0.3}
local f = brush{kind="round", width=0.5, point=1}
local cx, cy = 640, 428
for i=1,19 do
  local x = cx + randn(0, 11)
  local y = cy + randn(0, 1.6)
  local s = (y - 392)/36
  t:load(woolsh, 0.4); t:stroke({{x - 0.9*s, y - 0.5*s}, {x + 0.9*s, y - 0.55*s}}, {pressure={0.45, 0.45}})
  t:load(wool, 0.4); t:stroke({{x - 0.9*s, y - 0.8*s}, {x + 0.7*s, y - 0.85*s}}, {pressure={0.3, 0.25}})
  f:load(dk, 0.3); f:touch(x + (i % 2 == 0 and 1.1 or -1.1)*s, y - 0.5*s, {pressure=0.3})
end
-- the shepherd with his crook, and his dog
local sx, sy = 668, 430
f:load(dk, 0.5)
f:stroke({{sx, sy}, {sx, sy - 3.4}}, {pressure={0.9, 0.8}})
f:stroke({{sx - 0.4, sy - 1.5}, {sx - 0.2, sy - 4}}, {pressure={0.8, 0.7}})
f:touch(sx - 0.1, sy - 4.6, {pressure=0.6})
f:stroke({{sx + 1.3, sy + 0.1}, {sx + 1.6, sy - 6}}, {pressure={0.3, 0.3}})
f:stroke({{sx + 1.6, sy - 6}, {sx + 2.3, sy - 6.4}, {sx + 2.5, sy - 5.8}}, {pressure={0.25, 0.2}})
f:stroke({{sx - 5, sy + 0.4}, {sx - 3.5, sy + 0.3}}, {pressure={0.7, 0.6}})
f:touch(sx - 3.2, sy - 0.3, {pressure=0.45})
