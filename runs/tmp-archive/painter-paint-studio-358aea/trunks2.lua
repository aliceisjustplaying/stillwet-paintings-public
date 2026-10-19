local mid = pile{{"lead white",1},{"raw umber",0.9},{"green earth",0.45},{"pale smalt",0.3},{"bone black",0.12}, medium=0.08}
local dk  = pile{{"raw umber",1},{"bone black",0.3},{"green earth",0.5},{"lead white",0.35},{"pale smalt",0.15}, medium=0.08}
local lit = pile{{"lead white",2.4},{"raw umber",0.5},{"pale smalt",0.45},{"yellow ochre",0.25},{"green earth",0.2}, medium=0.08}
local fis = pile{{"raw umber",1},{"bone black",0.6},{"green earth",0.3}, medium=0.1}
for i,t in ipairs(PW) do
  local H, x0, y0 = t.H, t.x, t.y
  local m = PWTR[i]
  local function cx(yy) return x0 + t.lean*(y0-yy) end
  local wbr = math.max(1.2, H*0.012)
  work(m, {hand="detail", pile=mid, tool={kind="round", width=wbr, point=0.4}, angle=math.pi/2, angle_jitter=0.15, length={3,12}, coverage=2.2, clip=true, fill=true})
  local sh = m * mask(function(xx,yy) return smoothstep(cx(yy) + 0.0*H, cx(yy) + 0.05*H, xx) end)
  work(sh, {hand="detail", pile=dk, tool={kind="round", width=wbr, point=0.4}, angle=math.pi/2, angle_jitter=0.15, length={3,12}, coverage=1.8, clip=true, threshold=0.3})
  local lm = m * mask(function(xx,yy) return smoothstep(cx(yy) - 0.035*H, cx(yy) - 0.065*H, xx) end)
  work(lm, {hand="detail", pile=lit, tool={kind="round", width=wbr*0.8, point=0.4}, angle=math.pi/2, angle_jitter=0.15, length={3,10}, coverage=1.3, clip=true, threshold=0.3})
  local rb = brush{kind="rigger", width=math.max(0.5, H*0.005), point=1}
  rb:load(fis, 0.6)
  for k=1,math.floor(8 + H*0.08) do
    local u = rand(-0.06, 0.07)
    local v0 = rand(0.0, 0.36); local v1 = v0 + rand(0.05, 0.14)
    local pts = {}
    for j=0,4 do
      local v = lerp(v0, v1, j/4); local yy = y0 - v*H
      pts[#pts+1] = {cx(yy) + u*H + 0.006*H*math.sin(v*35 + k) + randn(0, 0.002*H), yy}
    end
    local inside = true
    for _,p in ipairs(pts) do if m:at(p[1], p[2]) < 0.6 then inside = false end end
    if inside then rb:stroke(pts, {pressure={0.2, 0.55}, ramps={0.3,0.3}, swell={0.6,1.2,0.7}}) end
    if rb:fullness() < 0.3 then rb:reload(fis, 0.6) end
  end
end
print(wait(0))
