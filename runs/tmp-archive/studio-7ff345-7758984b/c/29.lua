-- fill the spruces into dense masses whose edges are the drooping tiers
local m = nil
for _, t in ipairs(sprTiers) do
  local p = t.pts
  local s = t.s
  local d = (p[1][2] - (s.base - s.h)) / s.h
  local th = 2.5 + 6 * d
  local x0, y0 = p[1][1], p[1][2]
  local tip = p[4]
  local w = poly({{x0, y0 - 1.5}, {p[2][1], p[2][2] - 1.2}, {p[3][1], p[3][2] - 0.6}, {tip[1], tip[2]},
                 {p[3][1] - t.side * 1.5, p[3][2] + th * 0.5}, {p[2][1], p[2][2] + th * 0.9}, {x0, y0 + th}})
  m = m and (m + w) or w
end
sprMask = m:roughen(0.7, 3, 5)
work(sprMask, {hand="detail", pile=spruceP, load=1, pressure={0.6, 0.9}, coverage=3.5, fill=true,
   angle=function(x, y) return 0.4 end, angle_jitter=0.6})
