local wg = pile{{"lead white",1.5},{"raw umber",1},{"bone black",0.25},{"green earth",0.4}, medium=0.05}
local wgl = pile{{"lead white",2.5},{"raw umber",0.6},{"yellow ochre",0.3},{"green earth",0.3}, medium=0.05}
print(drying(792,490), drying(978,500))
for i,w in ipairs({{452,11},{505,14},{560,18},{626,22},{702,27},{792,33},{884,38},{978,44}}) do
  local x, s = w[1], w[2]
  local yb = interp(farBank, x) + 0.5
  local th = 0.42*s
  local b = brush{kind="round", width=math.max(1.0, 0.1*s), point=0.3}
  b:reload(wg, 0.7)
  b:stroke({{x+0.02*s, yb}, {x+0.02*s, yb - th*0.55}, {x+0.03*s, yb - th*0.95}}, {pressure={0.8,0.75}})
  local l = brush{kind="round", width=math.max(0.8, 0.045*s), point=0.5}
  l:reload(wgl, 0.6)
  l:stroke({{x-0.04*s, yb-1}, {x-0.045*s, yb - th*0.9}}, {pressure={0.6,0.4}})
end
