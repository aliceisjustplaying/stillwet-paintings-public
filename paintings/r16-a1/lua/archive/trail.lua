trailP = pile{{"lead white",2.2},{"smalt",1.5},{"raw umber",0.3},{"red earth",0.08}, medium=0.1}
local path = {{150,725},{215,665},{300,608},{385,560},{450,527},{497,502}}
local ws = {}
for i,p in ipairs(path) do local s = clamp((p[2]-462)/252, 0.05, 1.2); ws[i] = 20*s + 1.5 end
TRAIL = ribbon(path, ws):roughen(1.5, 10, 8)
work(TRAIL, {hand="detail", pile=trailP, coverage=2.5, fill=true, angle=function(x,y) return -0.6 end, tool={kind="filbert", width=4}, pressure={0.4,0.7}})
-- pocks: darker holes, irregular, along the trail
local bk = brush{kind="round", width=3, point=0.6}
bk:load(stepK, 0.8)
local n = #path - 1
for k=1,120 do
  local t = rand(0,1)
  local f = t*n; local i = math.min(math.floor(f)+1, n); local u = f-(i-1)
  local a, b = path[i], path[i+1]
  local x, y = lerp(a[1],b[1],u), lerp(a[2],b[2],u)
  local s = clamp((y-462)/252, 0.05, 1.2)
  x = x + randn(0, 3*s); y = y + randn(0, 1.5*s)
  if bk:fullness() < 0.3 then bk:load(stepK, 0.8) end
  bk:stroke({{x - 3*s, y}, {x, y - 1*s}, {x + 3*s, y + 0.3*s}}, {pressure={bk:pressure_for(math.max(0.6, 2.2*s)), bk:pressure_for(math.max(0.6,1.2*s))}, ramps={0.3,0.3}})
end
-- lit lips of snow thrown up along the trail edges
local bl = brush{kind="round", width=2.5, point=0.8}
bl:load(litS, 0.6)
for k=1,70 do
  local t = rand(0,1)
  local f = t*n; local i = math.min(math.floor(f)+1, n); local u = f-(i-1)
  local a, b = path[i], path[i+1]
  local x, y = lerp(a[1],b[1],u), lerp(a[2],b[2],u)
  local s = clamp((y-462)/252, 0.05, 1.2)
  local side = (math.random()<0.5) and -1 or 1
  x = x + side*10*s*rand(0.8,1.1); y = y + side*3*s + 5*s
  if bl:fullness() < 0.3 then bl:load(litS, 0.6) end
  bl:stroke({{x - 4*s, y}, {x + 4*s, y - 2.5*s}}, {pressure={bl:pressure_for(math.max(0.6, 1.5*s)), 0.1}})
end
