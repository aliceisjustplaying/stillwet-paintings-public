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
canvas{aspect=1.3347921225382933, ground={{apply="knife", pile={{"lead white", 6}, {"yellow ochre", 0.05}}, texture=0.25, um=70}, {apply="roller", pile={{"lead white", 1}}, um=35}}, linen={17, 15}, seed=2417, size=610}

--@ chunk 2
lw = pile{{"lead white", 1}, medium=0.45, name="liquid_white"}
sky_mid = pile{{"lead white", 4}, {"cobalt blue", 0.45}, {"vermilion", 0.22}, name="sky_mid"}
sky_low = pile{{"lead white", 5}, {"chrome yellow", 0.65}, {"vermilion", 0.06}, name="sky_low"}
work(everywhere(), {hand="broad", pile=lw, coverage=1.5, load=0.5, angle=0})
work(everywhere(), {hand="broad", piles={{sky_low, function(x,y) return 1 - x/1000 end}, {sky_mid, function(x,y) return x/1000 end}}, coverage=2, load=0.45, angle=0, length={120,240}})
blend(everywhere(), {angle=0})
land_dark = pile{{"raw umber", 1}, {"Prussian blue", 0.25}, {"bone black", 0.3}, {"red earth", 0.25}, {"lead white", 0.15}, name="land_dark"}
grass_mid = pile{{"yellow ochre", 1}, {"raw umber", 0.6}, {"red earth", 0.15}, {"green earth", 0.3}, name="grass_mid"}
grass_lit = pile{{"yellow ochre", 1}, {"lead white", 0.6}, {"vermilion", 0.1}, {"chrome yellow", 0.15}, blot=0.15, name="grass_lit"}
bank = poly({{0,400},{100,420},{220,450},{330,480},{420,520},{470,560},{470,749},{0,749}}, true):roughen(4, 25, 3)
work(bank, {hand="body", pile=land_dark, coverage=2.2, load=0.7, clip=true, angle=0.3, length={20,50}})
-- grass: fan pushed upward in zigzag
math.randomseed(4)
local fan = brush{kind="fan", width=14, lay=2}
local n = 0
for i = 1, 160 do
  local x = rand(0, 460)
  local ytop = 400 + x * 0.3
  local y = rand(ytop + 10, 740)
  if bank:at(x, y) > 0.5 then
    if n % 3 == 0 then fan:load(grass_mid, 0.6) end
    fan:stroke({{x, y}, {x + rand(-3, 3), y - rand(12, 30)}}, {pressure={0.6, 0.05}, orient="across"})
    n = n + 1
  end
end
local fan2 = brush{kind="fan", width=10, lay=2}
for i = 1, 90 do
  local x = rand(0, 300)
  local ytop = 400 + x * 0.3
  local y = rand(ytop + 5, ytop + 120)
  if bank:at(x, y) > 0.5 then
    if n % 3 == 0 then fan2:wipe(0.6); fan2:load(grass_lit, 0.45) end
    fan2:stroke({{x, y}, {x + rand(-3, 3), y - rand(10, 24)}}, {pressure={0.45, 0.05}, orient="across"})
    n = n + 1
  end
end
