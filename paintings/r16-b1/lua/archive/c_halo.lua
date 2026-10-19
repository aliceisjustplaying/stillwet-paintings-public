local tw = nil
for i, b in ipairs(branches) do
  local pts = b.pts or b
  local ok, r = pcall(ribbon, pts, 2.2)
  if ok then tw = tw and (tw + r) or r end
end
twigM = tw
local gap = (treeZone:grow(5) - oakM2:grow(1) - twigM - foliM:grow(3)) * rect(0, 0, 1000, 245)
print(gap:area())
local bands = {{skyTopS, -5, 70}, {skyMidS, 45, 90}, {skyMid2, 105, 80}, {skyMid3, 165, 90}}
for _, b in ipairs(bands) do
  work(gap * rect(0, b[2], 1000, b[3]), {hand="detail", pile=b[1], angle=0, coverage=3, fill=true, clip=true, length={4,10}})
end
blend((gap:grow(6) - oakM2:grow(1) - twigM - foliM:grow(3)) * rect(0,0,1000,245), {angle=0, coverage=3, length={10, 30}, tool="badger 12"})
