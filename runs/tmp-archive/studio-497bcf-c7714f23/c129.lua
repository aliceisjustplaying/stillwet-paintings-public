grDD = pile{{"green earth", 2}, {"raw umber", 2}, {"Prussian blue", 0.35}, {"bone black", 0.2}, {"yellow ochre", 0.4}, medium=0.08}
local ok = fore_m - path_m:shrink(3) - elder2:grow(1) - fence:grow(1)
local bottom = ok * mask(function(x,y) local d = crest_depth(x,y) return d > 75 and 1 or 0 end)
local cornerw = function(x,y) return 1 end
local up = function(x,y) return -math.pi/2 + 0.35*math.sin(x/29 + y/17) end
work(bottom, {hand="hatch", pile=grDD, tool={kind="rigger", width=2.4, point=1}, angle=up, length={16,34}, coverage=0.7, pressure={0.55,0.85}, ramps={0.05,0.75}, clip=ok, clump=0.5})
work(bottom, {hand="hatch", pile=grM, tool={kind="rigger", width=2.0, point=1}, angle=up, length={14,28}, coverage=0.3, pressure={0.5,0.8}, ramps={0.05,0.75}, clip=ok, clump=0.5})
-- a few long seeding grass stems with heads, catching the light
local st = brush{kind="rigger", width=1.2, point=1}
local hd = brush{kind="round", width=2.0, point=0.9}
for k = 1, 26 do
  local x = rand(0, 1000)
  local y0 = 716
  if ok:at(x, 700) > 0.9 then
    local L = rand(40, 75)
    local lean = rand(-0.25, 0.25)
    local tx, ty = x + L*lean, y0 - L
    st:load(stemG, 0.5)
    st:stroke({{x, y0}, {x + L*lean*0.4, y0 - L*0.5}, {tx, ty}}, {pressure={0.55, 0.3}})
    hd:load((k % 3 == 0) and pastL or stub, 0.5)
    hd:stroke({{tx, ty + 7}, {tx + lean*3, ty}}, {pressure={0.7, 0.1}})
  end
end
print(wait(0))
