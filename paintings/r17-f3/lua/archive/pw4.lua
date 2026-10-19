local barkD = pile{{"raw umber",1},{"bone black",0.4},{"green earth",0.6},{"lead white",0.5},{"pale smalt",0.2}, medium=0.06}
local barkM = pile{{"lead white",1.4},{"raw umber",0.6},{"green earth",0.6},{"pale smalt",0.45},{"bone black",0.12},{"yellow ochre",0.25}, medium=0.06}
local barkL = pile{{"lead white",2.8},{"raw umber",0.35},{"yellow ochre",0.45},{"pale smalt",0.35},{"green earth",0.2}, medium=0.06}
for i,t in ipairs(PW) do
  local H, x0, y0 = t.H, t.x, t.y
  local m = PWTR[i] - PWCR[i]:shrink(H*0.02)
  local wbr = math.max(1.2, H*0.011)
  work(m, {hand="detail", pile=barkM, tool={kind="round", width=wbr, point=0.4}, angle=math.pi/2, length={3,12}, coverage=3.5, clip=true, fill=true, edge="found", load=1.0})
  local sh = m * mask(function(xx,yy) local cx = x0 + t.lean*(y0-yy); return smoothstep(cx + 0.0*H, cx + 0.045*H, xx) end)
  work(sh, {hand="detail", pile=barkD, tool={kind="round", width=wbr, point=0.4}, angle=math.pi/2, length={3,12}, coverage=2.5, clip=true, fill=true, load=0.9})
  local lit = m * mask(function(xx,yy) local cx = x0 + t.lean*(y0-yy); return smoothstep(cx - 0.025*H, cx - 0.06*H, xx) end)
  work(lit, {hand="detail", pile=barkL, tool={kind="round", width=wbr*0.8, point=0.4}, angle=math.pi/2, length={3,10}, coverage=1.6, clip=true, load=0.9})
end
print(wait(0))
