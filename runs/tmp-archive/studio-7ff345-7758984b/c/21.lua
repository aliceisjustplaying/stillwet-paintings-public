bThick = brush{kind="round", width=8, point=0.7}
bMid = brush{kind="round", width=4, point=1}
bTwig = brush{kind="rigger", width=1.5, point=1}
function paintSeg(s, minw, maxw)
  if s.w0 < minw or s.w0 >= maxw then return 0 end
  local b = (s.w0 >= 3) and bThick or ((s.w0 >= 1.2) and bMid or bTwig)
  local p = s.dead and deadwood or bark
  b:load(p, s.w0 >= 1.2 and 0.9 or 0.7)
  local p0 = math.max(b:pressure_for(s.w0), 0.15)
  local p1 = math.max(b:pressure_for(s.w1), 0.05)
  b:stroke(s.pts, {pressure={p0, p1}, ramps={0.0, 0.25}})
  return 1
end
local n = 0
for _, s in ipairs(oakSegs) do n = n + paintSeg(s, 1.2, 1000) end
print(n)
