twigP = pile{{"raw umber",2},{"bone black",0.9},{"lead white",1.0},{"pale smalt",0.5}, medium=0.15}
local b = brush{kind="round", width=3, point=1, stiffness=0.5}
b:load(twigP, 0.8)
local cnt = 0
for _,s in ipairs(oak.thin) do
  local w0 = s.ws[1]; local w1 = s.ws[#s.ws]
  local p0 = math.max(b:pressure_for(w0), 0.15)
  local p1 = math.max(b:pressure_for(w1) * 0.6, 0.02)
  b:stroke(s.pts, {pressure={p0, p1}, ramps={0.0, 0.5}})
  cnt = cnt + 1
  if cnt % 12 == 0 then b:load(twigP, 0.7) end
end
print(cnt)
