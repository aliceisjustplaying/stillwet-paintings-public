print(wait(60*30))
print(drying(700,490), drying(900,525))
local R = riverM:shrink(0.3)
local rt = pile{{"raw umber",1.2},{"lead white",0.6},{"pale smalt",0.4},{"green earth",0.3}, medium=0.08}
for i,w in ipairs({{452,11},{505,14},{560,18},{626,22},{702,27},{792,33},{884,38},{978,44}}) do
  local x, s = w[1], w[2]
  local yb = interp(farBank, x) + 0.4
  local yn = interp(nearBank, x) - 0.3
  local tb = brush{kind="round", width=math.max(0.9, 0.12*s), point=0.3}
  tb:load(rt, 0.45)
  local y1 = math.min(yn, yb + 0.42*s)
  tb:stroke({{x, yb},{x + 0.1, (yb+y1)/2},{x - 0.1, y1}}, {pressure={0.6,0.15}, ramps={0.05,0.6}, clip=R})
end
-- the far bank's slim shadow line on the water
local bankP = pile{{"raw umber",1},{"green earth",1.5},{"Prussian blue",0.2},{"lead white",0.9}, medium=0.12}
local bb = brush{kind="round", width=1.2, point=0.4}
for x=335,1005,40 do
  local seg = {}
  for xx=x, math.min(x+42,1008), 6 do seg[#seg+1] = {xx, interp(farBank, xx) + 0.7} end
  if #seg > 1 then bb:load(bankP, 0.35); bb:stroke(seg, {pressure={0.3 + 0.0004*(x-335), 0.4 + 0.0004*(x-335)}, clip=R}) end
end
