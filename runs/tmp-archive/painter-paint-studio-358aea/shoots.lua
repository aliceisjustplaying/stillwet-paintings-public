local shootD = pile{{"green earth",1.4},{"raw umber",0.6},{"Prussian blue",0.15},{"yellow ochre",0.5},{"lead white",0.6}, medium=0.07}
local shootL = pile{{"lead white",2.2},{"green earth",1.3},{"pale smalt",0.4},{"yellow ochre",0.7}, medium=0.07}
local leafT = pile{{"lead white",1.4},{"green earth",1.6},{"yellow ochre",0.7},{"pale smalt",0.4},{"raw umber",0.15}, medium=0.07}
for i,t in ipairs(PW) do
  local H, x0, y0 = t.H, t.x, t.y
  local hx, hy = x0 + t.lean*0.43*H, y0 - 0.43*H
  local cr = PWCR2[i]
  local rb = brush{kind="rigger", width=math.max(0.5, H*0.005), point=1}
  local sb = brush{kind="round", width=math.max(1.0, H*0.01), point=0.6}
  rb:load(shootD, 0.6); sb:load(leafT, 0.5)
  local n = math.floor(8 + H*0.05)
  for k=1,n do
    local ang = -math.pi/2 + randn(0, 0.35)
    local rr = 0.2*H
    -- start inside the crown near its upper edge along this direction
    local sx, sy = hx, hy
    local dist = 0
    for d = 0, 0.9*H, 1.5 do
      local px, py = hx + math.cos(ang)*d, hy + math.sin(ang)*d
      if cr:at(px, py) > 0.5 then dist = d end
    end
    local d0 = dist - rand(0.02, 0.06)*H
    sx, sy = hx + math.cos(ang)*d0, hy + math.sin(ang)*d0
    local L = rand(0.06, 0.16)*H
    local ex, ey = sx + math.cos(ang)*L, sy + math.sin(ang)*L
    local mx, my = (sx+ex)/2 + rand(-0.01,0.01)*H, (sy+ey)/2
    rb:stroke({{sx,sy},{mx,my},{ex,ey}}, {pressure={0.55,0.0}})
    if rb:fullness() < 0.3 then rb:reload(shootD, 0.6) end
    -- leaves along the shoot: small dragged touches
    local p = (math.cos(ang) < -0.05) and shootL or leafT
    sb:reload(p, 0.4)
    for j=1,4 do
      local f = 0.3 + 0.18*j
      local px, py = sx + (ex-sx)*f, sy + (ey-sy)*f
      local side = (j % 2 == 0) and 1 or -1
      sb:touch(px + side*H*0.008, py, {pressure=0.35, drag={H*0.01, ang + side*0.8}})
    end
  end
end
print(wait(0))
