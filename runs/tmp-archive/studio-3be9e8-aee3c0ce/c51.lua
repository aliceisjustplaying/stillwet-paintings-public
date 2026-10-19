local H = {{420,236},{445,231},{470,233},{492,244},{505,265},{510,295},{505,325},{495,352},{484,374},{474,393}}
local function off(pts, d)
  local out = {}
  for i = 1, #pts do
    local a = pts[math.max(1, i-1)]; local c = pts[math.min(#pts, i+1)]
    local dx, dy = c[1]-a[1], c[2]-a[2]
    local l = math.sqrt(dx*dx+dy*dy)
    out[i] = {pts[i][1] - dy/l*d, pts[i][2] + dx/l*d}
  end
  return out
end
-- normal (-dy, dx): for path going right then down, positive d points ... test outward = up/right
local b = brush("filbert", 9)
b:reload(jp[5], 0.8)
b:stroke(H, {pressure={0.7,0.6}, ramps={0.05,0.1}, orient="across"})
b:reload(jp[5], 0.8)
b:stroke(off(H, 4), {pressure={0.6,0.5}, ramps={0.05,0.1}, orient="across"})
b:reload(jp[5], 0.8)
b:stroke(off(H, -4), {pressure={0.6,0.5}, ramps={0.05,0.1}, orient="across"})
local d = brush("filbert", 5)
d:reload(jDark, 0.7)
d:stroke(off({H[4],H[5],H[6],H[7],H[8],H[9],H[10]}, 7), {pressure={0.5,0.4}, ramps={0.1,0.2}, orient="across"})
d:reload(jDark, 0.7)
d:stroke(off({H[5],H[6],H[7],H[8],H[9],H[10]}, -7), {pressure={0.4,0.3}, ramps={0.2,0.2}, orient="across"})
local l = brush{kind="round", width=4, point=0.4}
l:reload(jp[2], 0.7)
l:stroke(off({H[1],H[2],H[3],H[4],H[5]}, -6), {pressure={0.7,0.2}, ramps={0.1,0.5}})
l:reload(jp[3], 0.6)
l:stroke(off({H[4],H[5],H[6],H[7]}, -2), {pressure={0.5,0.1}, ramps={0.1,0.6}})
