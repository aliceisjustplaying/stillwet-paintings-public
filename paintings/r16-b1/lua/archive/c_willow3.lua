willowG = pile{{"green earth", 2}, {"yellow ochre", 0.6}, {"raw umber", 1.2}, {"Prussian blue", 0.08}, {"lead white", 0.4}, medium=0.1}
local rod = brush{kind="round", width=2, point=1}
local leafTips = nil
for i = #willows, 1, -1 do
  local W = willows[i]; local x, y, h = W.x, W.y, W.h
  if h > 9 then
    rod:reload(willowD2, 0.7)
    local n = math.floor(h * 0.7)
    for k = 1, n do
      local side = rand(-1, 1)
      local a = -math.pi/2 + side * 0.75 + randn(0, 0.12)
      local L = h * rand(0.5, 0.8)
      local x0, y0 = x + side * 0.1 * h, y - 0.46*h
      local bend = side * 0.15
      local x1, y1 = x0 + 0.5*L*math.cos(a), y0 + 0.5*L*math.sin(a)
      local x2, y2 = x0 + L*math.cos(a + bend), y0 + L*math.sin(a + bend)
      rod:stroke({{x0, y0}, {x1, y1}, {x2, y2}}, {pressure={rod:pressure_for(math.max(0.5, 0.05*h)), 0.0}, ramps={0.05, 0.6}})
      if k % 5 == 0 then rod:load(willowD2, 0.6) end
      if rand(0,1) < 0.7 then
        local e = ellipse((x1 + x2)/2, (y1 + y2)/2, 0.07*h, 0.12*h)
        leafTips = leafTips and (leafTips + e) or e
      end
    end
  end
end
if leafTips then
  local lt = leafTips:roughen(0.8, 3, 401)
  stipple(lt, {pile=willowG, width=1.6, coverage=1.3, cluster={0.5, 3}, pressure={0.3, 0.7}, feather=0.3})
  stipple(lt * rect(0, 0, 1000, 1000), {pile=willowSil, width=1.3, coverage=0.35, cluster={0.6, 3}, pressure={0.25, 0.5}, feather=0.5})
end
