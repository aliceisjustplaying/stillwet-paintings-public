local printMid = pile{{"lead white",2.6},{"pale smalt",2},{"smalt",0.7},{"raw umber",0.3},{"vermilion",0.03}, medium=0.08}
work(stepsM:shrink(0.2), {hand="detail", pile=printMid, coverage=4, pressure={0.6,0.9}, load=1, fill=true, angle=0, tool={kind="round", width=1.2}})
local function h(y) return 0.34*(y-470)^2/3400 + 0.35 end
local S = stepsM
local upper = mask(function(x, y)
  if y < 556 or y > 716 or x < 570 or x > 790 then return 0 end
  if S:at(x, y) < 0.5 then return 0 end
  local d = math.max(0.4 * h(y), 0.5)
  return (S:at(x, y - d) < 0.5) and 1 or 0
end)
work(upper, {hand="detail", pile=printDark, coverage=4, pressure={0.6,0.9}, load=1, fill=true, angle=0, tool={kind="round", width=1.0}})
