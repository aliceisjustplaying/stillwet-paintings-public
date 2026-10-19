local ridge = pile{{"lead white",2.4},{"raw umber",0.45},{"pale smalt",0.35},{"yellow ochre",0.3},{"green earth",0.15}, medium=0.08}
local fis = pile{{"raw umber",1},{"bone black",0.55},{"green earth",0.3}, medium=0.1}
local tuft = pile{{"green earth",1.3},{"yellow ochre",1.1},{"Prussian blue",0.22},{"raw umber",0.4},{"lead white",0.5}, medium=0.08}
local tuftL = pile{{"yellow ochre",1.4},{"chrome yellow",0.4},{"green earth",0.8},{"lead white",1.2},{"Prussian blue",0.08}, medium=0.08}
for i,t in ipairs(PW) do
  local H, x0, y0 = t.H, t.x, t.y
  local function cx(yy) return x0 + t.lean*(y0-yy) end
  local m = PWTR[i]
  local rb = brush{kind="rigger", width=math.max(0.5, H*0.006), point=1}
  rb:load(ridge, 0.5)
  for k=1,math.floor(5 + H*0.04) do
    local u = rand(-0.075, -0.03)
    local v0 = rand(0.02, 0.33); local v1 = v0 + rand(0.04, 0.1)
    local pts = {}
    for j=0,3 do local v = lerp(v0, v1, j/3); local yy = y0 - v*H; pts[#pts+1] = {cx(yy) + u*H + 0.004*H*math.sin(v*30+k), yy} end
    local ok = true
    for _,p in ipairs(pts) do if m:at(p[1], p[2]) < 0.6 then ok = false end end
    if ok then rb:stroke(pts, {pressure={0.15, 0.45}, ramps={0.3,0.4}}) end
    if rb:fullness() < 0.3 then rb:reload(ridge, 0.5) end
  end
  rb:reload(fis, 0.6)
  for k=1,math.floor(4 + H*0.04) do
    local u = rand(-0.02, 0.07)
    local v0 = rand(0.0, 0.33); local v1 = v0 + rand(0.05, 0.12)
    local pts = {}
    for j=0,4 do local v = lerp(v0, v1, j/4); local yy = y0 - v*H; pts[#pts+1] = {cx(yy) + u*H + 0.005*H*math.sin(v*33+k), yy} end
    local ok = true
    for _,p in ipairs(pts) do if m:at(p[1], p[2]) < 0.6 then ok = false end end
    if ok then rb:stroke(pts, {pressure={0.2, 0.55}, ramps={0.3,0.3}, swell={0.6,1.2,0.7}}) end
    if rb:fullness() < 0.3 then rb:reload(fis, 0.6) end
  end
  -- grass tufts over the trunk's foot
  local s = H/200
  local g = brush{kind="rigger", width=math.max(0.6, 1.3*s), point=1}
  for pass=1,2 do
    g:reload(pass == 1 and tuft or tuftL, 0.6)
    for k=1, (pass == 1 and 30 or 12) do
      local x = x0 + rand(-0.12, 0.12)*H
      local yb = y0 + rand(-1, 3)*s
      local h = rand(4, 12)*s
      local lean = randn(0, 0.35)
      g:stroke({{x, yb}, {x + lean*h*0.5, yb - h*0.5}, {x + lean*h, yb - h}}, {pressure={0.55, 0.0}})
      if g:fullness() < 0.3 then g:reload(pass == 1 and tuft or tuftL, 0.6) end
    end
  end
end
print(wait(0))
