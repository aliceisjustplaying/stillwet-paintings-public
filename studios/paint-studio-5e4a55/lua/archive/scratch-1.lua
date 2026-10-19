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
lw = pile{{"lead white",1}, medium=0.45, name="liquid_white"}
lc = pile{{"lead white",0.15},{"yellow ochre",0.05}, medium=0.85, name="liquid_clear"}
dark = pile{{"Prussian blue",1},{"red earth",2},{"raw umber",2}, name="dark"}
gold = pile{{"chrome yellow",2},{"yellow ochre",2},{"lead white",1}, name="gold"}
rust = pile{{"red earth",3},{"yellow ochre",1},{"vermilion",0.5}, name="rust"}
moss = pile{{"green earth",3},{"chrome yellow",1},{"yellow ochre",1}, name="moss"}
olive = pile{{"Prussian blue",0.3},{"chrome yellow",2},{"yellow ochre",2},{"raw umber",1}, name="olive"}
birch = pile{{"lead white",8},{"yellow ochre",0.1}, name="birch"}
bshadow = pile{{"lead white",4},{"smalt",1},{"raw umber",0.5}, name="birch_shadow"}
water = pile{{"lead white",6},{"cobalt blue",0.4}, name="water_white"}
pooldark = pile{{"Prussian blue",1},{"raw umber",2},{"green earth",1}, name="pool_dark"}
print(palette())

--@ chunk 3
-- under films
work(rect(30,30,300,700), {hand="broad", pile=lw, coverage=1.5, angle=0.1})
work(rect(350,30,300,700), {hand="broad", pile=lc, coverage=1.5, angle=0.1})
-- row A: dark patch in each column
for i,x0 in ipairs({30,350,670}) do
  work(rect(x0+20,50,260,180), {hand="body", pile=dark, coverage=2, angle=1.4})
end
print(drying(100,100), drying(500,100), drying(800,100))

--@ chunk 4
fb = brush{kind="flat", width=14, stiffness=0.7, lay=4}
for i,x0 in ipairs({30,350,670}) do
  fb:reload(birch, 1.0)
  fb:stroke({{x0+60,40},{x0+62,240}}, {pressure=0.5})
  fb:reload(birch, 1.0)
  fb:stroke({{x0+100,40},{x0+102,240}}, {pressure=0.2})
  -- knife
  local k = knife{width=18}
  k:load(birch, 1.0)
  k:lay({{x0+150,40},{x0+152,240}}, {pressure={0.3,0.3}})
  -- water pulls with soft round
  local wb = brush{kind="filbert", width=10, stiffness=0.4}
  wb:reload(water, 0.9)
  wb:stroke({{x0+200,50},{x0+205,240}}, {pressure=0.6})
  wb:reload(water, 0.6)
  wb:stroke({{x0+235,50},{x0+238,240}}, {pressure=0.25})
end

--@ chunk 5
glow = pile{{"lead white",5},{"chrome yellow",1},{"yellow ochre",1}, name="glow"}
deepwood = pile{{"red earth",2},{"raw umber",2},{"yellow ochre",1},{"Prussian blue",0.3}, name="deepwood"}
for i,x0 in ipairs({30,350,670}) do
  local m = rect(x0+10, 290, 280, 230)
  work(m, {hand="broad", piles={{glow, function(x,y) return 1 - (x-x0)/300 end},{deepwood, function(x,y) return (x-x0)/300 end}}, coverage=2, angle=0.2})
end
for i,x0 in ipairs({30,350,670}) do
  blend(rect(x0+10, 290, 280, 230), {angle=0.2})
end

--@ chunk 6
-- foliage trial A: stipple clusters on col 1
local m1 = ellipse(130, 400, 90, 70)
stipple(m1, {pile=rust, width=7, coverage=1.2, cluster={0.6, 20}, feather=0.5, drag={3, 1.2}})
stipple(ellipse(150, 380, 70, 50), {pile=gold, width=5, coverage=0.8, cluster={0.6, 15}, feather=0.5, drag={2, 1.2}})
-- foliage trial B: fan touches on col 2
local fan = brush{kind="fan", width=22}
for i=1,40 do
  if i % 8 == 1 then fan:reload(rust, 0.6) end
  local x, y = 500 + randn(0, 60), 400 + randn(0, 45)
  fan:touch(x, y, {pressure=0.5, drag={rand(-4,4), rand(2,8)}, angle=rand(-0.6,0.6)})
end
for i=1,25 do
  if i % 8 == 1 then fan:reload(gold, 0.6) end
  local x, y = 500 + randn(0, 50), 380 + randn(0, 35)
  fan:touch(x, y, {pressure=0.35, drag={rand(-4,4), rand(2,6)}, angle=rand(-0.6,0.6)})
end
-- foliage trial C: filbert dabs on col 3
local fl = brush("filbert", 8)
for i=1,60 do
  if i % 10 == 1 then fl:reload(i < 35 and rust or gold, 0.7) end
  local x, y = 820 + randn(0, 60), 400 + randn(0, 45)
  local a = rand(0, 6.28)
  fl:stroke({{x, y}, {x + 6*math.cos(a), y + 6*math.sin(a)}}, {pressure=rand(0.3,0.7)})
end

--@ chunk 7
-- pool trial, columns at y 570-770
for i,x0 in ipairs({30,350,670}) do
  local m = rect(x0+10, 570, 280, 200)
  work(m, {hand="broad", pile=pooldark, coverage=2, angle=0, clip=true})
end
-- vertical reflection pulls, col 1: filbert pulled straight down
local fb2 = brush{kind="flat", width=20, stiffness=0.5}
for i,x in ipairs({70, 110, 150, 200}) do
  fb2:reload(i%2==1 and gold or rust, 0.5)
  fb2:stroke({{x, 580}, {x, 700}}, {pressure={0.5, 0.1}, orient="across"})
end
-- col 2: same pulls then horizontal light passes with a clean flat
for i,x in ipairs({390, 430, 470, 520}) do
  fb2:reload(i%2==1 and gold or rust, 0.5)
  fb2:stroke({{x, 580}, {x, 700}}, {pressure={0.5, 0.1}, orient="across"})
end
fb2:wipe(0.95)
for j=0,8 do
  local y = 585 + j*20
  fb2:stroke({{365, y}, {640, y}}, {pressure=0.15, orient="across"})
end
-- col 3: pulls then work blend vertical
for i,x in ipairs({710, 750, 790, 840}) do
  fb2:reload(i%2==1 and gold or rust, 0.5)
  fb2:stroke({{x, 580}, {x, 700}}, {pressure={0.5, 0.1}, orient="across"})
end
blend(rect(690,575,270,190):soften(15), {angle=math.pi/2})

--@ chunk 8
rock = pile{{"raw umber",2},{"Prussian blue",0.5},{"red earth",1},{"bone black",0.5}, name="rock"}
-- knife rock slabs on col 1, row D
local k = knife{width=40}
for j=0,5 do
  k:load(rock, 1.0)
  local y = 810 + j*35
  k:lay({{50, y}, {150, y+8}, {300, y+3}}, {pressure={0.6,0.4}})
end
-- falls in col 2 over a dark rock body
work(rect(360, 800, 280, 260), {hand="body", pile=rock, coverage=2.5, angle=1.5, clip=true})
-- the lip: a curved glassy band
local wb = brush{kind="filbert", width=12, stiffness=0.4}
for i=0,9 do
  wb:reload(water, 0.8)
  local x = 420 + i*14 + rand(-3,3)
  wb:gesture({{x-6, 810, 0.7}, {x-2, 830, 0.8}, {x, 870, 0.6}, {x+rand(-4,4), 950, 0.4}, {x+rand(-6,6), 1010, 0.1}}, {wobble=2})
end
stipple(ellipse(495, 1020, 90, 25), {pile=water, width=8, coverage=1.5, cluster={0.5, 12}, feather=0.6})

--@ chunk 9
work(rect(680, 800, 290, 260), {hand="body", pile=rock, coverage=2.5, angle=1.5, clip=true})
fallgray = pile{{"lead white",3},{"cobalt blue",0.3},{"raw umber",0.3},{"yellow ochre",0.1}, name="fallgray"}
falls_m = poly({{760,815},{900,812},{915,900},{935,1020},{745,1020},{752,900}}, true)
work(falls_m, {hand="body", pile=fallgray, coverage=1.5, angle=math.pi/2, clip=true, length={40,90}})
-- dry streaks
local fl = brush{kind="flat", width=16, stiffness=0.6}
for i=1,22 do
  if i%3==1 then fl:reload(water, 0.35) end
  local x = rand(765, 910)
  local y0 = rand(812, 840)
  fl:stroke({{x, y0}, {x+rand(-3,3), y0+60}, {x+rand(-6,6), y0+rand(140,200)}}, {pressure={0.35, 0.05}, orient="across", ramps={0.05,0.6}})
end
blend(falls_m:soften(6), {angle=math.pi/2})
-- a few bright streaks
local rd = brush{kind="round", width=6, point=0.6}
for i=1,8 do
  rd:reload(birch, 0.7)
  local x = rand(770, 900)
  rd:gesture({{x, 818, 0.5}, {x+rand(-2,2), 880, 0.6}, {x+rand(-5,5), 980, 0.15}}, {wobble=2})
end
-- foam
work(ellipse(845, 1030, 110, 30), {hand="scumble", pile=water, coverage=0.8})
local fl2 = brush("filbert", 10)
for i=1,25 do
  if i%5==1 then fl2:reload(birch, 0.6) end
  local x, y = 845 + randn(0, 50), 1025 + randn(0, 10)
  fl2:touch(x, y, {pressure=rand(0.3,0.7), drag={rand(-8,8), rand(-3,1)}, twist=rand(-0.5,0.5)})
end
