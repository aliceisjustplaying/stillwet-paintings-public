sheen = pile{{"lead white",2.4},{"cobalt blue",0.7},{"red earth",0.25},{"raw umber",0.15}}
darkLine = pile{{"raw umber",1.5},{"bone black",0.8},{"cobalt blue",0.2}}
local f = brush{kind="flat", width=3, stiffness=0.5}
local d = brush{kind="flat", width=2.2, stiffness=0.5}
local count = 0
for i = 1, 70 do
  local x = rand(0, 900); local y = rand(565, 712)
  if mudAll2:at(x, y) > 0.9 then
    local len = rand(25, 110) * (0.6 + (y-560)/150)
    local x2 = x + len
    local pts = {}
    for k = 0, 4 do local t = k/4; pts[#pts+1] = {lerp(x, x2, t), y + (t-0.5)*len*0.015 + randn(0, 0.4)} end
    if i % 3 == 0 then
      d:reload(darkLine, 0.5); d:stroke(pts, {pressure={0.5, 0.2}, ramps={0.2,0.5}, clip=mudAll2})
    else
      f:reload(sheen, 0.45); f:stroke(pts, {pressure={0.45, 0.15}, ramps={0.2,0.5}, clip=mudAll2})
    end
    count = count + 1
  end
end
print(count)
