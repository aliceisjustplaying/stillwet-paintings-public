local tD = pile{{"bone black",0.5},{"yellow ochre",0.5},{"green earth",0.8},{"lead white",0.8},{"pale smalt",0.3}, medium=0.08}
local tL = pile{{"lead white",2},{"yellow ochre",0.4},{"green earth",0.5},{"pale smalt",0.4},{"bone black",0.12}, medium=0.08}
for i,w in ipairs(WL) do
  local x, y, s = w[1], w[2], w[3]
  local t = TR2 * ellipse(x, y - 15*s, 12*s + 1, 20*s + 3)
  work(t, {hand="detail", pile=tD, tool={kind="round", width=math.max(0.8, 1.8*s), point=0.4}, angle=math.pi/2, length={2,8}, coverage=3.5, clip=true, fill=true, edge="found", load=1.0})
  local lit = t * mask(function(xx,yy) return smoothstep(x - 2*s, x - 5*s, xx) end)
  work(lit, {hand="detail", pile=tL, tool={kind="round", width=math.max(0.7, 1.1*s), point=0.4}, angle=math.pi/2, length={2,6}, coverage=1.3, clip=true, load=0.8})
end
print(wait(0))
