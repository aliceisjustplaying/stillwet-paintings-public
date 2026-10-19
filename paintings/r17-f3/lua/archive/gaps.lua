local skyC  = pile{{"lead white",5},{"yellow ochre",0.22},{"pale smalt",0.15},{"raw umber",0.05}, medium=0.08}
local riseC = pile{{"lead white",1.8},{"green earth",1.9},{"yellow ochre",0.7},{"pale smalt",0.75},{"raw umber",0.2}, medium=0.1}
PWGAP = {}
for i,t in ipairs(PW) do
  local H, x0, y0 = t.H, t.x, t.y
  local hx, hy = x0 + t.lean*0.43*H, y0 - 0.43*H
  local nz = noise{seed=7400+i, period=math.max(6, H*0.06), octaves=2}
  local halfw = 0.34*H
  local curve = function(x)
    local u = (x - hx)/halfw
    if math.abs(u) >= 1 then return hy + 0.08*H end
    return hy + 0.03*H - 0.14*H*(1 - u*u) + 0.025*H*nz(x, hy)
  end
  local G = PWCRALL * below(curve) * rect(hx - halfw, hy - 0.2*H, 2*halfw, 0.3*H) - PWTR[i]:shrink(0.5) - MILL:grow(1.5)
  G = G:roughen(math.max(0.8, H*0.006), math.max(3, H*0.02), 7410+i)
  PWGAP[i] = G
  local sk = G - LAND
  local ld = G * LAND
  work(sk, {hand="detail", pile=skyC, tool={kind="round", width=math.max(1.2,H*0.012), point=0.3}, angle=0, length={3,10}, coverage=3, clip=true, fill=true, load=0.8})
  work(ld, {hand="detail", pile=riseC, tool={kind="round", width=math.max(1.2,H*0.012), point=0.3}, angle=0, length={3,10}, coverage=3, clip=true, fill=true, load=0.8})
end
print(wait(0))
