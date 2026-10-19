-- the oak's trunk: the dawn behind catches its right flank as a thin warm rim; bark plates on the lit side
local tr = oak:wood(7)
local rimm = tr * mask(function(x, y) return 1 - tr:at(x + 1.6, y) end) * above(function(x) return 436 + (x - 158) * 0.5 end)
work(rimm, {hand="hatch", tool="round 1", pal=barkpal, length={3, 8}, coverage=2, angle=1.55, angle_jitter=0.25,
  color="#54463e", clip=true})
local pb = brush{kind="round", width=1.1, point=0.6}
for i = 1, 40 do
  local x = rand(166, 196); local y = rand(340, 440)
  if tr:at(x, y) > 0.9 and tr:at(x + 3, y) > 0.5 then
    if i % 5 == 1 then pb:reload(mix("#3e3530", "#54483f", rand()), 0.6) end
    pb:stroke({{x, y}, {x + rand(-0.4, 0.4), y - rand(3, 7)}}, {pressure={0.35, 0.1}, ramps={0.2, 0.5}, clip=tr})
  end
end
-- snow over the trunk's straight lower edge on the right
local sb = brush{kind="filbert", width=2.2}
for i = 1, 22 do
  local x = rand(176, 202)
  local top = 438 + (x - 172) * 0.5 + rand(-1.5, 1)
  sb:reload(mix("#bec2c6", "#c8c9cc", rand()), 1.0)
  sb:stroke({{x - rand(2, 4), top + 1.5}, {x, top - 0.8}, {x + rand(2, 4), top + 1.2}}, {pressure={0.8, 0.6}, ramps={0.2, 0.3}, shake=0.3})
end
-- a thin stipple of snow over the bank to close the pinholes of warm ground
local bnk = bank - oak:mask():grow(2) - pathm:grow(1)
for _, f in ipairs(firs) do bnk = bnk - f:mask():grow(1.5) end
bnk = bnk - (coat + head + hat):grow(4) - ellipse(591, 598, 8, 6)
for _, c in ipairs(CLUMPS) do bnk = bnk - ellipse(c[1] + 3 * c[4], c[2] - 8 * c[4], 9 * c[4] + 4, 12 * c[4] + 4) end
stipple(bnk, {width=2.2, pal=snowpal, color=function(x, y) return sample(x, y, 3) end, coverage=0.9, pressure={0.4, 0.8},
  dips={18, 0.35, 0.7}, medium=0.4, cluster={0.2, 5}, feather=0.6})
