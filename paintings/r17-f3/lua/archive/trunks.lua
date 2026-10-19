local glz = pile{{"raw umber",1},{"green earth",0.7},{"bone black",0.15},{"pale smalt",0.2}, medium=0.6}
local glzL = pile{{"raw umber",0.6},{"green earth",0.4},{"yellow ochre",0.2}, medium=0.75}
local fis = pile{{"raw umber",1},{"bone black",0.5},{"green earth",0.4}, medium=0.1}
local ridge = pile{{"lead white",2.2},{"raw umber",0.5},{"yellow ochre",0.5},{"pale smalt",0.3},{"green earth",0.2}, medium=0.08}
local moss = pile{{"green earth",1.5},{"yellow ochre",0.8},{"raw umber",0.3},{"lead white",0.3}, medium=0.1}
for i,t in ipairs(PW) do
  local H, x0, y0 = t.H, t.x, t.y
  local m = PWTR[i]
  local function cx(yy) return x0 + t.lean*(y0-yy) end
  -- an overall light glaze to lower the value and warm it toward grey-olive
  work(m, {hand="detail", pile=glzL, tool={kind="filbert", width=math.max(2, H*0.03)}, angle=math.pi/2, length={6,20}, coverage=1.2, clip=true, load=0.35})
  -- deeper glaze on the shadow side (right)
  local sh = m * mask(function(xx,yy) return smoothstep(cx(yy) - 0.03*H, cx(yy) + 0.05*H, xx) end)
  work(sh, {hand="detail", pile=glz, tool={kind="filbert", width=math.max(2, H*0.025)}, angle=math.pi/2, length={6,18}, coverage=1.4, clip=true, load=0.4, threshold=0.2})
  -- fissures: wavering vertical dark lines
  local rb = brush{kind="rigger", width=math.max(0.5, H*0.005), point=1}
  rb:load(fis, 0.6)
  local nf = math.floor(6 + H*0.06)
  for k=1,nf do
    local u = rand(-0.07, 0.07)
    local v0 = rand(0.0, 0.3); local v1 = v0 + rand(0.05, 0.16)
    local pts = {}
    for j=0,4 do
      local v = lerp(v0, v1, j/4)
      local yy = y0 - v*H
      pts[#pts+1] = {cx(yy) + u*H*(1 + 0.3*math.sin(v*20)) + randn(0, 0.004*H), yy}
    end
    local inside = true
    for _,p in ipairs(pts) do if m:at(p[1], p[2]) < 0.5 then inside = false end end
    if inside then rb:stroke(pts, {pressure={0.2, 0.6}, ramps={0.3,0.3}, swell={0.6,1.2,0.7}}) end
    if rb:fullness() < 0.3 then rb:reload(fis, 0.6) end
  end
  -- lit ridges on the left
  rb:reload(ridge, 0.5)
  for k=1,math.floor(4 + H*0.03) do
    local u = rand(-0.075, -0.02)
    local v0 = rand(0.02, 0.3); local v1 = v0 + rand(0.04, 0.1)
    local pts = {}
    for j=0,3 do local v = lerp(v0, v1, j/3); local yy = y0 - v*H; pts[#pts+1] = {cx(yy) + u*H + randn(0, 0.003*H), yy} end
    local inside = true
    for _,p in ipairs(pts) do if m:at(p[1], p[2]) < 0.5 then inside = false end end
    if inside then rb:stroke(pts, {pressure={0.15, 0.4}, ramps={0.3,0.4}}) end
  end
  -- moss at the foot and up the shaded side
  local mm = m * mask(function(xx,yy) local v = (y0-yy)/H; return smoothstep(0.12, 0.02, v) * smoothstep(cx(yy) - 0.02*H, cx(yy) + 0.06*H, xx) end)
  stipple(mm, {pile=moss, width=math.max(1, H*0.012), coverage=0.8, pressure={0.4,0.7}, cluster=0.6, clip=m})
end
print(wait(0))
