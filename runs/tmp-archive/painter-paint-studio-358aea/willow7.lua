local rodG = pile{{"lead white",1.2},{"green earth",1.8},{"yellow ochre",0.7},{"pale smalt",0.4},{"raw umber",0.3}, medium=0.08}
local rodS = pile{{"lead white",2.6},{"green earth",1.3},{"pale smalt",0.6},{"yellow ochre",0.5}, medium=0.08}
local rodD = pile{{"green earth",1.6},{"raw umber",0.8},{"Prussian blue",0.3},{"yellow ochre",0.4},{"lead white",0.3}, medium=0.08}
for i,w in ipairs(WL) do
  local x, y, s = w[1], w[2], w[3]
  local hy = y - 32*s
  local cx, cy = x, hy + 2*s
  local fan = CROWN2[i]:grow(7*s) * mask(function(xx,yy) return yy < hy - 6*s and 1 or 0 end)
  fan = fan * mask(function(xx,yy) local a = math.atan(yy - cy, xx - cx) + math.pi/2; return math.abs(a) < 1.25 and 1 or 0 end)
  local ang = function(xx,yy) return math.atan(yy - cy, xx - cx) end
  local rw = math.max(0.45, 0.9*s)
  -- dark rods inside first, then green, then silver ones at top edge
  work(CROWN2[i]:shrink(3*s), {hand="hatch", pile=rodD, tool={kind="rigger", width=rw, point=1}, clip=CROWN2[i], angle=ang, angle_jitter=0.12, length={10*s+2, 24*s+3}, coverage=0.5, pressure={0.35,0.7}, ramps={0.05,0.8}, seed=500+i})
  work(fan, {hand="hatch", pile=rodG, tool={kind="rigger", width=rw, point=1}, angle=ang, angle_jitter=0.1, length={12*s+2, 26*s+3}, coverage=0.6, pressure={0.35,0.7}, ramps={0.05,0.8}, seed=600+i})
  local top = fan * mask(function(xx,yy) return smoothstep(hy - 30*s, hy - 55*s, yy) end)
  work(top, {hand="hatch", pile=rodS, tool={kind="rigger", width=rw, point=1}, angle=ang, angle_jitter=0.1, length={8*s+2, 18*s+3}, coverage=0.6, pressure={0.35,0.65}, ramps={0.05,0.8}, seed=700+i, threshold=0.4})
end
print(wait(0))
