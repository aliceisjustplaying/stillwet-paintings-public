-- break the clean ellipse of the mere: snow tongues blown out onto the ice from both shores,
-- wind-streaks of snow on the ice, and the near rim broken with shadow
local tongues = nil
local xs = uneven(16, 420, 905, 0.7, 0.5, 81)
for i, x in ipairs(xs) do
  local near = (i % 3 ~= 0)
  local w = rand(6, 26)
  local d = rand(2.5, 8)
  local y0 = near and nearEdge(x) + 1.5 or mereFar(x) - 1
  local dir = near and -1 or 1
  local e = poly({{x - w, y0}, {x - w * 0.4, y0 + dir * d * rand(0.5, 1)}, {x + w * 0.1, y0 + dir * d}, {x + w * 0.6, y0 + dir * d * rand(0.3, 0.8)}, {x + w, y0}}, true)
  tongues = tongues and (tongues + e) or e
end
tonguesM = (tongues * merem:grow(1)):roughen(0.6, 3, 83)
work(tonguesM, {hand="detail", tool={kind="round", width=2, point=0.6}, pile=iceSnow, load=0.8, pressure={0.5, 0.75}, coverage=3, fill=true, clip=true, angle=0})
-- wind streaks: long thin drifts on the ice, lying with the wind from the left
local sm = nil
for i = 1, 14 do
  local x = rand(450, 880)
  local y = rand(553, 596)
  if merem:at(x, y) > 0.9 then
    local L = rand(15, 50)
    local r = ribbon({{x - L / 2, y + rand(-0.5, 0.5)}, {x, y}, {x + L / 2, y + rand(-0.8, 0.2)}}, {0.2, rand(0.6, 1.3), 0.2})
    sm = sm and (sm + r) or r
  end
end
streakM = (sm * merem):roughen(0.3, 2, 85)
work(streakM, {hand="detail", tool={kind="round", width=1.2, point=0.6}, pile=iceSnow, load=0.45, pressure={0.35, 0.55}, coverage=2, fill=true, clip=true, angle=0})
-- the rim: cool shadow in hollows along the near shore band
rimShade = pile{{"smalt",2},{"bone black",0.25},{"lead white",1.2},{"vermilion",0.05}, medium=0.6}
local rs = nil
for i = 1, 10 do
  local x = rand(430, 900)
  local y = nearEdge(x) + rand(3, 8)
  local e = ellipse(x, y, rand(10, 35), rand(2, 4))
  rs = rs and (rs + e) or e
end
rimShadeM = (rs - merem - pathM:grow(2)):roughen(1, 4, 87):soften(1)
work(rimShadeM, {hand="detail", tool={kind="round", width=3, point=0.4}, pile=rimShade, load=0.45, pressure={0.35, 0.55}, coverage=2, fill=true, clip=true, angle=0})
blend(rimShadeM:grow(2), {angle=0})
