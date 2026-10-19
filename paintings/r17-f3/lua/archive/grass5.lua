-- grass over the far path continuation and the path edges
local nearCont = rect(470, 490, 90, 55) - FIGS:grow(1)
local gm = pile{{"yellow ochre",1.4},{"green earth",1.4},{"Prussian blue",0.18},{"lead white",1.0},{"chrome yellow",0.2}, medium=0.1}
work(nearCont * LAND, {hand="hatch", pile=gm, tool={kind="round", width=1.2, point=0.8}, angle=-math.pi/2, angle_jitter=0.3, length={3,7}, coverage=1.0, pressure={0.35,0.7}, ramps={0.1,0.6}, seed=901})
-- blades breaking the path edges
local edgeBand = (PATH:grow(5) - PATH:shrink(3)) * mask(function(x,y) return y > 545 and 1 or 0 end)
local gd = pile{{"green earth",1.4},{"yellow ochre",1.1},{"Prussian blue",0.3},{"raw umber",0.5},{"lead white",0.5}, medium=0.1}
local rb = brush{kind="rigger", width=1.2, point=1}
rb:load(gd, 0.6)
local cnt = 0
for yy = 548, 704, 1.3 do
  for side = -1, 1, 2 do
    -- find edge x at this y by scanning
    local ex
    if side < 0 then
      for xx = 350, 700, 1 do if PATH:at(xx, yy) > 0.5 then ex = xx; break end end
    else
      for xx = 700, 350, -1 do if PATH:at(xx, yy) > 0.5 then ex = xx; break end end
    end
    if ex and math.random() < 0.75 then
      local sc = 0.4 + (yy - 540)/160
      local x0 = ex - side*rand(-2, 6)*sc
      local h = rand(4, 12)*sc
      local lean = side * rand(-0.1, 0.5)
      rb:stroke({{x0, yy}, {x0 + lean*h*0.5, yy - h*0.5}, {x0 + lean*h, yy - h}}, {pressure={0.5,0.0}})
      cnt = cnt + 1
      if rb:fullness() < 0.3 then rb:reload(gd, 0.6) end
    end
  end
end
print(cnt, wait(0))
