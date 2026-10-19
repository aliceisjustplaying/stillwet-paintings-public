-- a thin brown lay-in of the values, like a sepia wash: the bank darkest, the water darker toward me
sepia = pal:only{"raw umber", "bone black", "yellow ochre", "lead white"}
wob = noise{seed=4, period=90, octaves=3}
bankcurve = function(x)
  return 626 - 34*G(x, 90, 190) - 26*G(x, 930, 150) + 6*math.sin(x/47)
end
bankM = below(function(x) return bankcurve(x) - 3 end):roughen(2, 14, 5, 1.5)
work(bankM, {hand="broad", tool="flat 10", color="#4a3a2a", angle=function(x, y) return 0.06*wob(x, y) end,
  length={30, 90}, coverage=2.4, medium=0.7, load=0.5, pal=sepia, hug=false})
blend(bankM, {angle=0})
local t = timesheet(); print(string.format("sitting %.0f min", t.sitting))
