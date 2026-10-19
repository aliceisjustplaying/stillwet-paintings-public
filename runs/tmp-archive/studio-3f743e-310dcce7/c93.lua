-- A few reeds against the light at the bank edge
grassdark = pile{{"bone black", 0.35}, {"raw umber", 0.55}, {"green earth", 0.45}, {"cobalt blue", 0.15}, {"lead white", 0.15}}
g = brush{kind="round", width=9, point=1, stiffness=0.5}
spit_edge = function(x) return 1150 + 26 * math.sin(x / 90 + 1) + 14 * math.sin(x / 38 + 2) - 0.28 * x end
xs = uneven(7, 430, 900, 0.7, 0.4, 21)
for _, x in ipairs(xs) do
  if g:fullness() < 0.3 then g:wipe(0.5); g:load(grassdark, 0.95) end
  local hgt = rand(26, 52)
  if x > 560 and x < 760 then hgt = rand(38, 64) end
  local lean = rand(-12, 24)
  local base = spit_edge(x) + 5
  g:stroke({{x, base}, {x + lean * 0.4, base - hgt * 0.55}, {x + lean, base - hgt}},
    {pressure={0.85, 0.05}, ramps={0.08, 0.55}})
end
print("reeds struck")
