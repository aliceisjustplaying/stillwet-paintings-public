stepK = pile{{"lead white",0.7},{"smalt",1.7},{"raw umber",0.5},{"bone black",0.08}, medium=0.1}
local path = {{150,725},{215,665},{300,608},{385,560},{450,527},{497,502}}
local function interp(t)
  local n = #path - 1; local f = t*n; local i = math.min(math.floor(f)+1, n); local u = f - (i-1)
  local a, b = path[i], path[i+1]
  return lerp(a[1],b[1],u), lerp(a[2],b[2],u), math.atan(b[2]-a[2], b[1]-a[1])
end
local t, side = 0, 1
local bk = brush{kind="round", width=3, point=0.7}
local bl = brush{kind="round", width=2, point=1}
bk:load(stepK, 0.8); bl:load(litS, 0.6)
while t < 1 do
  local x, y, a = interp(t)
  local s = clamp((y - 462)/(714 - 462), 0.05, 1.2)
  local nx, ny = -math.sin(a), math.cos(a)
  local px, py = x + side*nx*3.2*s, y + side*ny*3.2*s*0.5
  local L = 11*s; local Wd = 6*s
  local ca, sa = math.cos(a), math.sin(a)
  if bk:fullness() < 0.3 then bk:load(stepK, 0.8) end
  -- dark far wall: a crescent along the upper edge
  bk:stroke({{px - ca*L*0.5, py - sa*L*0.3 - Wd*0.1}, {px, py - Wd*0.38}, {px + ca*L*0.5, py + sa*L*0.3 - Wd*0.15}}, {pressure={bk:pressure_for(math.max(0.6, Wd*0.35)), bk:pressure_for(math.max(0.6, Wd*0.2))}, ramps={0.2,0.3}})
  -- light near lip, below
  if bl:fullness() < 0.3 then bl:load(litS, 0.6) end
  bl:stroke({{px - ca*L*0.45, py - sa*L*0.3 + Wd*0.55}, {px + ca*L*0.4, py + sa*L*0.25 + Wd*0.5}}, {pressure={bl:pressure_for(math.max(0.6, 1.3*s)), 0.1}})
  side = -side
  t = t + 0.012 * (0.35 + s)
end
