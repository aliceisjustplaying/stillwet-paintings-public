local c = chalk()
-- Table ledge: shelf line
c:line({{0, 565}, {1000, 568}}, {pressure = {0.3, 0.4, 0.35}})
-- Shelf front bevel
c:line({{0, 580}, {1000, 583}}, {pressure = {0.25, 0.3, 0.25}})

-- Pitcher outline
c:sketch({
  {250, 260}, {235, 275}, {230, 310}, {215, 360}, {200, 420}, {205, 480}, {225, 530}, {260, 555},
  {310, 555}, {345, 530}, {365, 480}, {370, 420}, {355, 360}, {340, 310}, {335, 275}, {320, 260}, {250, 260}
}, {pressure = 0.35, wander = 2})

-- Pitcher rim ellipse
c:sketch({
  {250, 260}, {285, 252}, {320, 260}, {285, 268}, {250, 260}
}, {pressure = 0.3, wander = 1})

-- Pitcher handle
c:sketch({
  {345, 315}, {385, 330}, {400, 380}, {385, 430}, {355, 450}
}, {pressure = 0.3, wander = 1.5})

-- First quince (upright, center)
c:sketch({
  {510, 430}, {485, 470}, {470, 520}, {480, 560}, {530, 575}, {585, 565}, {605, 520}, {590, 465}, {550, 425}, {510, 430}
}, {pressure = 0.35, wander = 2})

-- Second quince (tilted, right)
c:sketch({
  {660, 525}, {635, 560}, {645, 595}, {680, 610}, {735, 605}, {775, 575}, {770, 540}, {725, 515}, {660, 525}
}, {pressure = 0.35, wander = 2})

-- Knife on the ledge
c:line({{350, 555}, {420, 572}}, {pressure = 0.3}) -- handle
c:line({{420, 572}, {505, 592}}, {pressure = 0.35}) -- blade
