-- a few thin strata, drawn by hand: long, slightly wavering strokes of a half-dry filbert
local notree = -(oak:mask():grow(1.5) + tower:grow(1))
local cb = brush{kind="filbert", width=5}
local lines = {
  {y=318, x0=250, x1=560, c="#d0b5b3"}, {y=328, x0=600, x1=960, c="#d6bab2"}, {y=300, x0=420, x1=780, c="#c8b0b2"},
  {y=276, x0=140, x1=430, c="#bca9b1"}, {y=262, x0=560, x1=1000, c="#b9a8b2"}, {y=236, x0=300, x1=640, c="#aea2ae"},
  {y=345, x0=700, x1=1000, c="#dbc0b0"}, {y=352, x0=360, x1=560, c="#d8c0b2"}, {y=212, x0=720, x1=990, c="#a59cab"},
}
for i, l in ipairs(lines) do
  local pts = {}
  local n = 7
  for k = 0, n do
    local x = l.x0 + (l.x1 - l.x0) * k / n
    pts[#pts + 1] = {x, l.y + 2.5 * math.sin(x / 70 + i) + rand(-1, 1)}
  end
  for pass = 1, 2 do
    cb:reload(mix(l.c, sample(0.5 * (l.x0 + l.x1), l.y), 0.05 + 0.12 * pass), 0.55)
    local off = {}
    for k, p in ipairs(pts) do off[k] = {p[1] + rand(-8, 8), p[2] + (pass - 1.5) * 3 + rand(-0.6, 0.6)} end
    cb:stroke(off, {pressure={0.45, 0.2}, ramps={0.3, 0.4}, shake=0.8, swell={0.8, 1.2, 0.7}, clip=notree})
  end
end
