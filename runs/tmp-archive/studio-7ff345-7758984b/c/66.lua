-- snow lying on the spruce tiers
sprSnow = pile{{"lead white",5},{"pale smalt",1.2},{"smalt",0.25},{"vermilion",0.03}, medium=0.12}
local m = nil
for _, t in ipairs(sprTiers) do
  if math.random() < 0.8 then
    local p = t.pts
    local s = t.s
    local d = (p[1][2] - (s.base - s.h)) / s.h
    local k = 0.8 + 1.6 * d
    local t0 = rand(0.1, 0.35)
    local pts, ws = {}, {}
    for j = 0, 6 do
      local u = lerp(t0, rand(0.85, 1.0), j / 6)
      local x = lerp(p[1][1], p[4][1], u)
      -- follow the droop of the tier
      local y = p[1][2] + (p[4][2] - p[1][2]) * (1 - (1 - u) ^ 1.6) - 1.6 - 0.5 * d
      pts[#pts+1] = {x, y}
      ws[#ws+1] = math.max(0.4, k * math.sin(math.pi * (j + 0.5) / 7) ^ 0.7 * rand(0.7, 1.2))
    end
    local r = ribbon(pts, ws)
    m = m and (m + r) or r
  end
end
sprSnowM = m:roughen(0.4, 2, 47)
work(sprSnowM, {hand="detail", tool={kind="round", width=1.2, point=0.8}, pile=sprSnow, load=0.9, pressure={0.5, 0.8}, coverage=3.5, fill=true, clip=true, angle=0})
