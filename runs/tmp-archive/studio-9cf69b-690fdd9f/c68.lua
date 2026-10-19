local function h(y) return 0.34*(y-470)^2/3400 + 0.35 end
local S = stepsM
local far = mask(function(x, y)
  if y < 560 or y > 716 or x < 580 or x > 780 then return 0 end
  if S:at(x, y) < 0.5 then return 0 end
  local d = math.max(0.45 * h(y), 0.6)
  return (S:at(x, y - d) < 0.5) and 1 or 0
end)
local near = mask(function(x, y)
  if y < 580 or y > 716 or x < 580 or x > 780 then return 0 end
  if S:at(x, y) > 0.5 then return 0 end
  local d = math.max(0.3 * h(y), 0.6)
  return (S:at(x, y - d) > 0.5) and 1 or 0
end)
print(far:area(), near:area())
work(far, {hand="detail", pile=chamber, coverage=2, pressure={0.35,0.6}, load=0.5, fill=true, angle=0, tool={kind="round", width=1.2}})
work(near, {hand="detail", pile=snowTop, coverage=2.5, pressure={0.4,0.7}, load=0.7, fill=true, angle=0, tool={kind="round", width=1.2}})
