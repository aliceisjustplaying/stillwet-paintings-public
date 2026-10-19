local lfD = pile{{"green earth",1.7},{"raw umber",0.6},{"Prussian blue",0.22},{"yellow ochre",0.6},{"lead white",0.5}, medium=0.08}
local lfM = pile{{"lead white",1.3},{"green earth",1.8},{"yellow ochre",0.8},{"pale smalt",0.5},{"raw umber",0.2}, medium=0.08}
local lfS = pile{{"lead white",2.8},{"green earth",1.3},{"pale smalt",0.6},{"yellow ochre",0.6}, medium=0.08}
ENV = {}
for i,w in ipairs(WL) do
  local x, y, s = w[1], w[2], w[3]
  local hy = y - 32*s
  local cy = hy + 2*s
  local env = CROWN2[i]:grow(3*s) * mask(function(xx,yy) local a = math.atan(yy - cy, xx - x) + math.pi/2; return (math.abs(a) < 1.35 and yy < hy + 1*s) and 1 or 0 end)
  env = env:roughen(math.max(1.5, 4*s), math.max(5, 9*s), 800+i)
  ENV[i] = env
  local wid = math.max(1.1, 2.6*s)
  local core = env:shrink(3*s)
  stipple(core, {pile=lfD, width=wid, coverage=2.0, pressure={0.55,0.85}, cluster={0.5, 5*s+2}, dips={10,0.8,0.4}})
  local midm = env * mask(function(xx,yy) local d = (yy - (hy - 40*s))/(40*s) - (xx - x)/(80*s); return 1 - smoothstep(-0.2, 0.9, d) end)
  stipple(midm, {pile=lfM, width=wid, coverage=function(xx,yy) return 2.2*midm:at(xx,yy) end, pressure={0.5,0.85}, cluster={0.7, 5*s+2}, feather=0.6, dips={8,0.7,0.4}})
  local litm = env * mask(function(xx,yy) local dx, dy = (xx - x + 12*s)/(28*s), (yy - hy + 52*s)/(24*s); return 1 - smoothstep(0.2, 1.1, math.sqrt(dx*dx+dy*dy)) end)
  stipple(litm, {pile=lfS, width=wid*0.85, coverage=function(xx,yy) return 1.8*litm:at(xx,yy) end, pressure={0.5,0.8}, cluster={0.75, 4*s+2}, feather=0.7, dips={6,0.6,0.4}})
end
print(wait(0))
