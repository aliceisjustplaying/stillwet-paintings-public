-- the high stratum was too loud: lose its edges into the blue, mostly on its upper side
print(drying(300, 85), drying(700, 172))
local up = function(x, y) return 0.8 end
local nA = lose(cA, {where=up, angle=0.02, load=0.25, mix=0.2, pressure={0.6, 0.15}, medium=0.55})
local nB = lose(cB, {where=0.6, angle=0, load=0.2, mix=0.25, pressure={0.55, 0.15}, medium=0.55})
print(nA, nB)
local t = timesheet(); print(string.format("sitting %.0f min", t.sitting))
