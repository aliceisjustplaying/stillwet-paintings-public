-- Unifying background and establishing correct table perspective

-- 1. Unify upper background with a glazing pass and broad blending
local m_upper_wall = rect(0, 0, 1000, 520)
work(m_upper_wall, {
  hand = "broad",
  tool = "filbert 24",
  pile = pile{{"raw umber", 4}, {"bone black", 2}, {"yellow ochre", 1}, medium = 0.35},
  angle = -0.2,
  coverage = 1.2
})
blend(m_upper_wall, {hand = "blend", tool = "badger 40", coverage = 1.8, angle = 0})

-- 2. Stone tabletop plane: from y = 520 to y = 620
-- The table surface slopes very slightly or sits flat in perspective
local m_table_surface = rect(0, 520, 1000, 100)
p_table_top = pile{{"lead white", 4}, {"yellow ochre", 2}, {"raw umber", 2}, {"bone black", 1}, medium = 0.15}

-- Work table top horizontally with wide strokes
work(m_table_surface, {
  hand = "body",
  tool = "filbert 20",
  pile = p_table_top,
  angle = 0.0,
  coverage = 2.0,
  fill = true
})

-- 3. Stone ledge front face: from y = 622 down to 800
local m_table_face = rect(0, 622, 1000, 178)
p_table_face = pile{{"raw umber", 4}, {"bone black", 3}, {"red earth", 1}, medium = 0.2}

work(m_table_face, {
  hand = "body",
  tool = "filbert 22",
  pile = p_table_face,
  angle = 1.57,
  coverage = 2.0,
  fill = true
})
blend(m_table_face, {hand = "blend", angle = 1.57, coverage = 1.0})

-- 4. Crisp catch-light along the front stone edge (y = 620 to 622)
local b_line = brush{kind = "flat", width = 3, stiffness = 0.7}
b_line:load(pile{{"lead white", 5}, {"yellow ochre", 2}, {"raw umber", 1}}, 0.9)
b_line:stroke({{0, 621}, {1000, 621}}, {pressure = {0.7, 0.75, 0.65}, orient = "along"})
