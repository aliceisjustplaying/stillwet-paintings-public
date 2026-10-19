local lD = pile{{"green earth",1.6},{"raw umber",0.7},{"Prussian blue",0.3},{"yellow ochre",0.45},{"lead white",0.35}, medium=0.07}
local lM = pile{{"lead white",1.0},{"green earth",1.8},{"yellow ochre",0.7},{"pale smalt",0.5},{"raw umber",0.3},{"Prussian blue",0.05}, medium=0.07}
local lS = pile{{"lead white",2.6},{"green earth",1.3},{"pale smalt",0.6},{"yellow ochre",0.55}, medium=0.07}
PWCR2 = {}
for i,t in ipairs(PW) do
  local H, x0, y0 = t.H, t.x, t.y
  local hx, hy = x0 + t.lean*0.43*H, y0 - 0.43*H
  -- a skirt of foliage hanging over the head of the trunk
  local skirt = (ellipse(hx, hy - 0.01*H, 0.14*H, 0.05*H) + ellipse(hx - 0.13*H, hy - 0.04*H, 0.08*H, 0.05*H) + ellipse(hx + 0.13*H, hy - 0.04*H, 0.08*H, 0.05*H)):roughen(math.max(1, H*0.01), math.max(4, H*0.03), 1600+i)
  local cr = PWCR[i] + skirt
  PWCR2[i] = cr
  local wid = math.max(1.3, H*0.02)
  -- dark underside and inner shadow, clustered
  local low = cr * mask(function(xx,yy) local v = (hy - yy)/(0.55*H); local u = (xx - hx)/(0.5*H); return 1 - smoothstep(0.15, 0.7, v - 0.3*u) end)
  stipple(low, {pile=lD, width=wid, coverage=function(xx,yy) return 2.4*low:at(xx,yy) end, pressure={0.55,0.9}, cluster={0.6, H*0.04}, dips={10,0.8,0.4}})
  -- mid clusters over the whole, sparser at top
  stipple(cr, {pile=lM, width=wid, coverage=function(xx,yy) local v = (hy - yy)/(0.55*H); return 0.9 * (0.4 + 0.6*smoothstep(0.1, 0.6, v)) end, pressure={0.5,0.85}, cluster={0.8, H*0.035}, feather=0.5, dips={8,0.7,0.4}})
  -- sparing silver on top-left clumps
  local lit = cr * mask(function(xx,yy) local u = (xx - hx)/(0.5*H); local v = (hy - yy)/(0.55*H); return smoothstep(0.5, 1.05, v - 0.5*u) end)
  stipple(lit, {pile=lS, width=wid*0.8, coverage=function(xx,yy) return 1.2*lit:at(xx,yy) end, pressure={0.45,0.8}, cluster={0.85, H*0.025}, feather=0.7, dips={6,0.6,0.4}})
end
print(wait(0))
