printDark2 = pile{{"lead white",1},{"pale smalt",2},{"smalt",1.2},{"raw umber",0.45},{"bone black",0.05},{"vermilion",0.03}, medium=0.08}
local function h(y) return 0.34*(y-470)^2/3400 + 0.35 end
local S = stepsM
local upper = mask(function(x, y)
  if y < 552 or y > 716 or x < 565 or x > 790 then return 0 end
  if S:at(x, y) < 0.5 then return 0 end
  local d = math.max(0.6 * h(y), 0.5)
  return (S:at(x, y - d) < 0.5) and 1 or 0
end)
work(upper, {hand="detail", pile=printDark2, coverage=4, pressure={0.6,0.9}, load=1, fill=true, angle=0, tool={kind="round", width=1.0}})
