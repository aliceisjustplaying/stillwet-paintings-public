-- easel session "painting": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.

--@ chunk 1
-- Canvas: 40x32 cm, medium-fine linen, warm grey-green oil ground
canvas{size=400, aspect=0.8, linen={16, 12}, seed=11,
  ground={
    {pile={{"lead white", 1}, {"raw umber", 0.18}, {"green earth", 0.1}}, um=95, apply="knife", texture=0.55},
    {pile={{"lead white", 1}, {"raw umber", 0.08}, {"green earth", 0.05}}, um=25, apply="brush"},
  }}
print("grooves set")

--@ chunk 2
-- Palette
sunset   = pile{{"vermilion", 1}, {"chrome yellow", 0.55}, {"lead white", 0.7}}                 -- vermilion & yellow pass to lead
gold     = pile{{"chrome yellow", 1}, {"vermilion", 0.22}, {"lead white", 0.9}}                -- gold & one part of its red to lead
peach    = pile{{"lead white", 2.2}, {"vermilion", 0.55}, {"chrome yellow", 0.3}}              -- lead & two parts red, one yellow
rosepink = pile{{"lead white", 2.2}, {"vermilion", 0.65}}
ice      = pile{{"lead white", 2.0}, {"smalt", 0.75}}
warmpale = pile{{"lead white", 2.0}, {"yellow ochre", 0.32}}
landblue = pile{{"cobalt blue", 1}, {"raw umber", 0.5}, {"lead white", 0.65}}                   -- cobalt & half its umber to lead
shoregrey= pile{{"lead white", 1}, {"yellow ochre", 0.2}, {"bone black", 0.16}}
flesh    = pile{{"lead white", 1.6}, {"vermilion", 0.45}, {"yellow ochre", 0.12}}
mistpink = pile{{"lead white", 1.5}, {"vermilion", 0.3}, {"chrome yellow", 0.18}}
skytop   = pile{{"cobalt blue", 1}, {"raw umber", 0.2}, {"lead white", 0.35}}                   -- cobalt & a fifth of umber to lead
print("piles mixed: 12")

--@ chunk 3
-- Sketch: horizon, headland, spit, boat, path of light, birds
h = pencil("HB")
h:rule({30, 515}, {970, 515}, {pressure=0.28})
h:sketch({{30, 446}, {240, 452}, {460, 452}, {700, 440}, {970, 438}}, {pressure=0.3})
h:sketch({{620, 512}, {700, 516}, {800, 528}, {820, 540}}, {pressure=0.26})
h:sketch({{548, 210}, {600, 166}, {620, 128}, {626, 92}, {612, 48}, {586, 30}}, {pressure=0.3})
h:sketch({{520, 176}, {586, 174}, {640, 190}, {668, 232}, {690, 300}, {700, 372}}, {pressure=0.3})
h:sketch({{660, 436}, {690, 444}, {718, 470}, {724, 500}}, {pressure=0.22})
h:sketch({{150, 660}, {176, 656}, {194, 644}}, {pressure=0.2})
h:sketch({{760, 262}, {772, 256}, {788, 252}}, {pressure=0.2})
print("sketched")

--@ chunk 4
-- Tone: thin warm golden-grey wash over everything
wash = pile{{"vermilion", 0.5}, {"yellow ochre", 0.4}, {"raw umber", 0.35}, {"bone black", 0.16}, medium=0.75}
darkmix = pile{{"bone black", 0.55}, {"raw umber", 1}, {"cobalt blue", 0.7}, medium=0.2}
all = mask(function(x, y) return 1 end)
work(all, {hand="glaze", pile=wash, coverage=1.0, angle=0.05})
print("toned")

--@ chunk 5
wait(6 * 60)

--@ chunk 6
-- Full toned ground: lead-rich warm grey, worked swiftly with the broad hand
tone = pile{{"lead white", 1}, {"yellow ochre", 0.28}, {"raw umber", 0.2}, {"bone black", 0.1}, {"vermilion", 0.07}, medium=0.35}
work(all, {hand="broad", pile=tone, coverage=1.2, angle=0.06, dips={70, 0.9, 0}, edge=1})
print("ground toned")

--@ chunk 7
-- Dense toned ground, covering the orange mess fully
tone = pile{{"lead white", 1}, {"raw umber", 0.5}, {"bone black", 0.22}, {"yellow ochre", 0.25}, {"vermilion", 0.1}, medium=0.3}
work(all, {hand="broad", pile=tone, coverage=2.4, fill=true, angle=0.09, dips={90, 0.95, 0}, edge=1})
print("dense tone on")

--@ chunk 8
tone = pile{{"lead white", 1}, {"raw umber", 0.55}, {"bone black", 0.28}, {"yellow ochre", 0.3}, {"vermilion", 0.12}, medium=0.3}
work(all, {hand="broad", pile=tone, coverage=2.2, fill=true, angle=-0.06, dips={90, 0.95, 0}, edge=1})
print("second dense pass")

--@ chunk 9
blend(all, {coverage=1.0})
print("blended")

--@ chunk 10
wait(6 * 60)
-- Sky palette trials on the spare rect, light pressure so I can compare
sk1 = pile{{"lead white", 1}, {"cobalt blue", 2.5}, {"vermilion", 2}, {"chrome yellow", 2}}
sk2 = pile{{"lead white", 1.5}, {"cobalt blue", 2}, {"vermilion", 1}, {"chrome yellow", 1}}
sk3 = pile{{"lead white", 1}, {"smalt", 2}, {"vermilion", 0.5}}
sk4 = pile{{"lead white", 1.5}, {"yellow ochre", 1}, {"vermilion", 0.4}}
trial = rect(0, 1266, 900, 180)
work(trial, {hand="detail", pile=sk1, coverage=1.6, edge=0.4, ruler=true, clip=true})

--@ chunk 11
-- test if masks work off-canvas; measure canvas bounds
e = mask(function(x, y) return 1 end)
print("probe")

--@ chunk 12
-- probe canvas bounds
probe = rect(0, 1300, 100, 10)
print("area:", probe:area())
r2 = rect(0, 1250, 900, 25)
work(r2, {hand="detail", pile=sk4, coverage=1.5, edge=0.2, clip=true, ruler=true})
print("painted 1250")

--@ chunk 13
-- fill the table of sky trials into the spare band, then look
trials = {sk1, sk2, sk3, sk4}
names = {"sk1","sk2","sk3","sk4"}
for i, m in ipairs(trials) do
  local x0 = 0 + (i-1) * 250
  local band = rect(x0, 1252, 248, 30)
  work(band, {hand="detail", pile=m, coverage=2.0, edge=0.2, clip=true, ruler=true})
end
print("trials painted")

--@ chunk 14
-- coordinate probe: X at (300,300) and (150,1050)
hp = pencil("2B")
hp:line({{280, 280}, {320, 320}}, {pressure=0.7, smooth=false})
hp:line({{130, 1030}, {170, 1070}}, {pressure=0.7, smooth=false})
print("probe lines drawn")

--@ chunk 15
wait(15 * 60)
print(drying(500, 300))
print(drying(500, 900))

--@ chunk 16
-- Sky band 1: top of sky, cool warm-grey blue
skyA = pile{{"lead white", 1}, {"cobalt blue", 2.5}, {"vermilion", 2}, {"chrome yellow", 2}}
top = below(function(x) return 190 + 30 * math.sin(x / 150) + 14 * math.sin(x / 57 + 2) end)
work(top, {hand="broad", pile=skyA, coverage=1.6, fill=true, angle=0.04, dips={70, 0.95, 0}, edge=0.5})
print("band 1")

--@ chunk 17
-- Band 2: cool grey-mauve upper-middle sky
skyB = pile{{"lead white", 2.2}, {"cobalt blue", 1.3}, {"vermilion", 0.8}, {"chrome yellow", 0.5}}
b2 = below(function(x) return 300 + 40 * math.sin(x / 130 + 1) + 18 * math.sin(x / 47) end)
work(b2, {hand="broad", pile=skyB, coverage=1.7, fill=true, angle=0.05, dips={70, 0.95, 0}, edge=0.6})
print("band 2")

--@ chunk 18
-- Bands 3+4: warm grey to pale gold, laid fast and generously
skyC = pile{{"lead white", 2.6}, {"cobalt blue", 0.5}, {"vermilion", 0.9}, {"chrome yellow", 1.1}}
b3 = below(function(x) return 395 + 35 * math.sin(x / 110 + 3) + 16 * math.sin(x / 41 + 1) end)
work(b3, {hand="broad", pile=skyC, coverage=2.2, fill=true, angle=0.05, dips={80, 0.95, 0}, edge=0.6})
print("band 3")

--@ chunk 19
-- Dark slate at the top of the sky
slate = pile{{"lead white", 1.2}, {"cobalt blue", 1.6}, {"bone black", 0.2}, {"raw umber", 0.25}}
topband = above(function(x) return 185 + 30 * math.sin(x / 150) + 14 * math.sin(x / 57 + 2) end)
work(topband, {hand="broad", pile=slate, coverage=2.4, fill=true, angle=0.04, dips={70, 0.95, 0}, edge=0.7})
print("slate top")

--@ chunk 20
-- Darker, greyer slate for the top band
slate2 = pile{{"lead white", 1}, {"cobalt blue", 0.9}, {"bone black", 0.45}, {"raw umber", 0.5}, {"vermilion", 0.15}}
topband = above(function(x) return 185 + 30 * math.sin(x / 150) + 14 * math.sin(x / 57 + 2) end)
work(topband, {hand="broad", pile=slate2, coverage=2.6, fill=true, angle=0.04, dips={70, 0.95, 0}, edge=0.7})
print("slate v2")

--@ chunk 21
-- Sky rebuild: three solid fields, dark to light, then blend
slate3 = pile{{"lead white", 1}, {"cobalt blue", 0.9}, {"bone black", 0.45}, {"raw umber", 0.55}, {"vermilion", 0.15}}
mauve  = pile{{"lead white", 1.6}, {"cobalt blue", 0.5}, {"vermilion", 0.5}, {"chrome yellow", 0.4}, {"raw umber", 0.15}}
goldpale = pile{{"lead white", 2.2}, {"chrome yellow", 0.55}, {"vermilion", 0.2}}

t1 = above(function(x) return 205 + 30 * math.sin(x / 150) + 14 * math.sin(x / 57 + 2) end)
work(t1, {hand="broad", pile=slate3, coverage=3.0, fill=true, angle=0.05, dips={70, 0.95, 0}, edge=1})

t2 = below(function(x) return 355 + 35 * math.sin(x / 130 + 1) + 16 * math.sin(x / 47) end)
work(t2, {hand="broad", pile=mauve, coverage=2.6, fill=true, angle=0.05, dips={70, 0.95, 0}, edge=1})

t3 = below(function(x) return 530 + 30 * math.sin(x / 110 + 3) + 14 * math.sin(x / 43 + 2) end)
work(t3, {hand="broad", pile=goldpale, coverage=2.6, fill=true, angle=0.05, dips={70, 0.95, 0}, edge=1})

print("three fields down")

--@ chunk 22
-- Full-cover repaint of the three sky fields
slate3 = pile{{"lead white", 1}, {"cobalt blue", 0.9}, {"bone black", 0.45}, {"raw umber", 0.55}, {"vermilion", 0.15}}
mauve2 = pile{{"lead white", 1.2}, {"cobalt blue", 0.7}, {"vermilion", 0.35}, {"raw umber", 0.3}, {"chrome yellow", 0.2}}
gold3  = pile{{"lead white", 3}, {"chrome yellow", 0.6}, {"vermilion", 0.2}}

t1 = above(function(x) return 205 + 30 * math.sin(x / 150) + 14 * math.sin(x / 57 + 2) end)
work(t1, {hand="broad", pile=slate3, coverage=3.2, fill=true, angle=0.05, pressure={0.7, 0.9}, edge=1})

t2 = below(function(x) return 365 + 35 * math.sin(x / 130 + 1) + 16 * math.sin(x / 47) end)
work(t2, {hand="broad", pile=mauve2, coverage=3.0, fill=true, angle=0.05, pressure={0.7, 0.9}, edge=1})

t3 = below(function(x) return 545 + 30 * math.sin(x / 110 + 3) + 14 * math.sin(x / 43 + 2) end)
work(t3, {hand="broad", pile=gold3, coverage=2.8, fill=true, angle=0.05, pressure={0.7, 0.9}, edge=1})

print("fields repainted")

--@ chunk 23
-- Fuse the sky while it is open
skyzone = below(function(x) return 560 + 20 * math.sin(x / 90) end)
blend(skyzone, {coverage=1.0})
print("sky blended")

--@ chunk 24
-- Cloud bank shaping: cool knit on top edge, violet shadow under the left
coolknit = pile{{"lead white", 1.4}, {"cobalt blue", 0.5}, {"vermilion", 0.25}, {"raw umber", 0.2}}
undersh  = pile{{"lead white", 1}, {"cobalt blue", 0.4}, {"vermilion", 0.3}, {"bone black", 0.15}, {"raw umber", 0.3}}

c150 = function(x) return 150 + 25 * math.sin(x / 120 + 1) end
c268 = function(x) return 268 + 22 * math.sin(x / 95 + 2) end
c292 = function(x) return 292 + 25 * math.sin(x / 105 + 3) end
c378 = function(x) return 378 + 20 * math.sin(x / 85) end

kz = above(c150) * below(c268) * mask(function(x) return x < 600 and 1 or 0.4 end)
work(kz, {hand="scumble", pile=coolknit, coverage=1.2, angle=0.05, edge=1})

uz = above(c292) * below(c378) * mask(function(x) return x < 520 and 1 or 0.3 end)
work(uz, {hand="scumble", pile=undersh, coverage=1.1, angle=0.05, edge=1})

blend(kz, {coverage=0.6})
blend(uz, {coverage=0.6})
print("bank shaped")

--@ chunk 25
wait(14 * 60)
print(drying(500, 300))

--@ chunk 26
-- Headland: low treeline right, thin far shore left
treedark = pile{{"lead white", 0.5}, {"cobalt blue", 0.6}, {"green earth", 0.35}, {"raw umber", 0.6}, {"bone black", 0.5}}

tl = function(x)
  return 448 + 24 * math.sin(x / 23 + 1) + 16 * math.sin(x / 61) + 9 * math.sin(x / 13 + 2)
end
hz = function(x) return 512 + 4 * math.sin(x / 40) end

headR = below(tl) * above(hz) * mask(function(x) return x > 370 and 1 or 0 end)
shoreL = below(function(x) return 498 + 8 * math.sin(x / 30) end) * above(hz) * mask(function(x) return x <= 420 and 1 or 0 end)

work(headR, {hand="body", pile=treedark, coverage=2.6, fill=true, angle=0.02, pressure={0.6, 0.85}, edge=0.5})
work(shoreL, {hand="body", pile=treedark, coverage=2.0, fill=true, angle=0.02, pressure={0.5, 0.7}, edge=0.6})
print("headland in")

--@ chunk 27
-- Deepen treeline, add taller irregular clumps
treedark2 = pile{{"lead white", 0.4}, {"cobalt blue", 0.55}, {"green earth", 0.3}, {"raw umber", 0.6}, {"bone black", 0.65}}

tl = function(x)
  return 448 + 24 * math.sin(x / 23 + 1) + 16 * math.sin(x / 61) + 9 * math.sin(x / 13 + 2)
end
hz = function(x) return 512 + 4 * math.sin(x / 40) end

clumps = ellipse(497, 424, 30, 36) + ellipse(638, 418, 46, 44) + ellipse(798, 426, 36, 28) + ellipse(938, 420, 33, 38)
band = below(tl) * above(hz) * mask(function(x) return x > 370 and 1 or 0 end)
work(band + clumps, {hand="body", pile=treedark2, coverage=2.0, fill=true, angle=0.02, pressure={0.6, 0.85}, edge=0.45})

shoreL = below(function(x) return 500 + 6 * math.sin(x / 30) end) * above(hz) * mask(function(x) return x <= 420 and 1 or 0 end)
work(shoreL, {hand="body", pile=treedark2, coverage=1.6, fill=true, angle=0.02, pressure={0.5, 0.7}, edge=0.6})
print("treeline deepened")

--@ chunk 28
-- Water: three fields over the old cream, blended
treedark2 = pile{{"lead white", 0.4}, {"cobalt blue", 0.55}, {"green earth", 0.3}, {"raw umber", 0.6}, {"bone black", 0.65}}
glowwater = pile{{"lead white", 1.2}, {"chrome yellow", 0.4}, {"vermilion", 0.2}, {"cobalt blue", 0.3}, {"raw umber", 0.3}}
watermid  = pile{{"lead white", 0.9}, {"cobalt blue", 1.0}, {"raw umber", 0.45}, {"bone black", 0.35}, {"green earth", 0.3}, {"vermilion", 0.1}}
waterdeep = pile{{"lead white", 0.7}, {"cobalt blue", 0.9}, {"raw umber", 0.6}, {"bone black", 0.55}, {"green earth", 0.35}, {"vermilion", 0.08}}

-- fill treeline holes
holes = ellipse(662, 452, 26, 20) + ellipse(938, 448, 22, 18) + ellipse(940, 462, 18, 14)
work(holes, {hand="detail", pile=treedark2, coverage=2.2, fill=true, edge=0.4, clip=true})

-- water fields
hz = function(x) return 512 + 4 * math.sin(x / 40) end
wg = below(function(x) return 610 + 15 * math.sin(x / 70) end) * above(hz)
work(wg, {hand="broad", pile=glowwater, coverage=2.6, fill=true, angle=0.02, pressure={0.7, 0.9}, edge=1})

wm = below(function(x) return 980 + 25 * math.sin(x / 80) end) * above(hz)
work(wm, {hand="broad", pile=watermid, coverage=2.6, fill=true, angle=0.02, pressure={0.7, 0.9}, edge=1})

wd = below(function(x) return 1260 end)
work(wd, {hand="broad", pile=waterdeep, coverage=2.6, fill=true, angle=0.02, pressure={0.7, 0.9}, edge=1})

print("water in")

--@ chunk 29
-- Water fields (correct masks: water lies below the horizon curve)
glowwater = pile{{"lead white", 1.2}, {"chrome yellow", 0.4}, {"vermilion", 0.2}, {"cobalt blue", 0.3}, {"raw umber", 0.3}}
watermid  = pile{{"lead white", 0.9}, {"cobalt blue", 1.0}, {"raw umber", 0.45}, {"bone black", 0.35}, {"green earth", 0.3}, {"vermilion", 0.1}}
waterdeep = pile{{"lead white", 0.7}, {"cobalt blue", 0.9}, {"raw umber", 0.6}, {"bone black", 0.55}, {"green earth", 0.35}, {"vermilion", 0.08}}

hz = function(x) return 512 + 4 * math.sin(x / 40) end
wg = below(hz) * above(function(x) return 615 + 15 * math.sin(x / 70) end)
work(wg, {hand="broad", pile=glowwater, coverage=2.6, fill=true, angle=0.02, pressure={0.7, 0.9}, edge=1})

wm = below(hz) * above(function(x) return 985 + 25 * math.sin(x / 80) end)
work(wm, {hand="broad", pile=watermid, coverage=2.6, fill=true, angle=0.02, pressure={0.7, 0.9}, edge=1})

wd = below(function(x) return 985 + 25 * math.sin(x / 80) end)
work(wd, {hand="broad", pile=waterdeep, coverage=2.6, fill=true, angle=0.02, pressure={0.7, 0.9}, edge=1})

print("water fields on")

--@ chunk 30
-- Blend the water, close the rims, deepen the bottom
waterzone = below(function(x) return 512 + 4 * math.sin(x / 40) end)
blend(waterzone, {coverage=1.0})

waterdeep = pile{{"lead white", 0.7}, {"cobalt blue", 0.9}, {"raw umber", 0.6}, {"bone black", 0.55}, {"green earth", 0.35}, {"vermilion", 0.08}}
rims = rect(0, 514, 14, 740) + rect(986, 514, 14, 740) + rect(0, 1226, 1000, 26)
work(rims, {hand="body", pile=waterdeep, coverage=2.4, fill=true, angle=0.02, pressure={0.7, 0.9}, edge=1})
print("water blended, rims closed")

--@ chunk 31
-- Light path on the water, wet into wet
bright = pile{{"lead white", 2.2}, {"chrome yellow", 0.5}, {"vermilion", 0.25}}
flare  = pile{{"lead white", 1.6}, {"chrome yellow", 0.35}, {"vermilion", 0.2}, {"cobalt blue", 0.12}}

core = ribbon({{640, 516}, {700, 640}, {660, 830}, {600, 1000}, {560, 1160}, {540, 1250}}, {26, 44, 70, 100, 130, 145})
work(core, {hand="body", pile=bright, coverage=2.0, fill=true, angle=function(x, y) return 0.15 * math.sin(y / 60) end, pressure={0.6, 0.85}, edge=1})

wide = ribbon({{640, 516}, {710, 650}, {670, 850}, {610, 1030}, {575, 1180}, {560, 1250}}, {60, 110, 190, 260, 320, 350})
work(wide, {hand="broad", pile=flare, coverage=0.9, fill=false, angle=0.02, pressure={0.5, 0.7}, edge=1})

print("light path laid")

--@ chunk 32
-- Soften and break the light path
watermid  = pile{{"lead white", 0.9}, {"cobalt blue", 1.0}, {"raw umber", 0.45}, {"bone black", 0.35}, {"green earth", 0.3}, {"vermilion", 0.1}}
bright = pile{{"lead white", 2.2}, {"chrome yellow", 0.5}, {"vermilion", 0.25}}

wideR = ribbon({{640, 516}, {710, 650}, {670, 850}, {610, 1030}, {575, 1180}, {560, 1250}}, {70, 120, 200, 270, 330, 360})
coreR = ribbon({{640, 516}, {700, 640}, {660, 830}, {600, 1000}, {560, 1160}, {540, 1250}}, {26, 44, 70, 100, 130, 145})

blend(wideR, {coverage=1.0})
ring = wideR - coreR
work(ring, {hand="scumble", pile=watermid, coverage=0.9, angle=0.0, edge=1})
print("path softened and broken")

--@ chunk 33
hullpile = pile{{"bone black", 0.6}, {"raw umber", 0.7}, {"cobalt blue", 0.35}, {"lead white", 0.35}, {"vermilion", 0.06}}
hull = body_of{spine = {{352, 912}, {398, 916}, {442, 910}, {474, 902}}, widths = 26, char="firm"}
work(hull:mask(), {hand="body", pile=hullpile, coverage=2.2, fill=true, angle=0.02, pressure={0.6, 0.8}, edge=0.5})
print("hull ok")

--@ chunk 34
-- Yacht: hull from a ribbon, cabin, furled sail, rigger mast
hullpile = pile{{"bone black", 0.6}, {"raw umber", 0.7}, {"cobalt blue", 0.35}, {"lead white", 0.35}, {"vermilion", 0.06}}
warmside = pile{{"lead white", 1.2}, {"vermilion", 0.35}, {"chrome yellow", 0.2}, {"raw umber", 0.15}}

hull = ribbon({{350, 912}, {398, 917}, {442, 911}, {476, 901}}, {22, 30, 24, 7})
work(hull, {hand="body", pile=hullpile, coverage=2.4, fill=true, angle=0.02, pressure={0.6, 0.8}, edge=0.4})

cabin = ribbon({{400, 894}, {446, 891}}, 15)
work(cabin, {hand="body", pile=hullpile, coverage=1.8, fill=true, angle=0.02, edge=0.5})

sail = ribbon({{424, 886}, {427, 800}, {428, 745}}, 7)
work(sail, {hand="body", pile=hullpile, coverage=1.6, fill=true, angle=0.02, edge=0.5})

mb = brush{kind="rigger", width=3.5, point=1, stiffness=0.5}
mb:load(hullpile, 0.95)
mast = outline{{420, 904}, {424, 830}, {427, 745}}
mast:paint(mb, {pressure=0.85, every=2})

hs = hull:rim(5, 2) * mask(function(x, y) return x > 424 and 1 or 0 end)
work(hs, {hand="scumble", pile=warmside, coverage=0.8, angle=0.02, edge=1})

print("yacht in")

--@ chunk 35
-- Fix the mast area: cover the fat column, redraw thin mast, faint warm rim
watermid  = pile{{"lead white", 0.9}, {"cobalt blue", 1.0}, {"raw umber", 0.45}, {"bone black", 0.35}, {"green earth", 0.3}, {"vermilion", 0.1}}
hullpile = pile{{"bone black", 0.6}, {"raw umber", 0.7}, {"cobalt blue", 0.35}, {"lead white", 0.35}, {"vermilion", 0.06}}
warmpale2 = pile{{"lead white", 2.4}, {"vermilion", 0.12}, {"chrome yellow", 0.1}}

col = rect(408, 738, 36, 152)
work(col, {hand="body", pile=watermid, coverage=2.2, fill=true, angle=0.02, pressure={0.6, 0.8}, edge=1})

mb = brush{kind="rigger", width=3.5, point=1, stiffness=0.5}
mb:load(hullpile, 0.95)
mast = outline{{421, 892}, {424, 830}, {427, 748}}
mast:paint(mb, {pressure=0.5, every=2})

nub = ellipse(425, 812, 5, 14)
work(nub, {hand="detail", pile=hullpile, coverage=1.6, fill=true, edge=0.3, clip=true})

rim = hull:rim(4, 1.5) * mask(function(x, y) return x > 428 and 1 or 0 end)
stipple(rim, {pile=warmpale2, width=3, coverage=0.5, pressure={0.2, 0.4}, feather=1})

print("mast fixed")

--@ chunk 36
-- Clean the bow, firm the mast, whisper the warm rim
hullpile = pile{{"bone black", 0.6}, {"raw umber", 0.7}, {"cobalt blue", 0.35}, {"lead white", 0.35}, {"vermilion", 0.06}}
warmpale2 = pile{{"lead white", 2.4}, {"vermilion", 0.12}, {"chrome yellow", 0.1}}

hull = ribbon({{350, 912}, {398, 917}, {442, 911}, {476, 901}}, {22, 30, 24, 7})
bowm = hull * mask(function(x, y) return x > 424 and 1 or 0 end)
work(bowm, {hand="body", pile=hullpile, coverage=2.2, fill=true, angle=0.02, pressure={0.65, 0.85}, edge=0.3, clip=true})

mb = brush{kind="rigger", width=3.5, point=1, stiffness=0.5}
mb:load(hullpile, 0.95)
mast = outline{{421, 890}, {425, 820}, {427, 748}}
mast:paint(mb, {pressure=0.55, every=2})

flecks = hull:rim(3, 1) * mask(function(x, y) return x > 432 and 1 or 0 end)
stipple(flecks, {pile=warmpale2, width=2.5, coverage=0.15, pressure={0.15, 0.3}, feather=1})

-- quiet the mottled halo beside the mast
halo = rect(404, 760, 46, 130)
blend(halo, {coverage=0.8})

print("bow cleaned")

--@ chunk 37
hullpile = pile{{"bone black", 0.6}, {"raw umber", 0.7}, {"cobalt blue", 0.35}, {"lead white", 0.35}, {"vermilion", 0.06}}
probe = rect(430, 880, 40, 40)
work(probe, {hand="body", pile=hullpile, coverage=2.2, fill=true, angle=0.02, pressure={0.65, 0.85}, edge=0.3, clip=true})
print("probe painted")

--@ chunk 38
wait(3 * 60)
print(drying(455, 905))

--@ chunk 39
wait(3 * 60)
print(drying(455, 905))

--@ chunk 40
wait(24 * 60)
print(drying(455, 905))
print(drying(500, 700))

--@ chunk 41
-- Bow over tacky paint: solid dark, two passes
hullpile = pile{{"bone black", 0.6}, {"raw umber", 0.7}, {"cobalt blue", 0.35}, {"lead white", 0.35}, {"vermilion", 0.06}}
hullpile2 = pile{{"bone black", 0.7}, {"raw umber", 0.8}, {"cobalt blue", 0.3}, {"lead white", 0.3}}

hull = ribbon({{350, 912}, {398, 917}, {442, 911}, {476, 901}}, {22, 30, 24, 7})
bowm = hull * mask(function(x, y) return x > 420 and 1 or 0 end)
work(bowm, {hand="body", pile=hullpile, coverage=2.6, fill=true, angle=0.02, pressure={0.75, 0.95}, edge=0.25, clip=true})
work(bowm, {hand="detail", pile=hullpile2, coverage=1.6, fill=true, angle=0.02, edge=0.2, clip=true})
print("bow covered")

--@ chunk 42
-- Stray pink flecks + foreground spit
hullpile2 = pile{{"bone black", 0.7}, {"raw umber", 0.8}, {"cobalt blue", 0.3}, {"lead white", 0.3}}
spitdark  = pile{{"raw umber", 1}, {"bone black", 0.45}, {"green earth", 0.35}, {"cobalt blue", 0.2}, {"lead white", 0.25}}

strays = ellipse(474, 887, 9, 7) + ellipse(418, 922, 12, 8) + ellipse(408, 916, 8, 6) + ellipse(441, 926, 6, 4)
work(strays, {hand="detail", pile=hullpile2, coverage=2.0, fill=true, edge=0.3, clip=true})

spit = below(function(x) return 1130 + 26 * math.sin(x / 90 + 1) + 14 * math.sin(x / 38 + 2) - 0.28 * x end)
work(spit, {hand="broad", pile=spitdark, coverage=2.6, fill=true, angle=0.05, pressure={0.7, 0.9}, edge=0.7})
print("spit in")

--@ chunk 43
-- Grasses and reeds on the bank edge
grassdark = pile{{"bone black", 0.5}, {"raw umber", 0.65}, {"cobalt blue", 0.2}, {"green earth", 0.25}, {"lead white", 0.2}}
g = brush{kind="rigger", width=2.2, point=1, stiffness=0.45}
g:load(grassdark, 0.9)

spit_edge = function(x) return 1150 + 26 * math.sin(x / 90 + 1) + 14 * math.sin(x / 38 + 2) - 0.28 * x end
xs = uneven(26, 30, 990, 0.8, 0.35, 7)
for i, x in ipairs(xs) do
  local hgt = rand(16, 48)
  if x > 640 and x < 900 then hgt = rand(34, 62) end
  local lean = rand(-14, 26)
  local base = spit_edge(x) + 4
  g:stroke({{x, base}, {x + lean * 0.4, base - hgt * 0.6}, {x + lean, base - hgt}},
    {pressure={0.65, 0.03}, ramps={0.12, 0.45}})
end
-- three taller reeds near the light
for _, x in ipairs({688, 742, 812}) do
  local base = spit_edge(x) + 4
  local hgt = rand(70, 92)
  local lean = rand(-6, 14)
  g:stroke({{x, base}, {x + lean * 0.5, base - hgt * 0.55}, {x + lean, base - hgt}},
    {pressure={0.6, 0.02}, ramps={0.1, 0.5}})
end
print("grasses in:", #xs + 3)

--@ chunk 44
grassdark = pile{{"bone black", 0.5}, {"raw umber", 0.65}, {"cobalt blue", 0.2}, {"green earth", 0.25}, {"lead white", 0.2}}
g = brush{kind="rigger", width=2.2, point=1, stiffness=0.45}
print("fullness after load:", g:fullness())
g:load(grassdark, 0.9)
print("fullness after load:", g:fullness())
g:stroke({{500, 1100}, {505, 1080}, {508, 1060}}, {pressure={0.65, 0.03}, ramps={0.12, 0.45}})
print("mark width:", g:mark_width(0.65))

--@ chunk 45
-- Grass clumps along the bank edge
grassdark = pile{{"bone black", 0.35}, {"raw umber", 0.55}, {"green earth", 0.45}, {"cobalt blue", 0.15}, {"lead white", 0.15}}
g = brush{kind="round", width=5, point=1, stiffness=0.5}

spit_edge = function(x) return 1150 + 26 * math.sin(x / 90 + 1) + 14 * math.sin(x / 38 + 2) - 0.28 * x end
xs = uneven(9, 40, 980, 0.7, 0.4, 11)
for _, x in ipairs(xs) do
  if g:fullness() < 0.3 then g:wipe(0.5); g:load(grassdark, 0.9) end
  local nb = math.random(2, 3)
  for k = 1, nb do
    local bx = x + rand(-7, 7)
    local hgt = rand(18, 46)
    if bx > 620 and bx < 900 then hgt = rand(30, 60) end
    local lean = rand(-16, 30)
    local base = spit_edge(bx) + 5
    g:stroke({{bx, base}, {bx + lean * 0.35, base - hgt * 0.55}, {bx + lean, base - hgt}},
      {pressure={0.8, 0.06}, ramps={0.1, 0.5}})
  end
end
print("grass clumps in")

--@ chunk 46
-- Thicker grass blades and reeds
grassdark = pile{{"bone black", 0.35}, {"raw umber", 0.55}, {"green earth", 0.45}, {"cobalt blue", 0.15}, {"lead white", 0.15}}
g = brush{kind="round", width=11, point=1, stiffness=0.5}

spit_edge = function(x) return 1150 + 26 * math.sin(x / 90 + 1) + 14 * math.sin(x / 38 + 2) - 0.28 * x end
xs = uneven(8, 50, 970, 0.7, 0.4, 13)
for _, x in ipairs(xs) do
  if g:fullness() < 0.3 then g:wipe(0.5); g:load(grassdark, 0.95) end
  local nb = math.random(2, 4)
  for k = 1, nb do
    local bx = x + rand(-8, 8)
    local hgt = rand(20, 48)
    if bx > 600 and bx < 900 then hgt = rand(36, 68) end
    local lean = rand(-18, 34)
    local base = spit_edge(bx) + 6
    g:stroke({{bx, base}, {bx + lean * 0.35, base - hgt * 0.55}, {bx + lean, base - hgt}},
      {pressure={0.85, 0.05}, ramps={0.08, 0.55}})
  end
end
-- reeds
for _, x in ipairs({672, 738, 806, 590}) do
  local base = spit_edge(x) + 6
  local hgt = rand(72, 96)
  local lean = rand(-8, 16)
  g:stroke({{x, base}, {x + lean * 0.5, base - hgt * 0.55}, {x + lean, base - hgt}},
    {pressure={0.85, 0.04}, ramps={0.08, 0.6}})
end
print("blades and reeds in")

--@ chunk 47
-- Firm the spit edge, knock back floaters, finish boat strays
spitdark  = pile{{"raw umber", 1}, {"bone black", 0.45}, {"green earth", 0.35}, {"cobalt blue", 0.2}, {"lead white", 0.25}}
watermid  = pile{{"lead white", 0.9}, {"cobalt blue", 1.0}, {"raw umber", 0.45}, {"bone black", 0.35}, {"green earth", 0.3}, {"vermilion", 0.1}}
hullpile2 = pile{{"bone black", 0.7}, {"raw umber", 0.8}, {"cobalt blue", 0.3}, {"lead white", 0.3}}

spit = below(function(x) return 1150 + 26 * math.sin(x / 90 + 1) + 14 * math.sin(x / 38 + 2) - 0.28 * x end)
work(spit, {hand="body", pile=spitdark, coverage=1.8, fill=true, angle=0.05, pressure={0.7, 0.9}, edge=0.15})

floaters = ellipse(172, 950, 22, 8) + ellipse(30, 1100, 30, 12) + ellipse(20, 980, 16, 30)
work(floaters, {hand="body", pile=watermid, coverage=1.6, fill=true, angle=0.02, edge=1})

strays2 = ellipse(468, 886, 14, 9) + ellipse(478, 896, 10, 7) + ellipse(452, 891, 9, 6)
work(strays2, {hand="detail", pile=hullpile2, coverage=2.2, fill=true, edge=0.25, clip=true})
print("cleanup done")

--@ chunk 48
-- Reed-bed tongue, mooring post, boat reflection, bank surface
spitdark  = pile{{"raw umber", 1}, {"bone black", 0.45}, {"green earth", 0.35}, {"cobalt blue", 0.2}, {"lead white", 0.25}}
hullpile  = pile{{"bone black", 0.6}, {"raw umber", 0.7}, {"cobalt blue", 0.35}, {"lead white", 0.35}, {"vermilion", 0.06}}
postdark  = pile{{"bone black", 0.55}, {"raw umber", 0.75}, {"cobalt blue", 0.25}, {"lead white", 0.2}}

-- tongue of reeds reaching into the water around x 500-640
tongue = poly({{500, 1128}, {560, 1102}, {620, 1088}, {665, 1096}, {640, 1130}, {560, 1160}, {500, 1170}}, true)
work(tongue, {hand="body", pile=spitdark, coverage=2.4, fill=true, angle=0.05, pressure={0.7, 0.9}, edge=0.4})

-- mooring post at the bank edge, raking slightly
post = ribbon({{596, 1010}, {590, 952}}, 6)
work(post, {hand="body", pile=postdark, coverage=2.2, fill=true, angle=0.02, edge=0.3, clip=true})

-- boat reflection: soft broken smear below the hull
refl = ribbon({{398, 948}, {404, 992}, {408, 1032}}, {22, 30, 40})
work(refl, {hand="scumble", pile=hullpile, coverage=0.8, angle=0.02, edge=1})

-- bank surface: subtle variation
spitwarm = pile{{"lead white", 1}, {"yellow ochre", 0.3}, {"raw umber", 0.5}, {"green earth", 0.2}}
patches = ellipse(180, 1210, 90, 30) + ellipse(420, 1180, 70, 24) + ellipse(700, 1140, 80, 26) + ellipse(880, 1090, 70, 24)
work(patches, {hand="scumble", pile=spitwarm, coverage=0.5, angle=0.05, edge=1})
print("tongue, post, reflection in")

--@ chunk 49
-- Cover cream blobs, calm the reflection, crisp the post, birds
spitdark  = pile{{"raw umber", 1}, {"bone black", 0.45}, {"green earth", 0.35}, {"cobalt blue", 0.2}, {"lead white", 0.25}}
watermid  = pile{{"lead white", 0.9}, {"cobalt blue", 1.0}, {"raw umber", 0.45}, {"bone black", 0.35}, {"green earth", 0.3}, {"vermilion", 0.1}}
postdark  = pile{{"bone black", 0.55}, {"raw umber", 0.75}, {"cobalt blue", 0.25}, {"lead white", 0.2}}

patches = ellipse(180, 1210, 100, 34) + ellipse(420, 1180, 80, 28) + ellipse(700, 1140, 90, 30) + ellipse(880, 1090, 80, 28)
work(patches, {hand="body", pile=spitdark, coverage=2.6, fill=true, angle=0.05, pressure={0.7, 0.9}, edge=1})

-- calm the boat's reflection: blend, then break with water
halo = rect(370, 930, 80, 120)
blend(halo, {coverage=0.9})
refl2 = ribbon({{398, 946}, {404, 985}, {408, 1020}}, {16, 22, 28})
work(refl2, {hand="scumble", pile=watermid, coverage=0.5, angle=0.02, edge=1})

-- crisper post
pb = brush{kind="round", width=8, point=1, stiffness=0.55}
pb:load(postdark, 0.95)
pb:stroke({{594, 1008}, {591, 978}, {589, 950}}, {pressure={0.9, 0.35}, ramps={0.08, 0.4}})

-- birds in the glow gap right of the trees
bird = brush{kind="round", width=6, point=1, stiffness=0.5}
birdpile = pile{{"bone black", 0.6}, {"raw umber", 0.5}, {"cobalt blue", 0.3}, {"lead white", 0.2}}
bird:load(birdpile, 0.95)
birds = {{788, 352}, {826, 366}, {862, 344}, {842, 384}}
for _, p in ipairs(birds) do
  local s = rand(0.8, 1.3)
  bird:stroke({{p[1] - 7 * s, p[2] - 3 * s}, {p[1], p[2]}, {p[1] + 7 * s, p[2] - 4 * s}},
    {pressure={0.55, 0.06}, ramps={0.15, 0.4}})
end
print("tidied, birds in")

--@ chunk 50
-- Decisive cover of pale patches; water over the reflection smear
spitvery = pile{{"raw umber", 1}, {"bone black", 0.5}, {"green earth", 0.3}, {"cobalt blue", 0.25}, {"lead white", 0.3}}
watermid  = pile{{"lead white", 0.9}, {"cobalt blue", 1.0}, {"raw umber", 0.45}, {"bone black", 0.35}, {"green earth", 0.3}, {"vermilion", 0.1}}
postdark  = pile{{"bone black", 0.55}, {"raw umber", 0.75}, {"cobalt blue", 0.25}, {"lead white", 0.2}}

patches = ellipse(180, 1210, 96, 30) + ellipse(420, 1180, 76, 25) + ellipse(700, 1140, 86, 26) + ellipse(880, 1090, 76, 25)
work(patches, {hand="broad", pile=spitvery, coverage=2.2, fill=true, angle=0.05, pressure={0.8, 0.95}, edge=1})
work(patches, {hand="scumble", pile=spitvery, coverage=1.6, angle=0.05, edge=1})

rpale = rect(380, 940, 60, 100)
work(rpale, {hand="body", pile=watermid, coverage=2.0, fill=true, angle=0.02, pressure={0.7, 0.85}, edge=1})

-- one quiet dark hint of reflection
rb = brush{kind="round", width=6, point=1, stiffness=0.5}
rb:load(postdark, 0.9)
rb:stroke({{399, 948}, {403, 982}, {406, 1012}}, {pressure={0.5, 0.1}, ramps={0.15, 0.5}})
print("patches settled")

--@ chunk 51
-- Reflection area unified with the darker water; post firm
waterdeep = pile{{"lead white", 0.7}, {"cobalt blue", 0.9}, {"raw umber", 0.6}, {"bone black", 0.55}, {"green earth", 0.35}, {"vermilion", 0.08}}
postdark  = pile{{"bone black", 0.55}, {"raw umber", 0.75}, {"cobalt blue", 0.25}, {"lead white", 0.2}}

work(rect(378, 936, 64, 108), {hand="body", pile=waterdeep, coverage=2.2, fill=true, angle=0.02, pressure={0.75, 0.9}, edge=1})

pb = brush{kind="round", width=14, point=1, stiffness=0.55}
pb:load(postdark, 0.95)
pb:stroke({{594, 1012}, {591, 980}, {589, 948}}, {pressure={0.9, 0.4}, ramps={0.08, 0.4}})
print("reflection and post")

--@ chunk 52
-- Veils to knit the boat zone into the water
veil = pile{{"bone black", 0.25}, {"cobalt blue", 0.4}, {"raw umber", 0.4}, {"green earth", 0.2}, medium=0.65}

veilrect = rect(372, 930, 76, 118)
work(veilrect, {hand="body", pile=veil, coverage=0.9, angle=0.02, edge=1})

veilmast = rect(404, 742, 42, 170)
work(veilmast, {hand="body", pile=veil, coverage=0.8, angle=0.02, edge=1})

veilstreak = rect(280, 888, 90, 46)
work(veilstreak, {hand="body", pile=veil, coverage=0.7, angle=0.02, edge=1})

blend(veilrect, {coverage=0.7})
blend(veilmast, {coverage=0.7})
print("veils laid")

--@ chunk 53
print("sky:", drying(500, 200))
print("treeline:", drying(500, 450))
print("far water:", drying(800, 640))
print("mid water:", drying(800, 750))
print("bank:", drying(600, 1150))

--@ chunk 54
-- Finishing lights (on tacky/dry ground: they grab and stay broken)
bright = pile{{"lead white", 2.2}, {"chrome yellow", 0.5}, {"vermilion", 0.25}}
warmpale2 = pile{{"lead white", 2.4}, {"vermilion", 0.12}, {"chrome yellow", 0.1}}
flarep = pile{{"lead white", 2.6}, {"chrome yellow", 0.6}, {"vermilion", 0.25}}

pathzone = ribbon({{640, 516}, {700, 640}, {660, 830}, {610, 1000}, {575, 1160}, {560, 1250}}, {50, 90, 150, 210, 260, 290})
stipple(pathzone, {pile=bright, width=3.5, coverage=0.3, pressure={0.25, 0.55}, drag={5, 0}, feather=1})

tltop = function(x) return 452 + 24 * math.sin(x / 23 + 1) + 16 * math.sin(x / 61) + 9 * math.sin(x / 13 + 2) end
tlrim = below(tltop) * above(function(x) return tltop(x) - 20 end) * mask(function(x) return x > 540 and 1 or 0 end)
stipple(tlrim, {pile=warmpale2, width=2.5, coverage=0.22, pressure={0.15, 0.4}, feather=1})

work(rect(570, 430, 260, 80), {hand="scumble", pile=flarep, coverage=0.55, angle=0.02, edge=1})

tips = ribbon({{672, 950}, {738, 962}, {806, 955}}, 26)
stipple(tips, {pile=warmpale2, width=2.5, coverage=0.12, pressure={0.15, 0.35}, feather=1})
print("lights in")

--@ chunk 55
-- Erase the flare letters: warm glow over sky part, tree dark over tree part
gold3  = pile{{"lead white", 3}, {"chrome yellow", 0.6}, {"vermilion", 0.2}}
treedark2 = pile{{"lead white", 0.4}, {"cobalt blue", 0.55}, {"green earth", 0.3}, {"raw umber", 0.6}, {"bone black", 0.65}}

skyfix = rect(565, 425, 270, 24)
work(skyfix, {hand="body", pile=gold3, coverage=2.2, fill=true, angle=0.02, pressure={0.75, 0.9}, edge=1})
blend(skyfix, {coverage=0.8})

treefix = rect(560, 443, 280, 74)
tltop = function(x) return 452 + 24 * math.sin(x / 23 + 1) + 16 * math.sin(x / 61) + 9 * math.sin(x / 13 + 2) end
work(below(tltop) * treefix, {hand="body", pile=treedark2, coverage=2.4, fill=true, angle=0.02, pressure={0.7, 0.9}, edge=0.3, clip=true})
print("flare fixed")

--@ chunk 56
-- Heavy dark over the smothered treeline stretch
treedark3 = pile{{"lead white", 0.3}, {"cobalt blue", 0.5}, {"green earth", 0.3}, {"raw umber", 0.65}, {"bone black", 0.75}}
tltop = function(x) return 452 + 24 * math.sin(x / 23 + 1) + 16 * math.sin(x / 61) + 9 * math.sin(x / 13 + 2) end
hz = function(x) return 512 + 4 * math.sin(x / 40) end
zone = below(tltop) * above(hz) * rect(555, 400, 300, 130)
work(zone, {hand="body", pile=treedark3, coverage=3.0, fill=true, angle=0.02, pressure={0.8, 0.95}, edge=0.25, clip=true})
work(zone, {hand="scumble", pile=treedark3, coverage=2.0, angle=0.02, edge=0.3})
print("treeline restored")

--@ chunk 57
-- Break the smooth domes into foliage; tie the stretch to the rest
treedark3 = pile{{"lead white", 0.3}, {"cobalt blue", 0.5}, {"green earth", 0.3}, {"raw umber", 0.65}, {"bone black", 0.75}}
gold3  = pile{{"lead white", 3}, {"chrome yellow", 0.6}, {"vermilion", 0.2}}

-- new clumps to vary the silhouette
clumps2 = ellipse(585, 470, 34, 26) + ellipse(660, 458, 30, 30) + ellipse(742, 472, 36, 24) + ellipse(828, 462, 30, 28)
work(clumps2, {hand="body", pile=treedark3, coverage=2.6, fill=true, angle=0.02, pressure={0.75, 0.9}, edge=0.35, clip=true})

-- flecks to roughen the top edges
tltop = function(x) return 452 + 24 * math.sin(x / 23 + 1) + 16 * math.sin(x / 61) + 9 * math.sin(x / 13 + 2) end
edgeband = below(function(x) return tltop(x) + 16 end) * above(function(x) return tltop(x) - 12 end) * mask(function(x) return x > 555 and x < 870 and 1 or 0 end)
stipple(edgeband, {pile=treedark3, width=4, coverage=0.9, pressure={0.3, 0.6}, feather=1})

-- unify tone across the whole right treeline
unif = below(tltop) * above(function(x) return 512 + 4 * math.sin(x / 40) end) * mask(function(x) return x > 540 and 1 or 0 end)
work(unif, {hand="scumble", pile=treedark3, coverage=0.8, angle=0.02, edge=0.5})
print("treeline re-carved")

--@ chunk 58
-- Lose the hard cream top edge into the sky; break the dark edge with glow flecks
gold3  = pile{{"lead white", 3}, {"chrome yellow", 0.6}, {"vermilion", 0.2}}
treedark3 = pile{{"lead white", 0.3}, {"cobalt blue", 0.5}, {"green earth", 0.3}, {"raw umber", 0.65}, {"bone black", 0.75}}
tltop = function(x) return 452 + 24 * math.sin(x / 23 + 1) + 16 * math.sin(x / 61) + 9 * math.sin(x / 13 + 2) end

-- soften the straight cream top edge upward into the glow
aboveband = below(function(x) return 425 end) * above(function(x) return 395 end) * mask(function(x) return x > 560 and x < 865 and 1 or 0 end)
work(aboveband, {hand="scumble", pile=gold3, coverage=0.7, angle=0.02, edge=1})

-- glow flecks eating into the dark top edge
gapband = below(function(x) return tltop(x) + 18 end) * above(function(x) return tltop(x) - 8 end) * mask(function(x) return x > 555 and x < 875 and 1 or 0 end)
stipple(gapband, {pile=gold3, width=3, coverage=0.5, pressure={0.2, 0.5}, feather=1})

-- more dark flecks above, to ruffle the silhouette
ruff = below(function(x) return tltop(x) - 2 end) * above(function(x) return tltop(x) - 22 end) * mask(function(x) return x > 555 and x < 875 and 1 or 0 end)
stipple(ruff, {pile=treedark3, width=4, coverage=0.8, pressure={0.25, 0.55}, feather=1})
print("edges broken")

--@ chunk 59
-- Rebuild the right treeline decisively
treedark3 = pile{{"lead white", 0.3}, {"cobalt blue", 0.5}, {"green earth", 0.3}, {"raw umber", 0.65}, {"bone black", 0.75}}
gold3  = pile{{"lead white", 3}, {"chrome yellow", 0.6}, {"vermilion", 0.2}}
hz = function(x) return 512 + 4 * math.sin(x / 40) end
stretch = rect(548, 388, 350, 140) * above(hz)

base = below(function(x) return 470 end) * stretch
work(base, {hand="body", pile=treedark3, coverage=3.2, fill=true, angle=0.02, pressure={0.8, 0.95}, edge=0.15, clip=true})
work(base, {hand="scumble", pile=treedark3, coverage=2.0, angle=0.02, edge=0.2})

clumps3 = ellipse(596, 444, 42, 30) + ellipse(668, 436, 48, 42) + ellipse(748, 444, 40, 26) + ellipse(836, 438, 46, 38) + ellipse(886, 446, 28, 24)
work(clumps3 * stretch, {hand="body", pile=treedark3, coverage=3.0, fill=true, angle=0.02, pressure={0.8, 0.95}, edge=0.2, clip=true})
work(clumps3 * stretch, {hand="scumble", pile=treedark3, coverage=1.8, angle=0.02, edge=0.25})

-- sparse glow flecks along the new silhouette
tltop = function(x) return 452 + 20 * math.sin(x / 31 + 2) + 14 * math.sin(x / 67) end
gapband = below(function(x) return tltop(x) + 14 end) * above(function(x) return tltop(x) - 6 end) * stretch
stipple(gapband, {pile=gold3, width=3, coverage=0.35, pressure={0.2, 0.45}, feather=1})
print("right treeline rebuilt")

--@ chunk 60
-- Give the right treeline its texture back
treedark2 = pile{{"lead white", 0.4}, {"cobalt blue", 0.55}, {"green earth", 0.3}, {"raw umber", 0.6}, {"bone black", 0.65}}
treedark3 = pile{{"lead white", 0.3}, {"cobalt blue", 0.5}, {"green earth", 0.3}, {"raw umber", 0.65}, {"bone black", 0.75}}
gold3  = pile{{"lead white", 3}, {"chrome yellow", 0.6}, {"vermilion", 0.2}}
hz = function(x) return 512 + 4 * math.sin(x / 40) end
stretch = rect(548, 388, 350, 140) * above(hz)

work(stretch, {hand="scumble", pile=treedark2, coverage=1.3, angle=0.02, edge=0.4})
speck = below(function(x) return 500 end) * stretch
stipple(speck, {pile=treedark3, width=4, coverage=0.7, pressure={0.25, 0.5}, feather=1})

tltop = function(x) return 452 + 20 * math.sin(x / 31 + 2) + 14 * math.sin(x / 67) end
topruff = below(function(x) return tltop(x) + 10 end) * above(function(x) return tltop(x) - 10 end) * stretch
stipple(topruff, {pile=treedark3, width=4, coverage=1.0, pressure={0.3, 0.6}, feather=1})

canopy = below(function(x) return tltop(x) + 26 end) * above(function(x) return tltop(x) - 2 end) * stretch
stipple(canopy, {pile=gold3, width=3, coverage=0.12, pressure={0.15, 0.4}, feather=1})
print("texture back")

--@ chunk 61
wait(2 * 24 * 60)
print("sky:", drying(500, 200))
print("treeline:", drying(500, 450))
print("far water:", drying(800, 640))
print("mid water:", drying(800, 750))
print("bank:", drying(600, 1150))
print("boat:", drying(420, 910))

--@ chunk 62
-- Sky glow re-carves the slab; spires remain
gold3  = pile{{"lead white", 3}, {"chrome yellow", 0.6}, {"vermilion", 0.2}}
treedark3 = pile{{"lead white", 0.3}, {"cobalt blue", 0.5}, {"green earth", 0.3}, {"raw umber", 0.65}, {"bone black", 0.75}}

hz = function(x) return 512 + 4 * math.sin(x / 40) end
glowtop = function(x) return 452 + 8 * math.sin(x / 57) end
glowzone = below(glowtop) * above(function(x) return 400 end) * mask(function(x) return x > 548 and 1 or 0 end)
work(glowzone, {hand="body", pile=gold3, coverage=2.6, fill=true, angle=0.02, pressure={0.75, 0.9}, edge=0.15, clip=true})
blend(glowzone, {coverage=0.8})

spires = ellipse(628, 442, 13, 24) + ellipse(776, 438, 11, 28) + ellipse(862, 446, 13, 22) + ellipse(700, 448, 10, 16)
work(spires, {hand="detail", pile=treedark3, coverage=2.2, fill=true, angle=0.02, edge=0.2, clip=true})

ruff = below(function(x) return glowtop(x) + 6 end) * above(function(x) return glowtop(x) - 8 end) * mask(function(x) return x > 548 and 1 or 0 end)
stipple(ruff, {pile=treedark3, width=3.5, coverage=0.7, pressure={0.25, 0.5}, feather=1})
print("glow recarved")

--@ chunk 63
-- Glow ABOVE the treeline top (y < 452), i.e. above(glowtop) * below(400-line)
gold3  = pile{{"lead white", 3}, {"chrome yellow", 0.6}, {"vermilion", 0.2}}
treedark3 = pile{{"lead white", 0.3}, {"cobalt blue", 0.5}, {"green earth", 0.3}, {"raw umber", 0.65}, {"bone black", 0.75}}

glowtop = function(x) return 452 + 8 * math.sin(x / 57) end
glowzone = above(glowtop) * below(function(x) return 402 end) * mask(function(x) return x > 548 and 1 or 0 end)
work(glowzone, {hand="body", pile=gold3, coverage=2.6, fill=true, angle=0.02, pressure={0.75, 0.9}, edge=0.15, clip=true})
blend(glowzone, {coverage=0.8})

ruff = above(function(x) return glowtop(x) + 8 end) * below(function(x) return glowtop(x) - 6 end) * mask(function(x) return x > 548 and 1 or 0 end)
stipple(ruff, {pile=treedark3, width=3.5, coverage=0.7, pressure={0.25, 0.5}, feather=1})
print("glow recarved for real")

--@ chunk 64
-- Clean sky over the upper zone; then re-fleck the tree edge
skyfixp = pile{{"lead white", 2.6}, {"chrome yellow", 0.5}, {"vermilion", 0.22}, {"raw umber", 0.1}}
treedark3 = pile{{"lead white", 0.3}, {"cobalt blue", 0.5}, {"green earth", 0.3}, {"raw umber", 0.65}, {"bone black", 0.75}}

fillz = rect(548, 355, 355, 92)
work(fillz, {hand="body", pile=skyfixp, coverage=3.0, fill=true, angle=0.02, pressure={0.75, 0.9}, edge=0.2, clip=true})
work(fillz, {hand="scumble", pile=skyfixp, coverage=1.6, angle=0.02, edge=0.25})
blend(fillz, {coverage=0.9})

-- re-fleck the treeline top against the clean sky
glowtop = function(x) return 452 + 10 * math.sin(x / 47 + 1) + 6 * math.sin(x / 23) end
ruff = above(function(x) return glowtop(x) + 10 end) * below(function(x) return glowtop(x) - 8 end) * mask(function(x) return x > 548 and 1 or 0 end)
stipple(ruff, {pile=treedark3, width=4, coverage=0.8, pressure={0.25, 0.55}, feather=1})
print("sky clean")

--@ chunk 65
-- Soft edges for the sky patch; marry the tone
skyfixp2 = pile{{"lead white", 2.2}, {"chrome yellow", 0.42}, {"vermilion", 0.2}, {"raw umber", 0.25}}
treedark3 = pile{{"lead white", 0.3}, {"cobalt blue", 0.5}, {"green earth", 0.3}, {"raw umber", 0.65}, {"bone black", 0.75}}

soft = rect(548, 350, 355, 100):soften(14)
work(soft, {hand="body", pile=skyfixp2, coverage=2.0, fill=true, angle=0.02, pressure={0.7, 0.85}, edge=1})
work(soft, {hand="scumble", pile=skyfixp2, coverage=0.9, angle=0.02, edge=1})

glowtop = function(x) return 452 + 10 * math.sin(x / 47 + 1) + 6 * math.sin(x / 23) end
ruff = above(function(x) return glowtop(x) + 10 end) * below(function(x) return glowtop(x) - 8 end) * mask(function(x) return x > 548 and 1 or 0 end)
stipple(ruff, {pile=treedark3, width=4, coverage=0.85, pressure={0.25, 0.55}, feather=1})
print("sky married")

--@ chunk 66
-- Wisps in the glow; bridge the left seam
wisp = pile{{"lead white", 1.6}, {"vermilion", 0.25}, {"chrome yellow", 0.2}, {"raw umber", 0.2}, medium=0.35}
treedark3 = pile{{"lead white", 0.3}, {"cobalt blue", 0.5}, {"green earth", 0.3}, {"raw umber", 0.65}, {"bone black", 0.75}}

wispz = rect(570, 366, 320, 70)
work(wispz, {hand="scumble", pile=wisp, coverage=0.5, angle=0.02, edge=1})

bridge = ellipse(560, 428, 30, 42) + ellipse(545, 470, 26, 30)
work(bridge, {hand="body", pile=treedark3, coverage=2.4, fill=true, angle=0.02, pressure={0.75, 0.9}, edge=0.25, clip=true})

notch = ellipse(516, 410, 22, 18)
work(notch, {hand="detail", pile=treedark3, coverage=2.0, fill=true, edge=0.25, clip=true})
print("wisps and bridge")
print("boat dryness:", drying(420, 910), drying(600, 1150))

--@ chunk 67
-- Rims and streak calming (dry zones)
waterdeep = pile{{"lead white", 0.7}, {"cobalt blue", 0.9}, {"raw umber", 0.6}, {"bone black", 0.55}, {"green earth", 0.35}, {"vermilion", 0.08}}

rims = rect(0, 516, 12, 620) + rect(988, 516, 12, 620) + rect(0, 1120, 30, 132) + rect(970, 1120, 30, 132)
work(rims, {hand="body", pile=waterdeep, coverage=2.2, fill=true, angle=0.02, pressure={0.7, 0.9}, edge=1})

streakz = rect(0, 850, 260, 100)
work(streakz, {hand="scumble", pile=waterdeep, coverage=0.7, angle=0.02, edge=1})
print("rims and streak")

--@ chunk 68
-- Cover the dark speckle swarm with matched water
watermid2 = pile{{"lead white", 1.05}, {"cobalt blue", 0.85}, {"raw umber", 0.35}, {"bone black", 0.28}, {"green earth", 0.25}, {"vermilion", 0.08}}
z = rect(0, 828, 270, 140)
work(z, {hand="body", pile=watermid2, coverage=2.4, fill=true, angle=0.02, pressure={0.7, 0.9}, edge=1, clip=true})
work(z, {hand="scumble", pile=watermid2, coverage=1.2, angle=0.02, edge=1})
blend(z, {coverage=0.8})
print("swarm covered")
print("boat:", drying(420, 910), "bank:", drying(600, 1150))

--@ chunk 69
-- Darkening glaze over the pale patch, soft edges
veil2 = pile{{"cobalt blue", 0.7}, {"bone black", 0.25}, {"raw umber", 0.45}, {"green earth", 0.2}, medium=0.6}
soft = rect(4, 838, 258, 118):soften(22)
work(soft, {hand="body", pile=veil2, coverage=0.9, angle=0.02, edge=1, clip=true})
work(soft, {hand="scumble", pile=veil2, coverage=0.5, angle=0.02, edge=1})
blend(soft, {coverage=0.7})
print("glazed")

--@ chunk 70
-- Matched water over the pale patch; clean slate behind the boat
watermid3 = pile{{"lead white", 1.0}, {"cobalt blue", 0.95}, {"raw umber", 0.45}, {"bone black", 0.35}, {"green earth", 0.28}, {"vermilion", 0.08}}

soft = rect(4, 838, 258, 118):soften(22)
work(soft, {hand="body", pile=watermid3, coverage=2.8, fill=true, angle=0.02, pressure={0.75, 0.9}, edge=1, clip=true})
blend(soft, {coverage=0.8})

slate = rect(300, 718, 225, 290)
work(slate, {hand="body", pile=watermid3, coverage=2.8, fill=true, angle=0.02, pressure={0.75, 0.9}, edge=1, clip=true})
work(slate, {hand="scumble", pile=watermid3, coverage=1.2, angle=0.02, edge=1})
blend(slate, {coverage=0.8})
print("clean slate")

--@ chunk 71
-- Marry patch edges into horizontal streaks
watermid3 = pile{{"lead white", 1.0}, {"cobalt blue", 0.95}, {"raw umber", 0.45}, {"bone black", 0.35}, {"green earth", 0.28}, {"vermilion", 0.08}}
darker = pile{{"lead white", 0.7}, {"cobalt blue", 1.05}, {"raw umber", 0.55}, {"bone black", 0.45}, {"green earth", 0.3}, {"vermilion", 0.08}}
spitdark  = pile{{"raw umber", 1}, {"bone black", 0.45}, {"green earth", 0.35}, {"cobalt blue", 0.2}, {"lead white", 0.25}}

for _, band in ipairs({rect(0, 826, 266, 30), rect(0, 940, 266, 30)}) do
  work(band, {hand="scumble", pile=watermid3, coverage=0.8, angle=0.0, edge=1})
  work(band, {hand="scumble", pile=darker, coverage=0.5, angle=0.0, edge=1})
  blend(band, {coverage=0.8})
end
for _, band in ipairs({rect(296, 712, 235, 26), rect(296, 996, 235, 26), rect(292, 760, 24, 260), rect(517, 760, 20, 260)}) do
  work(band, {hand="scumble", pile=watermid3, coverage=0.7, angle=0.0, edge=1})
  work(band, {hand="scumble", pile=darker, coverage=0.4, angle=0.0, edge=1})
  blend(band, {coverage=0.7})
end

-- bank top patch where the slate spilled
bp = ellipse(400, 1005, 60, 18) + ellipse(430, 1012, 40, 14)
work(bp, {hand="body", pile=spitdark, coverage=2.2, fill=true, angle=0.02, pressure={0.75, 0.9}, edge=0.4, clip=true})
print("edges married")

--@ chunk 72
-- Re-grade the lower water; re-cut the light path
deep2 = pile{{"lead white", 0.75}, {"cobalt blue", 0.95}, {"raw umber", 0.6}, {"bone black", 0.5}, {"green earth", 0.35}, {"vermilion", 0.1}}
deep3 = pile{{"lead white", 0.6}, {"cobalt blue", 1.0}, {"raw umber", 0.7}, {"bone black", 0.6}, {"green earth", 0.4}, {"vermilion", 0.08}}
bright = pile{{"lead white", 2.2}, {"chrome yellow", 0.5}, {"vermilion", 0.25}}
flare  = pile{{"lead white", 1.6}, {"chrome yellow", 0.35}, {"vermilion", 0.2}, {"cobalt blue", 0.12}}
waterdeep = pile{{"lead white", 0.7}, {"cobalt blue", 0.9}, {"raw umber", 0.6}, {"bone black", 0.55}, {"green earth", 0.35}, {"vermilion", 0.08}}

spit_edge = function(x) return 1150 + 26 * math.sin(x / 90 + 1) + 14 * math.sin(x / 38 + 2) - 0.28 * x end
notbank = mask(function(x, y) return y < spit_edge(x) and 1 or 0 end)

bandA = below(function(x) return 875 + 18 * math.sin(x / 80) end) * above(function(x) return 1075 + 15 * math.sin(x / 70) end) * notbank
work(bandA, {hand="body", pile=deep2, coverage=2.4, fill=true, angle=0.02, pressure={0.75, 0.9}, edge=1, clip=true})
blend(bandA, {coverage=0.7})

bandB2 = below(function(x) return 1260 end) * above(function(x) return 1075 + 15 * math.sin(x / 70) end)
work(bandB2, {hand="body", pile=deep3, coverage=2.4, fill=true, angle=0.02, pressure={0.75, 0.9}, edge=1, clip=true})
work(bandB2, {hand="scumble", pile=deep3, coverage=1.0, angle=0.02, edge=1})
blend(bandB2, {coverage=0.7})

lowpath = ribbon({{612, 1000}, {572, 1130}, {505, 1250}}, {150, 215, 260})
work(lowpath, {hand="body", pile=bright, coverage=1.6, fill=true, angle=0.02, pressure={0.6, 0.8}, edge=1})
wide2 = ribbon({{620, 1000}, {580, 1140}, {520, 1250}}, {230, 320, 380})
work(wide2, {hand="broad", pile=flare, coverage=0.8, fill=false, angle=0.02, pressure={0.5, 0.7}, edge=1})

rimb = rect(0, 1218, 1000, 34)
work(rimb, {hand="scumble", pile=waterdeep, coverage=0.8, angle=0.02, edge=1})
blend(rimb, {coverage=0.7})
print("lower water re-graded")

--@ chunk 73
-- Streaky water: alternating horizontal bands across the width
deep2 = pile{{"lead white", 0.75}, {"cobalt blue", 0.95}, {"raw umber", 0.6}, {"bone black", 0.5}, {"green earth", 0.35}, {"vermilion", 0.1}}
deep3 = pile{{"lead white", 0.6}, {"cobalt blue", 1.0}, {"raw umber", 0.7}, {"bone black", 0.6}, {"green earth", 0.4}, {"vermilion", 0.08}}
flare  = pile{{"lead white", 1.6}, {"chrome yellow", 0.35}, {"vermilion", 0.2}, {"cobalt blue", 0.12}}
spit_edge = function(x) return 1150 + 26 * math.sin(x / 90 + 1) + 14 * math.sin(x / 38 + 2) - 0.28 * x end
notbank = mask(function(x, y) return y < spit_edge(x) and 1 or 0 end)

bands = {
  {690, 745, flare, 0.45},
  {775, 825, deep2, 0.5},
  {845, 905, deep2, 0.55},
  {925, 985, flare, 0.3},
  {1010, 1075, deep3, 0.55},
  {1100, 1180, deep3, 0.6},
}
for _, bd in ipairs(bands) do
  local m = below(function(x) return bd[2] + 12 * math.sin(x / 64 + bd[1]) end)
          * above(function(x) return bd[1] - 12 * math.sin(x / 71) end)
          * notbank
  work(m, {hand="scumble", pile=bd[3], coverage=bd[4], angle=0.0, edge=1})
  blend(m, {coverage=0.6})
end
print("streaks in")

--@ chunk 74
-- Registered streak bands (broad hand)
deep2 = pile{{"lead white", 0.75}, {"cobalt blue", 0.95}, {"raw umber", 0.6}, {"bone black", 0.5}, {"green earth", 0.35}, {"vermilion", 0.1}}
deep3 = pile{{"lead white", 0.6}, {"cobalt blue", 1.0}, {"raw umber", 0.7}, {"bone black", 0.6}, {"green earth", 0.4}, {"vermilion", 0.08}}
flare  = pile{{"lead white", 1.6}, {"chrome yellow", 0.35}, {"vermilion", 0.2}, {"cobalt blue", 0.12}}
spit_edge = function(x) return 1150 + 26 * math.sin(x / 90 + 1) + 14 * math.sin(x / 38 + 2) - 0.28 * x end
notbank = mask(function(x, y) return y < spit_edge(x) and 1 or 0 end)

bands = {
  {695, 748, flare, 0.5},
  {778, 828, deep2, 0.55},
  {848, 908, deep2, 0.6},
  {928, 988, flare, 0.35},
  {1012, 1078, deep3, 0.6},
  {1105, 1185, deep3, 0.65},
}
for _, bd in ipairs(bands) do
  local m = below(function(x) return bd[2] + 10 * math.sin(x / 64 + bd[1]) end)
          * above(function(x) return bd[1] - 10 * math.sin(x / 71) end)
          * notbank
  work(m, {hand="broad", pile=bd[3], coverage=bd[4], angle=0.0, pressure={0.55, 0.75}, edge=1})
  blend(m, {coverage=0.7})
end
print("streaks laid")

--@ chunk 75
-- Registered streak bands, masks the right way round
deep2 = pile{{"lead white", 0.75}, {"cobalt blue", 0.95}, {"raw umber", 0.6}, {"bone black", 0.5}, {"green earth", 0.35}, {"vermilion", 0.1}}
deep3 = pile{{"lead white", 0.6}, {"cobalt blue", 1.0}, {"raw umber", 0.7}, {"bone black", 0.6}, {"green earth", 0.4}, {"vermilion", 0.08}}
flare  = pile{{"lead white", 1.6}, {"chrome yellow", 0.35}, {"vermilion", 0.2}, {"cobalt blue", 0.12}}
spit_edge = function(x) return 1150 + 26 * math.sin(x / 90 + 1) + 14 * math.sin(x / 38 + 2) - 0.28 * x end
notbank = mask(function(x, y) return y < spit_edge(x) and 1 or 0 end)

bands = {
  {695, 748, flare, 0.5},
  {778, 828, deep2, 0.55},
  {848, 908, deep2, 0.6},
  {928, 988, flare, 0.35},
  {1012, 1078, deep3, 0.6},
  {1105, 1185, deep3, 0.65},
}
for _, bd in ipairs(bands) do
  local m = below(function(x) return bd[1] - 10 * math.sin(x / 71) end)
          * above(function(x) return bd[2] + 10 * math.sin(x / 64 + bd[1]) end)
          * notbank
  work(m, {hand="broad", pile=bd[3], coverage=bd[4], angle=0.0, pressure={0.55, 0.75}, edge=1})
  blend(m, {coverage=0.7})
end
print("streaks laid")

--@ chunk 76
-- Rebuild the yacht, crisp, on the clean water
hullc = pile{{"bone black", 0.55}, {"raw umber", 0.65}, {"cobalt blue", 0.3}, {"lead white", 0.3}}
warmfleck = pile{{"lead white", 2.0}, {"vermilion", 0.3}, {"chrome yellow", 0.15}}
warmpale2 = pile{{"lead white", 2.4}, {"vermilion", 0.12}, {"chrome yellow", 0.1}}

hull = ribbon({{350, 912}, {398, 917}, {442, 911}, {476, 901}}, {22, 30, 24, 7})
work(hull, {hand="body", pile=hullc, coverage=2.6, fill=true, angle=0.02, pressure={0.8, 0.95}, edge=0.25, clip=true})
work(hull, {hand="detail", pile=hullc, coverage=1.5, fill=true, angle=0.02, edge=0.2, clip=true})

cabin = ribbon({{402, 893}, {446, 890}}, 15)
work(cabin, {hand="body", pile=hullc, coverage=1.8, fill=true, angle=0.02, edge=0.3, clip=true})

mb = brush{kind="rigger", width=3.5, point=1, stiffness=0.5}
mb:load(hullc, 0.95)
mast = outline{{421, 893}, {424, 820}, {427, 742}}
mast:paint(mb, {pressure=0.5, every=2})

nub = ellipse(425, 808, 5, 13)
work(nub, {hand="detail", pile=hullc, coverage=1.8, fill=true, edge=0.25, clip=true})

stipple(hull:rim(3, 1) * mask(function(x, y) return x > 430 and 1 or 0 end),
  {pile=warmpale2, width=2.5, coverage=0.12, pressure={0.15, 0.3}, feather=1})

-- broken reflection: short horizontal dark dashes below the hull
reflz = rect(360, 936, 110, 80)
stipple(reflz, {pile=hullc, width=4, coverage=0.25, pressure={0.2, 0.45}, drag={9, 0}, feather=1})
print("yacht rebuilt")

--@ chunk 77
-- Darken the hull; light catches the sheer
hulld = pile{{"bone black", 0.7}, {"raw umber", 0.7}, {"cobalt blue", 0.25}, {"lead white", 0.2}}
warmpale2 = pile{{"lead white", 2.4}, {"vermilion", 0.12}, {"chrome yellow", 0.1}}

hull = ribbon({{350, 912}, {398, 917}, {442, 911}, {476, 901}}, {22, 30, 24, 7})
work(hull, {hand="body", pile=hulld, coverage=2.0, fill=true, angle=0.02, pressure={0.8, 0.95}, edge=0.25, clip=true})

sheer = below(function(x) return 910 - 0.03 * x end) * above(function(x) return 886 - 0.03 * x end)
       * mask(function(x) return x > 352 and x < 478 and 1 or 0 end)
stipple(sheer, {pile=warmpale2, width=2.5, coverage=0.22, pressure={0.2, 0.4}, drag={6, 0}, feather=1})
print("hull darkened")

--@ chunk 78
-- Broad glow field on the water; dark left rim; boat reflection
flare  = pile{{"lead white", 1.6}, {"chrome yellow", 0.35}, {"vermilion", 0.2}, {"cobalt blue", 0.12}}
deep3 = pile{{"lead white", 0.6}, {"cobalt blue", 1.0}, {"raw umber", 0.7}, {"bone black", 0.6}, {"green earth", 0.4}, {"vermilion", 0.08}}
hullc = pile{{"bone black", 0.55}, {"raw umber", 0.65}, {"cobalt blue", 0.3}, {"lead white", 0.3}}

-- glow field: soft feathered pale wash around the path, edges feathered out
glowz = rect(280, 730, 290, 300):soften(30)
work(glowz, {hand="broad", pile=flare, coverage=0.55, angle=0.0, pressure={0.45, 0.65}, edge=1})
blend(glowz, {coverage=0.7})

-- left rim dark
work(rect(0, 516, 16, 630), {hand="body", pile=deep3, coverage=2.2, fill=true, angle=0.02, pressure={0.7, 0.9}, edge=1})
blend(rect(0, 516, 30, 630), {coverage=0.7})

-- boat reflection, a touch stronger
stipple(rect(355, 934, 120, 92), {pile=hullc, width=4.5, coverage=0.3, pressure={0.25, 0.5}, drag={10, 0}, feather=1})
print("glow field, rim, reflection")

--@ chunk 79
-- Hull dark again, mast and cabin crisp
hulld = pile{{"bone black", 0.75}, {"raw umber", 0.7}, {"cobalt blue", 0.25}, {"lead white", 0.15}}
hull = ribbon({{350, 912}, {398, 917}, {442, 911}, {476, 901}}, {22, 30, 24, 7})
work(hull, {hand="body", pile=hulld, coverage=2.4, fill=true, angle=0.02, pressure={0.85, 0.95}, edge=0.25, clip=true})
work(hull, {hand="detail", pile=hulld, coverage=1.4, fill=true, angle=0.02, edge=0.2, clip=true})

cabin = ribbon({{402, 893}, {446, 890}}, 15)
work(cabin, {hand="body", pile=hulld, coverage=1.6, fill=true, angle=0.02, edge=0.3, clip=true})

mb = brush{kind="rigger", width=3.5, point=1, stiffness=0.5}
mb:load(hulld, 0.95)
mast = outline{{421, 892}, {424, 820}, {427, 744}}
mast:paint(mb, {pressure=0.55, every=2})
nub = ellipse(425, 808, 5, 13)
work(nub, {hand="detail", pile=hulld, coverage=1.6, fill=true, edge=0.25, clip=true})
print("boat dark and crisp")

--@ chunk 80
-- Proper hull silhouette, no balloon
hulld = pile{{"bone black", 0.75}, {"raw umber", 0.7}, {"cobalt blue", 0.25}, {"lead white", 0.15}}
warmpale2 = pile{{"lead white", 2.4}, {"vermilion", 0.12}, {"chrome yellow", 0.1}}
watermid3 = pile{{"lead white", 1.0}, {"cobalt blue", 0.95}, {"raw umber", 0.45}, {"bone black", 0.35}, {"green earth", 0.28}, {"vermilion", 0.08}}

-- knock back the old lens and bump with water, then draw the hull poly
oldboat = rect(330, 878, 170, 56)
work(oldboat, {hand="body", pile=watermid3, coverage=2.4, fill=true, angle=0.02, pressure={0.75, 0.9}, edge=1, clip=true})
blend(oldboat, {coverage=0.7})

hullpoly = poly({{352, 898}, {395, 893}, {440, 889}, {478, 883}, {477, 916}, {432, 922}, {390, 924}, {354, 918}}, true)
work(hullpoly, {hand="body", pile=hulld, coverage=2.6, fill=true, angle=0.02, pressure={0.85, 0.95}, edge=0.2, clip=true})
work(hullpoly, {hand="detail", pile=hulld, coverage=1.5, fill=true, angle=0.02, edge=0.2, clip=true})

-- warm sheer line
sheer = below(function(x) return 897 - 0.032 * x end) * above(function(x) return 887 - 0.032 * x end)
       * mask(function(x) return x > 354 and x < 476 and 1 or 0 end)
stipple(sheer, {pile=warmpale2, width=2.2, coverage=0.3, pressure={0.2, 0.4}, drag={6, 0}, feather=1})

-- smaller knot on the mast
mb = brush{kind="rigger", width=3, point=1, stiffness=0.5}
mb:load(hulld, 0.95)
mb:stroke({{424, 800}, {425, 790}}, {pressure=0.6, ramps={0.2, 0.2}})

-- reflection dashes
stipple(rect(360, 934, 110, 76), {pile=hulld, width=4, coverage=0.3, pressure={0.25, 0.5}, drag={9, 0}, feather=1})
print("hull redrawn")

--@ chunk 81
-- Feather cream edge; mast knot off; left sliver; sparkles
skyfixp = pile{{"lead white", 2.6}, {"chrome yellow", 0.5}, {"vermilion", 0.22}, {"raw umber", 0.1}}
watermid3 = pile{{"lead white", 1.0}, {"cobalt blue", 0.95}, {"raw umber", 0.45}, {"bone black", 0.35}, {"green earth", 0.28}, {"vermilion", 0.08}}
deep3 = pile{{"lead white", 0.6}, {"cobalt blue", 1.0}, {"raw umber", 0.7}, {"bone black", 0.6}, {"green earth", 0.4}, {"vermilion", 0.08}}
hulld = pile{{"bone black", 0.75}, {"raw umber", 0.7}, {"cobalt blue", 0.25}, {"lead white", 0.15}}
bright = pile{{"lead white", 2.2}, {"chrome yellow", 0.5}, {"vermilion", 0.25}}

-- feather the cream cloud bank's right edge into the gold sky
fe = rect(868, 235, 90, 200):soften(30)
work(fe, {hand="scumble", pile=skyfixp, coverage=0.8, angle=0.02, edge=1})
work(rect(880, 250, 70, 170), {hand="scumble", pile=skyfixp, coverage=1.2, angle=0.02, edge=1})
blend(fe, {coverage=0.8})

-- mast knot off
knot = ellipse(424, 808, 10, 18)
work(knot, {hand="detail", pile=watermid3, coverage=2.2, fill=true, edge=0.3, clip=true})
mb = brush{kind="rigger", width=3.5, point=1, stiffness=0.5}
mb:load(hulld, 0.95)
mast = outline{{421, 892}, {424, 820}, {427, 744}}
mast:paint(mb, {pressure=0.55, every=2})

-- left sliver
work(rect(0, 516, 22, 630), {hand="body", pile=deep3, coverage=2.2, fill=true, angle=0.02, pressure={0.7, 0.9}, edge=1})
blend(rect(0, 516, 40, 630), {coverage=0.7})

-- sparkles down the path core
sparkz = ribbon({{640, 516}, {700, 640}, {660, 830}, {610, 1000}, {560, 1250}}, {26, 44, 70, 100, 130})
stipple(sparkz, {pile=bright, width=3.5, coverage=0.35, pressure={0.3, 0.6}, drag={7, 0}, feather=1})
print("final touches")

--@ chunk 82
-- Return the slab to the amber sky
goldsky = pile{{"lead white", 1.5}, {"chrome yellow", 0.7}, {"vermilion", 0.25}, {"raw umber", 0.3}, {"cobalt blue", 0.1}}
cloudtone = pile{{"lead white", 2.0}, {"chrome yellow", 0.3}, {"vermilion", 0.15}, {"raw umber", 0.2}}

z = rect(845, 218, 115, 230)
work(z, {hand="body", pile=goldsky, coverage=2.8, fill=true, angle=0.02, pressure={0.75, 0.9}, edge=0.5, clip=true})
blend(z, {coverage=0.8})

cz = rect(830, 240, 130, 180)
work(cz, {hand="scumble", pile=cloudtone, coverage=0.6, angle=0.02, edge=1})
print("slab to gold")

--@ chunk 83
-- One cream glow mass, soft edges, then leave it alone
skyfixp = pile{{"lead white", 2.6}, {"chrome yellow", 0.5}, {"vermilion", 0.22}, {"raw umber", 0.1}}
softcream = rect(838, 250, 145, 240):soften(24)
work(softcream, {hand="body", pile=skyfixp, coverage=2.4, fill=true, angle=0.02, pressure={0.7, 0.85}, edge=1, clip=true})
work(softcream, {hand="scumble", pile=skyfixp, coverage=1.0, angle=0.02, edge=1})
blend(softcream, {coverage=0.8})
print("glow unified")

--@ chunk 84
-- Haze the cream mass into the sky
cloudtone = pile{{"lead white", 2.0}, {"chrome yellow", 0.3}, {"vermilion", 0.15}, {"raw umber", 0.2}}
amber2 = pile{{"lead white", 1.0}, {"chrome yellow", 0.5}, {"vermilion", 0.25}, {"raw umber", 0.55}, {"cobalt blue", 0.1}}

topz = rect(460, 222, 540, 50):soften(18)
work(topz, {hand="scumble", pile=amber2, coverage=0.7, angle=0.02, edge=1})
blend(topz, {coverage=0.8})

leftz = rect(450, 255, 45, 215):soften(14)
work(leftz, {hand="scumble", pile=amber2, coverage=0.8, angle=0.02, edge=1})
blend(leftz, {coverage=0.8})

work(rect(455, 250, 80, 60), {hand="scumble", pile=amber2, coverage=0.9, angle=0.02, edge=1})
print("hazed")

--@ chunk 85
-- Amber sky above, tall dark headland below, burning rim between
amber2 = pile{{"lead white", 1.0}, {"chrome yellow", 0.5}, {"vermilion", 0.25}, {"raw umber", 0.55}, {"cobalt blue", 0.1}}
cloudtone = pile{{"lead white", 2.0}, {"chrome yellow", 0.3}, {"vermilion", 0.15}, {"raw umber", 0.2}}
treedark3 = pile{{"lead white", 0.3}, {"cobalt blue", 0.5}, {"green earth", 0.3}, {"raw umber", 0.65}, {"bone black", 0.75}}
bright = pile{{"lead white", 2.2}, {"chrome yellow", 0.5}, {"vermilion", 0.25}}

ambez = rect(450, 215, 550, 140)
work(ambez, {hand="body", pile=amber2, coverage=2.8, fill=true, angle=0.02, pressure={0.75, 0.9}, edge=1, clip=true})
blend(ambez, {coverage=0.8})
work(rect(460, 250, 530, 90), {hand="scumble", pile=cloudtone, coverage=0.5, angle=0.02, edge=1})

hz = function(x) return 512 + 4 * math.sin(x / 40) end
headz = below(function(x) return 348 + 12 * math.sin(x / 61 + 2) end) * above(hz) * rect(440, 330, 560, 220)
work(headz, {hand="body", pile=treedark3, coverage=3.0, fill=true, angle=0.02, pressure={0.8, 0.95}, edge=0.2, clip=true})
work(headz, {hand="scumble", pile=treedark3, coverage=1.6, angle=0.02, edge=0.25})

rimz = below(function(x) return 360 + 12 * math.sin(x / 61 + 2) end) * above(function(x) return 336 + 12 * math.sin(x / 61 + 2) end) * rect(450, 320, 550, 60)
stipple(rimz, {pile=bright, width=3, coverage=0.5, pressure={0.25, 0.55}, feather=1})
print("headland resolved")

--@ chunk 86
-- Marry the three hard boundaries
amber2 = pile{{"lead white", 1.0}, {"chrome yellow", 0.5}, {"vermilion", 0.25}, {"raw umber", 0.55}, {"cobalt blue", 0.1}}
cloudtone = pile{{"lead white", 2.0}, {"chrome yellow", 0.3}, {"vermilion", 0.15}, {"raw umber", 0.2}}
treedark3 = pile{{"lead white", 0.3}, {"cobalt blue", 0.5}, {"green earth", 0.3}, {"raw umber", 0.65}, {"bone black", 0.75}}
skymid2 = pile{{"lead white", 1.3}, {"cobalt blue", 0.8}, {"raw umber", 0.35}, {"vermilion", 0.2}}
hz = function(x) return 512 + 4 * math.sin(x / 40) end

ambLz = rect(420, 218, 70, 135):soften(16)
work(ambLz, {hand="scumble", pile=cloudtone, coverage=0.9, angle=0.02, edge=1})
work(ambLz, {hand="scumble", pile=amber2, coverage=0.7, angle=0.02, edge=1})
blend(ambLz, {coverage=0.9})

topz2 = rect(450, 193, 550, 46):soften(14)
work(topz2, {hand="scumble", pile=skymid2, coverage=0.6, angle=0.02, edge=1})
blend(topz2, {coverage=0.9})

headl = below(function(x) return 448 + 18 * math.sin(x / 31 + 2) + 10 * math.sin(x / 67) end)
       * above(hz) * rect(300, 330, 190, 220)
work(headl, {hand="body", pile=treedark3, coverage=2.2, fill=true, angle=0.02, pressure={0.75, 0.9}, edge=0.4, clip=true})

tope = below(function(x) return 358 + 12 * math.sin(x / 61 + 2) end) * above(function(x) return 340 + 12 * math.sin(x / 61 + 2) end) * rect(440, 330, 560, 40)
stipple(tope, {pile=treedark3, width=4, coverage=0.9, pressure={0.3, 0.6}, feather=1})
print("married")

--@ chunk 87
-- Final sky: one smooth dusk gradient over everything above the headland
skA = pile{{"lead white", 1}, {"cobalt blue", 1.1}, {"raw umber", 0.5}, {"vermilion", 0.25}}
skB = pile{{"lead white", 1.4}, {"cobalt blue", 0.8}, {"raw umber", 0.4}, {"vermilion", 0.22}}
skC = pile{{"lead white", 1.3}, {"chrome yellow", 0.55}, {"vermilion", 0.22}, {"raw umber", 0.45}}
skD = pile{{"lead white", 2.2}, {"chrome yellow", 0.42}, {"vermilion", 0.2}, {"raw umber", 0.25}}
hz = function(x) return 512 + 4 * math.sin(x / 40) end

b1 = below(function(x) return 165 + 10 * math.sin(x / 80) end)
work(b1, {hand="broad", pile=skA, coverage=2.6, fill=true, angle=0.03, pressure={0.7, 0.9}, edge=1})
blend(b1, {coverage=0.8})

b2 = below(function(x) return 285 + 10 * math.sin(x / 75) end) * above(function(x) return 125 + 10 * math.sin(x / 80) end)
work(b2, {hand="broad", pile=skB, coverage=2.4, fill=true, angle=0.03, pressure={0.7, 0.9}, edge=1})
blend(b2, {coverage=0.8})

b3 = below(function(x) return 365 + 10 * math.sin(x / 70) end) * above(function(x) return 245 + 10 * math.sin(x / 75) end)
work(b3, {hand="broad", pile=skC, coverage=2.4, fill=true, angle=0.03, pressure={0.7, 0.9}, edge=1})
blend(b3, {coverage=0.8})

b4 = below(function(x) return 352 + 8 * math.sin(x / 70) end) * above(function(x) return 300 + 8 * math.sin(x / 70) end)
work(b4, {hand="broad", pile=skD, coverage=2.2, fill=true, angle=0.03, pressure={0.7, 0.9}, edge=1})
blend(b4, {coverage=0.8})

b5 = mask(function(x, y)
  if y > 444 or y < 352 then return 0 end
  if x > 440 and y > 348 then return 0 end
  return 1
end)
work(b5, {hand="broad", pile=skD, coverage=2.2, fill=true, angle=0.03, pressure={0.7, 0.9}, edge=1})
blend(b5, {coverage=0.8})

bigblend = above(function(x) return 345 end)
blend(bigblend, {coverage=1.0})
print("final sky laid")

--@ chunk 88
-- Re-establish treeline and headland over the veil
treedark3 = pile{{"lead white", 0.3}, {"cobalt blue", 0.5}, {"green earth", 0.3}, {"raw umber", 0.65}, {"bone black", 0.75}}
hz = function(x) return 512 + 4 * math.sin(x / 40) end

tlband = below(function(x) return 452 + 20 * math.sin(x / 31 + 2) + 12 * math.sin(x / 67) + 8 * math.sin(x / 13) end) * above(hz)
work(tlband, {hand="body", pile=treedark3, coverage=2.8, fill=true, angle=0.02, pressure={0.8, 0.95}, edge=0.35, clip=true})
work(tlband, {hand="scumble", pile=treedark3, coverage=1.6, angle=0.02, edge=0.4})

headz = below(function(x) return 356 + 14 * math.sin(x / 61 + 2) end) * above(hz) * rect(440, 330, 560, 220)
work(headz, {hand="body", pile=treedark3, coverage=2.8, fill=true, angle=0.02, pressure={0.8, 0.95}, edge=0.2, clip=true})
work(headz, {hand="scumble", pile=treedark3, coverage=1.4, angle=0.02, edge=0.25})

tope = below(function(x) return 362 + 14 * math.sin(x / 61 + 2) end) * above(function(x) return 344 + 14 * math.sin(x / 61 + 2) end) * rect(440, 330, 560, 40)
stipple(tope, {pile=treedark3, width=4, coverage=1.0, pressure={0.3, 0.6}, feather=1})
print("treeline and headland back")

--@ chunk 89
-- Bank, path, boat over the veil
spitdark  = pile{{"raw umber", 1}, {"bone black", 0.5}, {"green earth", 0.35}, {"cobalt blue", 0.2}, {"lead white", 0.25}}
bright = pile{{"lead white", 2.2}, {"chrome yellow", 0.5}, {"vermilion", 0.25}}
flare  = pile{{"lead white", 1.6}, {"chrome yellow", 0.35}, {"vermilion", 0.2}, {"cobalt blue", 0.12}}
hulld = pile{{"bone black", 0.75}, {"raw umber", 0.7}, {"cobalt blue", 0.25}, {"lead white", 0.15}}

spit_edge = function(x) return 1150 + 26 * math.sin(x / 90 + 1) + 14 * math.sin(x / 38 + 2) - 0.28 * x end
bank = below(spit_edge)
work(bank, {hand="body", pile=spitdark, coverage=2.4, fill=true, angle=0.05, pressure={0.75, 0.9}, edge=0.5, clip=true})
work(bank, {hand="scumble", pile=spitdark, coverage=1.2, angle=0.05, edge=0.6})

lowpath = ribbon({{640, 516}, {700, 640}, {660, 830}, {610, 1000}, {560, 1250}}, {30, 60, 110, 180, 230})
work(lowpath, {hand="body", pile=bright, coverage=1.6, fill=true, angle=0.02, pressure={0.6, 0.8}, edge=1})
wide2 = ribbon({{640, 516}, {705, 650}, {665, 850}, {605, 1040}, {565, 1250}}, {70, 130, 220, 300, 360})
work(wide2, {hand="broad", pile=flare, coverage=0.7, fill=false, angle=0.02, pressure={0.5, 0.7}, edge=1})

hull = poly({{352, 898}, {395, 893}, {440, 889}, {478, 883}, {477, 916}, {432, 922}, {390, 924}, {354, 918}}, true)
work(hull, {hand="body", pile=hulld, coverage=2.6, fill=true, angle=0.02, pressure={0.85, 0.95}, edge=0.2, clip=true})
work(hull, {hand="detail", pile=hulld, coverage=1.4, fill=true, angle=0.02, edge=0.2, clip=true})
mb = brush{kind="rigger", width=3.5, point=1, stiffness=0.5}
mb:load(hulld, 0.95)
mast = outline{{421, 892}, {424, 820}, {427, 744}}
mast:paint(mb, {pressure=0.55, every=2})
stipple(rect(360, 934, 110, 76), {pile=hulld, width=4, coverage=0.3, pressure={0.25, 0.5}, drag={9, 0}, feather=1})
print("bank, path, boat re-stated")

--@ chunk 90
-- Path dies into the bank; gold band veil; sparkles
spitdark  = pile{{"raw umber", 1}, {"bone black", 0.5}, {"green earth", 0.35}, {"cobalt blue", 0.2}, {"lead white", 0.25}}
amber2 = pile{{"lead white", 1.0}, {"chrome yellow", 0.5}, {"vermilion", 0.25}, {"raw umber", 0.55}, {"cobalt blue", 0.1}}
cloudtone = pile{{"lead white", 2.0}, {"chrome yellow", 0.3}, {"vermilion", 0.15}, {"raw umber", 0.2}}
bright = pile{{"lead white", 2.2}, {"chrome yellow", 0.5}, {"vermilion", 0.25}}

spit_edge = function(x) return 1150 + 26 * math.sin(x / 90 + 1) + 14 * math.sin(x / 38 + 2) - 0.28 * x end
bank = below(spit_edge)
lowpath = ribbon({{640, 516}, {700, 640}, {660, 830}, {610, 1000}, {560, 1250}}, {30, 60, 110, 180, 230})
wide2 = ribbon({{640, 516}, {705, 650}, {665, 850}, {605, 1040}, {565, 1250}}, {70, 130, 220, 300, 360})
work(bank * (lowpath + wide2), {hand="body", pile=spitdark, coverage=2.4, fill=true, angle=0.05, pressure={0.75, 0.9}, edge=0.4, clip=true})

goldz = rect(300, 150, 700, 120)
work(goldz, {hand="scumble", pile=amber2, coverage=1.1, angle=0.02, edge=1})
work(goldz, {hand="scumble", pile=cloudtone, coverage=0.4, angle=0.02, edge=1})
blend(goldz, {coverage=0.8})

sparkz = ribbon({{640, 516}, {700, 640}, {660, 830}, {610, 1000}}, {26, 50, 100, 170})
stipple(sparkz, {pile=bright, width=3.5, coverage=0.4, pressure={0.3, 0.6}, drag={7, 0}, feather=1})
print("path dies into bank, gold veiled")

--@ chunk 91
-- Blend the gold band's edges out into the mist
softm = rect(270, 95, 730, 200):soften(36)
blend(softm, {coverage=1.2})
blend(softm, {coverage=1.0})
print("gold blended out")

--@ chunk 92
-- Last small things
watermid3 = pile{{"lead white", 1.0}, {"cobalt blue", 0.95}, {"raw umber", 0.45}, {"bone black", 0.35}, {"green earth", 0.28}, {"vermilion", 0.08}}
hulld = pile{{"bone black", 0.75}, {"raw umber", 0.7}, {"cobalt blue", 0.25}, {"lead white", 0.15}}
warmpale2 = pile{{"lead white", 2.4}, {"vermilion", 0.12}, {"chrome yellow", 0.1}}

knotz = ellipse(424, 806, 8, 15)
work(knotz, {hand="detail", pile=watermid3, coverage=2.4, fill=true, edge=0.3, clip=true})
mb = brush{kind="rigger", width=3, point=1, stiffness=0.5}
mb:load(hulld, 0.95)
mast = outline{{421, 890}, {424, 822}, {427, 746}}
mast:paint(mb, {pressure=0.5, every=2})

hull = poly({{352, 898}, {395, 893}, {440, 889}, {478, 883}, {477, 916}, {432, 922}, {390, 924}, {354, 918}}, true)
sheer = hull * mask(function(x, y) return y < 906 and 1 or 0 end)
stipple(sheer, {pile=warmpale2, width=2.2, coverage=0.25, pressure={0.2, 0.4}, drag={6, 0}, feather=1})

blend(rect(270, 175, 260, 60), {coverage=1.0})
print("last touches")

--@ chunk 93
-- A few reeds against the light at the bank edge
grassdark = pile{{"bone black", 0.35}, {"raw umber", 0.55}, {"green earth", 0.45}, {"cobalt blue", 0.15}, {"lead white", 0.15}}
g = brush{kind="round", width=9, point=1, stiffness=0.5}
spit_edge = function(x) return 1150 + 26 * math.sin(x / 90 + 1) + 14 * math.sin(x / 38 + 2) - 0.28 * x end
xs = uneven(7, 430, 900, 0.7, 0.4, 21)
for _, x in ipairs(xs) do
  if g:fullness() < 0.3 then g:wipe(0.5); g:load(grassdark, 0.95) end
  local hgt = rand(26, 52)
  if x > 560 and x < 760 then hgt = rand(38, 64) end
  local lean = rand(-12, 24)
  local base = spit_edge(x) + 5
  g:stroke({{x, base}, {x + lean * 0.4, base - hgt * 0.55}, {x + lean, base - hgt}},
    {pressure={0.85, 0.05}, ramps={0.08, 0.55}})
end
print("reeds struck")
