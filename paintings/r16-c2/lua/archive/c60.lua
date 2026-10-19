local b = brush{kind="round", width=3.2, point=0.2}
b:load(treeP, 0.7)
for i = 1, 40 do
  local a = rand(math.pi*0.85, math.pi*2.05)
  local rr = 1 + rand(-0.12, 0.08)
  local x = 818 + 16*rr*math.cos(a); local y = 306 + 12*rr*math.sin(a)
  if i % 10 == 0 then b:load(treeP, 0.6) end
  b:touch(x, y, {pressure=rand(0.4,0.8), drag={rand(-1,1), rand(-1,1)}})
end
local l = brush{kind="round", width=2.2, point=0.2}
l:load(treeLit, 0.5)
for i = 1, 14 do
  local a = rand(math.pi*1.0, math.pi*1.5)
  local x = 818 + 15*math.cos(a); local y = 306 + 11*math.sin(a)
  l:touch(x+rand(-1.5,1.5), y+rand(-1.5,1.5), {pressure=rand(0.3,0.5)})
end
