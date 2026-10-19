-- hanging clump and strip
local hc = foliM:grow(3) * rect(120, 410, 80, 60) - oakM2
stipple(hc, {pile=foliMidP, width=2.0, coverage=0.9, cluster={0.5, 4}, pressure={0.35, 0.7}, feather=0, seed=1401})
stipple(hc * rect(120, 410, 80, 26), {pile=foliLight, width=1.8, coverage=0.7, cluster={0.5, 4}, pressure={0.3, 0.6}, feather=0, seed=1402})
stipple(hc * rect(120, 436, 80, 40), {pile=foliLight, width=1.6, coverage=0.2, cluster={0.5, 4}, pressure={0.3, 0.55}, feather=0, seed=1403})
-- riverside shrubs along riverC's near bank
shrubP = pile{{"green earth", 2}, {"raw umber", 1.3}, {"lead white", 0.9}, {"smalt", 0.5}, medium=0.1}
shrubL = pile{{"green earth", 1.6}, {"lead white", 1.4}, {"yellow ochre", 0.6}, {"smalt", 0.3}, {"raw umber", 0.5}, medium=0.1}
local sm = nil
local x = 112
while x < 212 do
  local w = rand(4, 9); local h = rand(2.2, 4.2)
  local e = ellipse(x, 456.5 - h*0.4, w*0.6, h)
  sm = sm and (sm + e) or e
  x = x + w * rand(0.6, 1.1)
end
sm = sm:roughen(0.6, 2.5, 1404) - oakM2 - foliM
stipple(sm, {pile=shrubP, width=1.4, coverage=2.4, cluster={0.5, 3}, pressure={0.35, 0.7}, feather=0, seed=1405})
stipple(sm * rect(0, 440, 1000, 14), {pile=shrubL, width=1.2, coverage=0.5, cluster={0.5, 3}, pressure={0.3, 0.55}, feather=0, seed=1406})
-- dark unifying glaze over the lowest foreground
fgGlaze = pile{{"raw umber", 1.5}, {"bone black", 0.5}, {"green earth", 0.6}, {"Prussian blue", 0.08}, medium=0.75}
local fz = (bankM2 * rect(0, 628, 1000, 90)) - boulderM:grow(1) - figM
work(fz, {hand="glaze", pile=fgGlaze, angle=-0.05, coverage=1.0, clip=true, load_at=function(x, y) return clamp((y - 628) / 60, 0, 1) * 0.7 end})
