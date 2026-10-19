stepS2 = pile{{"lead white",1.2},{"smalt",1.8},{"raw umber",0.35},{"red earth",0.08}, medium=0.1}
local path = {{150,725},{215,665},{300,608},{385,560},{450,527},{497,502}}
local function interp(t)
  local n = #path - 1; local f = t*n; local i = math.min(math.floor(f)+1, n); local u = f - (i-1)
  local a, b = path[i], path[i+1]
  return lerp(a[1],b[1],u), lerp(a[2],b[2],u), math.atan(b[2]-a[2], b[1]-a[1])
end
local t, side = 0, 1
local bl = brush{kind="round", width=2, point=1}
bl:load(stepL, 0.6)
while t < 1 do
  local x, y, a = interp(t)
  local s = clamp((y - 462)/(714 - 462), 0.05, 1.2)
  local nx, ny = -math.sin(a), math.cos(a)
  local px, py = x + side*nx*3.2*s + rand(-0.8,0.8)*s, y + side*ny*3.2*s*0.5
  local L = 11*s*rand(0.85,1.15); local Wd = 6*s
  local ca, sa = math.cos(a), math.sin(a)
  local w = brush{kind="filbert", width=math.max(1.3, Wd)}
  w:load(stepS2, 0.9)
  w:stroke({{px - ca*L*0.5, py - sa*L*0.3}, {px + ca*L*0.5, py + sa*L*0.3}}, {pressure={0.85,0.6}, orient="across"})
  if bl:fullness() < 0.3 then bl:load(stepL, 0.6) end
  bl:stroke({{px - ca*L*0.45, py - sa*L*0.3 - Wd*0.55}, {px + ca*L*0.35, py + sa*L*0.2 - Wd*0.6}}, {pressure={bl:pressure_for(math.max(0.6, 1.6*s)), 0.1}})
  side = -side
  t = t + 0.012 * (0.35 + s)
end
