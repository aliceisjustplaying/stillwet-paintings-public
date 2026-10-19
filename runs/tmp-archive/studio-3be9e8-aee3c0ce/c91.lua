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
local function sub(i, j) local o = {} for k = i, j do o[#o+1] = H[k] end return o end
local hDark2 = pile{{"raw umber",1},{"lead white",0.45},{"yellow ochre",0.35},{"bone black",0.2}}
local hm = handle:grow(1)
local b = brush("filbert", 7)
b:reload(hDark2, 0.75)
b:stroke(off(sub(5,10), -2), {pressure={0.3,0.65}, ramps={0.45,0.05}, orient="across", clip=hm})
b:reload(hDark2, 0.6)
b:stroke(off(sub(3,6), 4), {pressure={0.1,0.35}, ramps={0.5,0.3}, orient="across", clip=hm})
