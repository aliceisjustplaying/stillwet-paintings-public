printP = pile{{"lead white",2.5},{"pale smalt",2},{"smalt",0.7},{"raw umber",0.35},{"vermilion",0.03}, medium=0.1}
-- the track: from the lower edge up to where the man stands, getting smaller with distance
local path = {{742,722},{712,680},{676,636},{640,600},{606,574},{578,556},{566,551}}
local function at(t)
  local n = #path - 1
  local f = t * n; local i = math.min(math.floor(f) + 1, n); local u = f - (i - 1)
  local a, b = path[i], path[i+1]
  return lerp(a[1], b[1], u), lerp(a[2], b[2], u), math.atan(b[2]-a[2], b[1]-a[1])
end
local t = 0.0
local side = 1
local m = nil
while t < 0.985 do
  local x, y, ang = at(t)
  local s = lerp(1, 0.18, t^0.7)          -- scale with distance
  local nx, ny = -math.sin(ang), math.cos(ang)
  local px, py = x + nx * side * 5 * s, y + ny * side * 5 * s
  local e = ellipse(px, py, 7 * s + 0.6, 3.2 * s + 0.4)
  m = m and (m + e) or e
  side = -side
  t = t + 0.022 * s + 0.004
end
trackM = m:roughen(0.4, 2, 91)
work(trackM, {hand="detail", pile=printP, coverage=2.5, pressure={0.4,0.7}, load=0.6, fill=true, angle=0, tool={kind="round", width=1.8}})
-- the lit far lips of the larger prints
local r = brush{kind="round", width=2, point=1}
r:load(snowTop, 0.5)
t = 0
side = 1
while t < 0.6 do
  local x, y, ang = at(t)
  local s = lerp(1, 0.18, t^0.7)
  local nx, ny = -math.sin(ang), math.cos(ang)
  local px, py = x + nx * side * 5 * s, y + ny * side * 5 * s
  r:stroke({{px - 6*s, py - 3*s}, {px, py - 3.8*s}, {px + 6*s, py - 3*s}}, {pressure={0.3, 0.05}})
  side = -side
  t = t + 0.022 * s + 0.004
end
