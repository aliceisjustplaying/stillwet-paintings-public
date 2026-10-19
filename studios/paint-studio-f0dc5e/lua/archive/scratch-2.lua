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
sky_top = pile{{"Prussian blue", 1}, {"bone black", 0.12}, {"lead white", 1.6}, name="sky_top"}
sky_mid = pile{{"Prussian blue", 0.25}, {"lead white", 3}, {"vermilion", 0.04}, name="sky_mid"}
sky_glow = pile{{"lead white", 4}, {"vermilion", 0.5}, {"chrome yellow", 0.5}, name="sky_glow"}
sky_low = pile{{"lead white", 5}, {"chrome yellow", 0.5}, {"vermilion", 0.08}, name="sky_low"}
local function wtop(x,y) return clamp(1 - y/260, 0, 1)^1.2 end
local function wmid(x,y) return math.exp(-((y-250)/90)^2) end
local function wglow(x,y) return math.exp(-((y-370)/60)^2) * (1.2 - 0.6*x/1000) end
local function wlow(x,y) return clamp((y-380)/80, 0, 1) end
local sky = rect(0, 0, 1000, 500)
local ang = function(x,y) return 0.7 end
work(sky, {hand="broad", piles={{sky_top, wtop}, {sky_mid, wmid}, {sky_glow, wglow}, {sky_low, wlow}}, coverage=1.3, load=0.4, angle=0.7, length={70,140}})
work(sky, {hand="broad", piles={{sky_top, wtop}, {sky_mid, wmid}, {sky_glow, wglow}, {sky_low, wlow}}, coverage=1.3, load=0.4, angle=-0.7, length={70,140}})

--@ chunk 3
local sky = rect(0, 0, 1000, 520):soften(30)
blend(sky, {angle=0, clip=false})
blend(sky, {angle=0.15, clip=false})

--@ chunk 4
local water = rect(0, 470, 1000, 279)
local function wlow(x,y) return clamp(1-(y-480)/60,0,1) end
local function wglow(x,y) return math.exp(-((y-540)/50)^2) * (1.2 - 0.7*x/1000) end
local function wmid(x,y) return math.exp(-((y-610)/60)^2) end
local function wtop(x,y) return clamp((y-600)/120,0,1) end
work(water, {hand="broad", piles={{sky_top, wtop}, {sky_mid, wmid}, {sky_glow, wglow}, {sky_low, wlow}}, coverage=2.0, load=0.4, angle=0, length={100,220}, angle_jitter=0.05})
blend(water:soften(20), {angle=0, clip=false})

--@ chunk 5
ridge_far = {{0,350},{60,338},{110,322},{165,300},{215,296},{255,276},{300,252},{340,236},{375,210},{405,190},{430,172},{452,186},{478,208},{505,232},{530,258},{560,250},{590,236},{615,248},{645,272},{680,292},{725,312},{780,328},{840,344},{900,352},{960,362},{1000,366}}
local pts = {}
for i,p in ipairs(ridge_far) do pts[#pts+1] = {p[1], p[2]} end
pts[#pts+1] = {1000, 480}; pts[#pts+1] = {0, 480}
mtn_far = poly(pts):roughen(4, 30, 11)
mtn_shadow = pile{{"cobalt blue", 1}, {"red earth", 0.35}, {"Prussian blue", 0.1}, {"lead white", 1.4}, name="mtn_shadow"}
work(mtn_far, {hand="body", pile=mtn_shadow, coverage=2, load=0.6, clip=true, angle=function(x,y) return 0.6 end, length={30,70}})

--@ chunk 6
snow_lit = pile{{"lead white", 5}, {"vermilion", 0.25}, {"chrome yellow", 0.2}, blot=0.15, name="snow_lit"}
k = knife{width=40}
k:load(snow_lit, 0.6)
-- along the left ridge, down-left
k:lay({{428,176},{400,200},{370,225},{345,250}}, {pressure={0.15, 0.1}})
k:load(snow_lit, 0.4)
k:lay({{372,214},{345,245},{320,268},{295,292}}, {pressure={0.1, 0.05}})
k:load(snow_lit, 0.4)
k:lay({{300,255},{270,285},{240,310}}, {pressure={0.12, 0.05}})
k:load(snow_lit, 0.4)
k:lay({{586,240},{560,262},{535,290}}, {pressure={0.12, 0.05}})
print(k)

--@ chunk 7
-- A: knife, blade nearly along the path, small load, firm pressure
k2 = knife{width=30}
k2:load(snow_lit, 0.25)
k2:lay({{660,290},{690,315},{720,340}}, {pressure={0.6,0.4}, angle=0.75})
k2:load(snow_lit, 0.25)
k2:lay({{700,305},{730,330},{760,360}}, {pressure={0.3,0.2}, angle=0.75})
k2:load(snow_lit, 0.15)
k2:lay({{740,320},{770,345},{800,380}}, {pressure={0.9,0.7}, angle=0.75})
-- B: flat brush, blotted paint, low load, light pressure
fb = brush{kind="flat", width=12, stiffness=0.8}
fb:load(snow_lit, 0.25)
fb:stroke({{820,340},{850,370},{880,400}}, {pressure={0.25,0.1}})
fb:load(snow_lit, 0.15)
fb:stroke({{860,350},{890,380},{920,410}}, {pressure={0.15,0.05}})
fb:load(snow_lit, 0.35)
fb:stroke({{900,360},{930,390},{960,420}}, {pressure={0.4,0.2}, orient="along"})

--@ chunk 8
mtn_dark = pile{{"Prussian blue", 0.5}, {"bone black", 0.2}, {"red earth", 0.3}, {"lead white", 0.6}, name="mtn_dark"}
kd = knife{width=50}
-- lay a dark triangle in the water area by knife strokes going down from the ridge
local ridge = {{200,520},{260,580},{320,640},{380,700}}
for i=0,8 do
  kd:load(mtn_dark, 0.8)
  local x0 = 200 + i*25
  kd:lay({{x0+40,560+i*3},{x0-10,650},{x0-40,720}}, {pressure={0.4,0.5}})
end
for i=0,8 do
  kd:load(mtn_dark, 0.8)
  local x0 = 450 + i*25
  kd:lay({{x0+40,560+i*3},{x0-10,650},{x0-40,720}}, {pressure={0.4,0.5}})
end

--@ chunk 9
kh = knife{width=40}
local trials = {
  {load=0.3, p=0.1, ang=nil},
  {load=0.3, p=0.5, ang=nil},
  {load=0.3, p=0.9, ang=nil},
  {load=0.15, p=0.9, ang=nil},
  {load=0.3, p=0.9, ang=0.3},
  {load=0.6, p=0.95, ang=nil},
}
for i,t in ipairs(trials) do
  kh:wipe()
  kh:load(snow_lit, t.load)
  local x0 = 230 + (i-1)*75
  if i > 3 then x0 = x0 + 60 end
  kh:lay({{x0+20,585},{x0-5,620},{x0-30,660}}, {pressure={t.p, t.p}, angle=t.ang})
end

--@ chunk 10
local trials = {0.18, 0.25, 0.32, 0.4}
for i,p in ipairs(trials) do
  kh:wipe()
  kh:load(snow_lit, 0.4)
  local x0 = 260 + (i-1)*70
  kh:lay({{x0+15,665},{x0,690},{x0-15,715}}, {pressure={p, p}})
end

--@ chunk 11
tree_dark = pile{{"Prussian blue", 1}, {"raw umber", 1}, {"bone black", 0.3}, name="tree_dark"}
fan = brush{kind="fan", width=22}
-- trunk line / center
local cx, top, base = 870, 110, 470
local rb = brush{kind="round", width=3, point=0.8}
rb:load(tree_dark, 0.8)
rb:gesture({{cx, top, 0.1}, {cx+1, (top+base)/2, 0.5}, {cx, base, 0.8}})
-- branches: fan touches from top down, widening
fan:load(tree_dark, 0.8)
local n = 0
local y = top + 8
while y < base - 20 do
  local t = (y - top) / (base - top)
  local half = 6 + 55 * t
  for side = -1, 1, 2 do
    local x1 = cx + side * half * rand(0.7, 1.05)
    local y1 = y + half * 0.35
    fan:stroke({{cx + side*2, y}, {(cx+x1)/2, y + half*0.12}, {x1, y1}}, {pressure={0.5, 0.15}, orient="along"})
    n = n + 1
    if n % 6 == 0 then fan:load(tree_dark, 0.6) end
  end
  y = y + 6 + 10 * t
end

--@ chunk 12
local cx, top, base = 690, 110, 470
local rb = brush{kind="round", width=3, point=0.8}
rb:load(tree_dark, 0.8)
rb:gesture({{cx, top, 0.1}, {cx+1, (top+base)/2, 0.5}, {cx, base, 0.8}})
fan2 = brush{kind="fan", width=18}
fan2:load(tree_dark, 0.9)
local n = 0
local y = top + 4
while y < base - 10 do
  local t = (y - top) / (base - top)
  local half = 4 + 60 * t^0.9
  -- several touches across the tier, each dragged down and outward
  local k = math.max(1, math.floor(half / 9))
  for j = -k, k do
    local x = cx + j * (half / k) * rand(0.75, 1.0)
    local out = (j == 0) and 0 or (j > 0 and 1 or -1)
    fan2:touch(x, y + math.abs(x - cx) * 0.25, {pressure=rand(0.35, 0.7), drag={out * rand(4, 10), rand(6, 12)}, angle=rand(-0.25,0.25) + out*0.35})
    n = n + 1
    if n % 8 == 0 then fan2:load(tree_dark, 0.7) end
  end
  y = y + 5 + 9 * t
end
print(n)

--@ chunk 13
tree_dark2 = pile{{"Prussian blue", 0.6}, {"raw umber", 1}, {"bone black", 0.5}, name="tree_dark2"}
-- version: filbert branch strokes
local cx, top, base = 940, 130, 470
local fb6 = brush{kind="filbert", width=6, lay=1.5}
fb6:load(tree_dark2, 1.0)
local y = top
local n = 0
while y < base - 5 do
  local t = (y - top) / (base - top)
  local half = 3 + 48 * t
  for side = -1, 1, 2 do
    local L = half * rand(0.7, 1.1)
    local x0 = cx + side * rand(0, 3)
    local x1 = cx + side * L
    local y1 = y + L * rand(0.25, 0.45)
    local xm = cx + side * L * 0.55
    local ym = y + L * 0.32
    fb6:stroke({{x0, y}, {xm, ym}, {x1, y1 - L*0.04}}, {pressure={0.8, 0.25}})
    n = n + 1
    if n % 4 == 0 then fb6:load(tree_dark2, 0.9) end
  end
  y = y + 3 + 6 * t + rand(0, 3)
end
print(n)

--@ chunk 14
-- reflection trial at right side water: hand-drawn inverted ridge shape
local refl = poly({{650,482},{700,482},{760,486},{820,490},{880,494},{940,496},{1000,498},{1000,560},{960,556},{900,548},{850,540},{800,530},{760,518},{720,505},{680,494},{650,488}}):roughen(3, 25, 5)
work(refl, {hand="body", pile=mtn_shadow, coverage=1.5, load=0.5, clip=true, angle=math.pi/2, length={15,40}})
-- pull down
local pulldown = rect(640, 478, 360, 120)
blend(pulldown, {angle=math.pi/2})
print(drying(800,520))
