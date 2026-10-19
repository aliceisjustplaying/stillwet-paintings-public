townM = pile{{"lead white", 4}, {"pale smalt", 1.6}, {"raw umber", 0.4}, {"red earth", 0.15}, {"smalt", 0.35}, medium=0.1}
local base = (town_all * rect(222,412,380,30)) + houses:grow(0.6)
-- ragged roofline for the lower town: small gables drawn as one outline
local pts = {{226,441}}
local x = 226
local k = 0
while x < 590 do
  k = k + 1
  local w = 5 + (k*37 % 7)
  local top = 425 - (k*13 % 5)
  pts[#pts+1] = {x, top}
  pts[#pts+1] = {x + w*0.5, top - 3 - (k % 3)}
  x = x + w
  pts[#pts+1] = {x, top}
end
pts[#pts+1] = {592,441}
lowtown = poly(pts) + base
lowtown = lowtown - (spJ + rect(262,390,10,30) + spN1 + rect(322,378,9,40) + rect(420,372,26,50))
work(lowtown, {hand="detail", pile=townM, angle=0, coverage=2.5, length={3,9}, fill=true, clip=true, edge="found"})
print(wait(0))
