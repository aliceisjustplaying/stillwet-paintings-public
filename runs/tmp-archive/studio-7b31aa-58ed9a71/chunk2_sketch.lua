local c = chalk()

-- Horizon / rear shelf line
c:sketch({{0, 535}, {350, 532}, {680, 528}, {1000, 525}}, {pressure=0.35, wander=1.0})

-- Front edge of wooden shelf
c:sketch({{0, 675}, {400, 672}, {750, 670}, {1000, 668}}, {pressure=0.4, wander=1.2})

-- Stoneware pitcher contour
c:sketch({
  {320, 265}, {310, 280}, {315, 330}, -- neck left
  {250, 390}, {235, 450}, {260, 520}, {310, 575}, -- belly left & base
  {440, 575}, {480, 520}, {495, 440}, {470, 380}, -- base right & belly right
  {415, 330}, {420, 280}, {410, 265}, -- neck right
  {365, 260}, {320, 265} -- rim
}, {pressure=0.45, wander=1.5, passes=2})

-- Pitcher mouth ellipse
c:sketch({{320, 265}, {365, 275}, {410, 265}, {365, 258}, {320, 265}}, {pressure=0.35})

-- Pitcher handle
c:sketch({
  {315, 305}, {250, 285}, {200, 320}, {195, 370}, {225, 420}, {255, 430}
}, {pressure=0.4, wander=1.2, passes=2})

-- Quince contour (pyriform, knobby)
c:sketch({
  {610, 450}, {585, 485}, {565, 535}, {550, 580}, {560, 625}, {605, 650},
  {665, 652}, {720, 630}, {745, 575}, {730, 525}, {675, 480}, {635, 455},
  {610, 450}
}, {pressure=0.45, wander=1.5, passes=2})

-- Quince stem
c:line({{610, 450}, {602, 430}, {595, 418}}, {pressure={0.5, 0.3}})

-- Bay sprig in foreground
c:sketch({{470, 620}, {510, 645}, {550, 665}, {560, 685}}, {pressure=0.35})
-- Leaf 1
c:sketch({{510, 645}, {490, 635}, {475, 645}, {510, 655}}, {pressure=0.35})
-- Leaf 2
c:sketch({{535, 655}, {560, 645}, {580, 655}, {545, 665}}, {pressure=0.35})
