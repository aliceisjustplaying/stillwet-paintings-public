-- ---------- the composition, decided on paper before any paint ----------
-- one light: up and to the left
LX, LY = -0.50, -0.866

-- the table's far edge, a gentle slope
function tline(x) return 400 - 0.03 * (x - 500) end
tlinep = {{0, tline(0)}, {1000, tline(1000)}}

-- the cloth: a big shape whose back edge crosses the table, running off
-- the left, right and bottom edges
clothpts = {{-10, 590}, {100, 556}, {220, 534}, {350, 526}, {480, 532},
            {610, 540}, {730, 533}, {860, 546}, {1010, 586}}

-- the bowl: rim ellipse centre/radii, and its depth below the rim
BOWLX, BOWLY, BOWLRX, BOWLRY = 575, 498, 185, 62

-- the five apples
AP = {
  {cx=592, cy=400, r=92,  k="g"},   -- green, back, tallest: breaks the table line
  {cx=505, cy=505, r=82,  k="r"},   -- red, in the bowl, left
  {cx=665, cy=515, r=80,  k="r"},   -- red, in the bowl, right
  {cx=300, cy=655, r=88,  k="r"},   -- red, on the cloth, front left
  {cx=485, cy=712, r=72,  k="g"},   -- green, on the cloth, front
}

function circ(cx, cy, rx, ry, n)
  n = n or 44
  local pts = {}
  for i = 0, n do local a = 2*math.pi*i/n; pts[#pts+1] = {cx+rx*math.cos(a), cy+ry*math.sin(a)} end
  return pts
end
function arc(cx, cy, rx, ry, a0, a1, n)
  n = n or 26
  local pts = {}
  for i = 0, n do local a = a0 + (a1-a0)*i/n; pts[#pts+1] = {cx+rx*math.cos(a), cy+ry*math.sin(a)} end
  return pts
end

-- fold lines on the cloth
FOLDS = {
  {{150, 542}, {112, 630}, {72, 750}},
  {{312, 527}, {272, 650}, {240, 792}},
  {{478, 532}, {440, 660}, {424, 796}},
  {{648, 540}, {628, 660}, {622, 796}},
  {{806, 541}, {820, 650}, {842, 788}},
}

h = pencil("2H")
h:line(tlinep, {pressure=0.28, smooth=false})
h:line(clothpts, {pressure=0.32})
-- bowl: far rim, right side, base, left side  (the near rim is an interior line)
h:line(arc(BOWLX, BOWLY, BOWLRX, BOWLRY, math.pi, 2*math.pi, 24), {pressure=0.3})
h:line(arc(BOWLX, BOWLY, BOWLRX, BOWLRY, 0, math.pi, 24), {pressure=0.22})
h:line({{758, 498}, {742, 540}, {700, 578}, {620, 596}, {520, 594}, {452, 574}, {412, 534}, {392, 498}}, {pressure=0.3})
for _, a in ipairs(AP) do h:line(circ(a.cx, a.cy, a.r, a.r*0.97), {pressure=0.32}) end
for _, f in ipairs(FOLDS) do h:line(f, {pressure=0.2}) end
print("drawn")
