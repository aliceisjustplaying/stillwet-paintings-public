weedP = pile{{"raw umber",1},{"bone black",0.4},{"green earth",0.5},{"yellow ochre",0.15},{"lead white",0.15}}
stoneP = pile{{"raw umber",1},{"bone black",0.5},{"cobalt blue",0.2},{"lead white",0.5}}
stoneHi = pile{{"lead white",3},{"cobalt blue",0.4},{"red earth",0.25},{"raw umber",0.2}}
local n = 0
for i = 1, 90 do
  local y = 566 + 150 * (rand(0,1)^1.1)
  local x = rand(0, 1000)
  if mud4:shrink(4):at(x, y) > 0.9 and not (x > 160 and x < 310 and y > 585 and y < 630) then
    local d = (y - 560) / 155
    local s = 1.2 + 7 * d^1.3
    if rand(0,1) < 0.55 then
      local c = ellipse(x, y, s*rand(1.2,2.5), s*0.45):roughen(s*0.3, s*0.8, i)
      stipple(c, {pile=weedP, width=math.max(1.2, s*0.5), coverage=1.4, pressure={0.3,0.6}, cluster=0.4})
    else
      local b = brush{kind="round", width=math.max(1, s*0.9), point=0.1}
      b:load(stoneP, 0.6)
      b:touch(x, y, {pressure=0.6, drag={s*0.4, 0}})
      local h = brush{kind="round", width=math.max(0.7, s*0.4), point=0.2}
      h:load(stoneHi, 0.4)
      h:touch(x - s*0.1, y - s*0.25, {pressure=0.35, drag={s*0.25, 0}})
    end
    n = n + 1
  end
end
print(n)
