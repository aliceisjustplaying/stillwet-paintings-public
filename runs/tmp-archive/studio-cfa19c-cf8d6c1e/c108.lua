local botP = {{350,490},{460,500},{560,516},{660,538},{760,560},{880,586},{1010,612}}
local top = below(function(x) return 462 + 0.014*x end)
local notFar = mask(function(x,y) return (x > 360 and y < interp(botP,x) + 1) and 0 or 1 end)
local excl = M1:grow(1) + riverM:grow(1) + riseM + oakM:grow(1) + oakSil:grow(1) + trunk2M:grow(1) + trunkM:grow(1) + figM + horsesM + ditchM:grow(1.2)
meadowM = (top * notFar) - excl
local mFar = pile{{"yellow ochre",2.4},{"Prussian blue",0.3},{"lead white",1.6},{"green earth",0.7}, medium=0.05}
local mMid = pile{{"yellow ochre",2.4},{"Prussian blue",0.38},{"lead white",1.2},{"green earth",0.6}, medium=0.05}
local mNear = pile{{"yellow ochre",2.3},{"Prussian blue",0.48},{"raw umber",0.3},{"lead white",0.8},{"green earth",0.5}, medium=0.05}
-- depth within the meadow: 0 at its far edge, 1 at the crest of the rise
local function depth(x,y)
  local t = (x > 360) and interp(botP,x) or (462 + 0.014*x)
  local b = riseY(math.max(-10, math.min(1010, x)))
  return clamp((y - t) / math.max(20, b - t), 0, 1)
end
work(meadowM * mask(function(x,y) return smoothstep(0.45, 0.2, depth(x,y)) end), {hand="body", tool="filbert 5", pile=mFar, angle=0.1, coverage=2.6, fill=true, pressure={0.4,0.65}, edge="found", seed=1081})
work(meadowM * mask(function(x,y) local d = depth(x,y); return smoothstep(0.2, 0.45, d) * smoothstep(0.8, 0.6, d) end), {hand="body", tool="filbert 6", pile=mMid, angle=0.12, coverage=2.6, fill=true, pressure={0.4,0.65}, edge="found", seed=1082})
work(meadowM * mask(function(x,y) return smoothstep(0.6, 0.8, depth(x,y)) end), {hand="body", tool="filbert 6", pile=mNear, angle=0.12, coverage=2.6, fill=true, pressure={0.4,0.65}, edge="found", seed=1083})
blend(meadowM:shrink(1.5), {tool={kind="badger", width=10}, angle=0.1, coverage=1.0, seed=1084})
