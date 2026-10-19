wD = pile{{"green earth", 2}, {"raw umber", 1.2}, {"Prussian blue", 0.15}, {"lead white", 0.9}, {"yellow ochre", 0.5}, medium=0.1}
wL = pile{{"lead white", 3}, {"green earth", 2}, {"yellow ochre", 0.8}, {"pale smalt", 0.6}, {"raw umber", 0.2}, medium=0.1}
wT = pile{{"raw umber", 2}, {"bone black", 0.3}, {"lead white", 0.8}, {"pale smalt", 0.5}, medium=0.1}
function willow(x, yb, s, seed)
  -- s = units per metre
  local th = 2.0 * s        -- trunk height
  local tw = 0.45 * s       -- trunk width
  local hr = 1.35 * s * (0.85 + 0.3 * ((seed * 7919) % 100) / 100)  -- head radius
  local lean = ((seed * 31) % 7 - 3) * 0.03 * s
  local trunk = poly({{x - tw*0.6, yb}, {x - tw*0.45 + lean, yb - th}, {x + tw*0.45 + lean, yb - th}, {x + tw*0.6, yb}})
  local hx, hy = x + lean, yb - th - hr * 0.7
  local head = ellipse(hx, hy, hr, hr * 0.9):roughen(math.max(0.8, hr*0.18), math.max(3, hr*0.5), seed)
  -- a few wands poking out at the top
  for k = 1, 5 do
    local a = -math.pi/2 + (k - 3) * 0.35 + rand(-0.1, 0.1)
    local L = hr * rand(1.0, 1.35)
    head = head + ribbon({{hx, hy}, {hx + L*math.cos(a), hy + L*math.sin(a)}}, {hr*0.35, 0.6})
  end
  head = head - trunk:shrink(0.1) * rect(0, hy + hr*0.6, 1000, 400)
  work(trunk, {hand="detail", pile=wT, angle=math.pi/2, coverage=2.5, length={2, 6}, fill=true, clip=true, edge="firm"})
  stipple(head, {pile=wD, width=math.max(1.6, hr*0.3), coverage=4, pressure={0.4,0.7}, clip=head, cluster=0.2})
  local lit = head * mask(function(px, py) return ((px - hx) * -0.6 + (py - hy) * -0.8) / hr > -0.05 and 1 or 0 end)
  stipple(lit:shrink(0.6), {pile=wL, width=math.max(1.3, hr*0.22), coverage=2.2, pressure={0.35,0.6}, clip=head, cluster=0.4, feather=0.5})
end
local S = function(y) return (y - 438) * 0.149 end
local xs = {578, 628, 671, 719, 771, 818, 872, 921, 972}
for i, x in ipairs(xs) do
  local yb = 516 - (x - 560) * 0.018 + ((i*37)%5 - 2) * 0.4
  willow(x + ((i*53)%9 - 4), yb, S(yb) * 0.85, i + 100)
end
print(wait(0))
