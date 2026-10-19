-- Blend across the transition zone in the background wall
local wall_transition = rect(350, 0, 200, 520) - pitcher_full
blend(wall_transition, {angle = -0.3, coverage = 2.0})
blend(wall_transition, {angle = 0, coverage = 1.5})
print("Wall transition smoothly blended.")
