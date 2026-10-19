local R = riverM
local wRef4 = pile{{"green earth",1.5},{"raw umber",0.7},{"Prussian blue",0.3},{"lead white",0.5}, medium=0.06}
for i,w in ipairs({{452,11},{505,14},{560,18},{626,22},{702,27},{792,33},{884,38},{978,44}}) do
  local x, s = w[1], w[2]
  local yb = interp(farBank, x)
  local tb = brush{kind="filbert", width=math.max(1.2, 0.1*s), stiffness=0.4}
  local n = math.max(3, math.floor(s/3))
  for k=1,n do
    local xx = x + (k/(n+1) - 0.5) * 0.75*s + rand(-0.3,0.3)
    tb:reload(wRef4, 0.7)
    local top = yb + 0.36*s + rand(-0.03,0.03)*s
    tb:stroke({{xx, top},{xx + rand(-0.2,0.2), top + (0.4 - 0.25*math.abs(k/(n+1)-0.5))*s}}, {pressure={0.75,0.3}, ramps={0.05,0.5}, clip=R:shrink(0.5)})
  end
end
