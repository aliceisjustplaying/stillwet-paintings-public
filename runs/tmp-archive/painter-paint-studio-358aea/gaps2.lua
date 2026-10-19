local skyC  = pile{{"lead white",5},{"yellow ochre",0.22},{"pale smalt",0.15},{"raw umber",0.05}, medium=0.08}
local riseC = pile{{"lead white",1.8},{"green earth",1.9},{"yellow ochre",0.7},{"pale smalt",0.75},{"raw umber",0.2}, medium=0.1}
for i,t in ipairs(PW) do
  local H, x0, y0 = t.H, t.x, t.y
  local hx, hy = x0 + t.lean*0.43*H, y0 - 0.43*H
  local halfw = 0.34*H
  local R = (PWGAP[i]:grow(2.5) * PWCRALL:grow(2.5)) - PWGAP[i]:shrink(1) - PWTR[i]:shrink(0.5) - MILL:grow(1.5)
  R = R * mask(function(x,y) return y > hy - 0.1*H and 1 or 0 end)
  -- keep only the rims below the crown: pixels whose upper neighbour 4 units up is gap or sky
  local sk = R - LAND
  local ld = R * LAND
  work(sk, {hand="detail", pile=skyC, tool={kind="round", width=1.0, point=0.3}, angle=0, length={3,8}, coverage=2.5, clip=true, fill=true, load=0.7})
  work(ld, {hand="detail", pile=riseC, tool={kind="round", width=1.0, point=0.3}, angle=0, length={3,8}, coverage=2.5, clip=true, fill=true, load=0.7})
end
print(wait(0))
