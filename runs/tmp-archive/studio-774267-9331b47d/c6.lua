-- low cumulus bank above the left horizon
local cm = ellipse(60, 372, 90, 22) + ellipse(150, 362, 70, 26) + ellipse(230, 370, 80, 20) + ellipse(320, 376, 70, 14) + ellipse(110, 350, 40, 16) + ellipse(185, 342, 36, 18) + ellipse(400, 380, 60, 9)
CLOUD1 = (cm:roughen(8, 40, 11) * SKY)
CLOUDBODY = pile{{"lead white", 6}, {"pale smalt", 1.6}, {"red earth", 0.12}, {"raw umber", 0.08}, {"vermilion", 0.02}, medium=0.2}
CLOUDLIT = pile{{"lead white", 9}, {"yellow ochre", 0.35}, {"vermilion", 0.06}, medium=0.2}
work(CLOUD1, {hand="body", tool="filbert 7", pile=CLOUDBODY, angle=0, angle_jitter=0.3, length={15,40}, coverage=2.2, fill=true, edge="soft", seed=401})
-- lit upper-left rims of the cloud heads (sun low on the left)
local lit = CLOUD1 - CLOUD1:offset(0):grow(0) -- placeholder so the var exists
local tops = (CLOUD1 - (cm:roughen(8,40,11)):shrink(0)) -- unused
local rimm = mask(function(x, y)
  local v = CLOUD1:at(x, y); if v < 0.5 then return 0 end
  local up = CLOUD1:at(x - 4, y - 7)
  return (up < 0.5) and 1 or 0 end)
work(rimm:grow(2), {hand="body", tool="filbert 5", pile=CLOUDLIT, angle=-0.2, angle_jitter=0.4, length={8,22}, coverage=2, fill=true, edge="soft", seed=402})
blend(CLOUD1:grow(6), {angle=0, length={20,60}, coverage=1.2, seed=403})
