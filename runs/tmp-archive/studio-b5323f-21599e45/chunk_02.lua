c = chalk()

-- Stone shelf edges
c:sketch({{0, 520}, {1000, 520}}, {pressure=0.25, wander=1.2})
c:sketch({{0, 640}, {1000, 640}}, {pressure=0.35, wander=1.5})

-- Terracotta jug outline
-- Rim
c:sketch({{325, 280}, {380, 275}, {435, 280}, {440, 290}, {380, 295}, {320, 290}, {325, 280}}, {pressure=0.4})
-- Neck & shoulder
c:sketch({{340, 290}, {345, 340}, {310, 390}, {265, 470}, {280, 560}, {315, 620}}, {pressure=0.4})
c:sketch({{420, 290}, {415, 340}, {450, 390}, {495, 470}, {480, 560}, {445, 620}}, {pressure=0.4})
-- Base
c:sketch({{315, 620}, {380, 625}, {445, 620}}, {pressure=0.45})
-- Handle
c:sketch({{342, 330}, {270, 345}, {242, 400}, {248, 455}, {275, 485}}, {pressure=0.35})
c:sketch({{345, 345}, {285, 360}, {260, 405}, {265, 450}, {280, 475}}, {pressure=0.3})

-- Quince outline
c:sketch({
  {660, 545}, {695, 560}, {720, 600}, {715, 635},
  {685, 650}, {640, 650}, {610, 625}, {605, 590},
  {630, 555}, {660, 545}
}, {pressure=0.4})

-- Small peeled lemon & curling peel
c:sketch({
  {515, 615}, {545, 610}, {560, 630}, {550, 645},
  {520, 648}, {505, 635}, {515, 615}
}, {pressure=0.35})
-- Peel spiral trailing over the shelf edge
c:sketch({
  {535, 625}, {555, 632}, {552, 648}, {538, 665}, {542, 690}, {548, 705}
}, {pressure=0.35})

-- Shadow indications
c:sketch({{430, 620}, {540, 635}, {620, 642}}, {pressure=0.25})
c:sketch({{700, 645}, {770, 658}, {820, 665}}, {pressure=0.25})
