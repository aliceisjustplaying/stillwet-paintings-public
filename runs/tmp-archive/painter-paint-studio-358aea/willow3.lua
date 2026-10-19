wD2 = pile{{"green earth",1.6},{"raw umber",0.9},{"Prussian blue",0.35},{"yellow ochre",0.5},{"lead white",0.25}, medium=0.08}
wM2 = pile{{"lead white",1.0},{"green earth",1.6},{"pale smalt",0.4},{"yellow ochre",0.7},{"raw umber",0.35},{"Prussian blue",0.05}, medium=0.08}
wL2 = pile{{"lead white",2.6},{"green earth",1.2},{"pale smalt",0.3},{"yellow ochre",1.0},{"chrome yellow",0.15}, medium=0.08}
CROWN2 = {}
local leans = {0.08,-0.05,0.12,0.0,-0.1,0.06,0.02,-0.04,0.05,0}
local widths = {1.1,0.95,1.0,0.8,1.05,0.9,1.0,0.85,1.0,0.9}
for i,w in ipairs(WL) do
  local x, y, s = w[1], w[2], w[3]
  local hy = y - 32*s
  local lean, wf = leans[i], widths[i]
  local m = CROWNS[i]:grow(1.2*s)
  for k=1,7 do
    local a = -math.pi/2 + lean + rand(-1.3, 1.3)
    local r = rand(18, 34)*s
    local cx, cy = x + math.cos(a)*r*wf*1.1, hy - 8*s + math.sin(a)*r
    m = m + ellipse(cx, cy, rand(9,15)*s*wf, rand(7,12)*s)
  end
  m = m * above(function(xx) return hy + 3*s end)
  m = m:roughen(math.max(1.2, 4*s), math.max(5, 10*s), 300+i)
  CROWN2[i] = m
  local wid = math.max(1.1, 2.8*s)
  stipple(m, {pile=wD2, width=wid, coverage=3.2, pressure={0.6,0.9}, cluster=0.25, dips={12,0.8,0.4}})
  local cl = m * mask(function(xx,yy) local d = (yy - (hy - 30*s))/(30*s); return 0.2 + 0.8*(1-smoothstep(-0.2, 0.9, d)) end)
  stipple(cl, {pile=wM2, width=wid, coverage=function(xx,yy) return 1.6*cl:at(xx,yy) end, pressure={0.5,0.8}, cluster={0.7, 7*s+2}, feather=0.5, dips={10,0.7,0.4}})
  local lit = m * mask(function(xx,yy) local dx, dy = (xx - x + 12*s)/(28*s), (yy - hy + 42*s)/(26*s); return 1 - smoothstep(0.3, 1.0, math.sqrt(dx*dx+dy*dy)) end)
  stipple(lit, {pile=wL2, width=wid*0.85, coverage=function(xx,yy) return 1.5*lit:at(xx,yy) end, pressure={0.5,0.8}, cluster={0.7, 5*s+2}, feather=0.7, dips={8,0.6,0.4}})
end
print(wait(0))
