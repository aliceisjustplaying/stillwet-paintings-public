local FGM = LAND * mask(function(x,y) return y > 600 and 1 or 0 end) - PATH:shrink(2)
local tall = pile{{"yellow ochre",1.5},{"green earth",1.2},{"lead white",1.0},{"Prussian blue",0.1},{"chrome yellow",0.2}, medium=0.08}
local tallD = pile{{"green earth",1.4},{"Prussian blue",0.3},{"raw umber",0.6},{"yellow ochre",0.6},{"lead white",0.3}, medium=0.08}
local seedP = pile{{"yellow ochre",1.3},{"raw umber",0.5},{"red earth",0.2},{"lead white",1.2}, medium=0.08}
local buttercup = pile{{"chrome yellow",2},{"yellow ochre",0.3},{"lead white",0.4}, medium=0.06}
local daisy = pile{{"lead white",6},{"yellow ochre",0.08}, medium=0.05}
local sorrel = pile{{"red earth",1},{"vermilion",0.5},{"raw umber",0.3},{"lead white",0.3}, medium=0.06}
local clover = pile{{"lead white",3},{"vermilion",0.3},{"red earth",0.2},{"pale smalt",0.3}, medium=0.06}
-- tall grass stems with seed heads
local rb = brush{kind="rigger", width=1.0, point=1}
local sb = brush{kind="round", width=1.8, point=0.7}
rb:load(tallD, 0.6); sb:load(seedP, 0.6)
local n = 0
for k=1,260 do
  local x, y = rand(0, 1000), rand(625, 712)
  if FGM:at(x, math.min(y,703)) > 0.5 then
    local sc = 0.6 + (y - 600)/110
    local h = rand(28, 70)*sc
    local bend = rand(-0.25, 0.25)
    local p = (k % 2 == 0) and tall or tallD
    rb:reload(p, 0.5)
    local tx, ty = x + bend*h, y - h
    rb:stroke({{x, y}, {x + bend*h*0.35, y - h*0.5}, {tx, ty}}, {pressure={0.55,0.15}})
    if k % 3 == 0 then
      sb:reload(seedP, 0.5)
      local a = math.atan(ty - (y - h*0.5), tx - (x + bend*h*0.35))
      sb:stroke({{tx, ty}, {tx + math.cos(a)*6*sc, ty + math.sin(a)*6*sc}}, {pressure={0.6,0.1}})
    end
    n = n + 1
  end
end
-- flowers: buttercups in the middle band and foreground, daisies, sorrel, clover
local ft = brush{kind="round", width=2.2, point=0.2}
local function dots(p, cnt, y0, y1, size)
  ft:reload(p, 0.6)
  for k=1,cnt do
    local x, y = rand(0,1000), rand(y0,y1)
    if FGM:at(x,y) > 0.5 or (y < 600 and LAND:at(x,y) > 0.5 and PATH:at(x,y) < 0.3 and FIGS:at(x,y) < 0.1 and PWALL:at(x,y) < 0.1 and FENCE:at(x,y) < 0.1 and RAILS:at(x,y) < 0.1) then
      local s = size * (0.35 + (y - 500)/200)
      ft:touch(x, y, {pressure=clamp(s, 0.15, 0.9)})
      if ft:fullness() < 0.3 then ft:reload(p, 0.6) end
    end
  end
end
dots(buttercup, 120, 560, 700, 0.8)
dots(buttercup, 90, 520, 600, 0.5)
dots(daisy, 70, 600, 700, 0.7)
dots(sorrel, 50, 580, 700, 0.6)
dots(clover, 30, 620, 700, 0.8)
print(n, wait(0))
