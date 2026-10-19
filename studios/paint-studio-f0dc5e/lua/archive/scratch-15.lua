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
work(everywhere(), {hand="broad", pile=lw, coverage=1.5, load=0.5, angle=0})
bg = pile{{"cobalt blue", 1}, {"Prussian blue", 0.3}, {"vermilion", 0.08}, {"lead white", 1.4}, name="bg"}
work(rect(0, 0, 1000, 749), {hand="broad", pile=bg, coverage=2, load=0.5, angle=0})
tree_dark = pile{{"Prussian blue", 0.6}, {"raw umber", 1}, {"bone black", 0.5}, name="tree_dark"}
local rb = brush{kind="round", width=5, point=0, lay=2}
for i = 1, 4 do
  rb:reload(tree_dark, 1.0)
  rb:stroke({{100, 100 + i*60}, {400, 100 + i*60}}, {pressure={0.9, 0.5}})
  rb:reload(tree_dark, 1.0)
  rb:stroke({{100, 101 + i*60}, {400, 100 + i*60}}, {pressure={0.9, 0.5}})
end
fixb = pile{{"cobalt blue", 1}, {"Prussian blue", 0.3}, {"vermilion", 0.08}, {"lead white", 1.4}, blot=0.2, name="fixb"}
local kk = knife{width=14}
local ps = {0.15, 0.25, 0.35, 0.5}
for i, p in ipairs(ps) do
  kk:wipe(); kk:load(fixb, 0.4)
  local y = 100 + i*60
  kk:lay({{250, y - 8}, {250, y + 8}}, {pressure={p, p}})
  kk:wipe(); kk:load(fixb, 0.4)
  kk:lay({{330, y - 8}, {345, y + 8}}, {pressure={p, p}, angle=0})
end

--@ chunk 3
local m = ribbon({{110, 160}, {240, 160}}, 9):soften(2)
local r = rag{width=12}
r:dip(0.9)
r:wipe(m, {pressure=0.8, angle=0, passes=2})
r:refold(); r:dip(0.9)
r:wipe(m, {pressure=0.8, angle=math.pi/2, passes=1})
local m2 = ribbon({{110, 160}, {240, 160}}, 14):soften(3)
work(m2, {hand="body", tool={kind="filbert", width=5}, pile=bg, coverage=2.0, load=0.6, clip=true, angle=math.pi/2, length={8,16}})
blend(m2, {angle=math.pi/2, length={6, 14}})
