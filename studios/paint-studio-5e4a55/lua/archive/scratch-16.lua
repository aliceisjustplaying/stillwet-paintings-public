-- easel session "scratch": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ engine 8
--@ knife-skim
--@ limbs-join-nearest
--@ blend-feather
--@ brush-skim
--@ blend-at-masks
--@ glaze-film
--@ liquid-film-levels
--@ rag-lift
--@ full-palette-refuses
--@ drain

--@ chunk 1
canvas{aspect=0.8, ground={{apply="knife", pile={{"lead white", 10}, {"yellow ochre", 0.4}, {"raw umber", 0.15}}, texture=0.25, um=120}}, linen={18, 15}, seed=4417, size=480}

--@ chunk 2
fallwhite = pile{{"lead white",8},{"yellow ochre",0.25},{"cobalt blue",0.08}, name="fallwhite"}
foamsh = pile{{"lead white",3},{"cobalt blue",0.3},{"raw umber",0.35},{"yellow ochre",0.1}, name="foamsh"}
waterdark = pile{{"raw umber",2},{"Prussian blue",0.5},{"red earth",0.7},{"green earth",0.4}, name="waterdark"}
lent = pile{{"bone black",1},{"raw umber",1.2}, name="lenticel"}
glow = pile{{"lead white",5},{"chrome yellow",1.2},{"yellow ochre",0.8}, name="glow"}
grayglaze = pile{{"raw umber",1},{"cobalt blue",0.4},{"lead white",0.6}, medium=0.6, name="grayglaze"}
-- dry flat white slab with dark around
work(rect(0,0,1000,600), {hand="body", pile=lent, coverage=3, fill=true, angle=1.5})
work(rect(200,100,600,400), {hand="body", pile=fallwhite, coverage=4, fill=true, clip=true, angle=0})
wait(30*24*60)
-- A: glaze gray in vertical streaks (left third)
local ns = noise{seed=1, period=10, octaves=2, stretch={math.pi/2, 7}}
local gm = rect(210, 110, 180, 380) * mask(function(x,y) return clamp((ns:at01(x,y) - 0.45)*4, 0, 1) end)
work(gm, {hand="glaze", pile=grayglaze, coverage=1, angle=math.pi/2, tool={kind="filbert", width=6, stiffness=0.3}})
-- B: dry-brush foamsh drags over dry (middle)
local fan = brush{kind="fan", width=12, stiffness=0.5}
for k = 1, 20 do
  if k % 2 == 1 then fan:reload(foamsh, 0.3) end
  local x = rand(410, 590)
  fan:stroke({{x, 110}, {x + rand(-2,2), 300}, {x + rand(-4,4), 490}}, {pressure={0.45, 0.2}, orient="across"})
end
-- C: round dark threads + foam lumps (right)
local rd = brush{kind="round", width=3, point=0.6}
for k = 1, 8 do
  rd:reload(waterdark, 0.45)
  local x = rand(620, 780)
  rd:gesture({{x, 120, 0.05}, {x + rand(-1,1), 250, 0.45}, {x + rand(-2,2), 380, 0.0}}, {wobble=0.5})
end
local rb = brush{kind="round", width=7, stiffness=0.4, lay=2}
for k = 1, 30 do
  local x, y = rand(620, 780), rand(400, 480)
  rb:reload((k % 3 == 0) and foamsh or fallwhite, 0.7)
  local w = rand(4, 9)
  rb:stroke({{x - w, y + 3}, {x, y - 3}, {x + w, y + 3}}, {pressure={0.5, 0.3}})
  rb:reload(foamsh, 0.5)
  rb:stroke({{x - w*0.8, y + 6}, {x + w*0.8, y + 6}}, {pressure={0.4, 0.3}})
end
