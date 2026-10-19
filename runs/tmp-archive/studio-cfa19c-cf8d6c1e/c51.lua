local bankP = pile{{"raw umber",1},{"green earth",1.5},{"Prussian blue",0.2},{"lead white",0.5}, medium=0.1}
local wRef = pile{{"green earth",1.5},{"raw umber",0.8},{"Prussian blue",0.15},{"lead white",1.0}, medium=0.25}
-- a thin dark line under the far bank: the bank's own reflection
local pts, wd = {}, {}
for x=335,1005,10 do pts[#pts+1] = {x, interp(farBank,x) + 0.4 + 0.004*(x-335)} ; wd[#wd+1] = 0.8 + 0.0035*(x-335) + rand(-0.3,0.3) end
local bankLine = ribbon(pts, wd) * riverM:grow(0.5)
work(bankLine, {hand="detail", pile=bankP, tool={kind="round", width=1.2, point=0.5}, angle=0.1, coverage=2.5, fill=true, seed=321})
-- willow reflections, each drawn as its own shape in the water
for i,w in ipairs({{452,11},{505,14},{560,18},{626,22},{702,27},{792,33},{884,38},{978,44}}) do
  local x, s = w[1], w[2]
  local yb = interp(farBank, x) + 0.5
  local yn = interp(nearBank, x)
  local th = 0.42*s
  local shape = poly({{x-0.1*s, yb},{x+0.1*s, yb},{x+0.12*s, yb+th*0.9},{x+0.42*s, yb+th*1.05},{x+0.46*s, yb+th*1.7},{x-0.46*s, yb+th*1.7},{x-0.42*s, yb+th*1.05},{x-0.12*s, yb+th*0.9}}, true)
  local m = shape * riverM:shrink(0.6)
  work(m, {hand="detail", pile=wRef, tool={kind="round", width=math.max(1,0.07*s), point=0.4}, angle=math.pi/2, coverage=1.8, fill=true, seed=330+i})
end
