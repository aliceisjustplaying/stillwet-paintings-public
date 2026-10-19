woods = pile{{"lead white",4},{"smalt",1},{"pale smalt",1},{"vermilion",0.08},{"bone black",0.06}, medium=0.2}
local m = mask(function(x, y) if x > 330 and y > woodtop(x) + 3 and y < 474 then return 1 end return 0 end)
local n = 0
for i = 1, 140 do
  local x = rand(335, 1005)
  local r = rand(3, 8)
  m = m + ellipse(x, woodtop(x) + 3, r, r * rand(0.8, 1.2))
end
-- a few distant firs
for i = 1, 22 do
  local x = rand(350, 1000)
  local hh = rand(8, 18)
  local b = woodtop(x) + 4
  m = m + poly({{x - 3.5, b}, {x, b - hh}, {x + 3.5, b}})
end
woodsm = m:roughen(1.2, 6, 3)
work(woodsm, {hand="detail", pile=woods, load=0.8, pressure={0.5, 0.8}, coverage=3, fill=true, angle=0})
