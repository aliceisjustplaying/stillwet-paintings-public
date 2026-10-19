printDark = pile{{"lead white",1.6},{"pale smalt",2},{"smalt",1.0},{"raw umber",0.4},{"vermilion",0.03}, medium=0.1}
local function h(y) return 0.34*(y-470)^2/3400 + 0.35 end
local S = stepsM
local upper = mask(function(x, y)
  if y < 556 or y > 716 or x < 570 or x > 790 then return 0 end
  if S:at(x, y) < 0.5 then return 0 end
  local d = math.max(0.55 * h(y), 0.5)
  return (S:at(x, y - d) < 0.5) and 1 or 0
end)
work(upper, {hand="detail", pile=printDark, coverage=3, pressure={0.5,0.8}, load=0.8, fill=true, angle=0, tool={kind="round", width=1.2}})
