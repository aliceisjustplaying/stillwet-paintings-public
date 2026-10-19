local mB = pile{{"yellow ochre",2.4},{"Prussian blue",0.45},{"raw umber",0.3},{"lead white",0.9},{"green earth",0.4}, medium=0.05}
local mD = pile{{"yellow ochre",2},{"Prussian blue",0.55},{"raw umber",0.5},{"lead white",0.5},{"green earth",0.5}, medium=0.05}
-- grass of the near bank growing up over the water, breaking the line
local band = ditchM:grow(2.5) * mask(function(x,y) return 1 end)
local n = noise{seed=1001, octaves=2, period=25}
work(band, {hand="hatch", pile=mB, tool={kind="round", width=1.4, point=0.7}, angle=-math.pi/2+0.1, length={3,7}, coverage=1.1, broken=0.4, pressure={0.35,0.7}, seed=1002})
-- a line of reeds and a few willow stakes along the ditch
local b = brush{kind="rigger", width=1, point=1}
for i=1,40 do
  local x = rand(560, 1000)
  local y = interp({{470,577},{540,584},{600,591},{680,601},{750,611},{830,622},{900,633},{1005,648}}, x) - 1
  if i % 8 == 1 then b:reload(mD, 0.6) end
  local L = 3 + 0.012*(x-470)
  b:stroke({{x,y},{x+rand(-0.8,0.8), y-L}}, {pressure={0.55,0.0}})
end
