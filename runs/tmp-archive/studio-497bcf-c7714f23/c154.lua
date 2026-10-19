cowBr = pile{{"red earth", 1.2}, {"raw umber", 1.5}, {"bone black", 0.12}, {"yellow ochre", 0.2}, medium=0.08}
cowBrD = pile{{"raw umber", 1.6}, {"red earth", 0.6}, {"bone black", 0.35}, medium=0.08}
cowBrL = pile{{"red earth", 1}, {"yellow ochre", 0.8}, {"raw umber", 0.5}, {"lead white", 0.5}, medium=0.08}
cowCr = pile{{"lead white", 4}, {"yellow ochre", 0.4}, {"pale smalt", 0.5}, {"raw umber", 0.15}, medium=0.08}
local defs = {{262,562,18,1,true,1}, {52,533,14,1,true,3}}
for _, c in ipairs(defs) do
  local m = cows[c[6]]
  work(m, {hand="detail", pile=cowBr, angle=0, coverage=3, length={1.5,4}, fill=true, clip=true, edge="found"})
  local x0, y0, s = c[1], c[2], c[3]
  local low = m * mask(function(px, py) return (py > y0 - 0.8*s or px > x0 + 1.8*s) and 1 or 0 end)
  work(low, {hand="detail", pile=cowBrD, angle=0, coverage=2.5, length={1.5,4}, fill=true, clip=true, edge="soft"})
  local r = brush{kind="round", width=math.max(0.9, 0.09*s), point=0.8}
  r:load(cowBrL, 0.5)
  r:stroke({{x0 - 0.04*s, y0 - 1.2*s}, {x0 + 0.02*s, y0 - 1.32*s}, {x0 + 0.5*s, y0 - 1.31*s}, {x0 + 1.1*s, y0 - 1.3*s}, {x0 + 1.6*s, y0 - 1.35*s}}, {pressure={0.55,0.3}, ramps={0.1,0.3}})
  r:stroke({{x0 + 0.02*s, y0 - 1.2*s}, {x0 + 0.05*s, y0 - 0.95*s}}, {pressure={0.4,0.2}})
end
-- white cow: restate as creamy white with red-brown patches
local m2 = cows[2]
work(m2, {hand="detail", pile=cowCr, angle=0, coverage=3, length={1.5,4}, fill=true, clip=true, edge="found"})
local x0, y0, s = 342, 549, 16.6
local pm = (ellipse(x0 - 0.7*s, y0 - 1.0*s, 0.33*s, 0.26*s) + ellipse(x0 - 1.35*s, y0 - 1.1*s, 0.2*s, 0.2*s) + ellipse(x0 - 2.25*s, y0 - 1.28*s, 0.18*s, 0.14*s)):roughen(0.08*s, 0.2*s, 342) * m2
work(pm, {hand="detail", pile=cowBr, coverage=3, length={1,3}, fill=true, clip=true, edge="firm"})
local low2 = m2 * mask(function(px, py) return (py > y0 - 0.78*s) and 1 or 0 end)
work(low2, {hand="detail", pile=cowWhD, angle=0, coverage=2, length={1.5,4}, fill=true, clip=true, edge="soft"})
print(wait(0))
