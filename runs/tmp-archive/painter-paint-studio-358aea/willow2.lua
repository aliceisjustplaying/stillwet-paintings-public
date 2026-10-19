wDark = pile{{"green earth",1.5},{"raw umber",0.8},{"Prussian blue",0.3},{"yellow ochre",0.5},{"lead white",0.5}, medium=0.1}
wMid  = pile{{"lead white",1.5},{"green earth",1.6},{"pale smalt",0.6},{"yellow ochre",0.6},{"raw umber",0.3}, medium=0.1}
wLit  = pile{{"lead white",3.5},{"green earth",1.2},{"pale smalt",0.5},{"yellow ochre",0.8},{"chrome yellow",0.1}, medium=0.1}
CROWNS = {}
for i,w in ipairs(WL) do
  local x, y, s = w[1], w[2], w[3]
  local hy = y - 32*s
  local cm = ellipse(x, hy-26*s, 34*s, 27*s) + ellipse(x-18*s, hy-12*s, 20*s, 14*s) + ellipse(x+19*s, hy-13*s, 19*s, 14*s) + ellipse(x+3*s, hy-40*s, 22*s, 16*s)
  cm = cm * above(function(xx) return hy + 2*s end)
  cm = cm:roughen(math.max(1.5, 5*s), math.max(6, 14*s), 100+i)
  CROWNS[i] = cm
  local wid = math.max(1.2, 3.2*s)
  stipple(cm, {pile=wDark, width=wid, coverage=2.2, pressure={0.5,0.8}, cluster=0.3, dips={16,0.7,0.4}})
  work(cm, {hand="hatch", pile=wMid, tool={kind="rigger", width=math.max(0.6,1.1*s), point=1}, clip=true,
    angle=function(xx,yy) return math.atan(yy - (hy+4*s), xx - x) end, angle_jitter=0.12, length={8*s+2, 26*s+3}, coverage=0.9, pressure={0.3,0.6}, ramps={0.1,0.7}})
  local lit = cm * mask(function(xx,yy) local dx, dy = (xx - x + 14*s)/(30*s), (yy - hy + 44*s)/(30*s); return 1 - smoothstep(0.5, 1.1, math.sqrt(dx*dx+dy*dy)) end)
  stipple(lit, {pile=wLit, width=wid*0.9, coverage=1.6, pressure={0.45,0.75}, cluster=0.5, feather=0.6, dips={10,0.6,0.4}})
end
print(wait(0))
