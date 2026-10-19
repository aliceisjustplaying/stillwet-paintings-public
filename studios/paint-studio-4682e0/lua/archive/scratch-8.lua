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
-- door cream base over the ground
work(rect(40, 40, 600, 300), {hand="body", tool={kind="filbert", width=10, lay=2.5}, piles={{skyP,1},{facP,1}}, coverage=2.5, fill=true, clip=rect(40,40,600,300), angle=1.57, length={15,40}})
-- a dark patch like the zombie arm
work(rect(300, 120, 120, 30), {hand="body", tool={kind="filbert", width=6}, pile=zombP, coverage=3, fill=true, clip=rect(300,120,120,30), angle=0, length={10,30}})
wait(14*24*60)
-- lace lines
local b = brush{kind="rigger", width=1.5, point=0.8}
b:load(laceP, 0.7)
for i = 1, 70 do
  local x = rand(60, 280); local y = rand(60, 320)
  b:stroke({{x, y}, {x + rand(-8, 8), y + rand(4, 12)}, {x + rand(-6, 10), y + rand(10, 20)}}, {pressure=0.6})
  if i % 10 == 0 then b:load(laceP, 0.7) end
end
wait(14*24*60)
print(drying(100,100))

--@ chunk 3
veilA = pile{{"lead white", 2}, {"raw umber", 0.5}, {"yellow ochre", 0.6}, {"burnt sienna", 0.2}, medium=0.6, name="veilA"}
veilB = pile{{"lead white", 2}, {"raw umber", 0.3}, {"raw sienna", 0.6}, {"burnt sienna", 0.25}, medium=0.75, name="veilB"}
local area = rect(45, 45, 590, 290) - rect(298, 118, 124, 34)
work(area, {hand="body", tool={kind="filbert", width=8, lay=2.5}, piles={{skyP,1},{facP,1.3}}, coverage=2.5, fill=true, clip=area, angle=1.57, length={12,30}})
local nz = noise{seed=11, period=40, octaves=3, kind="billow"}
local function cloud(cx, cy, rx, ry)
  return function(x, y)
    local dx, dy = (x - cx) / rx, (y - cy) / ry
    local e = math.exp(-(dx*dx + dy*dy) * 1.6)
    return e * (0.55 + 0.6 * nz:at01(x, y))
  end
end
local cA = cloud(170, 190, 140, 110)
local cB = cloud(500, 190, 140, 110)
local mA = rect(30, 50, 300, 290)
local mB = rect(330, 50, 300, 290)
stipple(mA, {pile=veilA, width=10, coverage=function(x,y) return 2.5*cA(x,y) end, feather=1, pressure={0.2,0.5}, dips={30,0.4,0}})
stipple(mB, {pile=veilB, width=10, coverage=function(x,y) return 2.5*cB(x,y) end, feather=1, pressure={0.2,0.5}, dips={30,0.4,0}})
blend(rect(40,45,595,290):blur(8), {angle=0.3})
blend(rect(40,45,595,290):blur(8), {angle=1.9})
print(drying(170,190))

--@ chunk 4
work(rect(40, 400, 600, 300), {hand="body", tool={kind="filbert", width=10, lay=2.5}, piles={{skyP,1},{facP,1}}, coverage=2.5, fill=true, clip=rect(40,400,600,300), angle=1.57, length={15,40}})
wait(10*24*60)
local arm1 = ribbon({{150, 520}, {220, 510}, {280, 500}}, {16, 13, 10})
local arm2 = ribbon({{400, 520}, {470, 510}, {530, 500}}, {16, 13, 10})
work(arm1 + arm2, {hand="detail", tool={kind="round", width=3}, pile=zombP, coverage=4, fill=true, clip=arm1 + arm2, angle=0, length={5,15}})
wait(10*24*60)
local area = rect(45, 405, 590, 290) - (arm1 + arm2)
work(area, {hand="body", tool={kind="filbert", width=8, lay=2.5}, piles={{skyP,1},{facP,1.3}}, coverage=2.5, fill=true, clip=area, angle=1.57, length={12,30}})
armT1 = arm1; armT2 = arm2

--@ chunk 5
local nz = noise{seed=12, period=40, octaves=3, kind="billow"}
local function cloud(cx, cy, rx, ry)
  return function(x, y)
    local dx, dy = (x - cx) / rx, (y - cy) / ry
    local e = math.exp(-(dx*dx + dy*dy) * 1.6)
    return e * (0.55 + 0.6 * nz:at01(x, y))
  end
end
local cA = cloud(200, 520, 120, 90)
local cB = cloud(470, 520, 120, 90)
stipple(rect(40, 405, 300, 290), {pile=veilA, width=10, coverage=function(x,y) return 3*cA(x,y) end, feather=1, pressure={0.2,0.5}, dips={30,0.4,0}})
stipple(rect(340, 405, 295, 290), {pile=veilA, width=10, coverage=function(x,y) return 3*cB(x,y) end, feather=1, pressure={0.2,0.5}, dips={30,0.4,0}})
local bl1 = rect(40, 405, 300, 290):blur(8) - armT1:grow(1.5)
local bl2 = rect(340, 405, 295, 290):blur(8)
blend(bl1, {angle=0.3}); blend(bl1, {angle=1.9})
blend(bl2, {angle=0.3}); blend(bl2, {angle=1.9})

--@ chunk 6
work(rect(660, 40, 320, 660), {hand="body", tool={kind="filbert", width=10, lay=2.5}, piles={{skyP,1},{facP,1.3}}, coverage=2.5, fill=true, clip=rect(660,40,320,660), angle=1.57, length={15,40}})
wait(10*24*60)
armT3 = ribbon({{700, 150}, {780, 140}, {860, 130}}, {16, 13, 10})
armT4 = ribbon({{700, 350}, {780, 340}, {860, 330}}, {16, 13, 10})
armT5 = ribbon({{700, 550}, {780, 540}, {860, 530}}, {16, 13, 10})
work(armT3 + armT4 + armT5, {hand="detail", tool={kind="round", width=3}, pile=zombP, coverage=4, fill=true, clip=armT3 + armT4 + armT5, angle=0, length={5,15}})
wait(10*24*60)
print(drying(780,140))

--@ chunk 7
wait(10*24*60)
print(drying(780,140), drying(780,340))
-- arm3: stipple restricted to the arm, more at the tip (left end x~700), then blend inside the arm only
local function tipw(x, y) return clamp((800 - x) / 100, 0, 1) end
stipple(armT3, {pile=veilA, width=6, coverage=function(x,y) return 2.5 * tipw(x,y) end, feather=1, pressure={0.2,0.5}, dips={30,0.4,0}, clip=armT3})
blend(armT3:shrink(0.5), {angle=0}); blend(armT3:shrink(0.5), {angle=0.2})
-- arm4: glaze of a thin veil
veilG = pile{{"lead white", 1}, {"yellow ochre", 0.5}, {"raw umber", 0.25}, {"burnt sienna", 0.1}, medium=0.8, name="veilG"}
work(rect(690, 320, 90, 45), {hand="glaze", pile=veilG, coverage=1})
-- arm5: scumble veilA
work(rect(690, 520, 90, 45), {hand="scumble", pile=veilA, coverage=0.8})

--@ chunk 8
handVeil1 = mix{{zombP, 1}, {veilA, 1}, name="hv1"}
handVeil2 = mix{{zombP, 1}, {veilA, 2.5}, name="hv2"}
local s1 = rect(700, 650, 40, 25); local s2 = rect(760, 650, 40, 25)
work(s1, {hand="detail", tool={kind="round", width=3}, pile=handVeil1, coverage=4, fill=true, clip=s1, angle=0, length={5,15}})
work(s2, {hand="detail", tool={kind="round", width=3}, pile=handVeil2, coverage=4, fill=true, clip=s2, angle=0, length={5,15}})
