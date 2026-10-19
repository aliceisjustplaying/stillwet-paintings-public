local function lens(cx, cy, rx, ry, tilt, seed)
  local pts = {}
  local n = 14
  for i = 0, n - 1 do
    local a = i / n * 2 * math.pi
    local r = 1 + 0.18 * math.sin(3 * a + seed) + 0.1 * math.cos(5 * a + seed * 2)
    local x = cx + rx * math.cos(a) * r
    local y = cy + ry * math.sin(a) * (1 + 0.3 * math.sin(2*a + seed)) + tilt * (x - cx)
    pts[#pts + 1] = {x, y}
  end
  return poly(pts, true)
end
puddles = {
  lens(80, 626, 58, 4.5, -0.02, 1),
  lens(470, 618, 44, 3.5, 0.015, 2),
  lens(318, 645, 30, 3, 0.0, 3),
  lens(525, 652, 26, 2.6, -0.03, 4),
}
local all = puddles[1] + puddles[2] + puddles[3] + puddles[4]
local near = pile{{"lead white",4},{"smalt",1.0},{"red earth",0.5},{"raw umber",0.55}}
work(all, {hand="body", tool="filbert 4", pile=near, angle=0, coverage=2.2, length={10,40}, clip=true, pressure={0.4,0.7}, fill=true})
