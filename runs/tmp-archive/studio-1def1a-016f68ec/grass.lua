local bot = rect(-10,630,420,50) * spit3
work(bot, {hand="body", pile=mudA, angle=0.1, coverage=3, fill=true, length={30,80}, clip=rect(-10,600,420,80)*spit3:grow(1)})
grassD = pile{{"raw umber",1},{"bone black",0.3},{"green earth",0.4},{"yellow ochre",0.15}}
grassL = pile{{"yellow ochre",1},{"raw umber",0.4},{"red earth",0.2},{"lead white",0.3}}
-- edge line of the bank, sampled along my drawn curve
local edgepts = {{-5,572},{40,566},{110,564},{190,573},{260,592},{320,618},{370,650},{395,672}}
local function edgeAt(t)
  local n = #edgepts - 1
  local f = t*n; local i = math.floor(f); if i >= n then i = n-1 end
  local u = f - i
  local a, b = edgepts[i+1], edgepts[i+2]
  return a[1] + (b[1]-a[1])*u, a[2] + (b[2]-a[2])*u
end
local r = brush{kind="rigger", width=1.4, point=1}
local ts = uneven(170, 0, 1, 0.8, 0.7, 101)
for i, t in ipairs(ts) do
  local x, y = edgeAt(t)
  y = y + rand(0, 6)
  local h = rand(5, 22) * (1 - 0.4*t)
  local lean = randn(0.15, 0.25)
  local p = (math.random() < 0.8) and grassD or grassL
  r:reload(p, rand(0.4,0.7))
  r:stroke({{x, y}, {x + lean*h*0.4, y - h*0.55}, {x + lean*h, y - h}}, {pressure={rand(0.4,0.7), 0}, ramps={0.05, 0.8}})
end
