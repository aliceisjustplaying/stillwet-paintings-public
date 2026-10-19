-- easel session "scratch": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box friedrich
--@ engine 7
--@ limbs-join-nearest

--@ chunk 1
canvas{aspect=1.4, ground={{apply="knife", pile={{"red earth", 2}, {"yellow ochre", 2}, {"lead white", 3}}, texture=0.35, um=70}, {apply="roller", pile={{"lead white", 8}, {"yellow ochre", 0.35}, {"raw umber", 0.12}}, um=45}}, linen={16, 14}, seed=1774, size=700}

--@ chunk 2
s_top = pile{{"smalt", 3}, {"cobalt blue", 1}, {"lead white", 2.5}, {"bone black", 0.08}, name="s_top"}
s_blue = pile{{"lead white", 5}, {"smalt", 2}, {"cobalt blue", 0.4}, name="s_blue"}
s_pale = pile{{"lead white", 8}, {"pale smalt", 1}, {"Naples yellow", 0.6}, name="s_pale"}
s_yel = pile{{"lead white", 6}, {"Naples yellow", 3}, {"chrome yellow", 0.25}, name="s_yel"}
s_rose = pile{{"lead white", 4}, {"Naples yellow", 2}, {"vermilion", 0.5}, {"rose madder", 0.3}, name="s_rose"}
print(palette())

--@ chunk 3
s_top = pile{{"smalt", 3}, {"cobalt blue", 2}, {"Prussian blue", 0.15}, {"lead white", 1.2}, {"rose madder", 0.15}, name="s_top2"}
s_blue = pile{{"lead white", 4}, {"smalt", 2}, {"cobalt blue", 1.2}, name="s_blue2"}
s_blue3 = pile{{"lead white", 6}, {"smalt", 1.5}, {"cobalt blue", 0.5}, {"Naples yellow", 0.2}, name="s_blue3"}
print(palette())

--@ chunk 4
function hat(y, a, b, c)
  if y <= a or y >= c then return 0 end
  if y <= b then return (y - a) / (b - a) end
  return (c - y) / (c - b)
end
stops = {{s_top, -200, 0, 150}, {s_blue, 0, 150, 260}, {s_blue3, 150, 260, 330}, {s_pale, 260, 330, 400}, {s_yel, 330, 400, 455}, {s_rose, 400, 455, 560}}
local ps = {}
for i, s in ipairs(stops) do
  local p, a, b, c = s[1], s[2], s[3], s[4]
  ps[#ps+1] = {p, function(x, y) return hat(y, a, b, c) + 0.001 end}
end
local m = rect(100, 40, 300, 430)
work(m, {hand="broad", piles=ps, angle=0, coverage=2.5, clip=true})
print(drying(200, 200))

--@ chunk 5
local ps = {}
for i, s in ipairs(stops) do
  local p, a, b, c = s[1], s[2], s[3], s[4]
  ps[#ps+1] = {p, function(x, y) return hat(y, a, b, c) + 0.001 end}
end
local m = rect(500, 40, 300, 430)
work(m, {hand="broad", piles=ps, angle=0, coverage=3, clip=true, fill=true})
blend(rect(500, 40, 300, 430), {angle=0})
blend(rect(100, 40, 300, 430), {angle=0})
