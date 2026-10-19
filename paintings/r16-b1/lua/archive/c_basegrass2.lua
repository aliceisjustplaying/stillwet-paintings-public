for i = 1, 4 do gb[i]:reload(gpiles[i], 0.8) end
for x = 250, 362, 0.8 do
  if rand(0,1) < 0.85 then
    local yb = 604 + randn(0, 2.5)
    local k = (rand(0,1) < 0.5) and 1 or ((rand(0,1) < 0.75) and 2 or 3)
    blade(k, x, yb, rand(8, 20), -math.pi/2 + randn(0, 0.28), rand(0.6, 1.0))
  end
end
for x = 262, 345, 2.2 do
  local k = (rand(0,1) < 0.6) and 2 or 3
  blade(k, x + randn(0,1), 598 + rand(0, 4), rand(5, 11), -math.pi/2 + randn(0, 0.3), rand(0.5, 0.8))
end
