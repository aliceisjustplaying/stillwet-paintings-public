--@ undone 1 · was chunk 6 · undone · 1079 bytes

-- A chunk 6: sink the foot in grass (sketchbook 6, "a straight base line makes a rock
-- architecture"; sketchbook 8, curving rigger blades set down lightly and lifted off), on dry paint
dry()
local lean = noise{seed=75, period=120}
local cols = {"#4d4a2e", "#6b6840", "#8a8456", "#3e3d28", "#7a7348", "#a09868"}
local g = brush("rigger", 0.8)
local n = 0
local foot = rk.foot or {}
for i = 1, 1400 do
  local x, y
  if i <= 700 then x = rand(240, 790); y = 522 + rand(-8, 26) + 0.02 * (x - 500)
  else x = rand(0, 1000); y = rand(560, 667) end
  local depth = smoothstep(HZ, H, y)
  local h = (8 + 34 * depth) * rand(0.5, 1.6) * (i <= 700 and 0.7 or 1)
  local a = -1.5708 + 0.35 * lean(x, y) + randn(0, 0.22)
  local curl = randn(0, 0.25)
  local mx, my = x + math.cos(a) * h * 0.5, y + math.sin(a) * h * 0.5
  local tx, ty = x + math.cos(a + curl) * h, y + math.sin(a + curl) * h
  if i % 7 == 1 then g:reload(cols[(i // 7) % 6 + 1], 0.7) end
  g:stroke({{x, y}, {mx, my}, {tx, ty}}, {pressure={0.35 + 0.5 * depth, 0}, ramps={0.05, 0.75}})
  n = n + 1
end
print("blades", n)

