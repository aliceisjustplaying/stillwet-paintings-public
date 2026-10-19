local lM = pile{{"lead white",0.9},{"green earth",1.9},{"yellow ochre",0.75},{"pale smalt",0.45},{"raw umber",0.3},{"Prussian blue",0.06}, medium=0.07}
local lS = pile{{"lead white",2.2},{"green earth",1.4},{"pale smalt",0.5},{"yellow ochre",0.7},{"chrome yellow",0.05}, medium=0.07}
local lD = pile{{"green earth",1.6},{"raw umber",0.7},{"Prussian blue",0.3},{"yellow ochre",0.45},{"lead white",0.4}, medium=0.07}
for i,t in ipairs(PW) do
  local H, x0, y0 = t.H, t.x, t.y
  local hx, hy = x0 + t.lean*0.43*H, y0 - 0.43*H
  local cr = PWCR2[i]:shrink(math.max(0.8, H*0.006))
  local wid = math.max(1.3, H*0.018)
  local up = cr * mask(function(xx,yy) local v = (hy - yy)/(0.55*H); return smoothstep(0.35, 0.7, v) end)
  stipple(up, {pile=lM, width=wid, coverage=function(xx,yy) return 1.8*up:at(xx,yy) end, pressure={0.55,0.9}, cluster={0.6, H*0.03}, dips={10,0.8,0.4}})
  -- shadowed pockets between clumps
  local nz = worley{seed=1700+i, period=H*0.12}
  local pockets = up * mask(function(xx,yy) local c = nz:at(xx,yy); return 1 end)
  stipple(up, {pile=lD, width=wid*0.9, coverage=function(xx,yy) return 0.5*up:at(xx,yy) end, pressure={0.5,0.8}, cluster={0.85, H*0.02}, dips={6,0.7,0.4}})
  local lit = cr * mask(function(xx,yy) local u = (xx - hx)/(0.5*H); local v = (hy - yy)/(0.55*H); return smoothstep(0.55, 1.1, v - 0.5*u) end)
  stipple(lit, {pile=lS, width=wid*0.8, coverage=function(xx,yy) return 1.0*lit:at(xx,yy) end, pressure={0.45,0.8}, cluster={0.85, H*0.022}, feather=0.7, dips={6,0.6,0.4}})
end
print(wait(0))
