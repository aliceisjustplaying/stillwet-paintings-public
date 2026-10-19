print(wait(180))
local edgepts = {{-5,572},{40,566},{110,564},{190,573},{260,592},{320,618},{370,650},{395,672}}
local function edgeAt(t)
  local n = #edgepts - 1
  local f = t*n; local i = math.floor(f); if i >= n then i = n-1 end
  local u = f - i
  local a, b = edgepts[i+1], edgepts[i+2]
  return a[1] + (b[1]-a[1])*u, a[2] + (b[2]-a[2])*u
end
local r = brush{kind="rigger", width=1.8, point=1}
local clumps = uneven(22, 0.0, 0.93, 0.7, 0.3, 111)
for _, c in ipairs(clumps) do
  local nb = math.random(4, 10)
  local H = rand(14, 40) * (1 - 0.35*c)
  for k = 1, nb do
    local t = c + randn(0, 0.008)
    local x, y = edgeAt(clamp(t,0,1))
    y = y + rand(1, 8)
    local h = H * rand(0.5, 1.1)
    local lean = randn(0.2, 0.3)
    local p = (math.random() < 0.7) and grassD or grassL
    r:reload(p, rand(0.45,0.75))
    r:stroke({{x, y}, {x + lean*h*0.3, y - h*0.5}, {x + lean*h, y - h}}, {pressure={rand(0.5,0.8), 0}, ramps={0.05, 0.85}})
  end
end
