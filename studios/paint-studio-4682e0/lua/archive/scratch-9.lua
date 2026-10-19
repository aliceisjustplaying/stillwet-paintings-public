-- easel session "scratch": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box every
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
canvas{aspect=1.3333333333333333, ground={{apply="knife", pile={{"lead white", 1}}, texture=0.25, um=70}, {apply="brush", pile={{"lead white", 3}, {"yellow ochre", 1.2}, {"raw umber", 1}, {"red earth", 0.35}}, um=25}}, linen={16, 14}, seed=1873, size=700}

--@ chunk 2
skyP = pile{{"lead white", 8}, {"Naples yellow", 1}, {"lemon chrome", 0.25}, name="sky"}
facP = pile{{"lead white", 5}, {"Naples yellow", 1}, {"raw umber", 0.12}, {"ultramarine blue", 0.06}, name="facade"}
zombP = pile{{"bone black", 1}, {"raw umber", 1.2}, {"green earth", 1.2}, name="zomb"}
laceP = pile{{"yellow ochre", 1}, {"raw umber", 0.4}, {"lead white", 0.6}, {"burnt sienna",0.2}, name="lace"}
warmD = pile{{"raw umber", 2}, {"burnt sienna", 1.2}, {"bone black", 0.4}, turps=0.3, name="warmD"}
door = rect(100, 50, 300, 500)
work(rect(20, 50, 80, 500), {hand="body", tool={kind="filbert", width=8}, pile=warmD, coverage=2.5, fill=true, clip=rect(20,50,80,500), angle=1.57, length={15,40}})
work(door, {hand="body", tool={kind="filbert", width=10, lay=2.5}, piles={{skyP,1},{facP,1}}, coverage=2.5, fill=true, clip=door, angle=1.57, length={15,40}})
wait(12*24*60)
local b = brush{kind="rigger", width=1.5, point=0.8}
b:load(laceP, 0.7)
for i = 1, 90 do
  local x = rand(105, 220); local y = rand(60, 400)
  b:stroke({{x, y}, {x + rand(-8, 8), y + rand(4, 12)}, {x + rand(-6, 10), y + rand(10, 20)}}, {pressure=0.6})
  if i % 10 == 0 then b:load(laceP, 0.7) end
end
armS = ribbon({{230, 200}, {200, 195}, {170, 188}, {140, 184}}, {16, 13, 11, 9}) + ribbon({{142, 182}, {130, 177}}, {4, 1.5}) + ribbon({{141, 185}, {129, 185}}, {4, 1.5}) + ribbon({{142, 188}, {131, 193}}, {3.5, 1.5})
armS = armS:roughen(1, 6, 13)
work(armS, {hand="detail", tool={kind="round", width=3}, pile=zombP, coverage=4, fill=true, clip=armS, angle=0.15, length={4,12}})
wait(14*24*60)
print(drying(180,190), drying(150,300))

--@ chunk 3
armS2 = ribbon({{230, 440}, {200, 435}, {170, 428}, {140, 424}}, {16, 13, 11, 9}) + ribbon({{142, 422}, {130, 417}}, {4, 1.5}) + ribbon({{141, 425}, {129, 425}}, {4, 1.5}) + ribbon({{142, 428}, {131, 433}}, {3.5, 1.5})
armS2 = armS2:roughen(1, 6, 14)
local b = brush{kind="rigger", width=1.5, point=0.8}
b:load(laceP, 0.7)
for i = 1, 40 do
  local x = rand(105, 220); local y = rand(400, 520)
  b:stroke({{x, y}, {x + rand(-8, 8), y + rand(4, 12)}, {x + rand(-6, 10), y + rand(10, 20)}}, {pressure=0.6})
  if i % 10 == 0 then b:load(laceP, 0.7) end
end
work(armS2, {hand="detail", tool={kind="round", width=3}, pile=zombP, coverage=4, fill=true, clip=armS2, angle=0.15, length={4,12}})
wait(14*24*60)
print(drying(180,430))

--@ chunk 4
veilA = pile{{"lead white", 2}, {"raw umber", 0.5}, {"yellow ochre", 0.6}, {"burnt sienna", 0.2}, medium=0.6, name="veilA"}
local function tv(x, y) return 2.5 * (1 - smoothstep(135, 230, x)) end
local arms = armS + armS2
work(arms, {hand="detail", tool={kind="round", width=3}, piles={{zombP, 1}, {veilA, tv}}, coverage=4, fill=true, clip=arms, angle=0.15, length={4,12}})
local zone = (rect(100, 60, 170, 480)) - arms
work(zone, {hand="body", tool={kind="filbert", width=8, lay=2.5}, piles={{skyP,1},{facP,1.3}}, coverage=2.5, fill=true, clip=zone, angle=1.57, length={12,30}})
local nz = noise{seed=21, period=40, octaves=3, kind="billow"}
local function cloud(cx, cy)
  return function(x, y)
    local u, v = x - cx, y - cy
    local a = -0.6
    local along = u * math.cos(a) + v * math.sin(a)
    local across = -u * math.sin(a) + v * math.cos(a)
    local e = math.exp(-((along / 110)^2 + (across / 60)^2) * 1.6) * smoothstep(-40, 10, along + 30)
    return e * (0.55 + 0.6 * nz:at01(x, y))
  end
end
local c1 = cloud(120, 200); local c2 = cloud(120, 440)
stipple(rect(95, 60, 180, 240) - armS:grow(1), {pile=veilA, width=10, coverage=function(x,y) return 2.6*c1(x,y) end, feather=1, pressure={0.2,0.5}, dips={30,0.4,0}})
stipple(rect(95, 310, 180, 230), {pile=veilA, width=10, coverage=function(x,y) return 2.6*c2(x,y) end, feather=1, pressure={0.2,0.5}, dips={30,0.4,0}})
local bl1 = (rect(100, 60, 170, 240):blur(6)) - armS:grow(1.5)
blend(bl1, {angle=-0.6}); blend(bl1, {angle=1.0})
local bl2 = (rect(100, 310, 170, 230):blur(6))
blend(bl2, {angle=-0.6}); blend(bl2, {angle=1.0})

--@ chunk 5
local m = rect(400, 100, 100, 100)
work(m, {hand="body", tool={kind="filbert", width=8, lay=2.5}, pile=facP, coverage=2.5, fill=true, clip=m, angle=1.57, length={10, 26}})
local k = knife{width=8}
k:scrape({{450, 110}, {450, 190}}, {pressure=1, angle=0})
wait(1)
print(drying(450, 150))
