local gD = pile{{"green earth",1.4},{"Prussian blue",0.3},{"raw umber",0.6},{"yellow ochre",0.4},{"lead white",0.3}, medium=0.08}
local gM = pile{{"green earth",1.4},{"yellow ochre",1.1},{"Prussian blue",0.15},{"raw umber",0.3},{"lead white",0.7}, medium=0.08}
local nz = noise{seed=7301, period=18, octaves=3}
local band = mask(function(x,y)
  if y < 566 then return 0 end
  local sc = 0.35 + (y-560)/110
  local w = sc * (3 + 9 * math.max(0, nz(x,y) + 0.25))
  return w end)
-- inside distance from the path edge
local d = PATHX:distance()
local enc = PATHX * mask(function(x,y) local sc = 0.35 + (y-560)/110; local w = sc*(2 + 10*math.max(0, nz(x,y)+0.2)); return (d:at(x,y) < w and y > 568) and 1 or 0 end)
enc = enc:roughen(1.2, 5, 7302)
local up = enc * mask(function(x,y) return y < 628 and 1 or 0 end)
local lo = enc * mask(function(x,y) return y >= 628 and 1 or 0 end)
work(up, {hand="hatch", pile=gM, tool={kind="round", width=1.3, point=0.8}, angle=-math.pi/2, angle_jitter=0.35, length={4,9}, coverage=1.6, pressure={0.35,0.7}, ramps={0.1,0.7}, load=0.6})
work(lo, {hand="hatch", pile=gD, tool={kind="round", width=1.8, point=0.8}, angle=-math.pi/2, angle_jitter=0.35, length={6,14}, coverage=1.6, pressure={0.35,0.7}, ramps={0.1,0.7}, load=0.6})
print(enc:area(), wait(0))
