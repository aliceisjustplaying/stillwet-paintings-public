-- Thicker grass blades and reeds
grassdark = pile{{"bone black", 0.35}, {"raw umber", 0.55}, {"green earth", 0.45}, {"cobalt blue", 0.15}, {"lead white", 0.15}}
g = brush{kind="round", width=11, point=1, stiffness=0.5}

spit_edge = function(x) return 1150 + 26 * math.sin(x / 90 + 1) + 14 * math.sin(x / 38 + 2) - 0.28 * x end
xs = uneven(8, 50, 970, 0.7, 0.4, 13)
for _, x in ipairs(xs) do
  if g:fullness() < 0.3 then g:wipe(0.5); g:load(grassdark, 0.95) end
  local nb = math.random(2, 4)
  for k = 1, nb do
    local bx = x + rand(-8, 8)
    local hgt = rand(20, 48)
    if bx > 600 and bx < 900 then hgt = rand(36, 68) end
    local lean = rand(-18, 34)
    local base = spit_edge(bx) + 6
    g:stroke({{bx, base}, {bx + lean * 0.35, base - hgt * 0.55}, {bx + lean, base - hgt}},
      {pressure={0.85, 0.05}, ramps={0.08, 0.55}})
  end
end
-- reeds
for _, x in ipairs({672, 738, 806, 590}) do
  local base = spit_edge(x) + 6
  local hgt = rand(72, 96)
  local lean = rand(-8, 16)
  g:stroke({{x, base}, {x + lean * 0.5, base - hgt * 0.55}, {x + lean, base - hgt}},
    {pressure={0.85, 0.04}, ramps={0.08, 0.6}})
end
print("blades and reeds in")
