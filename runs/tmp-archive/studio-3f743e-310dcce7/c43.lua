-- Grasses and reeds on the bank edge
grassdark = pile{{"bone black", 0.5}, {"raw umber", 0.65}, {"cobalt blue", 0.2}, {"green earth", 0.25}, {"lead white", 0.2}}
g = brush{kind="rigger", width=2.2, point=1, stiffness=0.45}
g:load(grassdark, 0.9)

spit_edge = function(x) return 1150 + 26 * math.sin(x / 90 + 1) + 14 * math.sin(x / 38 + 2) - 0.28 * x end
xs = uneven(26, 30, 990, 0.8, 0.35, 7)
for i, x in ipairs(xs) do
  local hgt = rand(16, 48)
  if x > 640 and x < 900 then hgt = rand(34, 62) end
  local lean = rand(-14, 26)
  local base = spit_edge(x) + 4
  g:stroke({{x, base}, {x + lean * 0.4, base - hgt * 0.6}, {x + lean, base - hgt}},
    {pressure={0.65, 0.03}, ramps={0.12, 0.45}})
end
-- three taller reeds near the light
for _, x in ipairs({688, 742, 812}) do
  local base = spit_edge(x) + 4
  local hgt = rand(70, 92)
  local lean = rand(-6, 14)
  g:stroke({{x, base}, {x + lean * 0.5, base - hgt * 0.55}, {x + lean, base - hgt}},
    {pressure={0.6, 0.02}, ramps={0.1, 0.5}})
end
print("grasses in:", #xs + 3)
