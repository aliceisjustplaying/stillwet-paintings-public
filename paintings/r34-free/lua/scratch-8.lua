-- easel session "scratch": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box every
--@ engine 5

--@ chunk 1
canvas{aspect=1.3333333333333333, ground={{apply="knife", pile={{"lead white", 3}, {"yellow ochre", 1}, {"raw umber", 0.4}}, texture=0.1, um=40}}, linen={24, 22}, seed=5, size=600}

--@ chunk 2
sandA = pile{{"rose madder", 0.4}, {"yellow ochre", 0.5}, {"ultramarine blue", 0.2}, {"lead white", 1.0}, turps=0.3}
sandB = pile{{"burnt sienna", 0.5}, {"ultramarine blue", 0.5}, {"permanent alizarin", 0.3}, {"lead white", 0.6}, turps=0.3}
sandC = pile{{"burnt sienna", 0.8}, {"raw umber", 0.3}, {"bone black", 0.2}, {"lead white", 0.3}, turps=0.2}
sandR = rect(0, 447, 1000, 303)
work(sandR, {hand="broad", coverage=1.3, fill=true, piles={
  {sandA, function(x,y) return clamp(1 - (y-450)/90, 0, 1) end},
  {sandB, function(x,y) return clamp(1 - math.abs(y-560)/110, 0, 1) end},
  {sandC, function(x,y) return clamp((y-580)/120, 0, 1) end}}})
glA = pile{{"pale cadmium", 1}, {"lead white", 1.6}, turps=0.2}
glB = pile{{"lead white", 1}, {"cadmium yellow", 0.3}, {"rose madder", 0.15}, turps=0.2}
b = brush("flat", 4)
n = 0
local y = 452
while y < 545 do
  local t = (y - 452) / 93
  local hw = 5 + t * 26
  local cnt = 2 + math.floor(t * 2.5)
  local gap = 3 + t * 5
  b:load(math.random() < 0.6 and glA or glB, 0.4 + 0.4 * math.random())
  for j = 1, cnt do
    local cx = 646 + (math.random() - 0.5) * 6 * t
    local x0 = cx - hw + math.random() * 2 * hw
    local len = (4 + math.random() * (6 + 22 * t)) * (0.8 + 0.4 * t)
    if math.random() < 0.7 then
      b:stroke({{x0, y}, {x0 + len, y + (math.random() - 0.5) * 0.8}}, {pressure = 0.25 + 0.2 * math.random()})
      n = n + 1
    end
  end
  y = y + gap
end
print("dashes", n, "end y", y)

--@ chunk 3
print(drying(500,600), drying(646,500), drying(300,600), drying(646,470))
wait(1440)
print(drying(500,600), drying(646,500), drying(300,600), drying(646,470))

--@ chunk 4
wait(600)
print(drying(500,600), drying(646,500), drying(300,600), drying(646,470))

--@ chunk 5
gl = pile{{"ultramarine blue", 0.5}, {"burnt sienna", 0.5}, {"permanent alizarin", 0.3}, medium=0.8, name="glz"}
print(gl)
pathM = poly({{622,452},{672,452},{700,548},{600,548}}, true)
sandG = rect(0, 455, 1000, 295)
work(sandG * (-pathM), {hand="glaze", pile=gl, coverage=1.0})
print("glaze laid off-path")
