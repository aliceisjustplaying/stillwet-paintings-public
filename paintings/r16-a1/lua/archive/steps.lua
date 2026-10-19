stepS = pile{{"lead white",2},{"smalt",1.6},{"raw umber",0.25},{"red earth",0.05}, medium=0.1}
stepL = pile{{"lead white",5},{"yellow ochre",0.12},{"vermilion",0.04},{"smalt",0.3}, medium=0.1}
-- path of the walker, near to far
local path = {{150,725},{215,665},{300,608},{385,560},{450,527},{497,502}}
-- resample by arc length with perspective spacing
local function interp(t)
  local n = #path - 1; local f = t*n; local i = math.min(math.floor(f)+1, n); local u = f - (i-1)
  local a, b = path[i], path[i+1]
  return lerp(a[1],b[1],u), lerp(a[2],b[2],u), math.atan(b[2]-a[2], b[1]-a[1])
end
local t, side = 0, 1
local bs = brush{kind="filbert", width=4}
local bl = brush{kind="round", width=1.5, point=1}
bs:load(stepS, 0.8); bl:load(stepL, 0.6)
local count = 0
while t < 1 do
  local x, y, a = interp(t)
  local s = clamp((y - 462)/(714 - 462), 0.05, 1.2)
  local nx, ny = -math.sin(a), math.cos(a)
  local px, py = x + side*nx*3.2*s, y + side*ny*3.2*s*0.5
  local L = 9*s; local Wd = 4.5*s
  local ca, sa = math.cos(a), math.sin(a)
  -- the print as a short dragged mark along the walking direction (foreshortened)
  if bs:fullness() < 0.3 then bs:load(stepS, 0.8) end
  local w = brush{kind="filbert", width=math.max(1.2, Wd)}
  w:load(stepS, 0.8)
  w:stroke({{px - ca*L*0.5, py - sa*L*0.25}, {px + ca*L*0.5, py + sa*L*0.25}}, {pressure={0.7,0.5}, orient="across"})
  -- lit back rim (far edge)
  if bl:fullness() < 0.3 then bl:load(stepL, 0.6) end
  bl:stroke({{px - ca*L*0.4 - Wd*0.3, py - sa*L*0.2 - Wd*0.35}, {px + ca*L*0.3 - Wd*0.3*0, py + sa*L*0.15 - Wd*0.45}}, {pressure={bl:pressure_for(math.max(0.6, 1.2*s)), 0.1}})
  side = -side
  t = t + 0.012 * (0.35 + s)
  count = count + 1
end
print(count)
