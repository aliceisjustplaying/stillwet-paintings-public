twigDark = pile{{"raw umber",2},{"bone black",1.2},{"lead white",0.45},{"pale smalt",0.3}, medium=0.1}
local b = brush{kind="round", width=2.5, point=1, stiffness=0.55}
b:load(twigDark, 0.7)
local cnt = 0
local function spurs(s, every)
  local pts, ws = s.pts, s.ws
  for i = 1, #pts-1 do
    local x0,y0 = pts[i][1], pts[i][2]
    local x1,y1 = pts[i+1][1], pts[i+1][2]
    local a = math.atan(y1-y0, x1-x0)
    local L = math.sqrt((x1-x0)^2 + (y1-y0)^2)
    local n = math.floor(L / every + math.random())
    for k = 1, n do
      local t = math.random()
      local x = lerp(x0,x1,t); local y = lerp(y0,y1,t)
      local w = lerp(ws[i], ws[i+1], t)
      local side = (math.random() < 0.5) and -1 or 1
      local sa = a + side * rand(0.5, 1.3)
      -- start at the branch edge
      x = x + math.cos(sa) * w * 0.4; y = y + math.sin(sa) * w * 0.4
      local l1 = rand(2.5, 6); local l2 = rand(2, 5)
      local mx, my = x + math.cos(sa)*l1, y + math.sin(sa)*l1
      local sa2 = sa + randn(0, 0.5)
      local ex, ey = mx + math.cos(sa2)*l2, my + math.sin(sa2)*l2
      local p0 = math.max(b:pressure_for(math.min(w*0.45, 1.6)), 0.2)
      b:stroke({{x,y},{mx,my},{ex,ey}}, {pressure={p0, 0.02}, ramps={0,0.5}})
      -- a small clustered fork at the tip, as oak buds bunch
      if math.random() < 0.45 then
        local sa3 = sa2 + (math.random()<0.5 and -1 or 1)*rand(0.4,0.9)
        b:stroke({{mx,my},{mx+math.cos(sa3)*l2*0.9, my+math.sin(sa3)*l2*0.9}}, {pressure={0.2,0.01}})
      end
      cnt = cnt + 1
      if cnt % 14 == 0 then b:load(twigDark, 0.6) end
    end
  end
end
for _,s in ipairs(oak.thick) do spurs(s, 9) end
for _,s in ipairs(oak.thin) do if s.ws[1] > 0.9 then spurs(s, 14) end end
print(cnt)
