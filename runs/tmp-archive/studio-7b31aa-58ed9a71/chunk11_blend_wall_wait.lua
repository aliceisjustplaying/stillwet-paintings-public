-- Re-unify the left background wall
local m_wall_left_patch = mask(function(x, y)
  if x < 320 and y < 530 then
    -- Don't hit the pitcher body center
    if x > 220 and y > 380 and y < 530 then return 0 end
    return 1.0
  end
  return 0.0
end)

work(m_wall_left_patch, {hand="broad", pile=p_unify, angle=0.05, coverage=1.4, fill=true})
blend(mask(function(x, y) return x < 400 and y < 535 and 1 or 0 end), {angle=0.0, coverage=1.2})

-- Advance time to let underpainting set
wait(180)

print("Status after 3 hours drying:")
print("pitcher:", drying(360, 450))
print("quince:", drying(650, 550))
print("wall:", drying(200, 300))
