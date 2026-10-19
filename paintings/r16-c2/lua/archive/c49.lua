farP2 = pile{{"lead white",3},{"cobalt blue",0.5},{"red earth",0.3},{"raw umber",0.25},{"yellow ochre",0.2}}
work(farShore, {hand="detail", tool="round 2.5", pile=farP2, angle=0, coverage=2.5, length={8,25}, fill=true})
rip1 = pile{{"lead white",6},{"chrome yellow",0.6},{"yellow ochre",0.3},{"vermilion",0.06}}
rip2 = pile{{"lead white",2.6},{"cobalt blue",0.55},{"red earth",0.3},{"raw umber",0.15}}
local waterMid = rect(0,404,1000,160) - bar:grow(2) - barR:grow(2) - mud4:grow(2)
local n = 0
for i = 1, 140 do
  local y = 405 + 155 * (rand(0,1)^1.25)
  local x = rand(-20, 1000)
  if waterMid:at(clamp(x,1,999), y) > 0.5 then
    local depth = (y - 400) / 165
    local w = 0.7 + 1.6*depth
    local len = rand(15, 90) * (0.6 + depth)
    local b = brush{kind="flat", width=w, stiffness=0.4}
    local light = (x > 250 and x < 560 and rand(0,1) < 0.75) or rand(0,1) < 0.45
    if light then b:load(rip1, rand(0.3,0.5)) else b:load(rip2, rand(0.25,0.45)) end
    local pts = {}
    for k=0,4 do local t=k/4; pts[#pts+1] = {x + len*t, y + randn(0, 0.2)} end
    b:stroke(pts, {pressure={rand(0.25,0.5), 0.05}, ramps={0.25,0.5}, clip=waterMid})
    n = n + 1
  end
end
print(n)
