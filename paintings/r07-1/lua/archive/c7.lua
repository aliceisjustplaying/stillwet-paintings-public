-- the second sky: a thin stipple, each touch from the pile for its band, dirtied with what's there
local wob = noise{seed=47, period=240}
local P = {SKY.top, mix(SKY.top, SKY.upper, 0.5), SKY.upper, mix(SKY.upper, SKY.mid, 0.5), SKY.mid, mix(SKY.mid, SKY.low, 0.5), SKY.low, mix(SKY.low, SKY.glow, 0.5), SKY.glow}
local Y = {-40, 95, 150, 220, 272, 322, 360, 398, 424, 480}
local function edge(i, x, y)   -- 0 above the join i, 1 below it
  if i <= 1 then return 1 end
  if i >= 10 then return 0 end
  local j = Y[i] + 15 * wob(x + 700 * i, 0) + 5 * wob(x * 3.1, 40 * i)
  return smoothstep(j - 5, j + 5, y)
end
SKYB = {}
for i = 1, 9 do
  local c = color(P[i])
  SKYB[i] = {m = mask(function(x, y) return edge(i, x, y) * (1 - edge(i + 1, x, y)) end) * skyM,
    over = function(x, y, under) return shift(mix(under, c, 0.15), 0.012, 0, 0) end}
end
function stband(i)
  local b = SKYB[i]
  stipple(b.m, {width=3.2, coverage=1.7, pressure={0.4, 0.8}, dips={40, 0.45, 0.7}, medium=0.62, pal=skypal, color_over=b.over})
  local t = timesheet(); print(string.format("band %d: sitting %.0f min, %d touches", i, t.sitting, t.touches))
end
rest(2); sitting{hours=8}
stband(1); stband(2)
