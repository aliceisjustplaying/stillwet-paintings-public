local count = 0
for i = 1, 160 do
  local y = 560 + 155 * (rand(0,1)^1.3)
  local x = rand(-20, 960)
  if mudAll2:at(math.max(1,x), y) > 0.9 then
    local depth = (y - 555) / 160   -- 0 far .. 1 near
    local w = 1.2 + 5 * depth^1.5
    local len = rand(20, 80) * (0.5 + 1.5*depth)
    local pts = {}
    for k = 0, 4 do local t = k/4; pts[#pts+1] = {x + len*t, y + (t-0.5)*len*0.01 + randn(0, 0.3*w)} end
    local b = brush{kind="flat", width=w, stiffness=0.45}
    if rand(0,1) < 0.35 then b:load(darkLine, 0.4) else b:load(sheen, 0.3 + 0.2*rand(0,1)) end
    b:stroke(pts, {pressure={rand(0.3,0.6), 0.1}, ramps={0.15,0.6}, clip=mudAll2})
    count = count + 1
  end
end
print(count)
