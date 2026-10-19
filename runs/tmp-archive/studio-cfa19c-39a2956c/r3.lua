local R = riverM:shrink(0.3)
local rc = pile{{"green earth",1.5},{"raw umber",0.8},{"Prussian blue",0.3},{"lead white",0.7}, medium=0.08}
local rt = pile{{"raw umber",1.2},{"lead white",0.8},{"pale smalt",0.3}, medium=0.08}
for i,w in ipairs({{452,11},{505,14},{560,18},{626,22},{702,27},{792,33},{884,38},{978,44}}) do
  local x, s = w[1], w[2]
  local yb = interp(farBank, x) + 0.6
  local yn = interp(nearBank, x) - 0.3
  local th = 0.42*s
  -- trunk reflection
  local tb = brush{kind="round", width=math.max(0.9, 0.11*s), point=0.3}
  tb:load(rt, 0.5)
  tb:stroke({{x, yb},{x + rand(-0.2,0.2), math.min(yn, yb + th*0.95)}}, {pressure={0.6,0.45}, clip=R})
  -- crown reflection: short vertical strokes, a soft mass widening a little, broken by ripples
  local y0 = yb + th*0.85
  if y0 < yn - 0.5 then
    local cb = brush{kind="flat", width=math.max(1.0, 0.09*s), stiffness=0.4}
    local n = math.max(4, math.floor(s/3))
    for k=1,n do
      local t = (k-0.5)/n - 0.5
      local xx = x + t * 0.85*s + rand(-0.04,0.04)*s
      local yy0 = y0 + math.abs(t)*0.12*s
      local yy1 = math.min(yn, y0 + (0.55 - 0.5*math.abs(t))*s*rand(0.85,1.1))
      if yy1 > yy0 + 0.5 then
        cb:load(rc, 0.35)
        cb:stroke({{xx, yy0},{xx + rand(-0.2,0.2), yy1}}, {pressure={0.55,0.3}, ramps={0.15,0.4}, orient="across", clip=R})
      end
    end
  end
end
