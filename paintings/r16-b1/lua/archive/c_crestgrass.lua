local mx = 596
work(poly({{mx-11.5, 566}, {mx-11.8, 579}, {mx+11.8, 580}, {mx+11.5, 566}}, true) - rect(mx-7, 576, 14, 10), {hand="detail", pile=coatP, coverage=3.5, fill=true, clip=true, angle=-1.57, length={2,5}})
crestG1 = pile{{"raw umber", 2.2}, {"green earth", 2.2}, {"bone black", 0.5}, {"yellow ochre", 0.3}, medium=0.1}
crestG2 = pile{{"raw umber", 2}, {"green earth", 2}, {"yellow ochre", 0.9}, {"lead white", 0.15}, medium=0.1}
local cb = {brush{kind="round", width=1.5, point=1}, brush{kind="round", width=1.5, point=1}}
local cp = {crestG1, crestG2}
cb[1]:load(crestG1, 0.8); cb[2]:load(crestG2, 0.8)
local cnt = 0
local x = -5
while x < 1005 do
  x = x + rand(0.8, 3.2)
  local y = crestY(x) + rand(0.5, 3)
  if keepOut:at(x, y - 3) < 0.5 and keepOut:at(x, y + 2) < 0.5 and not (x > 830 and x < 862 and y > 570) then
    local nb = math.random(1, 3)
    for j = 1, nb do
      local k = (rand(0,1) < 0.75) and 1 or 2
      local L = rand(2.5, 8) * (rand(0,1) < 0.1 and 1.8 or 1)
      local a = -math.pi/2 + randn(0, 0.28)
      local b = cb[k]
      cnt = cnt + 1
      if cnt % 8 == 0 then b:load(cp[k], 0.75) end
      local bend = randn(0, 0.3)
      b:stroke({{x, y}, {x + 0.5*L*math.cos(a), y + 0.5*L*math.sin(a)}, {x + L*math.cos(a+bend), y + L*math.sin(a+bend)}}, {pressure={b:pressure_for(0.9), 0.0}, ramps={0.02, 0.7}})
    end
  end
end
print(cnt)
