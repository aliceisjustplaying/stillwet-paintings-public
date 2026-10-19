-- wind-cleared ice: long dark patches between the pale drift streaks
darkIce = pile{{"smalt",2},{"bone black",0.4},{"red earth",0.1},{"lead white",0.6},{"Prussian blue",0.05}, medium=0.6}
local m = nil
local rows = {{556, 0.9}, {562, 1.0}, {569, 1.1}, {576, 1.2}, {583, 1.3}, {590, 1.3}}
for _, rw in ipairs(rows) do
  local x = rand(420, 470)
  while x < 900 do
    local rx = rand(25, 90) * rw[2]
    local ry = rand(1.6, 3.4) * rw[2]
    local e = ellipse(x + rx, rw[1] + rand(-2, 2), rx, ry)
    m = m and (m + e) or e
    x = x + 2 * rx + rand(8, 40)
  end
end
darkIceM = (m:roughen(0.9, 6, 41) * merem:shrink(4))
work(darkIceM, {hand="detail", tool={kind="round", width=2.5, point=0.4}, pile=darkIce, load=0.6, pressure={0.4, 0.7}, coverage=2.5, fill=true, clip=true, angle=0, angle_jitter=0.03})
