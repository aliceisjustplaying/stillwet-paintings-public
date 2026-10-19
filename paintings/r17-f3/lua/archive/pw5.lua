-- darker, cooler trunks: a semi-opaque dark glaze on the shadow side and a mid tone on the body
local tShade = pile{{"raw umber",1},{"bone black",0.5},{"green earth",0.8},{"lead white",0.3},{"Prussian blue",0.08}, medium=0.08}
local tMid = pile{{"lead white",0.9},{"raw umber",0.8},{"green earth",0.7},{"pale smalt",0.4},{"bone black",0.2},{"yellow ochre",0.2}, medium=0.08}
local moss = pile{{"green earth",1.5},{"yellow ochre",0.8},{"lead white",0.6},{"raw umber",0.3}, medium=0.08}
for i,t in ipairs(PW) do
  local H, x0, y0 = t.H, t.x, t.y
  local m = PWTR[i] - PWCR[i]:shrink(H*0.02)
  local wbr = math.max(1.2, H*0.011)
  local body = m * mask(function(xx,yy) local cx = x0 + t.lean*(y0-yy); return smoothstep(cx - 0.035*H, cx - 0.015*H, xx) end)
  work(body, {hand="detail", pile=tMid, tool={kind="round", width=wbr, point=0.4}, angle=math.pi/2, length={3,12}, coverage=2.5, clip=true, fill=true, load=0.9})
  local sh = m * mask(function(xx,yy) local cx = x0 + t.lean*(y0-yy); return smoothstep(cx + 0.01*H, cx + 0.04*H, xx) end)
  work(sh, {hand="detail", pile=tShade, tool={kind="round", width=wbr, point=0.4}, angle=math.pi/2, length={3,12}, coverage=3, clip=true, fill=true, load=0.9})
  -- shadow under the crown on the head
  local hd = m * mask(function(xx,yy) return smoothstep(y0 - 0.37*H, y0 - 0.43*H, yy) end)
  work(hd, {hand="detail", pile=tShade, tool={kind="round", width=wbr, point=0.4}, angle=0, length={3,10}, coverage=2.5, clip=true, fill=true, load=0.8})
  -- moss on the north (shadow) side lower down
  local ms = m * mask(function(xx,yy) local cx = x0 + t.lean*(y0-yy); return smoothstep(cx + 0.02*H, cx + 0.05*H, xx) * smoothstep(y0 - 0.25*H, y0 - 0.1*H, yy) end)
  stipple(ms, {pile=moss, width=math.max(1, H*0.012), coverage=1.2, pressure={0.4,0.7}, cluster=0.6, feather=0.5})
  -- vertical bark fissures
  local r = brush{kind="rigger", width=math.max(0.5, H*0.004), point=1}
  r:load(tShade, 0.6)
  for k=1, math.floor(4 + H*0.04) do
    local u = rand(-0.05, 0.04)
    local v0 = rand(0.02, 0.2); local v1 = v0 + rand(0.06, 0.18)
    local p0 = {x0 + u*H + t.lean*v0*H, y0 - v0*H}
    local p1 = {x0 + (u + rand(-0.008,0.008))*H + t.lean*v1*H, y0 - v1*H}
    r:stroke({p0, p1}, {pressure={0.5,0.1}})
    if r:fullness() < 0.3 then r:reload(tShade, 0.6) end
  end
end
print(wait(0))
