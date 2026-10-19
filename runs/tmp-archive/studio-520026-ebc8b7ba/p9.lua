-- check the composition as numbers before any paint goes on
function nearrim(x) return BOWLY + BOWLRY * math.sqrt(math.max(0, 1 - ((x-BOWLX)/BOWLRX)^2)) end
print(string.format("table line: y=%.0f at x=0, y=%.0f at x=500, y=%.0f at x=1000", tline(0), tline(500), tline(1000)))
print(string.format("bowl rim: x %.0f..%.0f  y %.0f..%.0f  near rim y at x=575 is %.0f",
  BOWLX-BOWLRX, BOWLX+BOWLRX, BOWLY-BOWLRY, BOWLY+BOWLRY, nearrim(575)))
for i, a in ipairs(AP) do
  print(string.format("apple %d %s: x %.0f..%.0f  y %.0f..%.0f | breaks table line by %.0f | rim at its x is y=%.0f so it is cut by %.0f",
    i, a.k, a.cx-a.r, a.cx+a.r, a.cy-a.r, a.cy+a.r,
    tline(a.cx) - (a.cy-a.r), nearrim(a.cx), (a.cy+a.r) - nearrim(a.cx)))
end
-- overlaps between fruit
for i=1,#AP do for j=i+1,#AP do
  local A, B = AP[i], AP[j]
  local d = math.sqrt((A.cx-B.cx)^2 + (A.cy-B.cy)^2)
  if d < A.r + B.r then print(string.format("  %d and %d touch: centres %.0f apart, radii %.0f", i, j, d, A.r+B.r)) end
end end
-- cloth back edge height at a few x
for _, x in ipairs{0, 200, 400, 600, 800, 1000} do
  print(string.format("cloth back edge at x=%d is about y=%d (table line y=%d, so bare table band %d)",
    x, clothpts[#(clothpts > x and 1 or 1) or 1] and 0 or 0, 0, 0))
end
