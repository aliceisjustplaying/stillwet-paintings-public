shoreP = pile{{"lead white",1.6},{"smalt",1},{"red earth",0.35},{"raw umber",0.5}}
treeP = pile{{"lead white",1},{"smalt",1},{"red earth",0.3},{"raw umber",0.7},{"green earth",0.3}}
shoreline = function(x)
  local base = 437 + 2*math.sin(x/47) + 1.5*math.sin(x/13)
  -- tree clump on the right
  local t = 0
  if x > 720 and x < 980 then
    local u = (x-720)/260
    t = 30*math.sin(u*math.pi)^0.7 + 7*math.sin(x/9)*math.sin(u*math.pi) + 5*math.sin(x/23)
  end
  -- small clump left of centre, low
  if x > 430 and x < 520 then t = t + 9*math.sin((x-430)/90*math.pi) + 3*math.sin(x/7) end
  -- a few trees far left
  if x > 20 and x < 130 then t = t + 12*math.sin((x-20)/110*math.pi)^1.5 + 3*math.sin(x/6) end
  return base - math.max(t,0)
end
local pts = {}
for x = -10, 1010, 3 do pts[#pts+1] = {x, shoreline(x)} end
shore = below(pts) * above(function(x) return 448 + 1.5*math.sin(x/31) end)
shore = shore:roughen(2, 12, 4)
work(shore, {hand="detail", pile=shoreP, angle=0, coverage=2.5, fill=true})
local trees = shore * above(function(x) return 436 end)
work(trees, {hand="detail", pile=treeP, angle=-1.4, angle_jitter=0.5, coverage=1.5})
