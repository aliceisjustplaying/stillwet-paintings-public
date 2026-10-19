local bY = pile{{"chrome yellow",2},{"lead white",0.8},{"yellow ochre",0.3}, medium=0.05}
local dW = pile{{"lead white",6},{"yellow ochre",0.1}, medium=0.05}
local st = pile{{"green earth",1.5},{"yellow ochre",1},{"Prussian blue",0.15},{"lead white",0.3}, medium=0.05}
local so = pile{{"red earth",1.5},{"vermilion",0.4},{"raw umber",0.4},{"lead white",0.3}, medium=0.05}
local keep = trunkM:grow(2) + oakM:grow(1) + stoneM:grow(1) + figM:grow(2)
math.randomseed(91)
local stem = brush{kind="rigger", width=1.2, point=1}
local head = brush{kind="round", width=4, point=0.7}
local plants = {}
-- clumps along the near foreground
for c=1,14 do
  local cx = 10 + math.random()*510
  local cy = 645 + math.random()*62
  if true then
  for k=1,5+math.floor(math.random()*6) do
    local x = cx + (math.random()-0.5)*40
    local y = cy + (math.random()-0.5)*14
    if y > riseY(x)+20 and y < 712 and keep:at(x,y) < 0.5 then plants[#plants+1] = {x,y} end
  end end
end
stem:load(st, 0.9)
local tops = {}
for i,p in ipairs(plants) do
  local s = 0.6 + (p[2]-620)/90
  local hgt = (14 + math.random()*16) * s
  local lean = (math.random()-0.5)*6*s
  local tx, ty = p[1]+lean, p[2]-hgt
  stem:stroke({{p[1],p[2]},{p[1]+lean*0.4, p[2]-hgt*0.5},{tx,ty}}, {pressure={0.45,0.15}, ramps={0.05,0.3}})
  if i % 12 == 0 then stem:load(st, 0.9) end
  tops[#tops+1] = {tx,ty,s,math.random()}
end
wait(1)
head:load(bY, 0.9)
local n=0
for _,t in ipairs(tops) do if t[4] < 0.6 then
  head:touch(t[1], t[2], {pressure=clamp(0.35*t[3],0.2,0.7), twist=math.random()}); n=n+1
  if n % 15 == 0 then head:load(bY,0.9) end
end end
head:reload(dW, 0.9)
for _,t in ipairs(tops) do if t[4] >= 0.6 and t[4] < 0.85 then
  head:touch(t[1], t[2], {pressure=clamp(0.35*t[3],0.2,0.7), twist=math.random()})
end end
-- sorrel spikes: small elongated rusty dabs
local sb = brush{kind="round", width=2, point=0.9}
sb:load(so, 0.9)
for _,t in ipairs(tops) do if t[4] >= 0.85 then
  for j=0,3 do sb:touch(t[1]+(math.random()-0.5)*1.5, t[2]+j*2.2*t[3], {pressure=0.35}) end
end end
print(#plants)
