-- two days later: the calm lines on the water, pale where they catch the glow, a few dark ripples near me
rest(40)
sitting{hours=4}
print(drying(500, 500), drying(300, 560), drying(500, 610))
local base = HZ + 2
local lb = brush{kind="round", width=1.2}
local db = brush{kind="round", width=1.6}
local y = base + 5
local n = 0
while y < 600 do
  local d = y - base
  local len = 60 + d * 2.2 + rand(-30, 60)
  local cx = rand(20, 980)
  if math.abs(cx - 500) < 40 and rand() < 0.5 then cx = cx + 120 end
  local sky = sample(cx, math.max(10, HZ - 8 - d * 1.8), 6)
  local c = mix(shift(sky, -0.02, 0, 0), sample(cx, y, 3), 0.35)
  if n % 3 == 0 then lb:reload(c, 0.6) end
  local wob = rand(-0.6, 0.6)
  lb:stroke({{cx - len / 2, y + wob}, {cx, y}, {cx + len / 2, y - wob}}, {pressure={0.35 + d * 0.002, 0.2}, ramps={0.25, 0.4}, shake=0.2})
  n = n + 1
  y = y + 1.5 + d * 0.035 + rand(0, 3.5)
end
-- a few darker ripples in the near water
local yy = 540
while yy < 615 do
  local len = rand(40, 140); local cx = rand(0, 1000)
  if rand() < 0.4 then db:reload(shift(sample(cx, yy, 4), -0.05, 0, -0.01), 0.6) end
  db:stroke({{cx - len / 2, yy}, {cx + len / 2, yy + rand(-0.5, 0.5)}}, {pressure={0.3, 0.2}, ramps={0.3, 0.4}})
  yy = yy + rand(4, 11)
end
print(n, "calm lines")
local t = timesheet(); print(string.format("sitting %.0f min", t.sitting))
