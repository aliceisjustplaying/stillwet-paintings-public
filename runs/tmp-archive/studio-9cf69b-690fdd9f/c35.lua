barkLight = pile{{"raw umber",1},{"bone black",0.4},{"lead white",1.6},{"pale smalt",0.6}, medium=0.1}
local r = brush{kind="round", width=2.5, point=1, stiffness=0.6}
-- trunk spans roughly x 168..214 (base) to 176..212 at the fork; y 440..330
local function halfw(y) return lerp(24, 20, (440 - y) / 110) end
local function cx(y) return lerp(190, 196, (440 - y) / 110) end
r:load(chamber, 0.7)
for i = 1, 26 do
  local u = rand(-0.85, 0.85)
  local y0 = rand(335, 430); local L = rand(18, 50)
  local pts = {}
  for k = 0, 4 do
    local y = y0 - L * k / 4
    if y < 332 then break end
    pts[#pts+1] = {cx(y) + u * halfw(y) + randn(0, 0.8), y}
  end
  if #pts >= 2 then r:stroke(pts, {pressure={rand(0.35,0.6), 0.05}, ramps={0.2,0.4}}) end
  if i % 6 == 0 then r:load(chamber, 0.7) end
end
-- ridges catching the cool sky light, mostly on the left flank
r:load(barkLight, 0.6)
for i = 1, 22 do
  local u = rand(-0.95, -0.3)
  if i % 4 == 0 then u = rand(0.5, 0.92) end
  local y0 = rand(340, 432); local L = rand(10, 30)
  local pts = {}
  for k = 0, 3 do
    local y = y0 - L * k / 3
    pts[#pts+1] = {cx(y) + u * halfw(y) + randn(0, 0.6), y}
  end
  r:stroke(pts, {pressure={rand(0.25,0.45), 0.03}, ramps={0.3,0.4}})
  if i % 6 == 0 then r:load(barkLight, 0.6) end
end
-- a burr and an old wound on the bole
local burr = ellipse(204, 372, 6, 5):roughen(0.7, 3, 61)
work(burr, {hand="detail", pile=chamber, coverage=3, pressure={0.4,0.7}, load=0.8, fill=true})
r:load(barkLight, 0.5)
r:stroke({{199,368},{203,366},{208,368}}, {pressure={0.3,0.05}})
