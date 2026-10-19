local tr = pile{{"lead white",2.5},{"green earth",1.5},{"pale smalt",0.5},{"yellow ochre",1.0},{"Prussian blue",0.04}, medium=0.1}
local tr2 = pile{{"lead white",1.6},{"green earth",1.5},{"yellow ochre",1.2},{"Prussian blue",0.1},{"raw umber",0.1}, medium=0.1}
local band1 = LANDC * mask(function(x,y) return smoothstep(478,484,y)*(1-smoothstep(496,504,y)) end) - M_rise:shrink(1)
local band2 = LANDC * mask(function(x,y) return smoothstep(492,497,y)*(1-smoothstep(508,516,y)) end)
hgrass(band1, tr, {8,22}, 1.8, 1.8, 11)
hgrass(band2, tr2, {8,24}, 1.5, 2.0, 12)
-- river: tone down, lighter streak in middle, far bank edge
local rv = pile{{"lead white",6},{"pale smalt",1.4},{"smalt",0.35},{"green earth",0.15}, medium=0.1}
work(RIVER, {hand="detail", pile=rv, angle=0, length={10,30}, coverage=1.2, clip=true, load=0.5})
-- reeds along near bank
local reed = pile{{"green earth",1.3},{"raw umber",0.6},{"yellow ochre",0.8},{"Prussian blue",0.12},{"lead white",0.8}, medium=0.1}
local rb = brush{kind="rigger", width=0.8, point=1}
rb:load(reed, 0.5)
local x = 345
while x < 1000 do
  local yb = rbot(x) + 1.0
  if math.random() < 0.7 then
    local h = rand(2, 5) * (1 + (x-345)/1400)
    rb:stroke({{x, yb}, {x + rand(-0.8,0.8), yb - h}}, {pressure={0.5,0.05}})
  end
  if rb:fullness() < 0.2 then rb:reload(reed, 0.5) end
  x = x + rand(1.5, 4.5)
end
-- dark line of far bank grass under town
local fb = brush{kind="round", width=1.0, point=0.6}
fb:load(reed, 0.4)
for x0 = 345, 990, 30 do
  local pts = {}
  for xx = x0, x0+32, 4 do pts[#pts+1] = {xx, rtop(xx) - 0.6} end
  fb:stroke(pts, {pressure={0.35,0.3}})
  if fb:fullness() < 0.25 then fb:reload(reed, 0.4) end
end
print(wait(0))
