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
sky_low = pile{{"lead white", 5}, {"chrome yellow", 0.65}, {"vermilion", 0.06}, name="sky_low"}
sky_mid = pile{{"lead white", 4}, {"cobalt blue", 0.45}, {"vermilion", 0.22}, name="sky_mid"}
mtn_dark = pile{{"cobalt blue", 1}, {"Prussian blue", 0.3}, {"red earth", 0.6}, {"bone black", 0.3}, {"lead white", 0.6}, name="mtn_dark"}
snow_lit = pile{{"lead white", 5}, {"vermilion", 0.22}, {"chrome yellow", 0.22}, blot=0.15, name="snow_lit"}
work(everywhere(), {hand="broad", pile=lw, coverage=1.5, load=0.5, angle=0})
work(everywhere(), {hand="broad", piles={{sky_low, function(x,y) return 1 - x/1000 end}, {sky_mid, function(x,y) return x/1000 end}}, coverage=2, load=0.45, angle=0, length={120,240}})
blend(everywhere(), {angle=0})
-- three inverted triangles
local tris = {}
for i = 0, 2 do
  local cx = 170 + i * 330
  local t = poly({{cx - 140, 100}, {cx + 140, 100}, {cx + 10, 600}})
  tris[i+1] = t
  work(t, {hand="body", pile=mtn_dark, coverage=2.0, load=0.6, clip=true, angle=math.pi/2, length={25,60}})
  local fb = brush{kind="filbert", width=7}
  for j = 1, 12 do
    fb:load(snow_lit, 0.5)
    local y = rand(350, 520); local x = cx + rand(-30, 20) * (600 - y) / 250
    fb:stroke({{x, y}, {x - 6, y - 25}}, {pressure={0.5, 0.15}})
  end
end
-- A: no pull; B: blend length short; C: blend length short + horizontal light
blend(rect(330, 100, 340, 600), {angle=math.pi/2, length={8, 20}})
blend(rect(660, 100, 340, 600), {angle=math.pi/2, length={8, 20}})
blend(rect(660, 100, 340, 600), {angle=0, length={20, 60}, pressure={0.1, 0.25}})

--@ chunk 3
r = rag()
r:dip(0.9)
local m = poly({{30,100},{180,100},{180,600}}):soften(4)
r:wipe(m, {pressure=0.7, angle=0, passes=2, refold=0.5})
r:dip(0.9)
r:wipe(m, {pressure=0.7, angle=math.pi/2, passes=1, refold=0.5})
print(r)

--@ chunk 4
ksc = knife{width=60}
for i = 0, 6 do
  local y = 150 + i * 50
  ksc:scrape({{690, y}, {990, y + 5}}, {pressure=1.0})
  ksc:wipe()
end
print(drying(800, 300))
