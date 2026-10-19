farland = pile{{"lead white", 5}, {"pale smalt", 2}, {"green earth", 1.5}, {"raw umber", 0.35}, {"yellow ochre", 0.3}, medium=0.1}
-- distant land strip with low tree clumps along its top
local pts = {{-10,452}}
local x = -10
local s = 0
while x < 1010 do
  local base = 436 + 2*math.sin(x/130) 
  local bump = 0
  local n = noise{seed=11, period=40, octaves=3}
  bump = math.max(0, n(x, 0)) * 9
  if x > 540 and x < 700 then bump = bump + 4 end
  if x > 780 and x < 900 then bump = bump + 6*math.max(0, math.sin((x-780)/40)) end
  pts[#pts+1] = {x, base - bump}
  x = x + 5
end
pts[#pts+1] = {1010,452}
farstrip = poly(pts):roughen(1.2, 8, 3)
work(farstrip, {hand="detail", pile=farland, angle=0, coverage=2.2, length={6,16}, pressure={0.5,0.8}, fill=true, edge="firm"})
print(wait(0))
