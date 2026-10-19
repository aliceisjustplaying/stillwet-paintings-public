function riseY(x)
  local c = riseCurve
  for i=1,#c-1 do
    if x >= c[i][1] and x <= c[i+1][1] then
      local t = (x - c[i][1])/(c[i+1][1]-c[i][1])
      t = t*t*(3-2*t)
      return lerp(c[i][2], c[i+1][2], t)
    end
  end
  return c[#c][2]
end
local riseTopM = below(function(x) return riseY(x) - 1 end)
local bandA = riseTopM - below(function(x) return riseY(x) + 22 end)
local bandB = below(function(x) return riseY(x) + 18 end) - below(function(x) return 655 + (x-300)*0.05 end)
local bandC = below(function(x) return 650 + (x-300)*0.05 end) * riseTopM
r1 = pile{{"yellow ochre",3},{"Prussian blue",0.3},{"lead white",1.5},{"chrome yellow",0.35}, medium=0.06}
r2 = pile{{"yellow ochre",2.5},{"Prussian blue",0.55},{"raw umber",0.6},{"lead white",0.4}, medium=0.06}
r3 = pile{{"raw umber",1.5},{"Prussian blue",0.6},{"yellow ochre",1},{"bone black",0.12}, medium=0.06}
work(bandC, {hand="body", tool="filbert 10", pile=r3, angle=-0.08, coverage=2.2, fill=true, pressure={0.45,0.7}, seed=201})
work(bandB, {hand="body", tool="filbert 8", pile=r2, angle=function(x,y) return math.atan(riseY(x+5)-riseY(x-5), 10) end, coverage=2.2, fill=true, pressure={0.45,0.7}, seed=202})
work(bandA, {hand="body", tool="filbert 5", pile=r1, angle=function(x,y) return math.atan(riseY(x+5)-riseY(x-5), 10) end, coverage=2.4, fill=true, pressure={0.45,0.7}, edge={found=0.3, soft=0.7}, seed=203})
blend(riseTopM:shrink(3), {angle=function(x,y) return math.atan(riseY(x+5)-riseY(x-5), 10) end, coverage=1.3, seed=204})
