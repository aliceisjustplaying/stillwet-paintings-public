barkL = pile{{"lead white",1.5},{"raw umber",0.8},{"smalt",0.6},{"bone black",0.1}, medium=0.1}
barkF = pile{{"bone black",1},{"raw umber",1},{"smalt",0.2}, medium=0.1}
lichen = pile{{"green earth",1.2},{"lead white",1},{"yellow ochre",0.2},{"raw umber",0.1}, medium=0.1}
local function trunk_bark(x0, x1, y0, y1, seed, cxf)
  math.randomseed(seed)
  local b = brush{kind="round", width=2, point=0.8}
  local f = brush{kind="round", width=1.6, point=1}
  -- light ridges: short vertical wavy strokes, denser toward the left edge
  b:load(barkL, 0.5)
  for i=1,140 do
    local y = rand(y0, y1)
    local cx, hw = cxf(y)
    local u = rand(-1, 1)
    if math.random() < 0.55 + 0.35*(-u) then
      local x = cx + u*hw*0.9
      local len = rand(6, 16)
      if b:fullness() < 0.2 then b:load(barkL, 0.5) end
      b:stroke({{x, y}, {x + rand(-1,1), y + len*0.5}, {x + rand(-1.5,1.5), y + len}}, {pressure={0.35,0.15}, shake=0.6})
    end
  end
  -- dark fissures
  f:load(barkF, 0.8)
  for i=1,110 do
    local y = rand(y0, y1)
    local cx, hw = cxf(y)
    local x = cx + rand(-0.9, 0.9)*hw
    local len = rand(8, 22)
    if f:fullness() < 0.3 then f:load(barkF, 0.8) end
    f:stroke({{x, y}, {x + rand(-1.2,1.2), y + len*0.5}, {x + rand(-1.5,1.5), y + len}}, {pressure={0.5,0.2}, shake=0.5})
  end
  -- lichen dabs, mostly on one side and low
  local s = brush{kind="round", width=2.5, point=0.3}
  s:load(lichen, 0.6)
  for i=1,35 do
    local y = rand(lerp(y0,y1,0.3), y1)
    local cx, hw = cxf(y)
    local x = cx + rand(0.1, 0.95)*hw
    if s:fullness() < 0.25 then s:load(lichen, 0.6) end
    s:touch(x, y, {pressure=rand(0.2,0.45), drag={rand(-1,1), rand(0,2)}})
  end
end
trunk_bark(386, 424, 335, 505, 11, function(y) local t=(y-330)/180; return 403 - 2*t, 15 + 5*t^3 end)
trunk_bark(838, 862, 350, 500, 12, function(y) local t=(y-350)/150; return 849, 10 + 4*t^3 end)
-- the hollow where the old limb broke off
local hole = ellipse(392, 424, 4, 6)
work(hole, {hand="detail", pile=rkK, coverage=4, fill=true, load=1, pressure={0.6,0.9}})
local lipb = brush{kind="round", width=1.5, point=1}; lipb:load(barkL, 0.5)
lipb:stroke({{388,418},{392,416.5},{397,419}}, {pressure={0.4,0.2}})
