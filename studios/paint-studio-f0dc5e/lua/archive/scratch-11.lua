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
grass_mid = pile{{"yellow ochre", 1}, {"raw umber", 0.7}, {"red earth", 0.2}, {"green earth", 0.3}, name="grass_mid"}
grass_lit = pile{{"yellow ochre", 1}, {"lead white", 0.5}, {"vermilion", 0.1}, {"chrome yellow", 0.15}, blot=0.1, name="grass_lit"}
bank = poly({{0,560},{100,575},{220,600},{330,630},{420,660},{480,700},{500,749},{0,749}}, true):roughen(4, 25, 3)
work(bank, {hand="body", pile=land_dark, coverage=2.5, load=0.75, clip=true, fill=true, angle=0.3, length={20,50}})
-- warm mid-tone laid wet into the upper part of the bank, horizontal-ish
local upper = bank * mask(function(x,y) return 1 - smoothstep(600 + x*0.25, 690 + x*0.2, y) end)
work(upper, {hand="body", pile=grass_mid, coverage=1.2, load=0.5, clip=true, angle=-1.3, length={10,25}, pressure={0.3,0.6}})

--@ chunk 3
math.randomseed(12)
local rg = brush{kind="rigger", width=2.2, point=1}
local rg2 = brush{kind="round", width=3, point=0.9}
local n = 0
-- grass blades along the bank's top edge and scattered, dark and mid
local function top_y(x) return 560 + x*0.15 + (x > 300 and (x-300)*0.4 or 0) end
for i = 1, 260 do
  local x = rand(0, 470)
  local y0 = top_y(x) + rand(-4, 60) ^ 1
  if bank:at(x, y0) > 0.5 then
    local h = rand(14, 40)
    local lean = rand(-0.35, 0.2)
    local b = (rand(0,1) < 0.6) and rg or rg2
    local p = (rand(0,1) < 0.55) and grass_mid or land_dark
    if n % 2 == 0 then b:load(p, 0.7) end
    b:gesture({{x, y0, 0.7}, {x + lean*h*0.4, y0 - h*0.5, 0.4}, {x + lean*h, y0 - h, 0.0}})
    n = n + 1
  end
end
-- lit blades (warm, facing the glow), fewer, on the top edge
for i = 1, 90 do
  local x = rand(0, 420)
  local y0 = top_y(x) + rand(0, 25)
  if bank:at(x, y0) > 0.5 then
    local h = rand(12, 32)
    local lean = rand(-0.4, 0.1)
    if n % 2 == 0 then rg:wipe(0.7); rg:load(grass_lit, 0.6) end
    rg:gesture({{x, y0, 0.55}, {x + lean*h*0.4, y0 - h*0.5, 0.35}, {x + lean*h, y0 - h, 0.0}})
    n = n + 1
  end
end
print(n)

--@ chunk 4
grass_dusk = pile{{"raw umber", 1}, {"yellow ochre", 0.8}, {"cobalt blue", 0.2}, {"red earth", 0.15}, {"lead white", 0.15}, name="grass_dusk"}
grass_rim = pile{{"yellow ochre", 1}, {"lead white", 0.7}, {"vermilion", 0.12}, {"raw umber", 0.1}, blot=0.1, name="grass_rim"}
bank2 = poly({{520,600},{620,610},{730,630},{840,660},{930,700},{980,749},{520,749}}, true):roughen(4, 25, 5)
local function topy(x) return 600 + (x-520)*0.1 + math.max(0, x-700)*0.35 end
work(bank2, {hand="body", piles={{land_dark, function(x,y) return smoothstep(topy(x)+10, topy(x)+70, y) + 0.1 end}, {grass_dusk, function(x,y) return 1 - smoothstep(topy(x)+10, topy(x)+70, y) end}}, coverage=2.5, load=0.75, clip=true, fill=true, angle=-1.35, length={10,30}})
blend(bank2:shrink(3), {angle=-1.4, length={10,25}})
math.randomseed(13)
local rg = brush{kind="rigger", width=2.2, point=1}
local rg2 = brush{kind="round", width=3, point=0.9}
local n = 0
for i = 1, 300 do
  local x = rand(520, 960)
  local y0 = topy(x) + rand(-2, 1) + rand(0, 1)^2 * 100
  if bank2:at(x, y0) > 0.5 then
    local h = rand(10, 34) * (1 + (y0 - topy(x))/120)
    local lean = rand(-0.35, 0.2)
    local b = (rand(0,1) < 0.6) and rg or rg2
    local p = (rand(0,1) < 0.5) and grass_dusk or land_dark
    if n % 2 == 0 then b:load(p, 0.7) end
    b:gesture({{x, y0, 0.7}, {x + lean*h*0.4, y0 - h*0.5, 0.4}, {x + lean*h, y0 - h, 0.0}})
    n = n + 1
  end
end
for i = 1, 60 do
  local x = rand(520, 900)
  local y0 = topy(x) + rand(0, 20)
  if bank2:at(x, y0) > 0.5 then
    local h = rand(10, 28)
    local lean = rand(-0.45, 0.05)
    if n % 2 == 0 then rg:wipe(0.7); rg:load(grass_rim, 0.55) end
    rg:gesture({{x, y0, 0.5}, {x + lean*h*0.4, y0 - h*0.5, 0.3}, {x + lean*h, y0 - h, 0.0}})
    n = n + 1
  end
end
