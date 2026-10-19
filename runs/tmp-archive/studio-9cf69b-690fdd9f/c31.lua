local M = nil
sprTiers = {}
for _,s in ipairs(spruces) do
  local x0, yb, h = s[1], s[2], s[3]
  local top = yb - h
  local y = yb - 1
  while y > top + 2 do
    local t = (yb - y) / h
    local hw = h * 0.2 * (1 - t)^0.85 + 1.0
    local dy = rand(2.2, 3.4)
    local drop = hw * rand(0.3, 0.45)
    local p = poly({{x0, y - dy*1.2}, {x0 + hw*0.5, y - dy*0.3}, {x0 + hw, y + drop*0.5}, {x0 + hw*0.6, y + drop*0.25}, {x0, y + 1}, {x0 - hw*0.6, y + drop*0.25}, {x0 - hw, y + drop*0.5}, {x0 - hw*0.5, y - dy*0.3}})
    M = M and (M + p) or p
    sprTiers[#sprTiers+1] = {x0, y, hw, drop}
    y = y - dy
  end
  M = M + poly({{x0-0.8, top+3}, {x0, top - 2}, {x0+0.8, top+3}})
end
sprM = M:roughen(0.5, 2, 51)
work(sprM, {hand="detail", pile=sprP, coverage=3, pressure={0.5,0.8}, load=0.9, fill=true, angle=0.3, angle_jitter=0.8, length={2,5}})
