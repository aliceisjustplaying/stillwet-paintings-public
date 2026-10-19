local b = brush{kind="flat", width=2.2, stiffness=0.4}
pGlint = pile{{"lead white",8},{"chrome yellow",0.9},{"vermilion",0.05}, medium=0.15}
-- short bright glints in the glow band, under the brightest sky
for i = 1, 22 do
  local y = rand(478, 520)
  local x = rand(500, 900)
  if math.abs(x - 660) > 40 or y < 530 then
    local L = rand(6, 22) * (1 - (y-478)/80)
    b:reload(pGlint, 0.35)
    b:stroke({{x, y}, {x + L, y + rand(-0.3,0.3)}}, {pressure={0.3, 0.15}, ramps={0.3,0.4}, orient="across"})
  end
end
-- long faint wind lines, lower right, a little lighter and cooler than the water
pWind = pile{{"lead white",5},{"pale smalt",1.2},{"vermilion",0.08}, medium=0.3}
for i = 1, 9 do
  local y = rand(600, 700)
  local x0 = rand(420, 800)
  local L = rand(90, 260)
  b:reload(pWind, 0.3)
  b:stroke({{x0, y}, {x0 + L*0.5, y + rand(-0.6,0.6)}, {math.min(x0 + L, 1000), y + rand(-0.6, 0.6)}}, {pressure={0.1, 0.25}, ramps={0.35,0.35}, orient="across"})
end
