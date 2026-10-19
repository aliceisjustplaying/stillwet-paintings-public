posts = {{766,644,46,4.6},{742,615,31,3.4},{724,598,22,2.7},{710,588,16,2.1},{700,581,11,1.6},{693,577,7,1.2}}
local topLit = pile{{"lead white",3},{"yellow ochre",0.4},{"raw umber",0.4}}
for i,p in ipairs(posts) do
  local x, yb, h, w = p[1], p[2], p[3], p[4]
  h = h * (0.85 + 0.3*rand(0,1))
  local tilt = randn(0, 0.05)
  local b = brush{kind="flat", width=w, stiffness=0.7}
  b:load(postP, 0.9)
  b:stroke({{x, yb}, {x + tilt*h*0.5, yb - h*0.5}, {x + tilt*h, yb - h}}, {pressure={0.9,0.85}, ramps={0.02,0.02}, orient="across"})
  local rb = brush{kind="flat", width=w*0.85, stiffness=0.5}
  rb:load(reflPost, 0.55)
  local pts = {}
  for k=0,8 do local t = k/8; pts[#pts+1] = {x + math.sin(t*10 + i)*w*0.45, yb + 1.5 + t*h*0.9} end
  rb:stroke(pts, {pressure={0.75,0.05}, ramps={0.02,0.8}, orient="across"})
  local tb = brush{kind="flat", width=w*0.9, stiffness=0.5}
  tb:load(topLit, 0.4)
  tb:touch(x + tilt*h - w*0.1, yb - h + w*0.3, {pressure=0.3, drag={w*0.4, 0}})
end
