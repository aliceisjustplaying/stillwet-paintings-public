-- Grass clumps along the bank edge
grassdark = pile{{"bone black", 0.35}, {"raw umber", 0.55}, {"green earth", 0.45}, {"cobalt blue", 0.15}, {"lead white", 0.15}}
g = brush{kind="round", width=5, point=1, stiffness=0.5}

spit_edge = function(x) return 1150 + 26 * math.sin(x / 90 + 1) + 14 * math.sin(x / 38 + 2) - 0.28 * x end
xs = uneven(9, 40, 980, 0.7, 0.4, 11)
for _, x in ipairs(xs) do
  if g:fullness() < 0.3 then g:wipe(0.5); g:load(grassdark, 0.9) end
  local nb = math.random(2, 3)
  for k = 1, nb do
    local bx = x + rand(-7, 7)
    local hgt = rand(18, 46)
    if bx > 620 and bx < 900 then hgt = rand(30, 60) end
    local lean = rand(-16, 30)
    local base = spit_edge(bx) + 5
    g:stroke({{bx, base}, {bx + lean * 0.35, base - hgt * 0.55}, {bx + lean, base - hgt}},
      {pressure={0.8, 0.06}, ramps={0.1, 0.5}})
  end
end
print("grass clumps in")
