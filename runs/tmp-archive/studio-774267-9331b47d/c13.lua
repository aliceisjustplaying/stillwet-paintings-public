-- distant tree lines along the horizon
local function copse(x0, x1, hmax, seed)
  local m = nil
  local xs = uneven(math.floor((x1-x0)/6), x0, x1, 0.6, 0.4, seed)
  for i, x in ipairs(xs) do
    local hh = hmax * (0.45 + 0.55*math.sin(math.pi*(x-x0)/(x1-x0))^0.6) * (0.75 + 0.5*((i*37 % 11)/11))
    local e = ellipse(x, far(x) - hh*0.55, 4 + hh*0.35, hh*0.6)
    m = m and (m + e) or e
  end
  return m
end
FARTREES = (copse(-10, 120, 14, 1) + copse(190, 250, 8, 2) + copse(290, 330, 6, 3) + copse(420, 545, 11, 4) + copse(745, 800, 9, 5) + copse(830, 860, 7, 6) + copse(900, 1010, 16, 7)):roughen(1.5, 8, 31)
FARTREES = FARTREES * above(function(x) return far(x) + 3 end)
local fartree = pile{{"pale smalt", 2}, {"lead white", 1.4}, {"green earth", 0.8}, {"raw umber", 0.3}, {"bone black", 0.08}, medium=0.1}
stipple(FARTREES, {pile=fartree, width=2.2, coverage=2.5, cluster=0.3, clip=true, seed=1301})
work(FARTREES:shrink(1.5), {hand="detail", pile=fartree, coverage=1.2, seed=1302})
