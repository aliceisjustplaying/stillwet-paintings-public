local groups = {{595,640,8,14},{628,775,14,26},{820,915,14,28},{922,1005,10,22}}
local M = nil
local tops = {}
for gi,g in ipairs(groups) do
  local x = g[1]
  while x < g[2] do
    local w = rand(5, 14)
    local t = (x-g[1])/(g[2]-g[1])
    local h = rand(g[3], g[4]) * (0.55 + 0.45*math.sin(math.pi*t))
    local cx = x + w/2
    local e = ellipse(cx, 472 - h*0.55, w*0.62, h*0.55)
    M = M and (M + e) or e
    tops[#tops+1] = {cx, 472 - h, w}
    x = x + w*rand(0.45, 0.9)
  end
end
M = (M * rect(560,400,450,72)):roughen(1.5, 5, 31)
woodsM = M + woodClumps
work(M, {hand="detail", pile=farWood2, angle=-math.pi/2, angle_jitter=0.4, coverage=3, pressure={0.4,0.7}, load=0.7, length={3,7}, fill=true})
-- airy twig tops above each crown: short upward strokes
local r = brush{kind="round", width=1.2, point=1}
r:load(farWood, 0.5)
for i,t in ipairs(tops) do
  for k=1,3 do
    local x = t[1] + rand(-t[3]*0.4, t[3]*0.4)
    local y = t[2] + rand(1,4)
    r:stroke({{x,y+3},{x+rand(-1.5,1.5),y-rand(2,5)}}, {pressure={0.35,0}})
    if k==3 then r:load(farWood, 0.5) end
  end
end
