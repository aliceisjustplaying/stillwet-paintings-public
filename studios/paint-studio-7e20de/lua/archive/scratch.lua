-- easel session "scratch": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box every
--@ engine 7
--@ width 4800

--@ chunk 1
canvas{aspect=1.5, ground={{apply="knife", pile={{"lead white", 8}, {"yellow ochre", 0.3}}, texture=0.25, um=110}, {apply="brush", pile={{"lead white", 3}, {"red earth", 1.2}, {"raw umber", 1.0}, {"yellow ochre", 0.6}}, um=22}}, linen={16, 14}, seed=4417, size=900}

--@ chunk 2
gm = pile{{"raw umber",1},{"green earth",0.5},{"bone black",0.35},{"ultramarine blue",0.15},{"lead white",0.12},{"yellow ochre",0.15}, name="gm"}
gd = pile{{"raw umber",1},{"bone black",0.6},{"ultramarine blue",0.3},{"green earth",0.3},{"lead white",0.04}, name="gd"}
mshB = pile{{"bone black",1},{"raw umber",0.6},{"ultramarine blue",0.1},{"Prussian blue",0.02}, name="mshB"}
local nz2 = noise{seed=1202, period=40, octaves=3, stretch={0, 3}}
local R = rect(0, 540, 420, 127)
work(R, {hand="body", tool={kind="filbert", width=5}, piles={
  {gm, function(x,y) return 1.0 + clamp(nz2(x,y),0,1)*0.3 end},
  {gd, function(x,y) return smoothstep(590, 667, y)*1.2 end}},
  coverage=3, fill=true, clip=R, length={8,18}, angle=0.02, pressure={0.4,0.7}, seed=101})
print(wait(20*24*60))

--@ chunk 3
trou2 = pile{{"bone black",1},{"ultramarine blue",0.35},{"raw umber",0.6}, name="trou2"}
boot2 = pile{{"bone black",1},{"raw umber",0.8},{"red earth",0.15}, name="boot2"}
boot_m = pile{{"raw umber",0.8},{"bone black",0.5},{"red earth",0.2},{"yellow ochre",0.15},{"lead white",0.12}, name="boot_m"}
boot_rim = pile{{"raw umber",0.5},{"lead white",0.45},{"Prussian blue",0.08},{"bone black",0.2},{"yellow ochre",0.12}, name="boot_rim"}
boot_lit = pile{{"raw umber",0.5},{"red earth",0.35},{"yellow ochre",0.4},{"orange vermilion",0.08},{"lead white",0.3}, name="boot_lit"}
BOOTF2 = {{266,590},{288,592},{294,600},{306,605},{320,608},{332,613},{334,618},{326,620},{290,621},{282,621},{282,626},{270,626},{268,610}}
BOOTR2 = {{138,590},{160,596},{166,603},{176,608},{186,612},{191,617},{186,620},{150,620},{140,621},{140,626},{128,626},{126,616},{130,604}}
LEGS = poly({{144.5,545},{189.5,545},{179.5,570},{172,585},{169,594},{138,594},{139.5,585},{142,570}}) + poly({{242,545},{279.5,545},{283,570},{288,585},{290.5,594},{266,594},{262.5,585},{255,570}})
work(LEGS, {hand="detail", tool={kind="filbert", width=4}, pile=trou2, coverage=3, fill=true, clip=LEGS, length={6,14}, angle=1.5, seed=201})
local bm = poly(BOOTR2, true) + poly(BOOTF2, true)
BOOTALL = bm
local function lit(x,y)
  local a = 0
  for _, d in ipairs({1, 2, 3}) do a = a + (1 - bm:at(x + 0.5*d, y - 0.85*d)) end
  return a/3
end
work(bm, {hand="detail", tool={kind="filbert", width=3}, piles={
    {boot2, 1},
    {boot_m, function(x,y) return clamp(lit(x,y)*1.5 - 0.2, 0, 1)*1.2 end},
    {boot_rim, function(x,y) return clamp(lit(x,y)*2 - 1.1, 0, 1)*1.0 end}},
  coverage=3.5, fill=true, clip=bm, length={3,8}, angle=0.12, seed=202})
print(wait(15*24*60))
work(BOOTALL, {hand="detail", tool={kind="filbert", width=3, lay=6}, pile=boot2, coverage=3, fill=true, clip=BOOTALL, length={3,8}, angle=0.12, seed=203})
print(wait(20*24*60))
local r = brush{kind="round", width=1.6, point=0.85}
r:load(boot_rim, 0.4)
r:gesture({{140,591.5,0.15},{152,594.5,0.4},{161,598.5,0.4},{171,605.5,0.35},{183,610.8,0.3},{189,614.5,0.1}}, {clip=BOOTALL})
r:load(boot_rim, 0.4)
r:gesture({{268,591.5,0.15},{282,592.8,0.4},{291,598,0.4},{304,603.8,0.35},{318,607.8,0.3},{329,612.6,0.1}}, {clip=BOOTALL})
print(wait(15*24*60))

--@ chunk 4
legdk = pile{{"bone black",1},{"raw umber",0.5},{"ultramarine blue",0.2}, name="legdk"}
spur_l = pile{{"lead white",0.6},{"bone black",0.18},{"Prussian blue",0.05},{"raw umber",0.12}, name="spur_l"}
spur_m = pile{{"lead white",0.25},{"bone black",0.4},{"Prussian blue",0.05},{"raw umber",0.3}, name="spur_m"}
-- heels: dark underslung blocks
HEELR = poly({{125.5,616.5},{142,617.5},{143.5,619},{140,627},{128.5,627},{126,622}})
HEELF = poly({{268,619.5},{283.5,619.5},{285,621},{281.5,627},{271,627},{268.5,624}})
local H = HEELR + HEELF
work(H, {hand="detail", tool={kind="filbert", width=2.4, lay=3}, pile=boot2, coverage=3, fill=true, clip=H, length={2,5}, angle=0.0, seed=301})
-- sole edge: a thin dark welt along the bottom from heel to toe
local s = brush{kind="round", width=1.6, point=0.6}
s:load(legdk, 0.6)
s:gesture({{142,620.5,0.5},{160,619.8,0.6},{180,619.3,0.5},{190,618.5,0.2}})
s:load(legdk, 0.6)
s:gesture({{285,621,0.5},{305,620.5,0.6},{322,620,0.5},{333,618.8,0.2}})
print(wait(3*24*60))

--@ chunk 5
local b = brush{kind="round", width=1.3, point=0.8}
b:load(spur_m, 0.5)
b:gesture({{143,615.6,0.3},{135,615.2,0.6},{127,615.6,0.6},{121,617.8,0.5},{118,619,0.3}})
-- rowel: a small dark wheel, glinting on top
local w = brush{kind="round", width=2.4, point=0.3}
w:load(spur_m, 0.5)
w:touch(115.8, 619.6, {pressure=0.7})
w:touch(115.8, 619.6, {pressure=0.7, twist=0.6})
local g = brush{kind="round", width=1.2, point=0.85}
g:load(spur_l, 0.45)
g:gesture({{114.5,618.3,0.2},{116.2,617.8,0.5},{117.6,618.4,0.2}})
g:load(spur_l, 0.35)
g:gesture({{124,616.2,0.15},{129,615.4,0.4},{136,615.1,0.2}})
print(wait(2*24*60))

--@ chunk 6
-- bigger spur on the front boot: heel band, shank, star rowel
local b = brush{kind="round", width=1.6, point=0.8}
b:load(spur_m, 0.55)
b:gesture({{285,618.4,0.3},{277,618.0,0.6},{269,618.3,0.65},{263,619.4,0.6},{258.5,620.4,0.4}})
local cx, cy, R = 254.5, 620.6, 4.6
local r = brush{kind="round", width=1.0, point=0.9}
for i = 0, 7 do
  local a = i * math.pi/4 + 0.2
  r:load(spur_m, 0.45)
  r:gesture({{cx + math.cos(a)*0.8, cy + math.sin(a)*0.8, 0.6}, {cx + math.cos(a)*R, cy + math.sin(a)*R, 0.05}})
end
local w = brush{kind="round", width=1.8, point=0.3}
w:load(spur_m, 0.5)
w:touch(cx, cy, {pressure=0.6})
-- moon glint on the upper spokes and the band
local g = brush{kind="round", width=1.0, point=0.9}
g:load(spur_l, 0.45)
g:gesture({{cx+0.3, cy-0.6, 0.4}, {cx+1.6, cy-3.6, 0.05}})
g:load(spur_l, 0.45)
g:gesture({{cx-0.4, cy-0.6, 0.4}, {cx-2.6, cy-3.0, 0.05}})
g:load(spur_l, 0.35)
g:gesture({{266,618.6,0.15},{271,617.8,0.4},{278,617.6,0.2}})
print(wait(2*24*60))
