-- smooth the pagoda-like tops into cones with small drooping tier tips
local function cone(s, frac)
  local top = s.base - s.h
  local yb = top + s.h * frac
  local hw = s.h * 0.29 * (0.25 + 0.75 * frac) * 0.95
  local pts = {{s.cx, top - 2}}
  local n = 7
  for i = 1, n do
    local y = top + (yb - top) * i / n
    local w = hw * (i / n) * (i / n)^(-0.15)
    pts[#pts+1] = {s.cx + w, y + 1.5}
    pts[#pts+1] = {s.cx + w * 0.72, y + 0.2}
  end
  local left = {}
  for i = #pts, 2, -1 do left[#left+1] = {2 * s.cx - pts[i][1], pts[i][2]} end
  for _, p in ipairs(left) do pts[#pts+1] = p end
  return poly(pts):roughen(0.5, 2.5, 9)
end
local m = cone(spruces[2], 0.3) + cone(spruces[1], 0.3) + cone(spruces[3], 0.3) + cone(spruces[4], 0.3)
work(m, {hand="detail", pile=spruceP, load=1, pressure={0.6, 0.9}, coverage=3.5, fill=true, angle=0.4, angle_jitter=0.6})
