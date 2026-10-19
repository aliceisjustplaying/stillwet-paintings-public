-- footprints down the path, and the trough's shaded left wall
fpP = pile{{"smalt",1.5},{"bone black",0.3},{"lead white",1},{"vermilion",0.04}, medium=0.3}
local function pathAt(t)
  local n = #pathC
  local f = t * (n - 1) + 1
  local i = math.min(math.floor(f), n - 1)
  local u = f - i
  local p, q = pathC[i], pathC[i + 1]
  return lerp(p[1], q[1], u), lerp(p[2], q[2], u), math.atan(q[2] - p[2], q[1] - p[1])
end
local m = nil
local t, side = 0.005, 1
while t < 0.97 do
  local x, y, a = pathAt(t)
  local sc = 0.5 + 2.6 * ((y - 536) / 184)^1.3
  local nx, ny = -math.sin(a), math.cos(a)
  local fx, fy = x + nx * side * sc * 0.9, y + ny * side * sc * 0.9
  local e = ellipse(fx, fy, sc * 0.75, sc * 0.45)
  m = m and (m + e) or e
  side = -side
  t = t + 0.004 + 0.022 * sc / 3
end
fpM = m:roughen(0.3, 1.5, 53)
work(fpM, {hand="detail", tool={kind="round", width=1, point=0.6}, pile=fpP, load=0.7, pressure={0.5, 0.8}, coverage=3, fill=true, clip=true, angle=0})
-- the left wall of the trough in shade, a soft blue line
local r = brush{kind="round", width=3, point=0.8}
local pts = {}
for i, p in ipairs(pathC) do
  local w = 2 + 30 * ((p[2] - 536) / 184)^1.4
  pts[#pts+1] = {p[1] - w * 0.46, p[2] + 0.5}
end
r:load(fpP, 0.5)
r:stroke(pts, {pressure={0.12, 0.45}, ramps={0.2, 0.1}})
