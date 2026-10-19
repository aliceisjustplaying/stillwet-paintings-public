local fsh = poly({{785,700},{945,720},{955,752},{795,734}}, true):grow(6) * front
blend(fsh, {angle=0.14, tool={kind="badger", width=14}})
kHandle2 = ribbon({{776,690},{830,697},{880,704},{928,711}}, {19,20,20,19})
local h = brush("filbert", 10)
for i = -1, 1 do
  h:reload(hWood, 0.8)
  h:stroke({{778, 690 + i*5.5}, {855, 700.5 + i*5.5}, {929, 711 + i*5.5}}, {pressure={0.7,0.7}, ramps={0.05,0.05}, orient="across", clip=kHandle2})
end
h:reload(hWood, 0.6)
h:touch(930, 711, {pressure=0.7, clip=kHandle2})
local hl = brush{kind="round", width=5, point=0.3}
hl:reload(hLight, 0.8)
hl:stroke({{782,684},{830,690},{880,697},{924,703}}, {pressure={0.55,0.35}, ramps={0.2,0.3}, clip=kHandle2})
local rv = brush{kind="round", width=3, point=0.2}
for _, p in ipairs({{812,695},{865,702},{905,707}}) do
  rv:reload(bHi, 0.6)
  rv:touch(p[1], p[2], {pressure=0.6})
end
-- lit arris of the ledge
local a = brush{kind="round", width=3, point=0.3}
local edgeLight = pile{{"lead white",2},{"yellow ochre",0.8},{"raw umber",0.5}}
local x = 0
while x < 1000 do
  local x1 = math.min(1000, x + rand(80, 160))
  if not (x1 > 770 and x < 935) then
    a:reload(edgeLight, 0.6)
    a:stroke({{x, 690 + rand(-0.5,0.5)}, {x1, 690 + rand(-0.5,0.5)}}, {pressure={0.45,0.35}, ramps={0.2,0.2}})
  end
  if x1 >= 1000 then break end
  x = x1 - 5
end
