-- the inside of the bowl: the far inner wall, bounded below by the near rim's inner edge
inpts = {}
for i, p in ipairs(arc(BOWLX, BOWLY, BOWLRX-17, BOWLRY-12, math.pi, 2*math.pi, 26)) do inpts[i] = p end
for i = 1, 26 do
  local t = 1 - (i - 1) / 26
  inpts[#inpts+1] = {BOWLX + (BOWLRX-17) * math.cos(math.pi * t * 0 + 0) * 0 +
                     (BOWLRX-17) * (1 - 2*t), BOWLY + (BOWLRY-12) * math.sin(math.pi * t)}
end
BOWL_IN = poly(inpts, true)
print(string.format("inside %.0f  (the inner ellipse is %.0f, so about half is right)",
  BOWL_IN:area(), rim_in:area()))
print(string.format("check: BOWL %.0f vs body+rim+inside = %.0f", BOWL:area(),
  BOWL_BODY:area() + BOWL_RIM:area() + BOWL_IN:area()))
