local cx, cy, rx, ry = 362, 191, 57, 11
local function E(a, sx, sy) return {cx + (rx*(sx or 1))*math.cos(a), cy + (ry*(sy or 1))*math.sin(a)} end
local b = brush("filbert", 5)
local inLit = pile{{"lead white",1.3},{"raw umber",0.9},{"yellow ochre",0.4},{"green earth",0.2}}
for i = 0, 5 do
  local yy = cy - 7 + i * 2.6
  local half = (rx-4) * math.sqrt(math.max(0, 1 - ((yy-cy)/(ry-2))^2))
  b:reload(inLit, 0.7)
  b:stroke({{cx + half*0.3, yy}, {cx + half, yy}}, {pressure={0.5,0.5}, ramps={0.3,0.05}, clip=opening})
end
-- rim: back line and front right part in the half-tone
local r = brush{kind="round", width=3, point=0.4}
local back = {}
for a = math.pi*1.02, math.pi*1.98, 0.07 do back[#back+1] = E(a, 1.02, 1.12) end
r:reload(jp[2], 0.7)
r:stroke(back, {pressure={0.5,0.45}, ramps={0.2,0.2}})
local front = {}
for a = math.pi*0.55, -0.05, -0.07 do front[#front+1] = E(a, 1.0, 1.15) end
r:reload(jp[4], 0.7)
r:stroke(front, {pressure={0.6,0.5}, ramps={0.2,0.2}})
-- handle shadow: glaze on the descending part, stronger on the outer side
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
local hm = handle:grow(1)
local g = brush("filbert", 8)
g:reload(gCore2, 0.6)
g:stroke(off({H[4],H[5],H[6],H[7],H[8],H[9],H[10]}, -3), {pressure={0.3,0.6}, ramps={0.3,0.05}, clip=hm})
g:reload(gCore2, 0.5)
g:stroke(off({H[6],H[7],H[8],H[9],H[10]}, 3), {pressure={0.2,0.4}, ramps={0.4,0.05}, clip=hm})
g:reload(gCore2, 0.5)
g:stroke({H[1],H[2],H[3]}, {pressure={0.2,0.2}, clip=hm * rect(400,240,40,20)})
-- contact shadow under the jug
local cs = brush("filbert", 5)
cs:reload(kShadow, 0.7)
cs:stroke({{296,602},{330,605},{370,606},{405,604},{425,600}}, {pressure={0.45,0.6}, ramps={0.2,0.1}, clip=table_top - jugBody})
