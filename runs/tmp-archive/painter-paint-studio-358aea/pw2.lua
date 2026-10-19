local rodP = pile{{"raw umber",1},{"green earth",0.8},{"bone black",0.15},{"lead white",0.6},{"yellow ochre",0.3}, medium=0.08}
PWCR = {}
PWRODS = {}
for i,t in ipairs(PW) do
  local H, x0, y0 = t.H, t.x, t.y
  local hx, hy = x0 + t.lean*0.43*H, y0 - 0.43*H
  local rods = {}
  local n = math.floor(22 + H*0.08)
  local crown = nil
  local rb = brush{kind="rigger", width=math.max(0.6, H*0.007), point=1}
  rb:load(rodP, 0.6)
  for k=1,n do
    local a = -math.pi/2 + randn(0, 0.5) + t.lean*0.5
    a = clamp(a, -math.pi/2 - 1.25, -math.pi/2 + 1.25)
    local L = H*rand(0.3, 0.58) * (1 - 0.25*math.abs(a + math.pi/2))
    local sx, sy = hx + rand(-0.07,0.07)*H, hy + rand(-0.01, 0.02)*H
    local bend = rand(-0.12, 0.12)
    local pts = {}
    for j=0,4 do
      local f = j/4
      local aa = a + bend*f + (a + math.pi/2)*0.25*f
      pts[#pts+1] = {sx + math.cos(aa)*L*f, sy + math.sin(aa)*L*f}
    end
    rods[#rods+1] = pts
    rb:stroke(pts, {pressure={0.6,0.05}})
    if rb:fullness() < 0.3 then rb:reload(rodP, 0.6) end
    for j=2,5 do
      local p = pts[j]
      local r = H*rand(0.035, 0.07)*(0.6 + 0.12*j)
      local e = ellipse(p[1] + rand(-0.02,0.02)*H, p[2], r, r*0.8)
      crown = crown and (crown + e) or e
    end
  end
  crown = crown:roughen(math.max(1.2, H*0.012), math.max(4, H*0.035), 1400+i)
  PWCR[i] = crown
  PWRODS[i] = rods
end
print(wait(0))
