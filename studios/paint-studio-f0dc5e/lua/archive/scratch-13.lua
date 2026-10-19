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
water_deep = pile{{"cobalt blue", 1}, {"Prussian blue", 0.4}, {"raw umber", 0.15}, {"lead white", 0.6}, name="water_deep"}
mtn_dark = pile{{"cobalt blue", 1}, {"Prussian blue", 0.3}, {"red earth", 0.6}, {"bone black", 0.3}, {"lead white", 0.6}, name="mtn_dark"}
work(everywhere(), {hand="broad", pile=lw, coverage=1.5, load=0.5, angle=0})
work(everywhere(), {hand="broad", piles={{sky_low, function(x,y) return 1 - x/1000 end}, {sky_mid, function(x,y) return x/1000 end}}, coverage=2.2, load=0.5, angle=0, length={120,240}, clip=true})
blend(everywhere(), {angle=0})
local refl = rect(300, 0, 700, 749)
work(refl, {hand="body", pile=mtn_dark, coverage=2.2, load=0.65, clip=true, angle=math.pi/2, length={25,60}})
sheen = pile{{"lead white", 4}, {"chrome yellow", 0.3}, {"vermilion", 0.08}, {"cobalt blue", 0.06}, blot=0.15, name="sheen"}
sheen_c = pile{{"lead white", 4}, {"cobalt blue", 0.35}, {"vermilion", 0.1}, blot=0.15, name="sheen_c"}
-- A: knife, blade along the path, thin lines, various pressures (rows at y 80..240)
local kk = knife{width=40}
local ps = {0.3, 0.5, 0.7, 0.9}
for i, p in ipairs(ps) do
  kk:wipe(); kk:load(sheen_c, 0.3)
  kk:lay({{120, 60 + i*40}, {480, 62 + i*40}}, {pressure={p, p}, angle=0})
end
-- B: rigger thin lines
local rg = brush{kind="rigger", width=2.0, point=1}
for i = 1, 4 do
  rg:wipe(0.7); rg:load(sheen_c, 0.4 + i*0.1)
  rg:stroke({{120, 260 + i*30}, {300, 260 + i*30}, {480, 261 + i*30}}, {pressure={0.2 + i*0.1, 0.1}, ramps={0.2, 0.3}})
end
-- C: horizontal blend through the dark reflection, light pressure, in bands
for i = 0, 3 do
  blend(rect(500, 420 + i*50, 450, 6), {angle=0, pressure={0.2, 0.35}, clip=false})
end
-- D: soft broad strokes of sheen, filbert flat dragged, light pressure
local fl = brush{kind="flat", width=20}
for i = 1, 3 do
  fl:wipe(0.7); fl:load(sheen_c, 0.25)
  fl:stroke({{120, 600 + i*35}, {480, 600 + i*35}}, {pressure={0.12, 0.12}, orient="across"})
end

--@ chunk 3
sheen_t = pile{{"lead white", 4}, {"cobalt blue", 0.35}, {"vermilion", 0.1}, thinner=0.5, name="sheen_t"}
local fl = brush{kind="flat", width=8}
for i = 1, 3 do
  fl:wipe(0.7); fl:load(sheen_t, 0.4)
  fl:stroke({{560, 600 + i*30}, {760, 601 + i*30}, {960, 600 + i*30}}, {pressure={0.25, 0.15}, ramps={0.3, 0.4}, orient="across"})
end
blend(rect(540, 610, 440, 110), {angle=0, pressure={0.15, 0.3}, clip=false})
-- knife at small blade angles
local kk = knife{width=30}
local angs = {0.05, 0.1, 0.2, 0.35}
for i, a in ipairs(angs) do
  kk:wipe(); kk:load(sheen_c, 0.25)
  kk:lay({{560, 380 + i*30}, {700, 381 + i*30}, {840, 380 + i*30}}, {pressure={0.6, 0.6}, angle=a})
end

--@ chunk 4
-- scrape test on the scratch knife lines at y ~ 410..500 (angles 0.05..0.35), and the earlier rows at y 100..220
local ks2 = knife{width=40}
local ps = {0.3, 0.5, 0.7, 0.9}
for i, p in ipairs(ps) do
  ks2:wipe()
  local y = 380 + i*30
  ks2:scrape({{555, y}, {700, y + 1}, {845, y}}, {pressure=p, angle=0.05 + (i-1)*0.1})
end

--@ chunk 5
local ks3 = knife{width=10}
-- line 1 (y~410): scrape blade across the path, narrow knife, pressure 1
ks3:scrape({{555, 410}, {700, 411}, {845, 410}}, {pressure=1.0})
ks3:wipe()
-- line 2 (y~440): blend along a ribbon
blend(ribbon({{550, 440}, {850, 440}}, 8), {angle=0, pressure={0.3, 0.5}})
-- line 3 (y~470): rag along a ribbon mask
local r = rag{width=14}
r:dip(0.8)
r:wipe(ribbon({{550, 471}, {850, 471}}, 10), {pressure=0.6, angle=0, passes=1})
-- line 4 (y~500): scrape with fixed angle along (pi/2 = vertical blade?) wide knife pressure 1
local ks4 = knife{width=20}
ks4:scrape({{555, 500}, {700, 501}, {845, 500}}, {pressure=1.0, angle=math.pi/2})

--@ chunk 6
local kk = knife{width=40}
for i = 0, 1 do
  local y = 560 + i * 40
  kk:wipe(); kk:load(sheen_c, 0.25)
  kk:lay({{560, y}, {700, y}, {840, y}}, {pressure={0.6, 0.6}, angle=0.12})
  blend(ribbon({{554, y}, {846, y}}, 10):soften(3), {angle=0, pressure={0.3, 0.5}, length={20, 60}})
end
-- fix A (y 560): vertical short strokes of the dark over the bar, clipped to a grown ribbon, then gentle horizontal blend
local rA = ribbon({{554, 560}, {846, 560}}, 16):soften(3)
work(rA, {hand="body", tool={kind="filbert", width=6}, pile=mtn_dark, coverage=1.6, load=0.5, clip=true, angle=math.pi/2, length={8,16}})
blend(rA, {angle=0, pressure={0.15, 0.3}, length={20, 60}})
-- fix B (y 600): same but coverage 1.0, load 0.4 -> partial
local rB = ribbon({{554, 600}, {846, 600}}, 16):soften(3)
work(rB, {hand="body", tool={kind="filbert", width=6}, pile=mtn_dark, coverage=1.0, load=0.4, clip=true, angle=math.pi/2, length={8,16}})
blend(rB, {angle=0, pressure={0.15, 0.3}, length={20, 60}})
