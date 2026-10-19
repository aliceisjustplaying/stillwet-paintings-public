postP = pile{{"raw umber",1},{"bone black",0.7},{"lead white",0.15}}
reflPost = pile{{"raw umber",1},{"bone black",0.4},{"cobalt blue",0.4},{"lead white",0.9}}
posts = {{765,642,44,4.5},{741,614,30,3.4},{722,597,21,2.6},{708,587,15,2},{698,580,10,1.5},{691,576,7,1.2}}
for i,p in ipairs(posts) do
  local x, yb, h, w = p[1], p[2], p[3], p[4]
  local tilt = randn(0, 0.04)
  local b = brush{kind="flat", width=w, stiffness=0.6}
  b:load(postP, 0.8)
  b:stroke({{x + tilt*h, yb - h}, {x + tilt*h*0.5, yb - h*0.5}, {x, yb}}, {pressure={0.8,0.9}, orient="across"})
  local rb = brush{kind="flat", width=w*0.9, stiffness=0.5}
  rb:load(reflPost, 0.6)
  local pts = {}
  for k=0,6 do local t = k/6; pts[#pts+1] = {x + math.sin(t*9 + i)*w*0.35, yb + 1 + t*h*0.85} end
  rb:stroke(pts, {pressure={0.7,0.1}, ramps={0.05,0.7}, orient="across"})
end
