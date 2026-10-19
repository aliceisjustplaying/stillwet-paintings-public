local hedges = {{200,480,401},{600,760,404},{800,960,407},{0,250,412},{350,700,418},{700,1000,425},{0,180,434},{420,580,436},{620,760,444}}
local nn = noise{seed=9, octaves=3, period=25}
HEDGES = nil
for i,h in ipairs(hedges) do
  local x0, x1, y = h[1], h[2], h[3]
  local t = (y - 398)/50
  local pts, wd = {}, {}
  local slope = rand(-0.01, 0.01)
  for x = x0, x1, 3 do
    pts[#pts+1] = {x, y + slope*(x - x0) + 0.4*nn(x, y)}
    wd[#wd+1] = (0.9 + 1.8*t) * (0.6 + 0.8*nn:at01(x, y*3))
  end
  local m = ribbon(pts, wd)
  -- bushes and small trees along it
  local nb = math.floor((x1 - x0)/22)
  for j=1,nb do
    local bx = rand(x0 + 4, x1 - 4)
    local by = y + slope*(bx - x0)
    local r = (1 + 2.2*t) * rand(0.7, 1.6)
    m = m + ellipse(bx, by - r*0.7, r*1.2, r)
  end
  m = m:roughen(0.5, 3, 90 + i)
  HEDGES = HEDGES and (HEDGES + m) or m
  local hp = pile{{"green earth", 1.2}, {"pale smalt", lerp(1.2, 0.4, t)}, {"raw umber", 0.4}, {"lead white", lerp(1.1, 0.3, t)}, {"Prussian blue", 0.03 + 0.05*t}, {"bone black", 0.03}, medium=0.12}
  work(m, {hand="detail", tool={kind="round", width=1 + t, point=0.5}, pile=hp, angle=0, coverage=2.5, fill=true, seed=5200+i})
end
-- sunlit tops of the hedges, from the left
local lit = mask(function(x, y) if HEDGES:at(x, y) < 0.5 then return 0 end; return (HEDGES:at(x - 1.2, y - 1.4) < 0.5) and 1 or 0 end)
local lp = pile{{"lead white", 1.4}, {"green earth", 1}, {"yellow ochre", 0.8}, {"chrome yellow", 0.1}, medium=0.1}
stipple(lit, {pile=lp, width=1, coverage=1, cluster=0.4, clip=true, seed=5210})
