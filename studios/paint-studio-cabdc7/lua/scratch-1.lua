-- easel session "scratch": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box friedrich
--@ engine 5

--@ chunk 1
canvas{aspect=1.4, ground={{apply="knife", pile={{"red earth", 3}, {"yellow ochre", 2}, {"lead white", 1}}, texture=0.35, um=45}, {apply="knife", pile={{"lead white", 6}, {"yellow ochre", 1}, {"raw umber", 0.5}}, texture=0.5, um=40}, {apply="brush", pile={{"lead white", 8}, {"yellow ochre", 0.4}, {"raw umber", 0.3}}, um=55}}, linen={14, 16}, seed=11, size=1200}

--@ chunk 2
local sDeep  = pile{{"smalt", 2}, {"Prussian blue", 0.45}, {"bone black", 0.3}, {"lead white", 0.4}, turps=0.55}
local sMid   = pile{{"pale smalt", 2}, {"smalt", 1}, {"lead white", 1.2}, {"raw umber", 0.15}, turps=0.5}
local wDeep = function(x, y) return 1 - smoothstep(40, 260, y) end
local wMid  = function(x, y) return smoothstep(60, 200, y) end
work(above(function(x) return 300 end), {hand="broad", piles={{sDeep, wDeep}, {sMid, wMid}},
  angle=0, length={130, 230}, coverage=1.0, pressure={0.5, 0.75}, seed=3})
print("piles with function weights: ok")

--@ chunk 3
local sGlow  = pile{{"lead white", 3}, {"Naples yellow", 1}, {"red earth", 0.22}, turps=0.4}
local colT = mask(function(x, y)
  if y > 500 and y < 600 and math.abs(x - 500) < 60 then return 1 else return 0 end
end)
stipple(colT, {pile=sGlow, width=2.6, coverage=1.5})
print("stipple bare: ok")

--@ chunk 4
local sGlow  = pile{{"lead white", 3}, {"Naples yellow", 1}, {"red earth", 0.22}, turps=0.4}
local colT = mask(function(x, y)
  if y > 500 and y < 560 and math.abs(x - 500) < 60 then return 1 else return 0 end
end)
stipple(colT, {pile=sGlow, width=2.6, coverage=function(x, y) return 1.5 end})
print("coverage function alone: ok")

--@ chunk 5
local sGlow  = pile{{"lead white", 3}, {"Naples yellow", 1}, {"red earth", 0.22}, turps=0.4}
local colT = mask(function(x, y)
  if y > 570 and y < 630 and math.abs(x - 500) < 60 then return 1 else return 0 end
end)
stipple(colT, {pile=sGlow, width=2.6, coverage=1.5, drag={7, 0}})
print("drag positional {7, 0}: ok")

--@ chunk 6
local sGlow  = pile{{"lead white", 3}, {"Naples yellow", 1}, {"red earth", 0.22}, turps=0.4}
local colT = mask(function(x, y)
  if y > 500 and y < 560 and math.abs(x - 500) < 60 then return 1 else return 0 end
end)
stipple(colT, {pile=sGlow, width=2.6, coverage=1.5, drag={7, 0}, cluster=0.35,
  pressure={0.4, 0.7}, dips={18, 0.5}, seed=10})
print("dips positional {18, 0.5}: ok")
