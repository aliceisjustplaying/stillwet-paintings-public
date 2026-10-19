-- snow blown over the ice in long thin drifts, and a snowy tongue running in from the right shore
iceSnow = pile{{"lead white",5},{"pale smalt",1.3},{"smalt",0.3},{"vermilion",0.06},{"bone black",0.03}, medium=0.25}
local m = nil
for i = 1, 16 do
  local y = rand(556, 598)
  local x = rand(440, 880)
  local rx = rand(12, 60) * (0.6 + (y - 550) / 60)
  local ry = rand(0.8, 2.2) * (0.6 + (y - 550) / 50)
  local e = ellipse(x, y, rx, ry)
  m = m and (m + e) or e
end
m = m + poly({{930,560},{900,562},{870,566},{842,572},{828,576},{850,580},{884,578},{915,575}}, true)
m = m + poly({{405,568},{430,566},{462,570},{478,575},{455,578},{425,578}}, true)
iceSnowM = (m:roughen(1.2, 7, 37) * merem:grow(3))
work(iceSnowM, {hand="detail", tool={kind="round", width=2, point=0.5}, pile=iceSnow, load=0.7, pressure={0.4, 0.7}, coverage=2.5, fill=true, clip=true, angle=0, angle_jitter=0.05})
-- let the drifts' edges go soft against the ice
blend(iceSnowM:grow(3) * merem, {angle=0})
