-- the water's surface: a few faint level lines of light, closer and shorter toward the far shore
local lb = brush{kind="rigger", width=0.9, point=1}
local db = brush{kind="round", width=1.4}
local y = HZ + 7
local n = 0
while y < 560 do
  local d = (y - HZ) / 110
  local cnt = math.random(1, 3)
  for k = 1, cnt do
    local len = rand(40, 180) * (0.5 + d)
    local x0 = rand(-40, 1000)
    if not (x0 + len > 425 and x0 < 575) or rand() < 0.2 then
      local under = sample(x0 + len / 2, y, 3)
      if rand() < 0.75 then
        lb:reload(shift(mix(under, color(SKY.glow), 0.6), 0.03, 0, 0), 0.5)
        lb:stroke({{x0, y}, {x0 + len * 0.5, y + randn(0, 0.2)}, {x0 + len, y + randn(0, 0.3)}}, {pressure={rand(0.25, 0.45), 0.05}, ramps={0.3, 0.4}})
      else
        db:reload(shift(under, -0.04, 0, -0.01), 0.4)
        db:stroke({{x0, y}, {x0 + len * 0.6, y + randn(0, 0.2)}, {x0 + len * 0.8, y}}, {pressure={0.25, 0.1}, ramps={0.3, 0.4}})
      end
      n = n + 1
    end
  end
  y = y + 2.5 + d * 9 + rand(0, 4)
end
print(n)
