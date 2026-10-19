local n = noise{seed=5, octaves=4, period=60}
local n2 = noise{seed=9, octaves=3, period=18}
farTop = function(x)
  local base = 433 + 2*math.sin(x/140)
  -- groves: little rounded bumps in places
  local g = math.max(0, n(x,0)) * 9 + math.max(0, n2(x,3)) * 3
  return base - g
end
farM = below(farTop) * above(function(x) return 452 end)
fl = pile{{"lead white",5},{"pale smalt",2},{"green earth",1},{"raw umber",0.25}, medium=0.1}
work(farM, {hand="body", tool="filbert 5", pile=fl, angle=0, coverage=2.2, fill=true, pressure={0.4,0.6}, edge=0.1, seed=91})
