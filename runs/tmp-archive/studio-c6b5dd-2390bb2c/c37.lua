local pts = {{455,452}}
local x = 455
local s = 0
while x < 1005 do
  s = s + 1
  local y = 446 + 3*math.sin(x/70) 
  if math.random() < 0.3 then y = y - rand(3, 9) end
  pts[#pts+1] = {x, y}
  x = x + rand(6, 16)
end
pts[#pts+1] = {1005, 452}
local topc = pts
farTrees = (below(topc) * above(function(x) return 459 + 1.5*math.sin(x/50) end)):roughen(1.5, 12, 61, 0)
pFar = pile{{"lead white",1},{"smalt",1},{"raw umber",1.5},{"green earth",0.6},{"red earth",0.2}}
work(farTrees, {hand="body", tool="filbert 4", pile=pFar, angle=0, angle_jitter=0.4, coverage=3, fill=true, length={8,25}, edge="firm", load=0.8})
