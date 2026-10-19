local starts = {{300,150,3.6},{130,112,3.0},{345,262,3.4},{62,236,2.6},{250,100,2.4}}
local m = nil
for _,st in ipairs(starts) do
  local best, bd, bw = nil, 1e9, 0
  for _,s in ipairs(oak.thick) do
    for i,p in ipairs(s.pts) do
      local d = (p[1]-st[1])^2 + (p[2]-st[2])^2
      -- prefer points below (closer to the trunk) and thicker than the start
      if p[2] > st[2] - 5 and s.ws[i] >= st[3] and d < bd and d > 16 then best, bd, bw = p, d, s.ws[i] end
    end
  end
  if best then
    local mx = (best[1]+st[1])/2 + randn(0,3); local my = (best[2]+st[2])/2 + randn(0,3)
    print(st[1],st[2],"<-",best[1],best[2], math.sqrt(bd))
    local r = ribbon({{best[1],best[2]},{mx,my},{st[1],st[2]}}, {math.min(bw, st[3]*1.4), st[3]*1.15, st[3]})
    m = m and (m + r) or r
  end
end
work(m, {hand="detail", pile=twigDark, coverage=3.5, pressure={0.6,0.9}, load=1, fill=true})
