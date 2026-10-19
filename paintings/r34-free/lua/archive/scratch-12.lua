-- easel session "scratch": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box every
--@ engine 5

--@ chunk 1
canvas{aspect=1.3333333333333333, ground={{apply="knife", pile={{"lead white", 3}, {"yellow ochre", 1}, {"raw umber", 0.4}}, texture=0.1, um=40}}, linen={24, 22}, seed=5, size=600}

--@ chunk 2
dkA = pile{{"rose madder", 0.4}, {"ultramarine blue", 0.5}, {"burnt sienna", 0.3}, {"lead white", 0.5}, turps=0.2, name="dkA"}
dkB = pile{{"ultramarine blue", 0.6}, {"burnt sienna", 0.7}, {"permanent alizarin", 0.4}, {"bone black", 0.1}, {"lead white", 0.15}, turps=0.15, name="dkB"}
dkC = pile{{"burnt sienna", 0.8}, {"ultramarine blue", 0.6}, {"bone black", 0.3}, {"permanent alizarin", 0.2}, turps=0.1, name="dkC"}
fgR = rect(0, 452, 1000, 298)
work(fgR, {hand="broad", coverage=1.2, fill=true, angle=0.03, piles={
  {dkA, function(x,y) return clamp(1 - (y-455)/50, 0, 1) end},
  {dkB, function(x,y) return clamp(1 - math.abs(y-560)/120, 0, 1) end},
  {dkC, function(x,y) return clamp((y-580)/140, 0, 1) end}}})
wait(2880)
print(drying(300,500), drying(300,600), drying(300,700))

--@ chunk 3
wait(2880)
print(drying(300,500), drying(300,600), drying(300,700))

--@ chunk 4
gl1 = pile{{"lead white", 1.0}, {"rose madder", 0.4}, {"ultramarine blue", 0.2}, turps=0.1, name="gl1"}
gl2 = pile{{"pale cadmium", 1.0}, {"lead white", 1.1}, turps=0.1, name="gl2"}
gl3 = pile{{"cerulean blue", 0.9}, {"lead white", 1.2}, {"permanent alizarin", 0.1}, turps=0.1, name="gl3"}
rig = brush{kind="rigger", width=2, point=1}
rig:load(gl1, 0.6)
n = 0
for i = 1, 30 do
  local y = 470 + math.random() * 200
  local x = 200 + math.random() * 600
  local len = 20 + math.random() * 60
  if i % 6 == 0 then rig:load(gl2, 0.6) end
  if i % 6 == 3 then rig:load(gl3, 0.6) end
  rig:stroke({{x, y}, {x + len, y + (math.random() - 0.5) * 1.0}}, {pressure = 0.35 + 0.25 * math.random()})
  n = n + 1
end
print("hairline glints", n, rig:fullness())

--@ chunk 5
vl = pile{{"permanent alizarin", 0.2}, {"rose madder", 0.3}, {"lead white", 1.0}, turps=0.5, name="vl"}
b = brush("flat", 10)
b:load(vl, 0.3)
b:stroke({{200, 480}, {800, 500}}, {pressure = 0.12})
b:stroke({{200, 520}, {800, 540}}, {pressure = 0.1})
b:stroke({{200, 580}, {800, 600}}, {pressure = 0.1})
print("veil passes")
