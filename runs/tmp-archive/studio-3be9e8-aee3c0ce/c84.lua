local jb = jugBody:grow(1)
local C = jb * mask(function(x,y)
  if y < 440 then return 0 end
  local t = jT(x,y)
  return smoothstep(0.5, 0.64, t) * (1 - smoothstep(0.9, 0.98, t)) * smoothstep(440, 490, y)
end)
work(C, {hand="glaze", pile=gCore2, angle=0.05, angle_jitter=0.05, coverage=1.5, threshold=0.3, clip=jb})
local Z = jb * mask(function(x,y) if y < 196 then return 0 end; return smoothstep(0.44, 0.56, jT(x,y)) end)
blend(Z, {angle=1.5708, tool={kind="badger", width=24}})
blend(Z, {angle=0.05, tool={kind="badger", width=24}})
-- handle: darker strap on the shadowed descending part
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
local hDark = pile{{"raw umber",1},{"lead white",0.6},{"yellow ochre",0.3},{"bone black",0.15}}
local hm = handle:grow(1)
local b = brush("filbert", 5)
b:reload(hDark, 0.7)
b:stroke(off(sub(4,10), -4), {pressure={0.3,0.6}, ramps={0.4,0.05}, orient="across", clip=hm})
b:reload(hDark, 0.6)
b:stroke(off(sub(5,10), 0), {pressure={0.2,0.5}, ramps={0.5,0.05}, orient="across", clip=hm})
