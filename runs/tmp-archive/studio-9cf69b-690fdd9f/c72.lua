moonP = pile{{"lead white",6},{"chrome yellow",0.12},{"yellow ochre",0.1}, medium=0.05}
local mx, my, rr = 742, 128, 8.5
local cres = ellipse(mx, my, rr, rr) - ellipse(mx - 2.6, my - 3.4, rr*0.93, rr*0.93)
moonM = cres:soften(0.3)
work(moonM, {hand="detail", pile=moonP, coverage=4, pressure={0.6,0.9}, load=1, fill=true, tool={kind="round", width=1.2}})
-- crows
crowP = pile{{"bone black",1.5},{"raw umber",0.6},{"lead white",0.15}, medium=0.06}
local r = brush{kind="round", width=1.8, point=1}
r:load(crowP, 0.8)
local function flying(x, y, s, up)
  local wy = up and -1 or 0.4
  -- body
  r:stroke({{x - s*0.35, y + 0.2*s}, {x + s*0.4, y - 0.05*s}}, {pressure={0.75, 0.45}})
  -- wings, bent at the wrist
  r:stroke({{x, y}, {x - s*0.45, y + wy*s*0.55}, {x - s*1.0, y + wy*s*0.35 + s*0.2}}, {pressure={0.6, 0.05}})
  r:stroke({{x + 0.1*s, y}, {x + s*0.4, y + wy*s*0.6}, {x + s*0.95, y + wy*s*0.4 + s*0.25}}, {pressure={0.6, 0.05}})
end
flying(470, 205, 6.5, true)
flying(505, 228, 5.2, false)
flying(540, 196, 4.4, true)
flying(612, 250, 3.6, false)
flying(430, 262, 5.8, false)
-- two perched on the dead limbs of the oak
local function perched(x, y, s)
  local body = ellipse(x, y - s*0.45, s*0.32, s*0.5) + ellipse(x + s*0.18, y - s*1.0, s*0.2, s*0.2)
  work(body, {hand="detail", pile=crowP, coverage=4, pressure={0.6,0.9}, load=1, fill=true, tool={kind="round", width=0.9}})
  r:load(crowP, 0.7)
  r:stroke({{x + s*0.35, y - s*1.02}, {x + s*0.6, y - s*0.96}}, {pressure={0.4, 0.05}})
  r:stroke({{x - s*0.15, y - s*0.2}, {x - s*0.45, y + s*0.25}}, {pressure={0.5, 0.1}})
end
perched(236, 116, 6)
perched(289, 70, 5.4)
