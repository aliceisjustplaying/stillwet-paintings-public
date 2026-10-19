local lD = pile{{"green earth",1.7},{"raw umber",0.55},{"Prussian blue",0.2},{"yellow ochre",0.5},{"lead white",0.6}, medium=0.08}
local lM = pile{{"lead white",1.5},{"green earth",1.8},{"yellow ochre",0.6},{"pale smalt",0.6},{"raw umber",0.2}, medium=0.08}
local lS = pile{{"lead white",3.2},{"green earth",1.2},{"pale smalt",0.7},{"yellow ochre",0.4}, medium=0.08}
for i,t in ipairs(PW) do
  local H, x0, y0 = t.H, t.x, t.y
  local hx, hy = x0 + t.lean*0.43*H, y0 - 0.43*H
  local cr = PWCR[i]
  local wid = math.max(1.4, H*0.022)
  -- darker underside & core
  stipple(cr, {pile=lD, width=wid, coverage=function(xx,yy) local v = (hy - yy)/(0.55*H); return 1.6 - 0.9*smoothstep(0.2, 0.9, v) end, pressure={0.5,0.85}, cluster={0.7, H*0.04}, dips={10,0.7,0.4}})
  -- middle grey-green
  stipple(cr, {pile=lM, width=wid, coverage=function(xx,yy) local v = (hy - yy)/(0.55*H); return 0.4 + 1.2*smoothstep(0.1, 0.7, v) end, pressure={0.5,0.85}, cluster={0.75, H*0.035}, feather=0.4, dips={8,0.7,0.4}})
  -- silver light from upper left
  local lit = cr * mask(function(xx,yy) local u = (xx - hx)/(0.5*H); local v = (hy - yy)/(0.55*H); return smoothstep(0.35, 0.95, v - 0.45*u) end)
  stipple(lit, {pile=lS, width=wid*0.85, coverage=function(xx,yy) return 1.6*lit:at(xx,yy) end, pressure={0.45,0.8}, cluster={0.8, H*0.03}, feather=0.7, dips={6,0.6,0.4}})
end
print(wait(0))
