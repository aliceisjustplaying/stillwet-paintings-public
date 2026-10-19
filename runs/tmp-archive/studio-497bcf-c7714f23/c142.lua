roofT = pile{{"lead white", 3}, {"pale smalt", 1.2}, {"red earth", 0.45}, {"raw umber", 0.4}, medium=0.1}
wallT = pile{{"lead white", 5}, {"pale smalt", 0.9}, {"yellow ochre", 0.25}, medium=0.1}
local x = 228
local k = 0
local all
local towers = spJ + rect(262,389,10,52) + spN1 + rect(322,377,9,64) + rect(420,371,26,70) + rect(330,395,90,30) + rect(446,397,62,28)
while x < 588 do
  k = k + 1
  local w = rand(9, 17)
  local wallTop = 430 - rand(0, 4)
  local gable = (rand(0,1) < 0.45)
  local roofH = rand(4, 7)
  local rm
  if gable then
    rm = poly({{x, wallTop}, {x + w/2, wallTop - roofH}, {x + w, wallTop}})
  else
    rm = poly({{x, wallTop}, {x + 2, wallTop - roofH*0.7}, {x + w - 2, wallTop - roofH*0.7}, {x + w, wallTop}})
  end
  rm = rm - towers
  local wm = rect(x, wallTop, w, 440.5 - wallTop) - towers
  work(wm, {hand="detail", pile=wallT, angle=math.pi/2, coverage=2.5, length={1.5,4}, fill=true, clip=true, edge="found"})
  work(rm, {hand="detail", pile=roofT, angle=0, coverage=2.5, length={1.5,4}, fill=true, clip=true, edge="found"})
  x = x + w + rand(-1, 1.5)
end
print(wait(0))
