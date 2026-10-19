local ch = rect(0,580,1000,140) - mud4:grow(2)
ripD = pile{{"lead white",1.8},{"cobalt blue",0.9},{"smalt",0.3},{"raw umber",0.3},{"red earth",0.15}}
ripL = pile{{"lead white",4},{"cobalt blue",0.3},{"vermilion",0.08},{"yellow ochre",0.2}}
local y = 588
local n = 0
while y < 714 do
  local d = (y - 575) / 140
  local x = rand(380, 560)
  while x < 860 do
    local len = rand(20, 70) * (0.6 + 1.2*d)
    if ch:at(clamp(x + len/2, 1, 999), y) > 0.5 and rand(0,1) < 0.6 then
      local b = brush{kind="flat", width=0.8 + 2.4*d, stiffness=0.4}
      if rand(0,1) < 0.55 then b:load(ripD, rand(0.25,0.45)) else b:load(ripL, rand(0.25,0.4)) end
      local pts = {}
      for k=0,4 do local t=k/4; pts[#pts+1] = {x + len*t, y + math.sin(t*3.1)*0.8*d + randn(0,0.2)} end
      b:stroke(pts, {pressure={rand(0.25,0.45), 0.05}, ramps={0.3,0.5}, clip=ch})
      n = n + 1
    end
    x = x + len + rand(15, 80)
  end
  y = y + 4 + 14*d^1.3 + rand(0, 4)
end
print(n)
