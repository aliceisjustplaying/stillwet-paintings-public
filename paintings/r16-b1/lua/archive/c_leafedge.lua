function leafEdge(rx, ry, rw, rh, seed)
  local R = rect(rx, ry, rw, rh)
  local band = ((foliM:grow(4):roughen(1.5, 3, seed) - foliM:shrink(2.5)) * R) - oakM2:grow(0.5)
  work(band, {hand="detail", pile=foliDark2, coverage=3.5, fill=true, clip=true, length={2,5}})
  local ring = (foliM:grow(8) - foliM:grow(3)) * R
  local sp = nil
  local n = 0
  for i = 1, math.floor(rw*rh/10) do
    local x, y = rand(rx, rx+rw), rand(ry, ry+rh)
    if ring:at(x, y) > 0.5 and rand(0,1) < 0.35 then
      local e = ellipse(x, y, rand(1.2, 2.6), rand(1.0, 2.0))
      sp = sp and (sp + e) or e; n = n + 1
    end
  end
  if sp then work(sp, {hand="detail", pile=foliDark, coverage=3.5, fill=true, clip=true, length={1.5,3}}) end
  return n
end
print(leafEdge(40, 215, 120, 100, 901))
