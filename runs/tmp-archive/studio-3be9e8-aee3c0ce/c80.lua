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
hShade = pile{{"lead white",1},{"raw umber",0.8},{"yellow ochre",0.35},{"bone black",0.1}}
hMid = pile{{"lead white",1.6},{"raw umber",0.6},{"yellow ochre",0.3}}
local hm = handle:grow(1)
local b = brush("filbert", 6)
for _, d in ipairs({-4, 0, 3}) do
  b:reload(hShade, 0.7)
  b:stroke(off(sub(4,10), d), {pressure={0.3,0.6}, ramps={0.35,0.05}, orient="across", clip=hm})
end
b:reload(hMid, 0.7)
b:stroke(off(sub(1,5), 4), {pressure={0.5,0.3}, ramps={0.1,0.3}, orient="across", clip=hm})
local r = brush{kind="round", width=3, point=0.4}
r:reload(hMid, 0.6)
r:stroke(off(sub(6,10), 5), {pressure={0.3,0.4}, ramps={0.3,0.2}, clip=hm})
-- orange speck in the loop
local t = brush{kind="round", width=6, point=0.3}
t:reload(bgMid, 0.7)
t:stroke({{444,241},{460,241}}, {pressure={0.6,0.6}, clip=wall - jugBody - hm})
-- lower-left belly: light half-tone strokes curving round the form
local s = brush("filbert", 7)
for y = 506, 597, 7 do
  local xl, xr = edgeX(jugL, y), edgeX(jugR, y)
  local x0, x1 = xl + 3, xl + (xr - xl) * 0.42
  s:reload(jp[3], 0.5)
  s:stroke({{x0, y - 1}, {(x0+x1)/2, y + 1.5}, {x1, y + 2}}, {pressure={0.5,0.25}, ramps={0.1,0.5}, orient="across", clip=jugBody})
end
-- highlight
local hl = brush("filbert", 6)
hl:reload(jp[1], 0.8)
local hx = function(y, t) local xl, xr = edgeX(jugL, y), edgeX(jugR, y); return xl + (xr - xl) * t end
hl:stroke({{hx(335,0.2),335},{hx(380,0.17),380},{hx(430,0.17),430}}, {pressure={0.2,0.2}, ramps={0.4,0.5}, clip=jugBody})
hl:reload(jp[1], 0.8)
hl:stroke({{hx(215,0.22),215},{hx(245,0.2),245}}, {pressure={0.1,0.1}, ramps={0.4,0.5}, clip=jugBody})
