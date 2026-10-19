local tz = foliM:grow(10) + oakM2:grow(5)
for _, B in ipairs(branches) do
  local ws = {}
  for i, w in ipairs(B.w) do ws[i] = w + 6 end
  tz = tz + ribbon(B.pts, ws)
end
treeZone = tz
skyStip = above(function(x) return hillY(x) - 3 end) - treeZone
print(skyStip:area())
