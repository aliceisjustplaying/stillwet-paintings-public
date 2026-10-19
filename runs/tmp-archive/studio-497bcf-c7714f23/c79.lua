hcL = pile{{"lead white", 3}, {"yellow ochre", 2.5}, {"chrome yellow", 0.2}, {"raw umber", 0.25}, medium=0.08}
hcS = pile{{"yellow ochre", 1.5}, {"raw umber", 1.2}, {"lead white", 1.2}, {"pale smalt", 0.6}, {"green earth", 0.4}, medium=0.08}
hcC = pile{{"raw umber", 1}, {"green earth", 0.8}, {"yellow ochre", 0.8}, {"lead white", 0.6}, {"pale smalt", 0.4}, medium=0.1}
wind = pile{{"yellow ochre", 1.6}, {"green earth", 1.2}, {"lead white", 1.6}, {"raw umber", 0.35}, medium=0.08}
-- windrows first: slightly darker, greener lines of raked hay
local wr = brush{kind="round", width=1.8, point=0.4}
for k, y0 in ipairs({526, 534, 546, 559, 571}) do
  wr:load(wind, 0.5)
  local xs = 330 + (y0 - 520) * 1.55 + 20
  local pts = {}
  for x = xs, 1005, 45 do pts[#pts+1] = {x, y0 - (x - 330) * 0.006 + 0.8*math.sin(x/37 + k)} end
  wr:stroke(pts, {pressure={0.4,0.3}, ramps={0.05,0.05}, shake=0.5})
end
haycocks = {}
local rows = {{y=531, xs={430, 505, 590, 690, 800, 905}}, {y=552, xs={470, 560, 665, 770, 890, 985}}, {y=572, xs={520, 640, 745, 860, 960}}}
for ri, r in ipairs(rows) do
  for ci, x in ipairs(r.xs) do
    local y = r.y - (x - 330) * 0.006 + rand(-1.2, 1.2)
    local S = (y - 438) * 0.13
    local h = 1.05 * S * rand(0.9, 1.1)
    local w = 1.45 * S * rand(0.9, 1.1)
    x = x + rand(-8, 8)
    haycocks[#haycocks+1] = {x=x, y=y, h=h, w=w}
    local body = poly({{x - w/2, y}, {x - w*0.45, y - h*0.45}, {x - w*0.28, y - h*0.85}, {x, y - h}, {x + w*0.28, y - h*0.85}, {x + w*0.45, y - h*0.45}, {x + w/2, y}}, true)
    local cast = ellipse(x + w*0.45, y + 0.3, w*0.55, math.max(1.0, h*0.12))
    work(cast - body, {hand="detail", pile=hcC, angle=0, coverage=2, length={2,6}, fill=true, clip=true, edge="soft", load=0.5})
    work(body, {hand="detail", pile=hcS, angle=math.pi/2, coverage=2.2, length={2,6}, fill=true, clip=true, edge="firm"})
    local lit = body * mask(function(px, py) return ((px - x) / w + (py - (y - h*0.5)) / h * 0.4) < -0.02 and 1 or 0 end)
    work(lit, {hand="detail", pile=hcL, angle=-1.2, coverage=2.0, length={2,5}, fill=true, clip=body, edge="soft"})
  end
end
print(#haycocks, wait(0))
