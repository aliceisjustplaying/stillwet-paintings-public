-- easel session "painting": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box every
--@ engine 5

--@ chunk 1
canvas{size=600, aspect=4/3, linen={24,22}, seed=5, ground={{pile={{"lead white",3},{"yellow ochre",1},{"raw umber",0.4}}, um=40, apply="knife", texture=0.1}}}
print("W="..W.." H="..H)

--@ chunk 2
-- The sky: deep zenith blue, mid blue, warm horizon
z1 = pile{{"ultramarine blue", 1}, {"cerulean blue", 1}, {"lead white", 1.2}}
z2 = pile{{"cerulean blue", 1}, {"lead white", 1.5}, {"permanent alizarin", 0.15}}
z3 = pile{{"cadmium yellow", 1}, {"lead white", 2}}
z4 = pile{{"deep cadmium", 1}, {"lead white", 1}}
print(z1) print(z2) print(z3) print(z4)

--@ chunk 3
zen = pile{{"ultramarine blue", 1}, {"cerulean blue", 1}, {"lead white", 1.0}, turps=0.5}
blu2 = pile{{"cerulean blue", 1}, {"lead white", 1.3}, {"permanent alizarin", 0.3}, turps=0.5}
lil = pile{{"rose madder", 1}, {"ultramarine blue", 0.4}, {"lead white", 1.6}, turps=0.5}
pch = pile{{"pale cadmium", 1}, {"rose madder", 0.4}, {"lead white", 1.5}, turps=0.5}
gold = pile{{"cadmium yellow", 1}, {"lead white", 1.5}, turps=0.5}
sky = rect(0, 0, 1000, 425)
work(sky, {hand="broad", coverage=1.5, fill=true, piles={
  {zen, function(x,y) return clamp((120 - y)/120, 0, 1) end},
  {blu2, function(x,y) return clamp(1 - math.abs(y-110)/110, 0, 1) end},
  {lil, function(x,y) return clamp(1 - math.abs(y-220)/110, 0, 1) end},
  {pch, function(x,y) return clamp(1 - math.abs(y-330)/100, 0, 1) end},
  {gold, function(x,y) return clamp((y-360)/90, 0, 1) end}}})
cA = poly({{330,330},{380,316},{450,322},{520,310},{600,318},{612,340},{560,346},{480,342},{400,352},{340,350}}, true)
cB = poly({{560,312},{640,292},{720,286},{800,298},{880,292},{960,320},{958,336},{880,330},{800,338},{720,330},{650,344},{600,336}}, true)
cC = poly({{760,352},{820,344},{880,350},{920,358},{860,366},{800,364}}, true)
cl1 = pile{{"ultramarine blue", 0.6}, {"permanent alizarin", 0.5}, {"lead white", 0.8}, turps=0.4}
cl2 = pile{{"rose madder", 0.8}, {"lead white", 1.2}, {"pale cadmium", 0.3}, turps=0.4}
work(cA + cB + cC, {hand="broad", pile=cl1, coverage=0.9, fill=true, edge="soft"})
work(cA + cB, {hand="broad", pile=cl2, coverage=0.5, fill=true, edge="soft"})
halo_p = pile{{"pale cadmium", 1}, {"lead white", 0.8}, {"deep cadmium", 0.3}, {"rose madder", 0.1}, turps=0.5}
core_p = pile{{"pale cadmium", 1}, {"lead white", 1.8}, turps=0.3}
halo = ellipse(646, 404, 110, 40)
work(halo, {hand="broad", pile=halo_p, coverage=0.8, fill=true, edge="lost"})
blend(halo, {})
core = ellipse(646, 402, 20, 15)
work(core, {hand="body", pile=core_p, coverage=1.2, fill=true, edge="soft"})
print("day one sky, cloud and sun laid")

--@ chunk 4
wait(1440)
print(drying(500,100), drying(500,300), drying(500,400), drying(646,404))

--@ chunk 5
hz = pile{{"permanent alizarin", 0.6}, {"ultramarine blue", 0.5}, {"lead white", 1.0}, turps=0.3}
seaT = pile{{"ultramarine blue", 0.7}, {"Prussian blue", 0.2}, {"permanent alizarin", 0.3}, {"lead white", 0.3}, turps=0.2}
sandA = pile{{"rose madder", 0.4}, {"yellow ochre", 0.5}, {"ultramarine blue", 0.2}, {"lead white", 1.0}, turps=0.3}
sandB = pile{{"burnt sienna", 0.5}, {"ultramarine blue", 0.5}, {"permanent alizarin", 0.3}, {"lead white", 0.6}, turps=0.3}
sandC = pile{{"burnt sienna", 0.8}, {"raw umber", 0.3}, {"bone black", 0.2}, {"lead white", 0.3}, turps=0.2}
hzR = rect(0, 418, 1000, 10)
work(hzR, {hand="body", pile=hz, coverage=1.2, fill=true, edge="soft"})
seaR = rect(0, 428, 1000, 21)
work(seaR, {hand="body", pile=seaT, coverage=1.5, fill=true, edge="soft"})
sandR = rect(0, 447, 1000, 303)
work(sandR, {hand="broad", coverage=1.3, fill=true, piles={
  {sandA, function(x,y) return clamp(1 - (y-450)/90, 0, 1) end},
  {sandB, function(x,y) return clamp(1 - math.abs(y-560)/110, 0, 1) end},
  {sandC, function(x,y) return clamp((y-580)/120, 0, 1) end}}})
print("horizon, sea and sand base laid")

--@ chunk 6
print("headland", drying(120,380), drying(200,350), "horizon", drying(500,420), "sun", drying(646,402), "sky-top", drying(300,60), "sand", drying(500,600), drying(600,520))

--@ chunk 7
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
  b:load(math.random() < 0.6 and glA or glB, 0.3 + 0.3 * math.random())
  for j = 1, cnt do
    local cx = 646 + (math.random() - 0.5) * 6 * t
    local x0 = cx - hw + math.random() * 2 * hw
    local len = (4 + math.random() * (6 + 22 * t)) * (0.8 + 0.4 * t)
    if math.random() < 0.7 then
      b:stroke({{x0, y}, {x0 + len, y + (math.random() - 0.5) * 0.8}}, {pressure = 0.2 + 0.18 * math.random()})
      n = n + 1
    end
  end
  y = y + gap
end
print("glitter dashes", n)

--@ chunk 8
print("hl top", drying(150,330), "hl mid", drying(150,380), "hl base", drying(220,412), "ridge", drying(400,400), "horizon", drying(500,418), "sea", drying(500,432), "sand", drying(300,500), drying(500,560), drying(800,620))

--@ chunk 9
hdA = pile{{"ultramarine blue", 1}, {"burnt sienna", 0.7}, {"bone black", 0.4}, {"permanent alizarin", 0.3}, {"lead white", 0.15}, name="hdA"}
hdB = pile{{"Prussian blue", 0.6}, {"burnt sienna", 0.6}, {"ultramarine blue", 0.4}, {"lead white", 0.2}, name="hdB"}
ridgeC = pile{{"ultramarine blue", 0.7}, {"cerulean blue", 0.6}, {"permanent alizarin", 0.5}, {"lead white", 1.2}, name="ridgeC"}
rimW = pile{{"deep cadmium", 0.8}, {"rose madder", 0.3}, {"lead white", 1.3}, name="rimW"}
seaDk = pile{{"ultramarine blue", 1}, {"permanent alizarin", 0.5}, {"burnt sienna", 0.3}, {"lead white", 0.4}, name="seaDk"}
seaGl = pile{{"cadmium yellow", 0.6}, {"rose madder", 0.4}, {"lead white", 1.5}, name="seaGl"}
print(hdA) print(hdB) print(ridgeC) print(rimW) print(seaDk) print(seaGl)

--@ chunk 10
print(table.concat(palette_lines or {}, "\n"))
local L = palette()
print(L)

--@ chunk 11
-- distant ridge: lighter, bluer, further off
ridgeM = poly({{300,421},{338,409},{372,399},{404,394},{430,400},{462,410},{500,418},{500,423},{300,423}}, true)
work(ridgeM, {hand="body", pile=ridgeC, coverage=1.3, fill=true, clip=true})
-- main headland, left: a dark mass rising from the sea line to a peak
headL = poly({{0,372},{22,356},{54,344},{88,333},{118,326},{140,322},{160,326},{186,338},{214,352},{246,370},{280,388},{312,402},{336,412},{352,421},{0,423}}, true)
HEADL = headL
work(headL, {hand="body", pile=hdA, coverage=1.6, fill=true, clip=true})
print("ridge and headland laid")

--@ chunk 12
work(HEADL, {hand="body", pile=hdA, coverage=1.0, fill=true, clip=true, load=1.0})
print("second coat laid")

--@ chunk 13
-- hotter sun: a warm bloom over the horizon, then a brighter core
bloomP = pile{{"deep cadmium", 0.7}, {"pale cadmium", 0.7}, {"lead white", 0.5}, {"rose madder", 0.1}, turps=0.3}
bloom = ellipse(646, 412, 84, 22)
work(bloom, {hand="broad", pile=bloomP, coverage=0.8, fill=true, edge="lost"})
coreP = pile{{"pale cadmium", 1}, {"lead white", 0.9}, turps=0.1}
core = ellipse(646, 404, 17, 13)
work(core, {hand="body", pile=coreP, coverage=1.6, fill=true, edge="soft"})
print("sun reworked")

--@ chunk 14
-- schooner silhouette on the glow, right of the sun (backlit, so dark)
silP = pile{{"Prussian blue", 0.6}, {"burnt sienna", 0.6}, {"ultramarine blue", 0.4}, {"lead white", 0.1}, name="silP"}
hull = poly({{784,410},{836,410},{829,418},{791,418}}, true)
sailM = poly({{813,372},{813,406},{793,406}}, true)
sailJ = poly({{809,380},{809,405},{827,405}}, true)
work(hull, {hand="detail", pile=silP, coverage=2.0, fill=true, clip=true})
work(sailM, {hand="detail", pile=silP, coverage=2.0, fill=true, clip=true})
work(sailJ, {hand="detail", pile=silP, coverage=2.0, fill=true, clip=true})
mast = brush{kind="round", width=2, point=0}
mast:load(silP, 1.0)
mast:stroke({{812,372},{812,412}}, {pressure=0.6})
print("boat laid")

--@ chunk 15
rimW2 = pile{{"deep cadmium", 0.6}, {"rose madder", 0.3}, {"lead white", 1.1}, turps=0.2, name="rimW2"}
rb = brush{kind="round", width=3, point=1}
rb:load(rimW2, 0.7)
rb:stroke({{238,356},{270,374},{300,392},{332,408},{350,418}}, {pressure={0.25, 0.45, 0.2}})
print("rim laid")

--@ chunk 16
print(drying(290,380), drying(262,366), drying(320,398))

--@ chunk 17
strayRib = ribbon({{238,356},{270,374},{300,392},{332,408},{350,418}}, 9)
coverM = strayRib * rect(0, 0, 1000, 419) - HEADL
skyG = pile{{"cadmium yellow", 1}, {"lead white", 1.5}, turps=0.5, name="skyG"}
work(coverM, {hand="body", pile=skyG, coverage=1.2, fill=true, clip=true})
print("stray rim covered")

--@ chunk 18
print(drying(290,380), drying(262,366))
blendM = ribbon({{226,344},{262,366},{300,388},{336,406},{362,420}}, 22) * rect(0,0,1000,419) - HEADL
blend(blendM, {angle=0.5})
blend(blendM, {angle=0.5})
print("blended")

--@ chunk 19
print(drying(250,358), drying(280,378), drying(300,390), drying(330,404), drying(355,416))

--@ chunk 20
rg = rag()
rg:dip(0.4)
rg:wipe({{222,339},{250,355},{282,373},{314,389},{340,402},{356,409}}, {pressure=0.5})
print("rag: load", rg.load, "damp", rg.damp)

--@ chunk 21
patchM = poly({{196,334},{250,324},{320,334},{380,352},{380,420},{300,404},{236,372},{196,350}}, true) * rect(0,0,1000,419) - HEADL
skyLow = pile{{"pale cadmium", 1}, {"lead white", 1.5}, {"rose madder", 0.1}, turps=0.5, name="skyLow"}
skyUp = pile{{"pale cadmium", 0.5}, {"rose madder", 0.4}, {"lead white", 1.5}, {"ultramarine blue", 0.05}, turps=0.5, name="skyUp"}
work(patchM, {hand="broad", coverage=1.4, fill=true, clip=true, piles={
  {skyLow, function(x,y) return clamp((y-336)/50, 0, 1) end},
  {skyUp, function(x,y) return clamp((350-y)/30, 0, 1) end}}})
print("patch re-laid")

--@ chunk 22
print(drying(300,360), drying(250,345), drying(360,380))
rimM = patchM:rim(16, 8) - HEADL
blend(rimM * rect(0,0,1000,419), {angle=0.3})
blend(rimM * rect(0,0,1000,419), {angle=1.2})
print("rim blended")

--@ chunk 23
seaGl2 = pile{{"cadmium yellow", 0.6}, {"rose madder", 0.3}, {"lead white", 1.6}, turps=0.2, name="seaGl2"}
seaCool = pile{{"cerulean blue", 1}, {"ultramarine blue", 0.4}, {"lead white", 1.2}, turps=0.2, name="seaCool"}
b = brush("flat", 5)
n = 0
for i = 1, 70 do
  local x = 470 + math.random() * 360
  local y = 434 + math.random() * 34
  local d = math.abs(x - 646) / 180
  local keep = 1 - 0.6 * clamp((y - 434) / 34, 0, 1)
  if math.random() < 0.55 * (1 - d * 0.7) then
    local p = (math.random() < 0.7) and seaGl2 or seaCool
    b:load(p, 0.3 + 0.3 * math.random())
    local len = 10 + math.random() * 26 * (1 - d * 0.4)
    b:stroke({{x, y}, {x + len, y + (math.random() - 0.5) * 1.2}}, {pressure = 0.15 + 0.2 * math.random()})
    n = n + 1
  end
end
print("sea streaks", n)

--@ chunk 24
glintZone = poly({{470,432},{830,432},{830,470},{470,470}}, true) * rect(0, 430, 1000, 40)
blend(glintZone, {angle=0.1})
print("glint zone softened")

--@ chunk 25
print(drying(560,445), drying(700,450), drying(520,438), drying(300,450), drying(600,520))

--@ chunk 26
seaPink = pile{{"rose madder", 0.6}, {"ultramarine blue", 0.3}, {"lead white", 1.2}, turps=0.4, name="seaPink"}
seaPink2 = pile{{"rose madder", 0.5}, {"ultramarine blue", 0.5}, {"lead white", 0.9}, turps=0.4, name="seaPink2"}
band = rect(0, 430, 1000, 40)
work(band, {hand="broad", coverage=1.2, fill=true, edge="soft", piles={
  {seaPink, function(x,y) return clamp((y-430)/25, 0, 1) end},
  {seaPink2, function(x,y) return clamp(1 - (y-430)/25, 0, 1) end}}})
print("sea band repainted")

--@ chunk 27
wait(900)
print(drying(560,445), drying(300,450), drying(600,520), drying(150,330), drying(646,404), drying(500,100))

--@ chunk 28
wait(600)
print(drying(560,445), drying(300,450), drying(600,520), drying(150,330), drying(646,404), drying(500,100), drying(200,380))

--@ chunk 29
print(drying(560,445), drying(300,450), drying(600,520), drying(150,330), drying(646,404), drying(500,100), drying(200,380), drying(700,470))

--@ chunk 30
wait(720)
print(drying(560,445), drying(300,450), drying(600,520), drying(150,330), drying(646,404), drying(500,100), drying(200,380), drying(700,470))

--@ chunk 31
wait(360)
print("hl", drying(60,370), drying(150,330), drying(230,380), drying(300,405), "sun", drying(646,404), drying(646,412), "sea", drying(560,445), drying(300,450), "sand", drying(600,520), drying(700,470), drying(300,600))

--@ chunk 32
-- the column of light under the sun (widens toward the viewer); kept clear of the dark
colP = poly({{628,452},{664,452},{770,750},{500,750}}, true)
COLP = colP
darkSandM = rect(0, 452, 1000, 298) - colP
dkA = pile{{"rose madder", 0.4}, {"ultramarine blue", 0.5}, {"burnt sienna", 0.3}, {"lead white", 0.5}, turps=0.2, name="dkA"}
dkB = pile{{"ultramarine blue", 0.6}, {"burnt sienna", 0.7}, {"permanent alizarin", 0.4}, {"bone black", 0.1}, {"lead white", 0.15}, turps=0.15, name="dkB"}
dkC = pile{{"burnt sienna", 0.8}, {"ultramarine blue", 0.6}, {"bone black", 0.3}, {"permanent alizarin", 0.2}, turps=0.1, name="dkC"}
work(darkSandM, {hand="broad", coverage=1.2, fill=true, clip=true, angle=0.03, piles={
  {dkA, function(x,y) return clamp(1 - (y-455)/50, 0, 1) end},
  {dkB, function(x,y) return clamp(1 - math.abs(y-560)/120, 0, 1) end},
  {dkC, function(x,y) return clamp((y-580)/140, 0, 1) end}}})
print("dark foreground laid")

--@ chunk 33
print("patch", drying(255,345), drying(230,330), drying(285,342), "sun", drying(646,404), drying(646,396), drying(640,412), "col", drying(646,520), drying(700,600), "headland", drying(120,340), drying(60,370), "cloud", drying(640,250))

--@ chunk 34
bankM = poly({{186,384},{236,350},{300,334},{360,336},{404,352},{430,376},{420,402},{340,410},{260,408},{200,400}}, true) - HEADL
bankM = bankM * rect(0, 0, 1000, 419)
BANKM = bankM
bkRose = pile{{"deep cadmium", 0.4}, {"rose madder", 0.7}, {"lead white", 1.0}, {"permanent alizarin", 0.15}, turps=0.3, name="bkRose"}
bkViol = pile{{"ultramarine blue", 0.3}, {"permanent alizarin", 0.5}, {"rose madder", 0.6}, {"lead white", 0.7}, turps=0.3, name="bkViol"}
bkPeach = pile{{"pale cadmium", 0.6}, {"rose madder", 0.2}, {"lead white", 1.4}, turps=0.3, name="bkPeach"}
work(bankM, {hand="broad", coverage=1.3, fill=true, clip=true, edge="soft", piles={
  {bkViol, function(x,y) return clamp((370-y)/40, 0, 1) end},
  {bkRose, function(x,y) return clamp(1 - math.abs(y-372)/38, 0, 1) end},
  {bkPeach, function(x,y) return clamp((y-372)/36, 0, 1) end}}})
print("bank laid")

--@ chunk 35
oldPatch = poly({{180,350},{200,326},{250,318},{300,322},{350,332},{420,350},{440,380},{430,410},{300,412},{220,406},{180,380}}, true)
coverM = oldPatch * rect(0, 0, 1000, 419) - HEADL - BANKM
skyYP = pile{{"cadmium yellow", 0.6}, {"pale cadmium", 0.4}, {"rose madder", 0.2}, {"lead white", 1.1}, turps=0.4, name="skyYP"}
horPeach = pile{{"deep cadmium", 0.7}, {"rose madder", 0.3}, {"lead white", 1.0}, turps=0.3, name="horPeach"}
work(coverM, {hand="broad", coverage=1.3, fill=true, clip=true, edge="soft", piles={
  {skyYP, function(x,y) return clamp((400-y)/60, 0, 1) end},
  {horPeach, function(x,y) return clamp((y-360)/50, 0, 1) end}}})
print("remnants covered")

--@ chunk 36
print(drying(230,340), drying(330,370), drying(360,392))
dust = pile{{"pale cadmium", 0.3}, {"rose madder", 0.35}, {"lead white", 1.6}, turps=0.5, name="dust"}
dustM = coverM * rect(0,0,1000,419)
work(dustM, {hand="broad", pile=dust, coverage=0.6, fill=true, clip=true, edge="lost"})
print("dusted")

--@ chunk 37
seamM = (coverM:rim(14, 8)) * rect(0,0,1000,419) - HEADL - BANKM
blend(seamM, {angle=0.6})
print("seams softened")

--@ chunk 38
print("sun", drying(646,404), drying(646,396), drying(660,410), "col", drying(646,470), drying(650,520), drying(700,620), "fg", drying(300,600), drying(120,680), "headland", drying(120,340), drying(60,370), drying(200,395))

--@ chunk 39
wait(120)
print("sun", drying(646,404), drying(646,396), "col", drying(646,470), drying(650,520), "fg", drying(300,600), drying(120,680), "headland", drying(120,340), drying(60,370), drying(200,395), "bank", drying(260,380))

--@ chunk 40
wait(240)
print("sun", drying(646,404), drying(646,396), "col", drying(646,470), drying(650,520), "fg", drying(300,600), drying(120,680), "headland", drying(120,340), drying(60,370), drying(200,395), "bank", drying(260,380))

--@ chunk 41
wait(720)
print("sun", drying(646,404), drying(646,396), "col", drying(646,470), drying(650,520), "fg", drying(300,600), drying(120,680), "headland", drying(120,340), drying(60,370), drying(200,395), "bank", drying(260,380))

--@ chunk 42
wait(600)
print("sun", drying(646,404), drying(646,396), "col", drying(646,470), drying(650,520), "fg", drying(300,600), drying(120,680), "headland", drying(120,340), drying(60,370), drying(200,395), "bank", drying(260,380))

--@ chunk 43
aboveH = rect(0, 0, 1000, 419)
sunGlowM = ellipse(646, 414, 120, 36) * aboveH
sunCoreM = ellipse(646, 406, 26, 19) * aboveH
sunHotM = ellipse(645, 404, 11, 9) * aboveH
glowP = pile{{"deep cadmium", 0.6}, {"rose madder", 0.25}, {"lead white", 0.5}, turps=0.5, name="glowP"}
coreP = pile{{"cadmium yellow", 1}, {"lead white", 0.9}, name="coreP"}
hotP = pile{{"pale cadmium", 1}, {"lead white", 1.6}, name="hotP"}
work(sunGlowM, {hand="broad", pile=glowP, coverage=0.6, fill=true, edge="lost"})
work(sunCoreM, {hand="body", pile=coreP, coverage=1.4, fill=true, edge="soft"})
work(sunHotM, {hand="body", pile=hotP, coverage=1.6, fill=true, edge="soft"})
print("sun reworked again")

--@ chunk 44
print("fg near", drying(200,460), drying(640,470), "mid", drying(200,560), drying(600,560), "far", drying(200,680), drying(640,700), "col", drying(646,500), drying(650,600))

--@ chunk 45
print("fg", drying(200,470), drying(120,520), drying(300,600), drying(150,700), drying(420,700), "col", drying(646,500), drying(640,640), "sea", drying(200,435), drying(600,440), "hl", drying(120,340), drying(230,380), "sun", drying(646,404))

--@ chunk 46
print("upper sky", drying(200,80), drying(600,120), drying(850,200), "cloud", drying(640,240), drying(700,300), "bank", drying(260,380), "schooner", drying(812,392), "headland", drying(120,340), drying(230,380), "sun", drying(646,404), "sea", drying(560,440), "fg", drying(300,500), drying(300,600), drying(640,650))

--@ chunk 47
wait(720)
print("sun", drying(646,404), "headland", drying(120,340), drying(230,380), "schooner", drying(812,392), "bank", drying(260,380), "col", drying(646,500), drying(650,600), "fg", drying(300,500), drying(300,600), drying(640,650), "sea", drying(560,440))

--@ chunk 48
wait(1440)
print("sun", drying(646,404), "headland", drying(120,340), drying(230,380), "schooner", drying(812,392), "bank", drying(260,380), "col", drying(646,500), drying(650,600), "fg", drying(300,500), drying(300,600), drying(640,650), "sea", drying(560,440))

--@ chunk 49
rL = pile{{"rose madder", 0.5}, {"ultramarine blue", 0.3}, {"lead white", 1.3}, turps=0.2, name="rL"}
rP = pile{{"pale cadmium", 0.6}, {"rose madder", 0.3}, {"lead white", 1.2}, turps=0.2, name="rP"}
rC = pile{{"cerulean blue", 0.8}, {"lead white", 1.2}, {"permanent alizarin", 0.1}, turps=0.2, name="rC"}
b = brush("flat", 8)
n = 0
local pals = {rL, rP, rC}
for i = 1, 150 do
  local x = math.random() * 1000
  local y = 452 + (math.random() ^ 1.4) * 52
  local d = math.abs(x - 646) / 420
  local p = (1 - clamp(d, 0, 1)) * (1 - (y - 452) / 60) + 0.05
  if math.random() < p then
    if n % 4 == 0 then b:reload(pals[math.random(1, 3)], 0.3) end
    local len = 22 + math.random() * 60 * (0.6 + 0.6 * (1 - (y - 452) / 52))
    b:stroke({{x, y}, {x + len, y + (math.random() - 0.5) * 1.0}}, {pressure = 0.12 + 0.12 * math.random()})
    n = n + 1
  end
end
print("reflection strokes", n, b:fullness())

--@ chunk 50
print("refl", drying(500,470), drying(700,465), drying(300,460), "col", drying(646,500), drying(640,600), drying(650,650), "fg", drying(200,600), drying(300,700), "sun", drying(646,404), "hl", drying(120,340), drying(230,380), "schooner", drying(812,392))

--@ chunk 51
b2 = brush("flat", 8)
b2:load(dkB, 0.2)
n = 0
for i = 1, 70 do
  local y = 452 + (math.random() ^ 1.3) * 60
  local x = math.random() * 1000
  local len = 30 + math.random() * 70
  b2:stroke({{x, y}, {x + len, y + (math.random() - 0.5) * 1.0}}, {pressure = 0.15 + 0.15 * math.random()})
  n = n + 1
end
print("dark dry-brush over reflections", n, b2:fullness())

--@ chunk 52
print("fg", drying(200,470), drying(200,520), drying(200,600), drying(300,700), drying(700,600), drying(640,600), "col", drying(646,480), drying(646,520), drying(646,600), drying(660,700), "sun", drying(646,404), "hl", drying(120,340), drying(230,380), "schooner", drying(812,392))

--@ chunk 53
colBase = poly({{628,452},{664,452},{770,750},{500,750}}, true)
COLM = colBase:roughen(7, 60, 3)
FGM = rect(0, 452, 1000, 298) - COLM
cPeach = pile{{"pale cadmium", 0.6}, {"rose madder", 0.3}, {"lead white", 1.2}, turps=0.2, name="cPeach"}
cLil = pile{{"ultramarine blue", 0.5}, {"permanent alizarin", 0.4}, {"lead white", 0.7}, turps=0.2, name="cLil"}
cWarm = pile{{"burnt sienna", 0.4}, {"yellow ochre", 0.4}, {"lead white", 0.6}, turps=0.2, name="cWarm"}
cDusk = pile{{"cerulean blue", 0.5}, {"rose madder", 0.3}, {"lead white", 0.9}, turps=0.2, name="cDusk"}
b = brush("flat", 8)
n = 0
for i = 1, 260 do
  local u = math.random()
  local y = 452 + 296 * (u ^ 1.7)
  local t = (y - 452) / 296
  local x = math.random() * 1000
  local dcol = math.abs(x - (646 + (y - 452) * 0.2)) 
  local near = clamp(1 - dcol / 320, 0, 1)
  if math.random() < 0.35 + 0.65 * near then
    if math.random() < 0.5 + 0.4 * near then
      p = (math.random() < 0.6) and cWarm or cPeach
    else
      p = (math.random() < 0.6) and cLil or cDusk
    end
    if n % 5 == 0 then b:load(p, 0.18 + 0.08 * math.random()) end
    local len = (10 + 30 * t) + math.random() * (14 + 60 * t)
    local lw = 0.12 + 0.13 * (1 - t) * math.random() + 0.04
    local xx = x
    local yy = y
    if FGM:at(xx, yy) > 0.5 then
      b:stroke({{xx, yy}, {xx + len, yy + (math.random() - 0.5) * (0.6 + 1.2 * t)}}, {pressure = lw})
      n = n + 1
    end
  end
end
print("foreground strokes", n, b:fullness())

--@ chunk 54
print(drying(330,548), drying(640,555), drying(440,568), drying(700,520), drying(300,500), drying(570,575))

--@ chunk 55
colBase = poly({{628,452},{664,452},{770,750},{500,750}}, true)
COLM = colBase:roughen(7, 60, 3)
recoverM = rect(0, 470, 1000, 280) - COLM
work(recoverM, {hand="body", coverage=1.2, fill=true, clip=true, angle=0.03, load=0.9, piles={
  {dkB, function(x,y) return clamp(1 - math.abs(y-540)/110, 0, 1) end},
  {dkC, function(x,y) return clamp((y-560)/140, 0, 1) end},
  {dkA, function(x,y) return clamp(1 - (y-470)/40, 0, 0.5) end}}})
print("foreground recovered")

--@ chunk 56
print("top sky", drying(200,40), drying(500,60), drying(800,40), "upper", drying(200,200), drying(800,180), "col", drying(600,500), drying(640,600), drying(680,700), "fg new", drying(200,600), drying(800,600), "hl", drying(120,340), drying(230,380), "sun", drying(646,404), "sea", drying(560,440), drying(200,430))

--@ chunk 57
deepT = pile{{"ultramarine blue", 0.8}, {"permanent alizarin", 0.3}, {"cerulean blue", 0.3}, {"lead white", 0.4}, turps=0.5, name="deepT"}
b = brush("flat", 10)
b:load(deepT, 0.4)
n = 0
for i = 1, 6 do
  local y = 12 + i * 8 + math.random() * 4
  local x = 20 + math.random() * 60
  b:stroke({{x, y}, {x + 200 + math.random() * 120, y + (math.random() - 0.5) * 3}}, {pressure = 0.2 + 0.1 * math.random()})
  n = n + 1
end
print("deep top trial strokes", n)

--@ chunk 58
-- take the test bars off: a rag dipped lightly, a pass over the strokes only (they are still open)
print(drying(60,20), drying(200,40), drying(100,60))

--@ chunk 59
testM = rect(0, 0, 420, 70)
blend(testM, {})
blend(testM, {})
print("test area blended")

--@ chunk 60
print("strip", drying(200,458), drying(800,460), drying(200,466), drying(800,472), "fg", drying(200,490), drying(800,520), drying(200,560))

--@ chunk 61
stripM = rect(0, 449, 1000, 26) - COLM
work(stripM, {hand="body", pile=dkB, coverage=1.5, fill=true, clip=true, load=0.9})
seamB = rect(0, 462, 1000, 16) - COLM
blend(seamB, {angle=0.02})
print("strip covered and seam blended")

--@ chunk 62
print("seam", drying(200,444), drying(200,449), drying(200,452), drying(200,462), drying(200,474), drying(200,480), drying(600,470))

--@ chunk 63
seamPile = pile{{"rose madder", 0.4}, {"ultramarine blue", 0.4}, {"burnt sienna", 0.3}, {"lead white", 0.5}, turps=0.3, name="seamPile"}
seamZ = rect(0, 436, 1000, 30) - COLM
work(seamZ, {hand="broad", coverage=1.2, fill=true, clip=true, angle=0.0, piles={
  {seaPink, function(x,y) return clamp(1 - (y-436)/16, 0, 1) end},
  {seamPile, function(x,y) return clamp((y-436)/30, 0, 1) end}}})
print("seam transition laid")

--@ chunk 64
bandB = rect(0, 424, 1000, 54) - COLM - HEADL
print("open check", drying(200,428), drying(200,440), drying(200,456), drying(200,470))
blend(bandB, {angle=0.0})
blend(bandB, {angle=0.0})
print("band blended twice")

--@ chunk 65
print("fg", drying(200,500), drying(800,520), drying(200,600), drying(800,650), "col", drying(646,480), drying(600,600), drying(680,700), "band", drying(200,440), "sun", drying(646,404), drying(646,420), "hl", drying(120,340), drying(230,380), "schooner", drying(812,392), "bank", drying(260,380))

--@ chunk 66
wait(720)
print("fg", drying(200,500), drying(800,520), drying(200,600), drying(800,650), "col", drying(646,480), drying(600,600), "band", drying(200,440), drying(600,440), "sun", drying(646,404), drying(646,420), "hl", drying(120,340), drying(230,380), "schooner", drying(812,392), "bank", drying(260,380))

--@ chunk 67
wait(1440)
print("fg", drying(200,500), drying(800,520), drying(200,600), drying(800,650), "col", drying(646,480), drying(600,600), "band", drying(200,440), drying(600,440), "sun", drying(646,404), drying(646,420), "hl", drying(120,340), drying(230,380), "schooner", drying(812,392), "bank", drying(260,380))

--@ chunk 68
wait(1440)
print("fg", drying(200,500), drying(800,520), drying(200,600), drying(800,650), "col", drying(646,480), drying(600,600), "band", drying(200,440), drying(600,440), "sun", drying(646,404), drying(646,420), "hl", drying(120,340), drying(230,380), "schooner", drying(812,392), "bank", drying(260,380))

--@ chunk 69
wait(1440)
print("fg", drying(200,500), drying(800,520), drying(200,600), drying(800,650), "col", drying(646,480), drying(600,600), "band", drying(200,440), drying(600,440), "sun", drying(646,404), drying(646,420), "hl", drying(120,340), drying(230,380), "schooner", drying(812,392), "bank", drying(260,380))

--@ chunk 70
wait(1440)
print("fg", drying(200,500), drying(800,520), drying(200,600), drying(800,650), "col", drying(646,480), drying(600,600), "band", drying(200,440), drying(600,440), "sun", drying(646,404), drying(646,420), "hl", drying(120,340), drying(230,380), "schooner", drying(812,392), "bank", drying(260,380))

--@ chunk 71
wait(1440)
print("fg", drying(200,500), drying(800,520), drying(200,600), drying(800,650), "col", drying(646,480), drying(600,600), "band", drying(200,440), drying(600,440), "sun", drying(646,404), drying(646,420), "hl", drying(120,340), drying(230,380), "schooner", drying(812,392), "bank", drying(260,380))

--@ chunk 72
wait(1440)
print("fg", drying(200,500), drying(800,520), drying(200,600), drying(800,650), "col", drying(646,480), drying(600,600), "band", drying(200,440), drying(600,440), "sun", drying(646,404), drying(646,420), "hl", drying(120,340), drying(230,380), "schooner", drying(812,392), "bank", drying(260,380))

--@ chunk 73
wait(1440)
print("fg", drying(200,500), drying(800,520), drying(200,600), drying(800,650), "col", drying(646,480), drying(600,600), "band", drying(200,440), drying(600,440), "sun", drying(646,404), drying(646,420), "hl", drying(120,340), drying(230,380), "schooner", drying(812,392), "bank", drying(260,380))

--@ chunk 74
wkL = pile{{"cerulean blue", 0.8}, {"permanent alizarin", 0.3}, {"lead white", 1.4}, turps=0.4, name="wkL"}
wkM = pile{{"ultramarine blue", 0.8}, {"permanent alizarin", 0.5}, {"lead white", 0.9}, turps=0.4, name="wkM"}
wkD = pile{{"Prussian blue", 0.5}, {"ultramarine blue", 0.7}, {"permanent alizarin", 0.3}, {"lead white", 0.5}, turps=0.3, name="wkD"}
seaM = rect(0, 426, 1000, 324)
work(seaM, {hand="broad", coverage=1.4, fill=true, clip=true, angle=0.02, piles={
  {wkL, function(x,y) return clamp(1 - (y-426)/60, 0, 1) end},
  {wkM, function(x,y) return clamp(1 - math.abs(y-580)/140, 0, 1) end},
  {wkD, function(x,y) return clamp((y-600)/150, 0, 1) end}}})
print("water base laid")

--@ chunk 75
print("sea", drying(200,440), drying(600,470), drying(200,600), drying(800,700), "sun", drying(646,404), drying(646,420), "hl", drying(120,340), drying(230,380), "schooner", drying(812,392), "bank", drying(260,380), drying(200,400), "sky", drying(500,80), drying(200,250), drying(800,250))

--@ chunk 76
print("sea", drying(200,440), drying(600,470), drying(200,600), drying(800,700), "sun", drying(646,404), "hl", drying(120,340), drying(230,380), "schooner", drying(812,392), "bank", drying(260,380))

--@ chunk 77
wait(1440)
print("sea", drying(200,440), drying(600,470), drying(200,600), drying(800,700), "sun", drying(646,404), "hl", drying(120,340), drying(230,380), "schooner", drying(812,392), "bank", drying(260,380))

--@ chunk 78
wait(1440)
print("sea", drying(200,440), drying(600,470), drying(200,600), drying(800,700), "sun", drying(646,404), "hl", drying(120,340), drying(230,380), "schooner", drying(812,392), "bank", drying(260,380))

--@ chunk 79
spP2 = pile{{"pale cadmium", 0.8}, {"lead white", 1.7}, turps=0.2, name="spP2"}
spW2 = pile{{"lead white", 1.0}, {"cadmium yellow", 0.4}, {"rose madder", 0.2}, turps=0.2, name="spW2"}
b = brush("flat", 6)
n = 0
local y = 452
while y < 640 do
  local t = (y - 452) / 298
  local half = 6 + t * 110
  local cnt = 2 + math.floor(t * 6)
  b:load((math.random() < 0.55) and spP2 or spW2, 0.25 + 0.2 * math.random())
  for j = 1, cnt do
    local cx = 646 - (y - 452) * 0.12
    local x0 = cx - half + math.random() * 2 * half * (0.7 + 0.3 * math.random())
    local len = (6 + math.random() * (10 + 40 * t)) * (0.6 + 0.6 * math.random())
    if math.random() < 0.75 then
      b:stroke({{x0, y}, {x0 + len, y + (math.random() - 0.5) * 0.8}}, {pressure = 0.14 + 0.16 * math.random()})
      n = n + 1
    end
  end
  y = y + 3 + t * 8
end
print("sun path dashes laid", n)

--@ chunk 80
print("sunpath", drying(640,470), drying(650,500), drying(640,540), drying(650,580), "sea low", drying(200,650), drying(800,650), drying(400,700), "sea mid", drying(200,520), drying(800,540), "hl", drying(120,340), "schooner", drying(812,392))

--@ chunk 81
print("sunpath", drying(640,470), drying(650,500), drying(640,540), drying(650,580), "sea", drying(200,520), drying(800,540))

--@ chunk 82
wait(360)
print("sunpath", drying(640,470), drying(650,500), drying(640,540), drying(650,580), "sea", drying(200,520), drying(800,540))

--@ chunk 83
spL = pile{{"pale cadmium", 0.6}, {"lead white", 1.4}, turps=0.3, name="spL"}
spDim = pile{{"rose madder", 0.3}, {"deep cadmium", 0.2}, {"lead white", 1.1}, turps=0.3, name="spDim"}
b = brush("flat", 5)
n = 0
for i = 1, 90 do
  local y = 470 + (math.random() ^ 1.1) * 170
  local t = (y - 452) / 298
  local half = 6 + t * 110
  local cx = 646 - (y - 452) * 0.12
  local x0 = cx - half * 1.1 + math.random() * 2.2 * half
  local len = 5 + math.random() * (6 + 30 * t)
  if i % 10 == 0 then b:load((math.random() < 0.7) and spL or spDim, 0.14 + 0.06 * math.random()) end
  b:stroke({{x0, y}, {x0 + len, y + (math.random() - 0.5) * 0.6}}, {pressure = 0.07 + 0.08 * math.random()})
  n = n + 1
end
print("sun path, light dashes", n)

--@ chunk 84
wait(1440)
print("sunpath", drying(640,470), drying(650,500), drying(640,540), drying(650,580), "sea", drying(200,520), drying(800,540), drying(200,650), "sun", drying(646,404), "hl", drying(120,340), "schooner", drying(812,392))

--@ chunk 85
silS = pile{{"Prussian blue", 0.6}, {"burnt sienna", 0.6}, {"ultramarine blue", 0.4}, {"bone black", 0.1}, {"lead white", 0.1}, name="silS"}
hullS = outline{{762, 404, "c"}, {786, 417}, {812, 419}, {842, 414, "c"}, {826, 408}, {770, 406}, closed=true, char="firm", seed=4, amount=0.2}
work(hullS:mask(), {hand="detail", pile=silS, coverage=2.0, fill=true, clip=true})
mainS = poly({{815,372},{815,406},{790,406}}, true)
jibS = poly({{804,380},{804,404},{786,404}}, true)
work(mainS, {hand="detail", pile=silS, coverage=2.0, fill=true, clip=true})
work(jibS, {hand="detail", pile=silS, coverage=2.0, fill=true, clip=true})
mastS = brush{kind="round", width=2, point=0}
mastS:load(silS, 1.0)
mastS:stroke({{815,370},{815,410}}, {pressure=0.5})
print("schooner redrawn")

--@ chunk 86
print("boat state", drying(800,400), drying(815,380))

--@ chunk 87
boatBox = rect(750, 350, 110, 80)
blend(boatBox, {})
blend(boatBox, {})
print("boat area blended", drying(800,400), drying(815,380))

--@ chunk 88
skyFix = rect(748, 350, 112, 58)
skyVio = pile{{"permanent alizarin", 0.4}, {"ultramarine blue", 0.4}, {"rose madder", 0.3}, {"lead white", 1.0}, turps=0.4, name="skyVio"}
skyGld = pile{{"cadmium yellow", 0.8}, {"pale cadmium", 0.4}, {"rose madder", 0.2}, {"lead white", 1.1}, turps=0.4, name="skyGld"}
work(skyFix, {hand="broad", coverage=1.6, fill=true, clip=true, piles={
  {skyVio, function(x,y) return clamp((385-y)/40, 0, 1) end},
  {skyGld, function(x,y) return clamp((y-365)/40, 0, 1) end}}})
print("sky patch laid", drying(800,380))

--@ chunk 89
print("state", drying(800,380), drying(760,360), drying(840,400))
fixM = rect(748, 350, 112, 58) * (-(poly({{0,0},{0,0},{0,0}}, true)))
print(fixM:at(800,380))

--@ chunk 90
skyFix2 = rect(752, 352, 104, 52)
work(skyFix2, {hand="broad", coverage=1.5, fill=true, edge="lost", piles={
  {skyVio, function(x,y) return clamp((380-y)/30, 0, 1) end},
  {skyGld, function(x,y) return clamp((y-372)/30, 0, 1) end}}})
print("sky patch redone")

--@ chunk 91
wideSky = rect(742, 330, 190, 88) * rect(0, 0, 1000, 418)
work(wideSky, {hand="broad", coverage=1.2, fill=true, edge="lost", piles={
  {skyVio, function(x,y) return clamp((372-y)/40, 0, 1) end},
  {skyGld, function(x,y) return clamp((y-352)/40, 0, 1) end}}})
blend(rect(742, 330, 190, 88) * rect(0, 0, 1000, 418), {angle=0.4})
print("wide sky pass and blend")

--@ chunk 92
wait(2880)
print("boat area", drying(800,380), drying(760,360), drying(840,400), drying(815,400), "sunpath", drying(640,500), drying(650,580), "sea", drying(200,520))

--@ chunk 93
wait(1440)
print("boat area", drying(800,380), drying(760,360), drying(840,400), drying(815,400), "sunpath", drying(640,500), drying(650,580), "sea", drying(200,520))

--@ chunk 94
patchR = poly({{736,338},{760,330},{800,326},{860,328},{910,324},{944,332},{950,360},{948,396},{930,418},{760,418},{738,404},{732,370}}, true)
rA = pile{{"rose madder", 0.7}, {"ultramarine blue", 0.3}, {"permanent alizarin", 0.2}, {"lead white", 1.3}, name="rA"}
rB = pile{{"pale cadmium", 0.6}, {"rose madder", 0.4}, {"lead white", 1.5}, name="rB"}
rC = pile{{"cadmium yellow", 0.8}, {"pale cadmium", 0.4}, {"lead white", 1.3}, name="rC"}
work(patchR, {hand="broad", coverage=1.4, fill=true, clip=true, edge="soft", piles={
  {rA, function(x,y) return clamp((362-y)/30, 0, 1) end},
  {rB, function(x,y) return clamp(1 - math.abs(y-368)/22, 0, 1) end},
  {rC, function(x,y) return clamp((y-366)/30, 0, 1) end}}})
print("sky patch laid, open:", drying(840,380))

--@ chunk 95
wait(480)
print("patch", drying(840,380), drying(760,350), drying(930,400), "sunpath", drying(640,500), drying(650,580))

--@ chunk 96
wait(720)
print("patch", drying(840,380), drying(760,350), drying(930,400), "sunpath", drying(640,500), drying(650,580))

--@ chunk 97
wait(900)
print("patch", drying(840,380), drying(760,350), drying(930,400), "sunpath", drying(640,500), drying(650,580))

--@ chunk 98
wait(900)
print("patch", drying(840,380), drying(760,350), drying(930,400), "sunpath", drying(640,500), drying(650,580))

--@ chunk 99
wait(900)
print("patch", drying(840,380), drying(760,350), drying(930,400), "sunpath", drying(640,500), drying(650,580))

--@ chunk 100
print("right", drying(780,380), drying(850,400), drying(900,360), drying(980,345), drying(960,345), "sea", drying(200,440), drying(800,440), "sunpath", drying(640,500), drying(650,580))

--@ chunk 101
paleG2 = pile{{"pale cadmium", 0.6}, {"rose madder", 0.35}, {"lead white", 0.9}, name="paleG2"}
deepG2 = pile{{"deep cadmium", 0.9}, {"cadmium yellow", 0.3}, {"lead white", 0.6}, name="deepG2"}
roseC2 = pile{{"rose madder", 0.8}, {"permanent alizarin", 0.2}, {"lead white", 0.8}, name="roseC2"}
fixP = poly({{700,338},{760,334},{1000,330},{1000,416},{700,416}}, true)
work(fixP, {hand="body", coverage=1.2, fill=true, clip=true, edge="soft", piles={
  {paleG2, function(x,y) return clamp(1 - math.abs(y-362)/30, 0, 1) end},
  {deepG2, function(x,y) return clamp((y-384)/24, 0, 1) end},
  {roseC2, function(x,y) return clamp(1 - math.abs(y-342)/14, 0, 1) end}}})
print("right sky repair laid", drying(850,380))

--@ chunk 102
print("sea top", drying(120,440), drying(400,450), drying(800,450), "sea mid", drying(150,500), drying(800,520), "sea low", drying(150,650), drying(850,680), "path", drying(646,480), drying(650,560), drying(640,620), "right", drying(850,380), drying(900,400), "sun", drying(646,404), "hl", drying(120,340))

--@ chunk 103
teal = pile{{"Prussian blue", 0.5}, {"cerulean blue", 0.8}, {"lead white", 0.8}, turps=0.2, name="teal"}
vlt = pile{{"ultramarine blue", 0.7}, {"permanent alizarin", 0.4}, {"lead white", 0.8}, turps=0.2, name="vlt"}
b = brush("flat", 7)
n = 0
b:load(teal, 0.16)
for i = 1, 22 do
  local y = 690 + math.random() * 56
  local x = 4 + math.random() * 170
  local len = 14 + math.random() * 44
  b:stroke({{x, y}, {x + len, y + (math.random() - 0.5) * 0.8}}, {pressure = 0.1 + 0.1 * math.random()})
  n = n + 1
end
b:load(vlt, 0.14)
for i = 1, 14 do
  local y = 690 + math.random() * 56
  local x = 4 + math.random() * 170
  local len = 14 + math.random() * 44
  b:stroke({{x, y}, {x + len, y + (math.random() - 0.5) * 0.8}}, {pressure = 0.1 + 0.1 * math.random()})
  n = n + 1
end
print("corner trial", n)

--@ chunk 104
teal2 = pile{{"cerulean blue", 0.6}, {"raw umber", 0.15}, {"lead white", 1.0}, turps=0.2, name="teal2"}
b3 = brush("flat", 3)
b3:load(teal2, 0.35)
n = 0
for i = 1, 26 do
  local y = 700 + math.random() * 46
  local x = 150 + math.random() * 220
  local len = 40 + math.random() * 70
  b3:stroke({{x, y}, {x + len, y + (math.random() - 0.5) * 0.4}}, {pressure = 0.08 + 0.05 * math.random()})
  n = n + 1
end
print("thin teal lines", n, b3:fullness())

--@ chunk 105
lilG = pile{{"rose madder", 0.3}, {"ultramarine blue", 0.3}, {"lead white", 1.1}, turps=0.25, name="lilG"}
grTeal = pile{{"cerulean blue", 0.5}, {"ultramarine blue", 0.2}, {"lead white", 1.1}, turps=0.25, name="grTeal"}
peachR = pile{{"pale cadmium", 0.3}, {"rose madder", 0.3}, {"lead white", 1.2}, turps=0.25, name="peachR"}
b3 = brush("flat", 3)
n = 0
local specs = {{lilG, 9, 0.5}, {grTeal, 9, 0.5}, {peachR, 6, 0.4}}
for _, s in ipairs(specs) do
  b3:load(s[1], 0.3)
  for i = 1, s[2] do
    local y = 720 + math.random() * 28
    local x = 380 + math.random() * 220
    local len = 36 + math.random() * 60
    b3:stroke({{x, y}, {x + len, y + (math.random() - 0.5) * 0.4}}, {pressure = 0.07 + 0.04 * math.random()})
    n = n + 1
  end
end
print("tone trial", n)

--@ chunk 106
print("path", drying(646,500), drying(650,580), drying(640,620), "sea", drying(200,520), drying(800,520), "right", drying(850,380), drying(900,400), "sun", drying(646,404), "hl", drying(120,340))

--@ chunk 107
sunDisc = ellipse(645, 403, 15, 13)
sunHot = ellipse(645, 402, 8, 7)
discP = pile{{"pale cadmium", 1}, {"lead white", 1.2}, name="discP"}
hotP2 = pile{{"lead white", 1.6}, {"pale cadmium", 0.5}, name="hotP2"}
work(sunDisc, {hand="body", pile=discP, coverage=1.6, fill=true, clip=true, edge="firm"})
work(sunHot, {hand="body", pile=hotP2, coverage=1.6, fill=true, clip=true, edge="soft"})
print("sun disc re-laid", drying(645,403))

--@ chunk 108
warmRef = pile{{"pale cadmium", 0.5}, {"rose madder", 0.35}, {"lead white", 1.2}, turps=0.2, name="warmRef"}
warmRef2 = pile{{"deep cadmium", 0.5}, {"rose madder", 0.3}, {"lead white", 1.0}, turps=0.2, name="warmRef2"}
b = brush("flat", 3)
n = 0
for i = 1, 40 do
  local x = 500 + math.random() * 260
  local d = math.abs(x - 646) / 150
  local y = 430 + (math.random() ^ 1.4) * 22
  if math.random() < clamp(1 - d, 0.1, 1) then
    if i % 6 == 0 then b:load((math.random() < 0.6) and warmRef or warmRef2, 0.3) end
    local len = 26 + math.random() * 50 * (1 - d * 0.5)
    b:stroke({{x, y}, {x + len, y + (math.random() - 0.5) * 0.3}}, {pressure = 0.07 + 0.05 * math.random()})
    n = n + 1
  end
end
print("warm band on painting", n)

--@ chunk 109
lilG = pile{{"rose madder", 0.3}, {"ultramarine blue", 0.3}, {"lead white", 1.1}, turps=0.25, name="lilG"}
grTeal = pile{{"cerulean blue", 0.5}, {"ultramarine blue", 0.2}, {"lead white", 1.1}, turps=0.25, name="grTeal"}
b3 = brush("flat", 3)
n = 0
local specs = {{lilG, 16}, {grTeal, 12}}
for _, s in ipairs(specs) do
  b3:load(s[1], 0.3)
  for i = 1, s[2] do
    local y = 470 + (math.random() ^ 1.2) * 70
    local x = 30 + math.random() * 380
    local len = 30 + math.random() * 60 * (0.6 + (y - 470) / 120)
    b3:stroke({{x, y}, {x + len, y + (math.random() - 0.5) * 0.4}}, {pressure = 0.07 + 0.04 * math.random()})
    n = n + 1
  end
end
print("mid ripples laid", n)

--@ chunk 110
PATHENV = poly({{628,440},{664,440},{722,650},{520,650}}, true)
seaCoatM = rect(0, 452, 1000, 298) - PATHENV
cTop = pile{{"rose madder", 0.3}, {"ultramarine blue", 0.2}, {"lead white", 1.2}, {"pale cadmium", 0.15}, turps=0.4, name="cTop"}
cMid = pile{{"ultramarine blue", 0.8}, {"permanent alizarin", 0.5}, {"lead white", 0.9}, turps=0.4, name="cMid"}
cLow = pile{{"Prussian blue", 0.4}, {"ultramarine blue", 0.8}, {"permanent alizarin", 0.3}, {"lead white", 0.4}, turps=0.3, name="cLow"}
cTeal = pile{{"cerulean blue", 0.8}, {"Prussian blue", 0.2}, {"lead white", 1.0}, turps=0.3, name="cTeal"}
work(seaCoatM, {hand="broad", coverage=1.2, fill=true, clip=true, angle=0.02, edge="soft", piles={
  {cTop, function(x,y) return clamp(1 - (y-452)/60, 0, 1) end},
  {cMid, function(x,y) return clamp(1 - math.abs(y-560)/120, 0, 1) end},
  {cLow, function(x,y) return clamp((y-580)/140, 0, 1) end},
  {cTeal, function(x,y) return 0.25 * clamp(1 - math.abs(y-500)/60, 0, 1) end}}})
print("sea coat laid on painting", drying(200,520), drying(800,600))

--@ chunk 111
print("top", drying(700,60), drying(800,120), drying(560,80), drying(900,40))

--@ chunk 112
wait(1440)
print("sea", drying(200,520), drying(800,600), "path", drying(646,500), drying(650,580), "right", drying(850,380), drying(900,400))

--@ chunk 113
wait(1440)
print("sea", drying(200,520), drying(800,600), "path", drying(646,500), drying(650,580), "right", drying(850,380), drying(900,400))

--@ chunk 114
wait(1440)
print("sea", drying(200,520), drying(800,600), "path", drying(646,500), drying(650,580), "right", drying(850,380), drying(900,400))

--@ chunk 115
print("path", drying(646,450), drying(646,500), drying(640,560), drying(640,620), "sea", drying(200,520), drying(800,600))

--@ chunk 116
wedge = poly({{628,426},{664,426},{770,700},{512,700}}, true)
wedgeS = wedge:blur(9)
fadeV = mask(function(x, y) return clamp((700 - y) / 110, 0, 1) end)
PATHBASE = wedgeS * rect(0, 424, 1000, 300) * fadeV
pTop = pile{{"pale cadmium", 0.5}, {"rose madder", 0.25}, {"lead white", 1.3}, turps=0.3, name="pTop"}
pMid = pile{{"rose madder", 0.5}, {"ultramarine blue", 0.2}, {"lead white", 1.2}, turps=0.3, name="pMid"}
pLow = pile{{"ultramarine blue", 0.5}, {"permanent alizarin", 0.3}, {"lead white", 0.9}, turps=0.3, name="pLow"}
work(PATHBASE, {hand="broad", coverage=1.6, fill=true, clip=true, edge="soft", piles={
  {pTop, function(x,y) return clamp(1 - (y-426)/50, 0, 1) end},
  {pMid, function(x,y) return clamp(1 - math.abs(y-520)/70, 0, 1) end},
  {pLow, function(x,y) return clamp((y-560)/120, 0, 1) end}}})
print("path base on painting", drying(646,500))

--@ chunk 117
wait(60)
print("path base", drying(646,450), drying(646,500), drying(640,560), drying(640,620))

--@ chunk 118
wait(120)
print("path base", drying(646,450), drying(646,500), drying(640,560), drying(640,620))

--@ chunk 119
wait(240)
print("path base", drying(646,450), drying(646,500), drying(640,560), drying(640,620))

--@ chunk 120
print("path", drying(646,450), drying(646,500), drying(640,560), drying(640,620), "boat zone", drying(800,405), drying(815,395), drying(780,420), "right sky", drying(860,360), drying(930,380), "top", drying(300,60), drying(800,80))

--@ chunk 121
wait(360)
print("path", drying(646,450), drying(646,500), drying(640,560), drying(640,620), "boat zone", drying(800,405), drying(815,395), drying(780,420), "top", drying(300,60))

--@ chunk 122
wait(480)
print("path", drying(646,450), drying(646,500), drying(640,560), drying(640,620), "boat zone", drying(800,405), drying(815,395), drying(780,420), "top", drying(300,60))

--@ chunk 123
wait(480)
print("path", drying(646,450), drying(646,500), drying(640,560), drying(640,620), "boat zone", drying(800,405), drying(815,395), drying(780,420), "top", drying(300,60))

--@ chunk 124
gCream = pile{{"pale cadmium", 0.5}, {"lead white", 1.8}, turps=0.2, name="gCream"}
gWhite = pile{{"lead white", 1.0}, {"cadmium yellow", 0.3}, turps=0.2, name="gWhite"}
rbP = brush{kind="round", width=3, point=1}
n = 0
for i = 1, 14 do
  local y = 470 + (math.random() ^ 1.2) * 60
  local t = (y - 426) / 290
  local half = 4 + t * 100
  local cx = 646 - (y - 426) * 0.12
  local x0 = cx - 24 + math.random() * 48
  local len = (5 + 10 * t) + math.random() * (10 + 40 * t)
  if i % 5 == 0 then rbP:load((math.random() < 0.6) and gCream or gWhite, 0.8) end
  local pk = clamp((0.3 + 0.5 * math.random()) * (0.6 + 0.6 * t), 0, 1)
  rbP:gesture({{x0, y, 0}, {x0 + len * 0.5, y + 0.2, pk}, {x0 + len, y + 0.4, 0}}, {})
  n = n + 1
end
print("trial glints on tacky path", n, rbP:fullness())

--@ chunk 125
gCream2 = pile{{"lead white", 1.6}, {"pale cadmium", 0.3}, {"rose madder", 0.05}, turps=0.2, name="gCream2"}
gWhite2 = pile{{"lead white", 1.0}, {"cadmium yellow", 0.15}, turps=0.2, name="gWhite2"}
rbP = brush{kind="round", width=3, point=1}
n = 0
for i = 1, 150 do
  local u = math.random()
  local y = 428 + 290 * (u ^ 1.5)
  local t = (y - 426) / 290
  local half = 4 + t * 100
  local cx = 646 - (y - 426) * 0.12
  local x0 = cx - half + math.random() * 2 * half
  local len = (5 + 10 * t) + math.random() * (10 + 40 * t)
  if i % 7 == 0 then rbP:load((math.random() < 0.6) and gCream2 or gWhite2, 0.8) end
  local pk = clamp((0.3 + 0.5 * math.random()) * (0.6 + 0.6 * t), 0, 1)
  rbP:gesture({{x0, y, 0}, {x0 + len * 0.5, y + 0.2, pk}, {x0 + len, y + 0.4, 0}}, {})
  n = n + 1
end
print("path glints laid", n)

--@ chunk 126
skyBL = pile{{"cerulean blue", 0.9}, {"permanent alizarin", 0.3}, {"lead white", 1.3}, turps=0.3, name="skyBL"}
fleck1 = ellipse(781, 64, 24, 4)
work(fleck1, {hand="body", pile=skyBL, coverage=1.4, fill=true, clip=true, edge="soft"})
print("fleck 1 touched", drying(781,64))

--@ chunk 127
print("boat zone", drying(800,405), drying(815,395), drying(780,420), drying(806,400), "fleck", drying(781,64), "sea", drying(200,520), "path", drying(646,500))

--@ chunk 128
wait(480)
print("boat zone", drying(800,405), drying(815,395), drying(780,420), drying(806,400), "fleck", drying(781,64), "sea", drying(200,520), "path", drying(646,500))

--@ chunk 129
wait(240)
print("boat zone", drying(800,405), drying(815,395), drying(780,420), drying(806,400), "fleck", drying(781,64), "sea", drying(200,520), "path", drying(646,500))

--@ chunk 130
silB = pile{{"Prussian blue", 0.6}, {"burnt sienna", 0.6}, {"ultramarine blue", 0.4}, {"bone black", 0.1}, {"lead white", 0.1}, name="silB"}
hullB = outline{{784, 418, "c"}, {800, 424}, {826, 424}, {838, 416, "c"}, {818, 418}, {796, 416}, closed=true, char="firm", seed=4, amount=0.12}
hmB = hullB:mask()
work(hmB, {hand="detail", pile=silB, coverage=2.0, fill=true, clip=true})
sailB = poly({{806, 382}, {806, 414}, {788, 414}}, true)
work(sailB, {hand="detail", pile=silB, coverage=2.0, fill=true, clip=true})
jibB = poly({{810, 390}, {810, 414}, {826, 414}}, true)
work(jibB, {hand="detail", pile=silB, coverage=2.0, fill=true, clip=true})
mastB = brush{kind="round", width=1.6, point=0}
mastB:load(silB, 1.0)
mastB:stroke({{806, 379}, {806, 418}}, {pressure=0.45})
print("boat laid on painting")

--@ chunk 131
skyBL2 = pile{{"cerulean blue", 0.6}, {"ultramarine blue", 0.2}, {"permanent alizarin", 0.25}, {"lead white", 1.2}, name="skyBL2"}
blobM = ellipse(800, 64, 40, 10)
work(blobM, {hand="body", pile=skyBL2, coverage=1.6, fill=true, clip=true, edge="soft", load=1.0})
print("blob covered", drying(800,64))

--@ chunk 132
print("blob", drying(800,64), drying(760,60), "boat", drying(806,400), drying(800,420), "headland", drying(120,340), drying(230,380), "sea", drying(200,520))

--@ chunk 133
wait(720)
print("blob", drying(800,64), drying(760,60), "boat", drying(806,400), drying(800,420), "headland", drying(120,340), drying(230,380), "sea", drying(200,520))

--@ chunk 134
wait(1440)
print("blob", drying(800,64), drying(760,60), "boat", drying(806,400), drying(800,420), "headland", drying(120,340), drying(230,380), "sea", drying(200,520))

--@ chunk 135
ledgeM = poly({{270,404},{292,396},{318,398},{336,406},{352,414},{352,422},{270,422}}, true)
leftRock = poly({{0,380},{14,366},{34,362},{46,372},{30,386},{0,390}}, true)
work(ledgeM, {hand="body", pile=hdA, coverage=1.6, fill=true, clip=true})
work(leftRock, {hand="body", pile=hdA, coverage=1.6, fill=true, clip=true})
print("ledge and left rock laid", drying(300,410))

--@ chunk 136
wait(720)
print("ledge", drying(300,410), drying(20,375))

--@ chunk 137
wait(1440)
print("ledge", drying(300,410), drying(20,375), "blob", drying(800,64), "boat", drying(806,400))

--@ chunk 138
wait(1440)
print("ledge", drying(300,410), drying(20,375), "blob", drying(800,64), "boat", drying(806,400), "sea", drying(200,520), "path", drying(646,500))

--@ chunk 139
wait(1440)
print("ledge", drying(300,410), drying(20,375), "blob", drying(800,64), "boat", drying(806,400), "sea", drying(200,520), "path", drying(646,500))

--@ chunk 140
wait(1440)
print("ledge", drying(300,410), drying(20,375), "blob", drying(800,64), "boat", drying(806,400), "sea", drying(200,520), "path", drying(646,500))

--@ chunk 141
print("blob", drying(800,64), drying(790,70), drying(810,58), "boat", drying(806,400), "ledge", drying(300,410), "sea", drying(200,520), "path", drying(646,500))

--@ chunk 142
wait(480)
print("blob", drying(800,64), drying(790,70), "boat", drying(806,400), drying(800,420), drying(815,384), "ledge", drying(300,410), "sea", drying(800,432), drying(780,440), drying(200,520))

--@ chunk 143
wait(1440)
print("blob", drying(800,64), drying(790,70), "boat", drying(806,400), drying(800,420), drying(815,384), "ledge", drying(300,410), "sea", drying(800,432), drying(780,440), drying(200,520))

--@ chunk 144
wait(1440)
print("blob", drying(800,64), drying(790,70), "boat", drying(806,400), drying(800,420), drying(815,384), "ledge", drying(300,410), "sea", drying(800,432), drying(780,440), drying(200,520))

--@ chunk 145
refP = pile{{"Prussian blue", 0.4}, {"burnt sienna", 0.4}, {"ultramarine blue", 0.3}, {"lead white", 0.15}, turps=0.3, name="refP"}
b3 = brush("flat", 3)
b3:load(refP, 0.3)
n = 0
local rows = {{427, 800, 22}, {431, 806, 16}, {435, 798, 26}, {440, 804, 12}}
for _, r in ipairs(rows) do
  local y, cx, hw = r[1], r[2], r[3]
  b3:stroke({{cx - hw, y}, {cx + hw * 0.6, y + 0.3}}, {pressure = 0.09 + 0.03 * math.random()})
  n = n + 1
end
print("boat reflection laid", n)

--@ chunk 146
silP2 = pile{{"Prussian blue", 0.6}, {"burnt sienna", 0.6}, {"ultramarine blue", 0.4}, {"bone black", 0.1}, {"lead white", 0.1}, name="silP2"}
b4 = brush("flat", 2)
b4:load(silP2, 0.7)
b4:stroke({{790, 423.5}, {812, 424.5}, {832, 423}}, {pressure = 0.3})
print("hull planted")

--@ chunk 147
cloudUnder = ellipse(800, 66, 46, 9) * rect(0, 60, 1000, 30)
cuP = pile{{"ultramarine blue", 0.4}, {"permanent alizarin", 0.5}, {"lead white", 0.7}, name="cuP"}
work(cloudUnder, {hand="body", pile=cuP, coverage=1.3, fill=true, clip=true, edge="soft"})
cloudTop = ellipse(800, 56, 34, 4) * rect(0, 0, 1000, 60)
ctP = pile{{"pale cadmium", 0.5}, {"rose madder", 0.2}, {"lead white", 1.4}, name="ctP"}
work(cloudTop, {hand="body", pile=ctP, coverage=1.2, fill=true, clip=true, edge="soft"})
print("cloud shaped", drying(800,66))

--@ chunk 148
print("cloud open", drying(800,66), drying(800,56))
wait(1440)
print("cloud", drying(800,66), drying(800,56))

--@ chunk 149
wait(1440)
print("cloud", drying(800,66), drying(800,56))

--@ chunk 150
wait(1440)
print("cloud", drying(800,66), drying(800,56))

--@ chunk 151
wait(1440)
print("cloud", drying(800,66), drying(800,56))

--@ chunk 152
greyV = pile{{"cerulean blue", 0.6}, {"permanent alizarin", 0.2}, {"lead white", 1.0}, name="greyV"}
b5 = brush("flat", 7)
b5:load(greyV, 0.14)
n = 0
for i = 1, 18 do
  local x = 720 + math.random() * 160
  local y = 62 + math.random() * 10
  b5:stroke({{x, y}, {x + 20 + math.random() * 30, y + (math.random() - 0.5) * 0.6}}, {pressure = 0.08 + 0.05 * math.random()})
  n = n + 1
end
print("dry lilac scumble on cloud", n)

--@ chunk 153
skyCov = poly({{690,40},{930,40},{930,90},{690,90}}, true) * ellipse(800, 66, 70, 28)
skyCovP = pile{{"cerulean blue", 0.7}, {"permanent alizarin", 0.35}, {"rose madder", 0.2}, {"lead white", 1.4}, name="skyCovP"}
work(skyCovP and skyCov or skyCov, {hand="body", pile=skyCovP, coverage=1.4, fill=true, clip=true, edge="soft", load=1.0})
print("cloud covered", drying(800,66))

--@ chunk 154
wait(60)
skyBlueC = pile{{"cerulean blue", 0.9}, {"permanent alizarin", 0.2}, {"lead white", 1.3}, name="skyBlueC"}
work(skyCov, {hand="broad", pile=skyBlueC, coverage=1.6, fill=true, clip=true, edge="lost", load=1.0})
print("re-covered in sky blue", drying(800,66))

--@ chunk 155
wait(1440)
print("cover", drying(800,66), drying(740,70), drying(880,60))

--@ chunk 156
wait(2880)
print("cover", drying(800,66), drying(740,70), drying(880,60))

--@ chunk 157
wait(2880)
print("cover", drying(800,66), drying(740,70), drying(880,60))

--@ chunk 158
wait(1440)
print("cover", drying(800,66), drying(740,70), drying(880,60))

--@ chunk 159
print("state", drying(800,66), drying(760,60))
wait(480)
print("state2", drying(800,66), drying(760,60))

--@ chunk 160
wait(1440)
print("state", drying(800,66), drying(760,60), drying(880,60))

--@ chunk 161
wait(1440)
print("state", drying(800,66), drying(760,60), drying(880,60))

--@ chunk 162
wait(1440)
print("state", drying(800,66), drying(760,60), drying(880,60))

--@ chunk 163
wait(1440)
print("state", drying(800,66), drying(760,60), drying(880,60))

--@ chunk 164
wait(2880)
print("cover", drying(800,66), drying(760,60), drying(880,60))

--@ chunk 165
wait(1440)
print("cover", drying(800,66), drying(760,60), drying(880,60))

--@ chunk 166
wait(1440)
print("cover", drying(800,66), drying(760,60), drying(880,60))

--@ chunk 167
coverFinal = poly({{690,30},{940,30},{940,96},{690,96}}, true) * ellipse(815, 66, 130, 42)
coverP = pile{{"cerulean blue", 0.9}, {"ultramarine blue", 0.15}, {"permanent alizarin", 0.2}, {"lead white", 1.5}, name="coverP"}
work(coverFinal, {hand="body", pile=coverP, coverage=1.8, fill=true, clip=true, edge="soft", load=1.0})
print("final cover laid", drying(800,66))

--@ chunk 168
print("final cover", drying(800,66), drying(700,40))
wait(60)
print("after wait", drying(800,66))

--@ chunk 169
wait(1440)
print("cover", drying(800,66), drying(700,40), drying(880,60))

--@ chunk 170
wait(2880)
print("cover", drying(800,66), drying(700,40), drying(880,60))

--@ chunk 171
print("cloud", drying(800,50), drying(800,70), drying(800,85))
wait(1440)
print("cloud after", drying(800,50), drying(800,70), drying(800,85))

--@ chunk 172
wait(2880)
print("cloud", drying(800,50), drying(800,70), drying(800,85))

--@ chunk 173
cTopP = pile{{"pale cadmium", 0.4}, {"rose madder", 0.3}, {"lead white", 1.6}, turps=0.2, name="cTopP"}
cUndP = pile{{"rose madder", 0.6}, {"permanent alizarin", 0.3}, {"ultramarine blue", 0.2}, {"lead white", 0.9}, turps=0.2, name="cUndP"}
cTopM = ellipse(800, 42, 120, 12) * rect(0, 0, 1000, 60)
work(cTopM, {hand="body", pile=cTopP, coverage=1.0, fill=true, clip=true, edge="soft"})
print("cloud top laid", drying(800,42))

--@ chunk 174
wait(2880)
print("top", drying(800,42), drying(800,50))

--@ chunk 175
wait(2880)
print("top", drying(800,42), drying(800,50), drying(800,70))

--@ chunk 176
wait(1440)
print("top", drying(800,42), drying(800,50), drying(800,70))

--@ chunk 177
cloudBlend = ellipse(800, 52, 128, 36) * rect(0, 0, 1000, 90)
blendZone = cloudBlend - ellipse(800, 66, 120, 24)
print("cloud blend zone ready")

--@ chunk 178
coverSky1 = pile{{"cerulean blue", 1}, {"ultramarine blue", 0.4}, {"permanent alizarin", 0.25}, {"lead white", 0.9}, name="coverSky1"}
coverSky2 = pile{{"cerulean blue", 0.8}, {"permanent alizarin", 0.5}, {"rose madder", 0.3}, {"lead white", 1.0}, name="coverSky2"}
print(coverSky1) print(coverSky2)

--@ chunk 179
cover2M = ellipse(812, 62, 150, 52) * rect(0, 0, 1000, 104)
work(cover2M, {hand="body", coverage=1.6, fill=true, clip=true, edge="soft", load=1.0, piles={
  {coverSky1, function(x,y) return clamp((64 - y)/26, 0, 1) end},
  {coverSky2, function(x,y) return clamp((y - 56)/26, 0, 1) end}}})
print("sky cover laid", drying(812,62))

--@ chunk 180
blend(cover2M, {angle=0.1})
blend(cover2M, {angle=1.4})
print("cover blended", drying(812,62))

--@ chunk 181
wait(2880)
print("cover", drying(812,62), drying(760,50))

--@ chunk 182
wait(2880)
print("cover", drying(812,62), drying(760,50))

--@ chunk 183
wait(2880)
print("cover", drying(812,62), drying(760,50))

--@ chunk 184
print("horizon glints", drying(300,424), drying(620,425), drying(760,426), "sea", drying(200,440), drying(560,436), "path", drying(646,450))

--@ chunk 185
glintFar = pile{{"lead white", 1.4}, {"pale cadmium", 0.3}, turps=0.2, name="glintFar"}
rf = brush{kind="rigger", width=2, point=1}
rf:load(glintFar, 0.5)
n = 0
for i = 1, 10 do
  local x = 500 + math.random() * 60
  local y = 430 + math.random() * 6
  rf:stroke({{x, y}, {x + 3 + math.random() * 5, y + 0.2}}, {pressure = 0.14 + 0.08 * math.random()})
  n = n + 1
end
print("far glints trial", n, rf:fullness())

--@ chunk 186
rf = brush{kind="rigger", width=2, point=1}
rf:load(glintFar, 0.5)
n = 0
for i = 1, 34 do
  local side = (math.random() < 0.5) and -1 or 1
  local x = 646 + side * (40 + math.random() * 300)
  local y = 428 + math.random() * 14
  local len = 3 + math.random() * 6
  rf:stroke({{x, y}, {x + len, y + 0.2}}, {pressure = 0.14 + 0.08 * math.random()})
  n = n + 1
end
print("far sea glints laid", n)

--@ chunk 187
print("headland edge", drying(180,340), drying(220,358), drying(250,372), drying(160,335))

--@ chunk 188
edgeHL = poly({{118,326},{140,322},{160,326},{186,338},{214,352},{246,370},{280,388},{312,402},{336,412},{352,421},{300,421},{250,400},{200,376},{150,350},{120,336}}, true)
edgeHL2 = edgeHL * HEADL
work(edgeHL2, {hand="body", pile=hdA, coverage=1.4, fill=true, clip=true, edge="firm"})
print("headland edge re-laid", drying(200,360))

--@ chunk 189
wait(1440)
print("edge", drying(200,360), drying(250,372))

--@ chunk 190
wait(2880)
print("edge", drying(200,360), drying(250,372))

--@ chunk 191
print("far sea", drying(480,450), drying(800,450), drying(420,462), drying(880,470))
refRose = pile{{"rose madder", 0.5}, {"pale cadmium", 0.2}, {"lead white", 1.3}, turps=0.2, name="refRose"}
rr = brush{kind="rigger", width=2, point=1}
rr:load(refRose, 0.45)
n = 0
for i = 1, 26 do
  local side = (math.random() < 0.5) and -1 or 1
  local x = 646 + side * (110 + math.random() * 300)
  local y = 440 + math.random() * 30
  local len = 14 + math.random() * 34
  rr:stroke({{x, y}, {x + len, y + (math.random() - 0.5) * 0.4}}, {pressure = 0.09 + 0.05 * math.random()})
  n = n + 1
end
print("rose reflections laid", n)

--@ chunk 192
print("stain", drying(560,482), drying(540,474), drying(600,486))
fixSeaP = pile{{"ultramarine blue", 0.6}, {"permanent alizarin", 0.4}, {"lead white", 1.0}, turps=0.3, name="fixSeaP"}
stainM = ellipse(566, 480, 42, 10)
work(stainM, {hand="body", pile=fixSeaP, coverage=1.2, fill=true, clip=true, edge="soft"})
print("stain covered", drying(566,480))

--@ chunk 193
wait(1440)
print("stain cover", drying(566,480), drying(550,478))

--@ chunk 194
wait(2880)
print("stain cover", drying(566,480), drying(550,478))

--@ chunk 195
print("tacky check", drying(566,480), drying(540,478))
rimStain = stainM:rim(14, 10) * rect(0, 440, 1000, 60)
blend(rimStain, {angle=0.1})
print("stain rim blended", drying(566,480))

--@ chunk 196
wait(2880)
print("stain", drying(566,480), drying(540,478))

--@ chunk 197
seaCov = pile{{"ultramarine blue", 0.5}, {"permanent alizarin", 0.35}, {"lead white", 1.1}, {"rose madder", 0.15}, name="seaCov"}
seaCovM = ellipse(566, 480, 50, 16)
work(seaCovM, {hand="body", pile=seaCov, coverage=1.5, fill=true, clip=true, edge="soft", load=0.9})
print("sea cover laid", drying(566,480))

--@ chunk 198
wait(2880)
print("sea cover", drying(566,480), drying(540,478))

--@ chunk 199
wait(2880)
print("sea cover", drying(566,480), drying(540,478))

--@ chunk 200
wait(2880)
print("sea cover", drying(566,480), drying(540,478))

--@ chunk 201
seaCov2 = pile{{"cerulean blue", 0.5}, {"ultramarine blue", 0.3}, {"permanent alizarin", 0.2}, {"lead white", 1.4}, name="seaCov2"}
seaCovM2 = ellipse(566, 480, 52, 18)
work(seaCovM2, {hand="body", pile=seaCov2, coverage=1.6, fill=true, clip=true, edge="soft", load=1.0})
print("cool sea cover laid", drying(566,480))

--@ chunk 202
wait(2880)
print("cool cover", drying(566,480), drying(540,478))

--@ chunk 203
wait(2880)
print("cool cover", drying(566,480), drying(540,478))

--@ chunk 204
wait(2880)
print("cool cover", drying(566,480), drying(540,478))

--@ chunk 205
seaLine = pile{{"ultramarine blue", 0.5}, {"permanent alizarin", 0.3}, {"lead white", 0.8}, turps=0.3, name="seaLine"}
b6 = brush("flat", 3)
b6:load(seaLine, 0.3)
n = 0
for i = 1, 30 do
  local y = 466 + math.random() * 28
  local x = 502 + math.random() * 110
  local len = 18 + math.random() * 36
  b6:stroke({{x, y}, {x + len, y + (math.random() - 0.5) * 0.4}}, {pressure = 0.08 + 0.04 * math.random()})
  n = n + 1
end
print("ripple lines over oval", n, b6:fullness())

--@ chunk 206
wait(2880)
print("oval", drying(566,480), drying(540,478))

--@ chunk 207
print("painting cloud zone", drying(800,62), drying(760,50), drying(900,30), drying(800,110))
tSky = pile{{"ultramarine blue", 0.7}, {"cerulean blue", 0.6}, {"lead white", 1.0}, name="tSky"}
mSky = pile{{"cerulean blue", 0.6}, {"permanent alizarin", 0.35}, {"lead white", 1.2}, name="mSky"}
bSky = pile{{"rose madder", 0.5}, {"permanent alizarin", 0.25}, {"lead white", 1.4}, {"ultramarine blue", 0.2}, name="bSky"}
coverT = rect(600, 0, 400, 126)
work(coverT, {hand="broad", coverage=1.5, fill=true, clip=true, edge="soft", load=1.0, piles={
  {tSky, function(x,y) return clamp((40 - y)/25, 0, 1) end},
  {mSky, function(x,y) return clamp(1 - math.abs(y - 50)/36, 0, 1) end},
  {bSky, function(x,y) return clamp((y - 60)/30, 0, 1) end}}})
print("sky cover laid on painting", drying(800,62))

--@ chunk 208
wait(4320)
print("cover", drying(800,20), drying(800,62), drying(800,110))

--@ chunk 209
wait(2880)
print("cover", drying(800,20), drying(800,62), drying(800,110))

--@ chunk 210
wait(2880)
print("cover", drying(800,20), drying(800,62), drying(800,110))

--@ chunk 211
rippleL = pile{{"rose madder", 0.3}, {"lead white", 1.2}, {"ultramarine blue", 0.2}, turps=0.25, name="rippleL"}
rippleG = pile{{"cerulean blue", 0.4}, {"lead white", 1.2}, {"ultramarine blue", 0.2}, turps=0.25, name="rippleG"}
rippleV = pile{{"ultramarine blue", 0.5}, {"permanent alizarin", 0.3}, {"lead white", 0.6}, turps=0.25, name="rippleV"}
b7 = brush("flat", 3)
n = 0
local specs = {{rippleL, 14, 0.25}, {rippleG, 10, 0.25}, {rippleV, 10, 0.25}}
for _, s in ipairs(specs) do
  b7:load(s[1], 0.28)
  for i = 1, s[2] do
    local y = 448 + math.random() * 56
    local x = 430 + math.random() * 190
    if x < 620 then
      local len = 22 + math.random() * 46
      b7:stroke({{x, y}, {x + len, y + (math.random() - 0.5) * 0.4}}, {pressure = 0.07 + 0.04 * math.random()})
      n = n + 1
    end
  end
end
print("oval edge ripples", n)

--@ chunk 212
print("painting block", drying(800,60), drying(700,100), drying(900,40))

--@ chunk 213
cvTop = pile{{"ultramarine blue", 0.6}, {"cerulean blue", 0.9}, {"lead white", 1.5}, name="cvTop"}
cvMid = pile{{"cerulean blue", 0.8}, {"rose madder", 0.3}, {"permanent alizarin", 0.15}, {"lead white", 1.6}, name="cvMid"}
cvLow = pile{{"rose madder", 0.5}, {"ultramarine blue", 0.3}, {"lead white", 1.8}, name="cvLow"}
cvM = poly({{520,0},{1000,0},{1000,128},{962,138},{904,126},{846,146},{784,132},{722,152},{662,138},{612,152},{566,136},{526,124},{506,70},{512,20}}, true)
cvM = cvM:roughen(6, 40, 7)
work(cvM, {hand="body", coverage=1.8, fill=true, clip=true, edge="soft", load=1.0, piles={
  {cvTop, function(x,y) return clamp((55 - y)/40, 0, 1) end},
  {cvMid, function(x,y) return clamp(1 - math.abs(y - 80)/40, 0, 1) end},
  {cvLow, function(x,y) return clamp((y - 100)/40, 0, 1) end}}})
print("top cover laid on painting", drying(800,60))

--@ chunk 214
wait(5760)
print("top cover", drying(800,60), drying(700,100))

--@ chunk 215
wait(2880)
print("top cover", drying(800,60), drying(700,100))

--@ chunk 216
print("painting top right", drying(800,60), drying(700,100), drying(520,60))
cvTop = pile{{"ultramarine blue", 0.6}, {"cerulean blue", 0.9}, {"lead white", 1.5}, name="cvTop"}
cvMid = pile{{"cerulean blue", 0.8}, {"rose madder", 0.3}, {"permanent alizarin", 0.15}, {"lead white", 1.6}, name="cvMid"}
cvLow = pile{{"rose madder", 0.5}, {"ultramarine blue", 0.3}, {"lead white", 1.8}, name="cvLow"}
cvP2 = poly({{520,0},{1000,0},{1000,128},{962,138},{904,126},{846,146},{784,132},{722,152},{662,138},{612,152},{566,136},{526,124},{506,70},{512,20}}, true)
cvSoft2 = cvP2:roughen(6, 40, 7):blur(16)
work(cvSoft2, {hand="body", coverage=1.8, fill=true, clip=true, edge="soft", load=1.0, piles={
  {cvTop, function(x,y) return clamp((55 - y)/40, 0, 1) end},
  {cvMid, function(x,y) return clamp(1 - math.abs(y - 80)/40, 0, 1) end},
  {cvLow, function(x,y) return clamp((y - 100)/40, 0, 1) end}}})
print("feathered cover over painting", drying(800,60))

--@ chunk 217
wait(8640)
print("top right", drying(800,60), drying(700,100))

--@ chunk 218
seaVio = pile{{"ultramarine blue", 0.8}, {"permanent alizarin", 0.5}, {"rose madder", 0.2}, {"lead white", 0.7}, name="seaVio"}
print(seaVio)
ovalM = ellipse(566, 480, 50, 16)
work(ovalM, {hand="body", pile=seaVio, coverage=1.5, fill=true, clip=true, edge="soft", load=1.0})
print("violet cover over oval", drying(566,480))

--@ chunk 219
wait(8640)
print("oval", drying(566,480), drying(540,478))

--@ chunk 220
wait(4320)
print("oval", drying(566,480), drying(540,478))

--@ chunk 221
print("oval painting", drying(566,480), drying(540,478))
wait(8640)
print("oval after", drying(566,480), drying(540,478))

--@ chunk 222
cTop = pile{{"rose madder", 0.3}, {"ultramarine blue", 0.2}, {"lead white", 1.2}, {"pale cadmium", 0.15}, turps=0.4, name="cTop"}
cMid = pile{{"ultramarine blue", 0.8}, {"permanent alizarin", 0.5}, {"lead white", 0.9}, turps=0.4, name="cMid"}
coverOvP = ellipse(566, 480, 80, 30):blur(14)
work(coverOvP, {hand="broad", coverage=1.5, fill=true, clip=true, edge="soft", load=1.0, angle=0.02, piles={
  {cTop, function(x,y) return clamp((482 - y)/16, 0, 1) end},
  {cMid, function(x,y) return clamp((y - 478)/16, 0, 1) end}}})
print("feathered sea cover on painting", drying(566,480))

--@ chunk 223
wait(8640)
print(drying(566,480))

--@ chunk 224
refHL = pile{{"ultramarine blue", 0.8}, {"burnt sienna", 0.5}, {"bone black", 0.2}, {"permanent alizarin", 0.3}, {"lead white", 0.2}, turps=0.3, name="refHL"}
bR = brush("flat", 3)
bR:load(refHL, 0.3)
n = 0
for i = 1, 22 do
  local y = 426 + (math.random() ^ 1.3) * 14
  local x = 10 + math.random() * 300
  local t = (y - 426) / 14
  local len = 26 + math.random() * 46 * (1 - t * 0.5)
  if x + len < 360 then
    bR:stroke({{x, y}, {x + len, y + (math.random() - 0.5) * 0.3}}, {pressure = 0.07 + 0.04 * math.random()})
    n = n + 1
  end
end
print("headland reflection strokes", n, bR:fullness())

--@ chunk 225
print("lower-left", drying(120,650), drying(200,700), drying(60,720))
rippleC = pile{{"cerulean blue", 0.6}, {"lead white", 1.2}, {"permanent alizarin", 0.1}, turps=0.25, name="rippleC"}
rippleW = pile{{"lead white", 1.0}, {"pale cadmium", 0.2}, {"rose madder", 0.1}, turps=0.25, name="rippleW"}
bq = brush("flat", 3)
bq:load(rippleC, 0.42)
n = 0
for i = 1, 18 do
  local y = 652 + math.random() * 84
  local x = 14 + math.random() * 270
  local len = 26 + math.random() * 50
  bq:stroke({{x, y}, {x + len, y + (math.random() - 0.5) * 0.4}}, {pressure = 0.1 + 0.04 * math.random()})
  n = n + 1
end
print("lower-left ripples, cerulean", n, bq:fullness())

--@ chunk 226
print("beads", drying(208,656), drying(120,683), drying(170,708), drying(140,734), "dry sea nearby", drying(60,700))

--@ chunk 227
muteP = pile{{"ultramarine blue", 0.7}, {"permanent alizarin", 0.4}, {"Prussian blue", 0.15}, {"lead white", 0.9}, turps=0.3, name="muteP"}
muteM = rect(0, 640, 320, 110):blur(14) * rect(0, 452, 1000, 298)
work(muteM, {hand="broad", pile=muteP, coverage=1.1, fill=true, clip=true, edge="soft", load=0.9, angle=0.02})
print("feathered mute laid", drying(120,683))

--@ chunk 228
wait(8640)
print("mute", drying(120,683), drying(200,700))

--@ chunk 229
PATHENV = poly({{628,440},{664,440},{722,650},{520,650}}, true)
seaCoatM = rect(0, 452, 1000, 298) - PATHENV
cTop = pile{{"rose madder", 0.3}, {"ultramarine blue", 0.2}, {"lead white", 1.2}, {"pale cadmium", 0.15}, turps=0.4, name="cTop"}
cMid = pile{{"ultramarine blue", 0.8}, {"permanent alizarin", 0.5}, {"lead white", 0.9}, turps=0.4, name="cMid"}
cLow = pile{{"Prussian blue", 0.4}, {"ultramarine blue", 0.8}, {"permanent alizarin", 0.3}, {"lead white", 0.4}, turps=0.3, name="cLow"}
work(seaCoatM, {hand="broad", coverage=1.2, fill=true, clip=true, angle=0.02, edge="soft", piles={
  {cTop, function(x,y) return clamp(1 - (y-452)/60, 0, 1) end},
  {cMid, function(x,y) return clamp(1 - math.abs(y-560)/120, 0, 1) end},
  {cLow, function(x,y) return clamp((y-580)/140, 0, 1) end}}})
print("sea re-laid over the strip", drying(120,683))

--@ chunk 230
wait(8640)
print("sea", drying(120,683), drying(300,600))

--@ chunk 231
print("sun", drying(646,404), "path", drying(646,500), drying(640,600), "boat", drying(806,400), "top cover", drying(800,60), drying(700,100), "oval", drying(566,480), "sea-left", drying(120,683), drying(300,600), "headland", drying(200,360), "sky-mid", drying(300,200), drying(700,250))

--@ chunk 232
print("painting sea", drying(120,600), drying(300,600), drying(120,683), drying(800,600), drying(900,700), "path", drying(646,500), drying(640,620), "top", drying(800,60), drying(700,100), "boat", drying(806,400))

--@ chunk 233
lilG = pile{{"rose madder", 0.3}, {"ultramarine blue", 0.3}, {"lead white", 1.1}, turps=0.25, name="lilG"}
grTeal = pile{{"cerulean blue", 0.5}, {"ultramarine blue", 0.2}, {"lead white", 1.1}, turps=0.25, name="grTeal"}
teal2 = pile{{"cerulean blue", 0.6}, {"raw umber", 0.15}, {"lead white", 1.0}, turps=0.2, name="teal2"}
peachR = pile{{"pale cadmium", 0.3}, {"rose madder", 0.3}, {"lead white", 1.2}, turps=0.25, name="peachR"}
LOWREG = rect(0, 540, 1000, 150) - PATHENV
b7 = brush("flat", 3)
n = 0
local cur = nil
for i = 1, 70 do
  local y = 540 + (math.random() ^ 1.15) * 150
  local t = (y - 540) / 150
  local x = math.random() * 1000
  if LOWREG:at(x, y) > 0.5 then
    local cx = 646 - (y - 440) * 0.12
    local pick
    if math.abs(x - cx) < 150 and math.random() < 0.5 then pick = peachR
    elseif math.random() < 0.5 then pick = lilG
    elseif math.random() < 0.6 then pick = teal2
    else pick = grTeal end
    if pick ~= cur or i % 9 == 0 then b7:reload(pick, 0.3); cur = pick end
    local len = 18 + 56 * t + math.random() * (12 + 36 * t)
    b7:stroke({{x, y}, {x + len, y + (math.random() - 0.5) * 0.4}}, {pressure = 0.07 + 0.04 * math.random()})
    n = n + 1
  end
end
print("lower sea ripples on painting", n)
b8 = brush("flat", 3)
n = 0
cur = nil
for i = 1, 30 do
  local y = 618 + (math.random() ^ 1.1) * 74
  local t = (y - 540) / 150
  local x = math.random() * 1000
  if LOWREG:at(x, y) > 0.5 then
    local pick = (math.random() < 0.5) and lilG or teal2
    if pick ~= cur or i % 10 == 0 then b8:reload(pick, 0.32); cur = pick end
    local len = 40 + math.random() * (30 + 40 * t)
    b8:stroke({{x, y}, {x + len, y + (math.random() - 0.5) * 0.5}}, {pressure = 0.12 + 0.05 * math.random()})
    n = n + 1
  end
end
print("near band on painting", n)

--@ chunk 234
wait(30 * 1440)
print("after 30 days", drying(800,60), drying(700,100), drying(566,480), drying(200,650), drying(646,500), drying(806,400), drying(120,360))

--@ chunk 235
wait(60 * 1440)
print("after 90 days", drying(800,60), drying(700,100), drying(566,480), drying(200,650), drying(646,500), drying(806,400), drying(120,360))

--@ chunk 236
print("mid sea right", drying(800,470), drying(900,500), drying(760,520), "mid left", drying(150,470), drying(300,500), "sea low", drying(200,600), "path", drying(646,500))

--@ chunk 237
mR = rect(690, 452, 310, 84) - PATHENV
lilR = pile{{"rose madder", 0.3}, {"ultramarine blue", 0.3}, {"lead white", 1.1}, turps=0.25, name="lilR"}
grR = pile{{"cerulean blue", 0.5}, {"ultramarine blue", 0.2}, {"lead white", 1.1}, turps=0.25, name="grR"}
tlR = pile{{"cerulean blue", 0.6}, {"raw umber", 0.15}, {"lead white", 1.0}, turps=0.2, name="tlR"}
pcR = pile{{"pale cadmium", 0.3}, {"rose madder", 0.3}, {"lead white", 1.2}, turps=0.25, name="pcR"}
bm = brush("flat", 3)
n = 0
cur = nil
for i = 1, 28 do
  local y = 452 + math.random() * 78
  local t = (y - 452) / 78
  local x = 690 + math.random() * 300
  if mR:at(x, y) > 0.5 then
    local pick
    local r = math.random()
    if r < 0.3 then pick = lilR elseif r < 0.6 then pick = grR elseif r < 0.85 then pick = tlR else pick = pcR end
    if pick ~= cur then bm:reload(pick, 0.3); cur = pick end
    local len = 14 + 30 * t + math.random() * (10 + 20 * t)
    bm:stroke({{x, y}, {x + len, y + (math.random() - 0.5) * 0.4}}, {pressure = 0.07 + 0.03 * math.random()})
    n = n + 1
  end
end
print("right-mid glints laid on painting", n, drying(800,470))

--@ chunk 238
print("headland painting", drying(120,340), drying(200,380), drying(300,410), drying(20,375), drying(330,415), "bank", drying(260,380), drying(380,380))

--@ chunk 239
litA = pile{{"burnt sienna", 0.8}, {"yellow ochre", 0.3}, {"ultramarine blue", 0.35}, {"rose madder", 0.15}, {"lead white", 0.9}, name="litA"}
shP = pile{{"ultramarine blue", 1}, {"burnt sienna", 0.5}, {"bone black", 0.4}, {"permanent alizarin", 0.3}, {"lead white", 0.15}, name="shP"}
slopeP = {{140,322},{160,326},{186,338},{214,352},{246,370},{280,388},{312,402},{336,412},{352,421}}
function dSlope(x, y)
  local best = 1e9
  for i = 1, #slopeP - 1 do
    local ax, ay = slopeP[i][1], slopeP[i][2]
    local bx, by = slopeP[i+1][1], slopeP[i+1][2]
    local dx, dy = bx - ax, by - ay
    local t = clamp(((x-ax)*dx + (y-ay)*dy) / (dx*dx + dy*dy), 0, 1)
    local px, py = ax + t*dx, ay + t*dy
    local d = ((x-px)^2 + (y-py)^2)^0.5
    if d < best then best = d end
  end
  return best
end
function litW(x, y)
  local near = 1 - clamp(dSlope(x, y) / 40, 0, 1)
  return clamp(near * clamp((x - 120) / 200, 0, 1), 0, 1)
end
ledgeM = poly({{270,404},{292,396},{318,398},{336,406},{352,414},{352,422},{270,422}}, true)
leftRock = poly({{0,380},{14,366},{34,362},{46,372},{30,386},{0,390}}, true)
MASS = HEADL + ledgeM + leftRock
work(MASS, {hand="body", coverage=1.6, fill=true, clip=true, load=1.0, angle=function(x,y) return 0.5 * clamp((x-80)/120, 0, 1) end, piles={
  {litA, litW},
  {shP, function(x,y) return 1 - litW(x,y) end}}})
print("graded headland laid on painting", litW(300,400), litW(200,350), litW(60,370), drying(200,380))

--@ chunk 240
wait(8640)
print("headland graded, day 6", drying(200,380), drying(300,410), drying(120,340), drying(330,415))

--@ chunk 241
wait(8640)
print("headland graded, day 12", drying(200,380), drying(300,410), drying(120,340), drying(330,415))

--@ chunk 242
mL = rect(20, 462, 420, 80)
pcL = pile{{"pale cadmium", 0.3}, {"rose madder", 0.3}, {"lead white", 1.2}, turps=0.25, name="pcL"}
gtL2 = pile{{"cerulean blue", 0.5}, {"ultramarine blue", 0.2}, {"lead white", 1.1}, turps=0.25, name="gtL2"}
bL = brush("flat", 3)
n = 0
cur = nil
for i = 1, 26 do
  local y = 462 + math.random() * 80
  local t = (y - 462) / 80
  local x = 20 + math.random() * 420
  if mL:at(x, y) > 0.5 then
    local pick
    if math.random() < 0.5 then pick = pcL else pick = gtL2 end
    if pick ~= cur then bL:reload(pick, 0.3); cur = pick end
    local len = 18 + 56 * t + math.random() * (12 + 36 * t)
    bL:stroke({{x, y}, {x + len, y + (math.random() - 0.5) * 0.4}}, {pressure = 0.07 + 0.03 * math.random()})
    n = n + 1
  end
end
print("left-mid glints laid on painting", n, drying(200,500))

--@ chunk 243
print("painting untouched check", drying(370,40), drying(800,60), drying(806,400))

--@ chunk 244
print("painting clock check (no marks)", drying(800,60), drying(806,400), drying(646,500))
