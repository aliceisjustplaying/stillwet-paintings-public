trailK = pile{{"lead white",1.2},{"smalt",1.6},{"raw umber",0.45},{"red earth",0.1}, medium=0.1}
local path = {{150,725},{215,665},{300,608},{385,560},{450,527},{497,502}}
local sh, ws = {}, {}
for i,p in ipairs(path) do local s = clamp((p[2]-462)/252, 0.05, 1.2); sh[i] = {p[1] - 3*s, p[2] - 2.5*s}; ws[i] = 9*s + 1 end
local m = ribbon(sh, ws):roughen(1.2, 7, 21) * TRAIL:grow(1)
work(m, {hand="detail", pile=trailK, coverage=2.5, fill=true, angle=-0.6, tool={kind="filbert", width=3}, pressure={0.4,0.7}})
local bk = brush{kind="round", width=4, point=0.6}
bk:load(stepK, 0.9)
local n = #path - 1
for k=1,90 do
  local t = (k - rand(0,1))/90
  local f = t*n; local i = math.min(math.floor(f)+1, n); local u = f-(i-1)
  local a, b = path[i], path[i+1]
  local x, y = lerp(a[1],b[1],u), lerp(a[2],b[2],u)
  local s = clamp((y-462)/252, 0.05, 1.2)
  local side = (k % 2 == 0) and 1 or -1
  x = x + side*3*s + randn(0, 1.2*s); y = y + side*1.2*s
  if bk:fullness() < 0.3 then bk:load(stepK, 0.9) end
  bk:stroke({{x - 4*s, y + 0.5*s}, {x, y - 1.5*s}, {x + 4*s, y}}, {pressure={bk:pressure_for(math.max(0.6, 3*s)), bk:pressure_for(math.max(0.6,1.5*s))}, ramps={0.3,0.3}})
end
