-- the bank's face: many blades close to the ground's own value, clumped, longer toward me
local pn = noise{seed=121, period=60, octaves=3}
local wind = noise{seed=111, period=160}
local cols = {"#2a271f", "#312d23", "#433d2d", "#4d4633", "#23211b"}
local b1 = brush{kind="rigger", width=0.8, point=1}
local b2 = brush{kind="rigger", width=1.2, point=1}
local i, tries = 0, 0
while i < 2400 and tries < 40000 do
  tries = tries + 1
  local x = rand(-5, 1005)
  local y = rand(bankTop(x) + 8, 720)
  local pz = pn:at01(x, y)
  if rand() < smoothstep(0.35, 0.75, pz) then
    i = i + 1
    local depth = clamp((y - 575) / 140, 0, 1)
    local b = depth > 0.45 and b2 or b1
    if i % 5 == 1 then b:reload(cols[math.random(1, #cols)], 0.7) end
    local h = (4 + 22 * depth) * rand(0.5, 1.4)
    local lean = 0.22 * wind(x, y) + randn(0, 0.22)
    local curl = randn(0, 0.2)
    b:stroke({{x, y}, {x + lean * h * 0.35, y - h * 0.5}, {x + lean * h + curl * h * 0.3, y - h + math.abs(curl) * h * 0.2}},
      {pressure={0.3 + 0.4 * depth, 0}, ramps={0.04, 0.7}, shake=0.2})
  end
end
print(i)
local t = timesheet(); print(t.sitting)
