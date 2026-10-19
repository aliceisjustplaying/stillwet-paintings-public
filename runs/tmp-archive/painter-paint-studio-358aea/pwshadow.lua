local shG = pile{{"green earth",1.6},{"Prussian blue",0.3},{"raw umber",0.6},{"yellow ochre",0.7},{"lead white",0.35}, medium=0.1}
local tuft = pile{{"green earth",1.3},{"yellow ochre",1.1},{"Prussian blue",0.22},{"raw umber",0.4},{"lead white",0.5}, medium=0.08}
local tuftL = pile{{"yellow ochre",1.4},{"chrome yellow",0.4},{"green earth",0.8},{"lead white",1.2},{"Prussian blue",0.08}, medium=0.08}
local ALLPW = PWTR[1]
for i=2,#PWTR do ALLPW = ALLPW + PWTR[i] end
PWALL = ALLPW
for i,t in ipairs(PW) do
  local H, x0, y0 = t.H, t.x, t.y
  local s = H/200
  -- cast shadow of the crown, to the right and a little forward, on the grass
  local sm = (ellipse(x0 + 0.32*H, y0 + 0.03*H, 0.42*H, 0.035*H) + ellipse(x0 + 0.1*H, y0 + 0.01*H, 0.12*H, 0.02*H)):roughen(2, 8, 1500+i) - ALLPW - FIGS:grow(1) - PATH
  work(sm, {hand="hatch", pile=shG, tool={kind="round", width=math.max(1.0, 2*s), point=0.8}, angle=-math.pi/2, angle_jitter=0.3, length={3*s+2, 9*s+3}, coverage=1.8, pressure={0.4,0.75}, ramps={0.1,0.6}, clip=sm:grow(2)})
  -- grass tufts over the trunk foot
  local g = brush{kind="rigger", width=math.max(0.6, 1.3*s), point=1}
  g:load(tuft, 0.6)
  for k=1,math.floor(12 + 20*s) do
    local xx = x0 + rand(-0.12, 0.12)*H
    local yb = y0 + rand(0, 0.015)*H
    local p = (k % 3 == 0) and tuftL or tuft
    if k % 3 == 0 then g:reload(p, 0.5) end
    g:stroke({{xx, yb}, {xx + rand(-0.02,0.02)*H, yb - rand(0.02,0.06)*H}}, {pressure={0.6,0.0}})
    if g:fullness() < 0.25 then g:reload(tuft, 0.6) end
  end
end
print(wait(0))
