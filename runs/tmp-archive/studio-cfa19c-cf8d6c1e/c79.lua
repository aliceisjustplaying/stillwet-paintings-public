local wd = pile{{"raw umber",1.2},{"bone black",0.35},{"green earth",0.8},{"lead white",0.5}, medium=0.05}
for i,w in ipairs({{452,11},{505,14},{560,18},{626,22},{702,27},{792,33},{884,38},{978,44}}) do
  local x, s = w[1], w[2]
  local yb = interp(farBank, x) + 0.5
  local th = 0.42*s
  local b = brush{kind="round", width=math.max(0.9, 0.06*s), point=0.4}
  b:reload(wd, 0.7)
  b:stroke({{x+0.06*s, yb}, {x+0.065*s, yb - th*0.6}, {x+0.07*s, yb - th*0.95}}, {pressure={0.8,0.7}})
  -- the knob where the shoots start, in shadow
  b:reload(wd, 0.6)
  b:stroke({{x-0.08*s, yb - th*0.95}, {x+0.1*s, yb - th*1.0}}, {pressure={0.8,0.6}})
end
