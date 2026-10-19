print(wait(30*60))
willowD2 = pile{{"green earth", 2}, {"raw umber", 1.6}, {"smalt", 0.5}, {"lead white", 0.35}, {"bone black", 0.25}, medium=0.1}
willowSil = pile{{"lead white", 2.2}, {"green earth", 1}, {"pale smalt", 0.6}, {"yellow ochre", 0.3}, {"raw umber", 0.4}, medium=0.1}
willowTrunk2 = pile{{"raw umber", 1.6}, {"bone black", 1}, {"lead white", 0.5}, {"smalt", 0.3}, medium=0.1}
local rod = brush{kind="round", width=2.5, point=1}
for i = #willows, 1, -1 do
  local W = willows[i]; local x, y, h = W.x, W.y, W.h
  local crown = ellipse(x, y - 0.66*h, 0.42*h, 0.36*h):roughen(math.max(0.8, 0.06*h), math.max(3, 0.12*h), 300+i)
  W.crown2 = crown
  local sw = math.max(1.2, 0.07*h)
  stipple(crown, {pile=willowD2, width=sw, coverage=2.8, cluster={0.4, sw*2}, pressure={0.4,0.8}, dips={30, 0.7, 0}})
  -- upright rods rising from the head
  if h > 12 then
    rod:reload(willowD2, 0.7)
    local n = math.floor(h * 0.5)
    for k = 1, n do
      local a = -math.pi/2 + randn(0, 0.45)
      local L = h * rand(0.3, 0.55)
      local x0, y0 = x + rand(-0.12, 0.12)*h, y - 0.45*h
      rod:stroke({{x0, y0}, {x0 + 0.5*L*math.cos(a) , y0 + 0.5*L*math.sin(a)}, {x0 + L*math.cos(a+randn(0,0.1)), y0 + L*math.sin(a)}}, {pressure={rod:pressure_for(0.9), 0.0}, ramps={0.05, 0.5}})
      if k % 6 == 0 then rod:load(willowD2, 0.6) end
    end
  end
  stipple(crown - crown:offset(-math.max(1, 0.06*h)), {pile=willowSil, width=sw*0.8, coverage=0.5, cluster={0.5, sw*2}, pressure={0.3,0.6}, feather=0.4})
  local trunkVis = W.trunk - crown:shrink(0.05*h)
  work(trunkVis, {hand="detail", pile=willowTrunk2, coverage=3, fill=true, clip=true, angle=-1.57, length={2, math.max(3, 0.15*h)}})
end
