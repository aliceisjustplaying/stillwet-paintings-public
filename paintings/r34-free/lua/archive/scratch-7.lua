-- easel session "scratch": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box every
--@ engine 5

--@ chunk 1
canvas{aspect=1.3333333333333333, ground={{apply="knife", pile={{"lead white", 3}, {"yellow ochre", 1}, {"raw umber", 0.4}}, texture=0.1, um=40}}, linen={24, 22}, seed=5, size=600}

--@ chunk 2
-- fresh scratch: sand base under the sun path (same as painting's sand: warm base, open)
sandA = pile{{"rose madder", 0.4}, {"yellow ochre", 0.5}, {"ultramarine blue", 0.2}, {"lead white", 1.0}, turps=0.3}
sandB = pile{{"burnt sienna", 0.5}, {"ultramarine blue", 0.5}, {"permanent alizarin", 0.3}, {"lead white", 0.6}, turps=0.3}
sandC = pile{{"burnt sienna", 0.8}, {"raw umber", 0.3}, {"bone black", 0.2}, {"lead white", 0.3}, turps=0.2}
sandR = rect(0, 447, 1000, 303)
work(sandR, {hand="broad", coverage=1.3, fill=true, piles={
  {sandA, function(x,y) return clamp(1 - (y-450)/90, 0, 1) end},
  {sandB, function(x,y) return clamp(1 - math.abs(y-560)/110, 0, 1) end},
  {sandC, function(x,y) return clamp((y-580)/120, 0, 1) end}}})
glA = pile{{"pale cadmium", 1}, {"lead white", 1.6}, turps=0.2}
b = brush("flat", 5)
b:load(glA, 0.8)
-- rows of dashes: y, centre x, half-width; dashes shorten and spread toward the viewer
rows = {{452,646,6},{460,648,8},{468,646,10},{478,647,12},{490,644,15},{504,646,18},{520,645,22},{540,644,28}}
n = 0
for i, r in ipairs(rows) do
  local y, cx, hw = r[1], r[2], r[3]
  local k = 0
  for j = 1, 4 do
    local x0 = cx - hw + (j - 1) * (2 * hw / 4) + (j % 2) * 3
    local len = 6 + hw * 0.9
    b:stroke({{x0, y}, {x0 + len, y + 0.6}}, {pressure=0.35})
    n = n + 1
  end
end
print("dashes", n)
