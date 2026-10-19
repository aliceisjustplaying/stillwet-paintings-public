branches = {}
function grow(x, y, ang, len, w, depth, crook)
  local pts = {{x, y}}
  local nseg = math.max(2, math.floor(len / 9))
  local sl = len / nseg
  local cx, cy, a = x, y, ang
  local ws = {w}
  for i = 1, nseg do
    a = a + randn(0, crook or 0.3)
    -- mild tendency: oak limbs spread and turn up at ends
    a = a + 0.06 * (-math.pi/2 - a) * (i/nseg)
    cx = cx + sl * math.cos(a); cy = cy + sl * math.sin(a)
    pts[#pts+1] = {cx, cy}
    ws[#ws+1] = w * (1 - 0.55 * i / nseg)
    if depth > 0 and i < nseg and rand(0,1) < (0.25 + 0.4 * i/nseg) then
      local side = (rand(0,1) < 0.5) and -1 or 1
      grow(cx, cy, a + side * rand(0.45, 1.1), len * rand(0.45, 0.7), ws[#ws] * rand(0.55, 0.75), depth - 1, crook)
    end
  end
  branches[#branches+1] = {pts=pts, w=ws}
  if depth > 0 then
    grow(cx, cy, a + rand(-0.5, 0.5), len * rand(0.4, 0.6), ws[#ws] * 0.8, depth - 1, crook)
  end
end
-- living branches off the boughs, toward crown edges
local seeds = {
 {150,294, math.pi+0.25, 50, 3.5, 3}, {182,304, math.pi+0.7, 45, 3.5, 2}, {206,318, math.pi+1.2, 40, 3, 2},
 {226,330, -2.2, 40, 3.5, 2}, {160,404, math.pi-0.1, 45, 2.8, 2}, {188,418, math.pi+0.9, 35, 2.5, 2},
 {222,422, -2.0, 40, 3, 2}, {252,434, -1.9, 35, 2.8, 2},
 {446,272, -0.25, 45, 3.2, 3}, {420,278, -0.9, 40, 3, 2}, {402,290, 0.3, 45, 3, 2}, {366,322, -0.4, 40, 3, 2},
 {452,330, 0.1, 40, 2.6, 2}, {418,342, 0.6, 35, 2.5, 2}, {385,340, 0.9, 30, 2.5, 2},
 {146,350, math.pi+0.2, 35, 2.4, 2}, {168,352, math.pi-0.5, 30, 2.3, 2},
 {330,380, -0.2, 45, 3.5, 2}, {275,385, math.pi+0.1, 40, 3.5, 2},
 {346,356, 0.5, 40, 3.5, 2}, {262,372, math.pi-0.4, 40, 3.2, 2},
}
for _, s in ipairs(seeds) do grow(s[1], s[2], s[3], s[4], s[5], s[6], 0.32) end
-- dead: short broken stubs on the stag-horns
local dead = {{309,262,-0.6,22,3,0},{304,212,-2.6,18,2.5,0},{312,160,-0.5,14,2,0},{246,252,-0.4,18,2.5,1},{234,300,-2.8,15,2.5,0},
  {396,252,-2.4,16,2.2,0},{418,212,0.1,15,2,0},{358,252,-2.6,14,2.4,0},{374,212,-0.3,12,2,0},{232,202,-2.5,12,2,0}}
for _, s in ipairs(dead) do grow(s[1], s[2], s[3], s[4], s[5], s[6], 0.25) end
rig = brush{kind="round", width=5, point=1}
rig:load(barkD, 0.9)
local n = 0
for _, B in ipairs(branches) do
  local w0 = B.w[1]; local w1 = B.w[#B.w]
  if w0 > 3 then
    work(ribbon(B.pts, B.w), {hand="detail", pile=barkD, coverage=2.5, fill=true, length={4,12}})
  else
    if n % 4 == 0 then rig:load(barkD, 0.8) end
    rig:stroke(B.pts, {pressure={rig:pressure_for(w0), rig:pressure_for(math.max(0.4, w1))}, ramps={0.02, 0.3}})
  end
  n = n + 1
end
print(#branches)
