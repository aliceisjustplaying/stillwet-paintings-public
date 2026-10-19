local R = riverM
local wRef3 = pile{{"green earth",1.5},{"raw umber",0.5},{"Prussian blue",0.25},{"lead white",1.6},{"pale smalt",0.5}, medium=0.08}
local refl = nil
for i,w in ipairs({{452,11},{505,14},{560,18},{626,22},{702,27},{792,33},{884,38},{978,44}}) do
  local x, s = w[1], w[2]
  local yb = interp(farBank, x)
  local yn = interp(nearBank, x)
  local d = yn - yb
  -- a narrow trunk shadow and a soft, ragged crown reflection, drawn freehand
  local shape = poly({{x-0.07*s, yb},{x+0.07*s, yb},{x+0.1*s, yb+0.33*s},{x+0.36*s, yb+0.42*s},{x+0.3*s, yb+0.75*s},{x+0.05*s, yb+0.95*s},{x-0.08*s, yb+0.9*s},{x-0.34*s, yb+0.72*s},{x-0.38*s, yb+0.44*s},{x-0.1*s, yb+0.33*s}}, true):roughen(0.05*s, 0.2*s, 470+i)
  local m = shape * R:shrink(0.4)
  refl = refl and (refl + m) or m
  local tb = brush{kind="filbert", width=math.max(1.2, 0.12*s), stiffness=0.3}
  local n = math.max(3, math.floor(s/3.5))
  for k=1,n do
    local xx = x + (k/(n+1) - 0.5) * 0.7*s
    tb:reload(wRef3, 0.35)
    tb:stroke({{xx, yb + 0.3*s},{xx + rand(-0.3,0.3), yb + 0.9*s}}, {pressure={0.45,0.1}, ramps={0.1,0.6}, clip=m})
  end
  tb:reload(wRef3, 0.4)
  tb:stroke({{x, yb},{x, yb+0.4*s}}, {pressure={0.5,0.4}, clip=m})
end
reflM = refl
blend(refl:grow(1), {tool={kind="badger", width=5}, angle=math.pi/2, coverage=1.2, seed=479})
