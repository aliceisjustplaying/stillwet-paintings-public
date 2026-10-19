local r = brush{kind="rigger", width=2.2, point=1}
local n = 0
-- find the bank's top edge along x
local function edgeY(x)
  for y = 560, 714, 2 do if fg:at(x, y) > 0.5 then return y end end
  return 714
end
local xs = uneven(70, 0, 430, 0.7, 0.6, 191)
for i, x in ipairs(xs) do
  local y0 = edgeY(x) + rand(2, 10)
  local tall = (x > 250) and rand(40, 110) or rand(25, 70)
  local lean = randn(0.15, 0.25)
  local bend = randn(0, 0.12)
  local pts = {}
  for k = 0, 4 do
    local t = k / 4
    local a = -math.pi/2 + lean * t + bend * t * t
    pts[#pts+1] = {x + tall * t * math.cos(-math.pi/2 + lean*t) * 0 + tall * t * math.sin(lean * t + bend*t), y0 - tall * t}
  end
  if n % 3 == 0 then r:reload(pFG, 0.85) end
  n = n + 1
  r:stroke(pts, {pressure={rand(0.6,0.8), 0.0}, ramps={0.02, 0.7}})
end
print(n)
