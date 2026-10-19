-- break the grid of haycocks: a few more, some only half-built heaps, off the rows
local extra = {{402, 547, 1.0, 1.0}, {622, 559, 0.95, 1.05}, {737, 537, 0.55, 1.35}, {846, 541, 0.7, 1.2}, {702, 571, 0.5, 1.5}, {940, 540, 0.9, 0.95}}
for i, e in ipairs(extra) do
  local x, y = e[1], e[2]
  local S = (y - 438) * 0.13
  local h = 1.05 * S * e[3]
  local w = 1.45 * S * e[4]
  local body
  if e[3] > 0.8 then
    body = poly({{x - w/2, y}, {x - w*0.46, y - h*0.4}, {x - w*0.3, y - h*0.82}, {x - w*0.05, y - h}, {x + w*0.22, y - h*0.9}, {x + w*0.44, y - h*0.5}, {x + w/2, y}}, true)
  else
    body = poly({{x - w/2, y}, {x - w*0.42, y - h*0.6}, {x - w*0.15, y - h}, {x + w*0.2, y - h*0.95}, {x + w*0.45, y - h*0.55}, {x + w/2, y}}, true)
  end
  body = body:roughen(0.5, 2, 800 + i)
  local cast = ellipse(x + w*0.45, y + 0.3, w*0.55, math.max(1.0, h*0.14))
  work(cast - body, {hand="detail", pile=hcC, angle=0, coverage=2, length={2,6}, fill=true, clip=true, edge="soft", load=0.5})
  work(body, {hand="detail", pile=hcS, angle=math.pi/2, coverage=2.2, length={2,6}, fill=true, clip=true, edge="firm"})
  local lit = body * mask(function(px, py) return ((px - x) / w + (py - (y - h*0.5)) / h * 0.4) < -0.02 and 1 or 0 end)
  work(lit, {hand="detail", pile=hcL, angle=-1.2, coverage=2.0, length={2,5}, fill=true, clip=body, edge="soft"})
  haycocks[#haycocks+1] = {x=x, y=y, h=h, w=w}
end
-- loose hay: short raked strands trailing from the heaps and along the windrows
local st = brush{kind="round", width=1.2, point=0.8}
for k = 1, 60 do
  local hcx = haycocks[math.random(1, #haycocks)]
  local x = hcx.x + rand(-2.5, 2.5) * hcx.w
  local y = hcx.y + rand(-0.4, 1.2) * hcx.h * 0.3
  if fieldB:at(x, y) > 0.9 and figs:grow(3):at(x, y) < 0.1 and elder2:grow(2):at(x, y) < 0.1 then
    st:load((k % 3 == 0) and hcL or wind, 0.4)
    local L = (y - 438) * 0.06 * rand(0.6, 1.4)
    st:stroke({{x, y}, {x + L, y + rand(-0.4, 0.4)}}, {pressure={0.4, 0.2}})
  end
end
print(wait(0))
