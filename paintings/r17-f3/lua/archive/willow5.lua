wGreen = pile{{"green earth",2},{"yellow ochre",0.9},{"Prussian blue",0.12},{"raw umber",0.3},{"lead white",0.5}, medium=0.08}
for i,w in ipairs(WL) do
  local x, y, s = w[1], w[2], w[3]
  local hy = y - 32*s
  local m = CROWN2[i]:shrink(0.6*s)
  local wid = math.max(1.0, 2.6*s)
  stipple(m, {pile=wGreen, width=wid, coverage=function(xx,yy) local d = (yy - (hy - 50*s))/(50*s); return 1.6*(1 - 0.5*smoothstep(0.4,1,d)) end, pressure={0.55,0.85}, cluster={0.5, 5*s+2}, dips={10,0.8,0.4}})
end
print(wait(0))
