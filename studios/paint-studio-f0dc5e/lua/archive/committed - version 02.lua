-- easel session "painting": a painting replayed chunk by chunk.
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
canvas{size=610, aspect=610/457, linen={17, 15}, seed=2417,
  ground={{pile={{"lead white", 6}, {"yellow ochre", 0.05}}, um=70, apply="knife", texture=0.25},
          {pile={{"lead white", 1}}, um=35, apply="roller"}}}
print(W, H)
print(table.concat(tubes(), ", "))

--@ chunk 2
lw = pile{{"lead white", 1}, medium=0.45, name="liquid_white"}
work(everywhere(), {hand="broad", pile=lw, coverage=1.5, load=0.5, angle=0, seed=101})
print(drying(500, 400))

--@ chunk 3
sky_top = pile{{"cobalt blue", 1}, {"Prussian blue", 0.3}, {"vermilion", 0.08}, {"lead white", 0.8}, name="sky_top"}
sky_mid = pile{{"lead white", 4}, {"cobalt blue", 0.45}, {"vermilion", 0.22}, name="sky_mid"}
sky_glow = pile{{"lead white", 4}, {"chrome yellow", 0.6}, {"vermilion", 0.35}, name="sky_glow"}
sky_low = pile{{"lead white", 5}, {"chrome yellow", 0.65}, {"vermilion", 0.06}, name="sky_low"}
-- distance from the glow, low left, just under the ridge
function glow_d(x, y) return math.sqrt(((x + 60)/900)^2 + ((y - 470)/430)^2) end
local function wtop(x,y) return clamp((glow_d(x,y) - 0.68)/0.35, 0, 1)^1.2 * 1.6 end
local function wmid(x,y) return math.exp(-((glow_d(x,y)-0.6)/0.2)^2) end
local function wglow(x,y) return math.exp(-((glow_d(x,y)-0.35)/0.16)^2) end
local function wlow(x,y) return clamp(1 - glow_d(x,y)/0.27, 0, 1) * 1.5 end
sky_piles = {{sky_top, wtop}, {sky_mid, wmid}, {sky_glow, wglow}, {sky_low, wlow}}
local sky = rect(0, 0, 1000, 485)
work(sky, {hand="broad", piles=sky_piles, coverage=1.4, load=0.4, angle=0.7, length={60,120}, seed=201})
work(sky, {hand="broad", piles=sky_piles, coverage=1.4, load=0.4, angle=-0.7, length={60,120}, seed=202})

--@ chunk 4
local s = rect(0, 0, 1000, 500):soften(20)
blend(s, {angle=0, clip=false, seed=211})
blend(s, {angle=0.15, clip=false, seed=212})
blend(s, {angle=-0.1, clip=false, seed=213})

--@ chunk 5
water_deep = pile{{"cobalt blue", 1}, {"Prussian blue", 0.4}, {"raw umber", 0.15}, {"lead white", 0.6}, name="water_deep"}
local water = rect(0, 466, 1000, 284)
-- mirrored geometry: a point at depth (y-470) below the waterline mirrors sky at 470-(y-470)
local function my(y) return 470 - (y - 470) * 1.1 end
local function wtop(x,y) return clamp((glow_d(x, my(y)) - 0.68)/0.35, 0, 1)^1.2 * 1.6 end
local function wmid(x,y) return math.exp(-((glow_d(x, my(y))-0.6)/0.2)^2) end
local function wglow(x,y) return math.exp(-((glow_d(x, my(y))-0.35)/0.16)^2) end
local function wlow(x,y) return clamp(1 - glow_d(x, my(y))/0.27, 0, 1) * 1.5 end
local function wdeep(x,y) return clamp((y - 560)/150, 0, 1) * 1.2 end
local P = {{sky_top, wtop}, {sky_mid, wmid}, {sky_glow, wglow}, {sky_low, wlow}, {water_deep, wdeep}}
work(water, {hand="broad", piles=P, coverage=2.0, load=0.45, angle=0, angle_jitter=0.04, length={120,240}, seed=301})
blend(water:soften(10), {angle=0, clip=false, seed=302})

--@ chunk 6
skyline = {{0,415},{50,410},{100,404},{150,400},{190,398},{230,392},{265,380},{300,366},{335,350},{365,332},{392,312},{420,288},{445,262},{468,238},{490,214},{508,196},{524,182},{537,172},{546,166},{554,170},{566,180},{580,194},{596,210},{614,228},{634,246},{652,258},{668,264},{682,262},{698,254},{714,246},{728,240},{742,244},{758,252},{778,262},{800,272},{830,282},{860,290},{900,298},{950,306},{1000,314}}
function skyline_y(x)
  for i = 1, #skyline - 1 do
    local a, b = skyline[i], skyline[i+1]
    if x >= a[1] and x <= b[1] then
      local t = (x - a[1]) / (b[1] - a[1])
      return a[2] + t * (b[2] - a[2])
    end
  end
  return skyline[#skyline][2]
end
local pts = {}
for i, p in ipairs(skyline) do pts[#pts+1] = {p[1], p[2]} end
pts[#pts+1] = {1000, 474}; pts[#pts+1] = {0, 474}
mtn = poly(pts):roughen(2.5, 18, 21)
mtn_dark = pile{{"cobalt blue", 1}, {"Prussian blue", 0.3}, {"red earth", 0.6}, {"bone black", 0.3}, {"lead white", 0.6}, name="mtn_dark"}
mtn_warm = pile{{"cobalt blue", 1}, {"red earth", 0.9}, {"bone black", 0.2}, {"lead white", 0.9}, name="mtn_warm"}
local function wwarm(x, y) return clamp(1 - x/600, 0, 1) * 0.8 end
local function wdark(x, y) return 0.6 + clamp(x/700, 0, 1) end
work(mtn, {hand="body", piles={{mtn_dark, wdark}, {mtn_warm, wwarm}}, coverage=2.4, load=0.7, clip=true, angle=function(x,y) if x < 546 then return 2.05 else return 1.15 end end, length={25,60}, seed=401})
print(mtn:area())

--@ chunk 7
snow_lit = pile{{"lead white", 5}, {"vermilion", 0.22}, {"chrome yellow", 0.22}, blot=0.15, name="snow_lit"}
snow_sh = pile{{"lead white", 3}, {"cobalt blue", 0.6}, {"red earth", 0.14}, {"Prussian blue", 0.04}, blot=0.15, name="snow_sh"}
math.randomseed(501)
ks = knife{width=22}
kb = knife{width=34}
function snow_stroke(k, p, x, dy, L, a, press, blade, load)
  local y = skyline_y(x) + dy
  k:wipe(); k:load(p, load or 0.4)
  local pts = {{x, y}, {x + math.cos(a)*L*0.5 + rand(-2,2), y + math.sin(a)*L*0.5}, {x + math.cos(a)*L, y + math.sin(a)*L}}
  k:lay(pts, {pressure=press, angle=blade})
end
-- main peak, lit west face: from the left ridge (x 450-546) down-left
for i = 1, 14 do
  local x = lerp(452, 544, (i-1)/13) + rand(-4, 4)
  local a = 2.0 + rand(-0.15, 0.12)
  local L = rand(35, 70) * (0.6 + 0.6 * (x - 440)/110)
  snow_stroke(ks, snow_lit, x, rand(1, 3), L, a, {rand(0.15, 0.22), rand(0.28, 0.45)}, a + rand(-0.6, 0.6))
end
-- lower left ridge (x 300-450), shorter
for i = 1, 9 do
  local x = lerp(300, 448, (i-1)/8) + rand(-5, 5)
  local a = 1.95 + rand(-0.15, 0.15)
  snow_stroke(ks, snow_lit, x, rand(1, 3), rand(20, 42), a, {rand(0.18, 0.25), rand(0.3, 0.5)}, a + rand(-0.6, 0.6))
end
-- secondary peak west face (x 670-728)
for i = 1, 6 do
  local x = lerp(672, 726, (i-1)/5) + rand(-3, 3)
  local a = 2.05 + rand(-0.15, 0.15)
  snow_stroke(ks, snow_lit, x, rand(1, 3), rand(22, 40), a, {rand(0.15, 0.22), rand(0.3, 0.45)}, a + rand(-0.6, 0.6))
end
-- shadow faces: east of main peak (x 548-650) down-right; east of secondary (x 730-860)
for i = 1, 11 do
  local x = lerp(549, 650, (i-1)/10) + rand(-4, 4)
  local a = 1.12 + rand(-0.15, 0.15)
  local L = rand(30, 60) * (1.2 - 0.6 * (x - 549)/100)
  snow_stroke(ks, snow_sh, x, rand(1, 3), L, a, {rand(0.2, 0.28), rand(0.32, 0.5)}, a + rand(-0.6, 0.6), 0.35)
end
for i = 1, 10 do
  local x = lerp(730, 900, (i-1)/9) + rand(-5, 5)
  local a = 1.05 + rand(-0.15, 0.15)
  snow_stroke(ks, snow_sh, x, rand(1, 3), rand(20, 45), a, {rand(0.2, 0.3), rand(0.35, 0.5)}, a + rand(-0.6, 0.6), 0.35)
end

--@ chunk 8
math.randomseed(502)
-- point on the central rib from the summit
local function rib(t) return 546 - 30*t, 166 + 150*t end
-- lit face: swaths starting near the west ridge or the rib, down the fall line
for i = 1, 16 do
  local t = rand(0.02, 0.75)
  -- a start point between the west ridge and the rib at height y
  local y0 = 170 + 120 * t
  local xr = select(1, rib((y0 - 166)/150))
  -- west ridge x at that height: invert skyline roughly
  local xw = 546 - (y0 - 166) * (101/96)
  local x0 = lerp(xw + 4, xr - 4, rand(0.1, 0.9))
  local a = 1.95 + rand(-0.15, 0.2)
  local L = rand(25, 55)
  kb:wipe(); kb:load(snow_lit, rand(0.35, 0.5))
  kb:lay({{x0, y0}, {x0 + math.cos(a)*L*0.5, y0 + math.sin(a)*L*0.5}, {x0 + math.cos(a)*L, y0 + math.sin(a)*L}}, {pressure={rand(0.15, 0.22), rand(0.3, 0.55)}, angle=a + rand(0.7, 1.1)})
end
-- shadow face: between rib and east ridge
for i = 1, 12 do
  local t = rand(0.02, 0.7)
  local y0 = 172 + 110 * t
  local xr = select(1, rib((y0 - 166)/150))
  local xe = 546 + (y0 - 166) * (122/98)
  local x0 = lerp(xr + 5, xe - 4, rand(0.1, 0.9))
  local a = 1.4 + rand(-0.2, 0.15)
  local L = rand(20, 45)
  kb:wipe(); kb:load(snow_sh, rand(0.3, 0.45))
  kb:lay({{x0, y0}, {x0 + math.cos(a)*L*0.5, y0 + math.sin(a)*L*0.5}, {x0 + math.cos(a)*L, y0 + math.sin(a)*L}}, {pressure={rand(0.2, 0.28), rand(0.35, 0.55)}, angle=a - rand(0.7, 1.1)})
end
-- secondary peak (728,240): lit face west small swaths, shadow shoulder east
for i = 1, 6 do
  local x0 = rand(690, 726); local y0 = skyline_y(x0) + rand(3, 12)
  local a = 1.95 + rand(-0.15, 0.2); local L = rand(18, 35)
  kb:wipe(); kb:load(snow_lit, 0.4)
  kb:lay({{x0, y0}, {x0 + math.cos(a)*L, y0 + math.sin(a)*L}}, {pressure={0.18, rand(0.35, 0.55)}, angle=a + rand(0.7, 1.1)})
end
for i = 1, 12 do
  local x0 = rand(735, 990); local y0 = skyline_y(x0) + rand(4, 20)
  local a = 1.25 + rand(-0.2, 0.2); local L = rand(18, 40)
  kb:wipe(); kb:load(snow_sh, 0.4)
  kb:lay({{x0, y0}, {x0 + math.cos(a)*L, y0 + math.sin(a)*L}}, {pressure={0.22, rand(0.4, 0.6)}, angle=a - rand(0.7, 1.1)})
end

--@ chunk 9
snow_sh2 = pile{{"lead white", 2}, {"cobalt blue", 0.8}, {"red earth", 0.22}, {"Prussian blue", 0.06}, blot=0.15, name="snow_sh2"}
math.randomseed(503)
kn = knife{width=14}
-- dark rock ribs pushing up into the snowcap: from below the snowline, upward along fall line
local ribs = {
  {{470,300},{478,270},{486,246}}, {{500,292},{506,262},{512,236}}, {{528,300},{532,262},{537,226}},
  {{436,290},{444,272},{452,256}}, {{562,286},{566,260},{570,236}}, {{595,282},{592,256},{588,232}},
  {{620,282},{614,262},{606,246}}, {{648,290},{642,272},{634,258}}, {{545,240},{546,215},{546,195}},
}
for i, r in ipairs(ribs) do
  kn:wipe(); kn:load(mtn_dark, 0.5)
  kn:lay(r, {pressure={rand(0.3, 0.45), rand(0.55, 0.75)}, angle=math.atan(r[3][2]-r[1][2], r[3][1]-r[1][1]) + rand(-0.25, 0.25)})
end
-- snow tongues down gullies, lit face
for i = 1, 9 do
  local x0 = rand(440, 540); local y0 = 250 + rand(0, 25) - (x0 - 440) * 0.2
  local a = 1.95 + rand(-0.15, 0.15); local L = rand(25, 55)
  kn:wipe(); kn:load(snow_lit, 0.35)
  kn:lay({{x0, y0}, {x0 + math.cos(a)*L*0.5, y0 + math.sin(a)*L*0.5}, {x0 + math.cos(a)*L, y0 + math.sin(a)*L}}, {pressure={0.2, 0.6}, angle=a + rand(-0.3, 0.3)})
end
-- darker shadow-snow on the east faces
for i = 1, 10 do
  local x0 = rand(555, 660); local y0 = rand(200, 270)
  if y0 > skyline_y(x0) + 4 then
    local a = 1.3 + rand(-0.2, 0.2); local L = rand(15, 35)
    kn:wipe(); kn:load(snow_sh2, 0.35)
    kn:lay({{x0, y0}, {x0 + math.cos(a)*L, y0 + math.sin(a)*L}}, {pressure={0.22, 0.45}, angle=a - rand(0.6, 1.0)})
  end
end
for i = 1, 8 do
  local x0 = rand(740, 980); local y0 = skyline_y(x0) + rand(8, 30)
  local a = 1.25 + rand(-0.2, 0.2); local L = rand(15, 30)
  kn:wipe(); kn:load(snow_sh2, 0.35)
  kn:lay({{x0, y0}, {x0 + math.cos(a)*L, y0 + math.sin(a)*L}}, {pressure={0.22, 0.5}, angle=a - rand(0.6, 1.0)})
end

--@ chunk 10
mist_warm = pile{{"lead white", 4}, {"chrome yellow", 0.25}, {"vermilion", 0.15}, {"cobalt blue", 0.15}, blot=0.2, name="mist_warm"}
mist_cool = pile{{"lead white", 4}, {"cobalt blue", 0.4}, {"vermilion", 0.12}, {"chrome yellow", 0.04}, blot=0.2, name="mist_cool"}
local band = rect(0, 395, 1000, 82)
local function base(y) return smoothstep(408, 472, y) end
local function ww(x) return clamp(1 - (x - 150)/450, 0, 1) end
stipple(band, {pile=mist_warm, width=10, coverage=function(x,y) return 2.6 * base(y) * ww(x) end, pressure={0.3, 0.6}, feather=0.5, clip=true, seed=601})
stipple(band, {pile=mist_cool, width=10, coverage=function(x,y) return 2.6 * base(y) * (1 - ww(x)) end, pressure={0.3, 0.6}, feather=0.5, clip=true, seed=602})
local soft = mask(function(x,y) return smoothstep(398, 430, y) * (1 - smoothstep(474, 479, y)) end)
blend(soft, {angle=0, seed=603})

--@ chunk 11
local soft = mask(function(x,y) return smoothstep(400, 432, y) * (1 - smoothstep(474, 479, y)) * smoothstep(600, 700, x) end)
blend(soft, {angle=0.12, seed=604})
blend(soft, {angle=-0.1, seed=605})

--@ chunk 12
refl_line = {{0,532},{60,540},{120,547},{190,553},{240,561},{280,576},{320,594},{360,613},{395,636},{425,662},{455,690},{480,717},{505,744},{522,760},{546,778},{572,766},{592,750},{615,724},{640,700},{664,688},{686,689},{706,696},{728,705},{750,699},{776,688},{802,678},{840,665},{880,655},{930,646},{1000,636}}
local pts = {{0, 477}, {1000, 477}}
for i = #refl_line, 1, -1 do pts[#pts+1] = {refl_line[i][1], refl_line[i][2]} end
refl_mtn = poly(pts):roughen(3, 30, 31)
refl_dark = mix{{mtn_dark, 0.7}, {water_deep, 0.3}, name="refl_dark"}
refl_warm = mix{{mtn_warm, 0.7}, {water_deep, 0.3}, name="refl_warm"}
local function wwarm(x, y) return clamp(1 - x/600, 0, 1) * 0.8 end
local function wdark(x, y) return 0.6 + clamp(x/700, 0, 1) end
work(refl_mtn, {hand="body", piles={{refl_dark, wdark}, {refl_warm, wwarm}}, coverage=2.0, load=0.6, clip=true, angle=math.pi/2, angle_jitter=0.05, length={25,60}, seed=701})

--@ chunk 13
palette{scrape={lw, snow_sh2}}
refl_snow_lit = mix{{snow_lit, 0.55}, {refl_warm, 0.45}, name="refl_snow_lit"}
refl_snow_sh = mix{{snow_sh, 0.5}, {refl_dark, 0.5}, name="refl_snow_sh"}
math.randomseed(702)
local fb = brush{kind="filbert", width=7}
for i = 1, 26 do
  local y = rand(650, 745)
  local xl = 425 + (y - 662) * (121/116)
  local xr = xl + 20 + (y - 650) * 0.7
  local x = rand(xl + 4, math.min(xr, 540))
  local a = math.pi/2 + 0.35 + rand(-0.1, 0.1)
  if i % 3 == 1 then fb:load(refl_snow_lit, 0.6) end
  fb:stroke({{x, y}, {x - math.cos(a)*rand(15,35), y - math.sin(a)*rand(15,35)}}, {pressure={0.55, 0.15}})
end
for i = 1, 16 do
  local y = rand(690, 748)
  local x = rand(550, 630)
  if y < 778 - (x - 546) * 0.95 - 4 then
    if i % 3 == 1 then fb:load(refl_snow_sh, 0.6) end
    fb:stroke({{x, y}, {x + 8, y - rand(15, 30)}}, {pressure={0.5, 0.15}})
  end
end
for i = 1, 22 do
  local x = rand(668, 990)
  local yedge = 705 - (x - 728) * 0.2
  if x < 728 then yedge = 690 + (x - 668) * 0.25 end
  local y = rand(yedge - 70, yedge - 6)
  if i % 3 == 1 then fb:load((x < 728) and refl_snow_lit or refl_snow_sh, 0.55) end
  fb:stroke({{x, y}, {x + rand(-4, 4), y - rand(12, 28)}}, {pressure={0.45, 0.15}})
end

--@ chunk 14
local wm = rect(0, 478, 1000, 272)
blend(wm, {angle=math.pi/2, seed=711})
blend(wm, {angle=math.pi/2 + 0.03, seed=712})

--@ chunk 15
for i = 0, 3 do
  local rr = rag()
  local m = rect(i * 250, 479, 250, 271)
  rr:dip(0.9)
  rr:wipe(m, {pressure=0.7, angle=0, passes=2, refold=0.45, seed=800 + i})
  rr:dip(0.9)
  rr:wipe(m, {pressure=0.7, angle=math.pi/2, passes=1, refold=0.45, seed=810 + i})
  print(i, rr)
end

--@ chunk 16
local water_all = rect(0, 479, 1000, 271)
local rr = rag()
rr:dip(0.9)
rr:wipe(water_all, {pressure=0.75, angle=math.pi/2, passes=1, refold=0.4, seed=821})
print(rr)
rr:refold(); rr:dip(0.9)
rr:wipe(rect(0, 479, 1000, 22), {pressure=0.75, angle=0, passes=2, refold=0.4, seed=822})
print(rr)
local r2 = rag()
r2:dip(0.9)
r2:wipe(water_all, {pressure=0.75, angle=0, passes=1, refold=0.4, seed=823})
print(r2)

--@ chunk 17
palette{scrape={refl_snow_lit, refl_snow_sh, refl_warm, refl_dark}}
far_tree = pile{{"cobalt blue", 1}, {"Prussian blue", 0.35}, {"bone black", 0.35}, {"red earth", 0.3}, {"lead white", 0.7}, name="far_tree"}
function far_spruce(b, x, base, h, w, p)
  b:load(p, 0.75)
  local lean = rand(-0.04, 0.04)
  b:stroke({{x + lean*h, base - h}, {x, base}}, {pressure={0.05, 0.7}})
  local y = base - h + 1.5
  local i = 0
  while y < base do
    local t = (y - (base - h)) / h
    local half = w * (0.12 + 0.88 * t^0.9) * rand(0.55, 1.25)
    local xx = x + lean * (base - y)
    local sag = half * rand(0.15, 0.4)
    if rand(0,1) < 0.85 then b:stroke({{xx - half, y + sag}, {xx - half*0.4, y + sag*0.3}, {xx, y - 0.5}}, {pressure={0.15, 0.35}}) end
    if rand(0,1) < 0.85 then b:stroke({{xx, y - 0.5}, {xx + half*0.4, y + sag*0.3}, {xx + half, y + sag}}, {pressure={0.35, 0.15}}) end
    y = y + rand(1.2, 3.0) * (0.7 + 0.6*t)
    i = i + 1
    if i % 4 == 0 then b:load(p, 0.6) end
  end
end
math.randomseed(901)
local b = brush{kind="round", width=2.6, point=0.5}
far_trees = {}
-- right-hand wooded shore, from x 400 to 1000, taller toward the right
local xs = uneven(46, 400, 995, 0.6, 0.6, 902)
for _, x in ipairs(xs) do
  local s = 0.7 + 0.6 * (x - 400) / 600
  local h = rand(9, 24) * s
  if rand(0,1) < 0.2 then h = h * 1.45 end
  local base = 477 + rand(-1, 2)
  far_spruce(b, x, base, h, h * rand(0.2, 0.3), far_tree)
  far_trees[#far_trees+1] = {x, base, h}
end
-- a small spit on the left with a few trees
local xs2 = uneven(9, 120, 250, 0.6, 0.7, 903)
for _, x in ipairs(xs2) do
  local h = rand(7, 16)
  local base = 477 + rand(-1, 1)
  far_spruce(b, x, base, h, h * rand(0.2, 0.3), far_tree)
  far_trees[#far_trees+1] = {x, base, h}
end
-- shore band under the trees
local shore = poly({{385,477},{430,473},{520,472},{620,471},{760,470},{900,469},{1000,468},{1000,481},{385,481}}):roughen(1.5, 10, 904)
local spit = poly({{105,478},{130,475},{180,474},{235,475},{262,478},{262,481},{105,481}}):roughen(1.2, 8, 905)
far_shore = shore + spit
work(far_shore, {hand="body", tool={kind="filbert", width=5}, pile=far_tree, coverage=2, load=0.6, angle=0, length={8,20}, clip=true, seed=906})

--@ chunk 18
math.randomseed(911)
local b = brush{kind="round", width=2.4, point=0.5}
-- denser clusters, smaller trees filling between, mostly right of 600
local xs = uneven(40, 560, 998, 0.7, 0.8, 912)
for _, x in ipairs(xs) do
  local s = 0.6 + 0.5 * (x - 560) / 440
  local h = rand(6, 15) * s
  local base = 474 + rand(-1, 2)
  far_spruce(b, x, base, h, h * rand(0.25, 0.35), far_tree)
  far_trees[#far_trees+1] = {x, base, h}
end
-- low brush mounds on the shore band
local mounds = brush{kind="filbert", width=6}
for i = 1, 30 do
  local x = rand(400, 1000)
  mounds:load(far_tree, 0.5)
  local y = 472 - rand(0, 3)
  mounds:stroke({{x - rand(6, 14), y + 3}, {x, y - rand(1, 3)}, {x + rand(6, 14), y + 3}}, {pressure={0.4, 0.4}})
end

--@ chunk 19
math.randomseed(921)
local b = brush{kind="round", width=2.0, point=0.6}
local xs = uneven(70, 395, 1000, 0.8, 0.5, 922)
for _, x in ipairs(xs) do
  local h = rand(4, 10)
  local base = 471 + rand(-1, 3)
  far_spruce(b, x, base, h, h * rand(0.25, 0.4), far_tree)
end

--@ chunk 20
print(drying(300, 600), drying(700, 650), drying(500, 520))

--@ chunk 21
local water = rect(0, 478, 1000, 272)
local function my(y) return 478 - (y - 478) * 1.0 end
local function wtop(x,y) return clamp((glow_d(x, my(y)) - 0.68)/0.35, 0, 1)^1.2 * 1.6 end
local function wmid(x,y) return math.exp(-((glow_d(x, my(y))-0.6)/0.2)^2) end
local function wglow(x,y) return math.exp(-((glow_d(x, my(y))-0.35)/0.16)^2) end
local function wlow(x,y) return clamp(1 - glow_d(x, my(y))/0.27, 0, 1) * 1.5 end
local function wdeep(x,y) return 0.15 + clamp((y - 600)/150, 0, 1) * 0.6 end
local P = {{sky_top, wtop}, {sky_mid, wmid}, {sky_glow, wglow}, {sky_low, wlow}, {water_deep, wdeep}}
work(water, {hand="broad", piles=P, coverage=2.2, load=0.5, angle=0, angle_jitter=0.03, length={120,240}, clip=true, seed=1001})
blend(water, {angle=0, seed=1002})

--@ chunk 22
refl_dark = mix{{mtn_dark, 0.65}, {water_deep, 0.2}, {sky_mid, 0.15}, name="refl_dark"}
refl_warm = mix{{mtn_warm, 0.6}, {water_deep, 0.2}, {sky_mid, 0.2}, name="refl_warm"}
local pts = {{0, 480}, {1000, 480}}
for i = #refl_line, 1, -1 do pts[#pts+1] = {refl_line[i][1], refl_line[i][2]} end
refl_mtn = poly(pts):roughen(2.5, 22, 1101)
local function wwarm(x, y) return clamp(1 - x/600, 0, 1) * 0.8 end
local function wdark(x, y) return 0.6 + clamp(x/700, 0, 1) end
work(refl_mtn, {hand="body", piles={{refl_dark, wdark}, {refl_warm, wwarm}}, coverage=2.2, load=0.65, clip=true, angle=math.pi/2, angle_jitter=0.04, length={25,60}, seed=1102})

--@ chunk 23
local m = refl_mtn:grow(6):soften(8)
blend(m, {angle=math.pi/2, length={10, 25}, seed=1111})

--@ chunk 24
palette{scrape={far_tree}}
refl_snow_lit = mix{{snow_lit, 0.6}, {refl_warm, 0.25}, {water_deep, 0.15}, name="refl_snow_lit"}
refl_snow_sh = mix{{snow_sh, 0.55}, {refl_dark, 0.3}, {water_deep, 0.15}, name="refl_snow_sh"}
-- hand-drawn shapes of the snowcap's reflection (main peak), lit (west) and shade (east)
refl_cap_lit = poly({{430,664},{452,657},{478,660},{500,655},{520,662},{534,660},{538,690},{540,720},{542,749},{508,749},{493,730},{478,716},{462,700},{448,686},{436,674}}, true):roughen(3, 14, 1201)
refl_cap_sh = poly({{536,658},{556,654},{578,662},{602,658},{624,668},{646,672},{660,684},{648,694},{632,706},{616,722},{600,740},{594,749},{544,749},{540,715}}, true):roughen(3, 14, 1202)
refl_cap2 = poly({{664,676},{690,650},{712,660},{736,648},{760,662},{790,650},{820,640},{850,628},{880,624},{915,612},{950,606},{1000,598},{1000,630},{950,640},{905,648},{870,655},{830,664},{800,676},{776,688},{752,698},{728,704},{706,696},{686,688}}, true):roughen(3, 14, 1203)
work(refl_cap_lit, {hand="body", pile=refl_snow_lit, coverage=1.0, load=0.5, clip=true, angle=math.pi/2 - 0.25, length={12,30}, seed=1204})
work(refl_cap_sh, {hand="body", pile=refl_snow_sh, coverage=0.9, load=0.5, clip=true, angle=math.pi/2 + 0.2, length={12,30}, seed=1205})
work(refl_cap2, {hand="body", piles={{refl_snow_sh, function(x,y) return x > 735 and 1 or 0.2 end}, {refl_snow_lit, function(x,y) return x <= 735 and 1 or 0 end}}, coverage=0.7, load=0.45, clip=true, angle=math.pi/2, length={8,22}, seed=1206})

--@ chunk 25
local caps = (refl_cap_lit + refl_cap_sh + refl_cap2):grow(4):soften(6)
blend(caps, {angle=math.pi/2, length={10, 22}, seed=1211})
blend(caps, {angle=math.pi/2 + 0.08, length={10, 22}, seed=1212})

--@ chunk 26
palette{scrape={refl_snow_lit, refl_snow_sh}}
mist_refl_c = mix{{mist_cool, 0.82}, {water_deep, 0.18}, name="mist_refl_c"}
mist_refl_w = mix{{mist_warm, 0.85}, {water_deep, 0.15}, name="mist_refl_w"}
local band = rect(0, 481, 1000, 85)
local function g(y) return 1 - smoothstep(486, 560, y) end
local function ww(x) return clamp(1 - (x - 150)/450, 0, 1) end
stipple(band, {pile=mist_refl_w, width=10, coverage=function(x,y) return 2.4 * g(y) * ww(x) end, pressure={0.3, 0.6}, feather=0.5, clip=true, seed=1301})
stipple(band, {pile=mist_refl_c, width=10, coverage=function(x,y) return 2.4 * g(y) * (1 - ww(x)) end, pressure={0.3, 0.6}, feather=0.5, clip=true, seed=1302})
local soft = mask(function(x,y) return smoothstep(479, 484, y) * (1 - smoothstep(540, 575, y)) end)
blend(soft, {angle=0, seed=1303})
blend(soft, {angle=0.08, seed=1304})

--@ chunk 27
palette{scrape={refl_warm, mist_refl_w}}
shore_refl = pile{{"cobalt blue", 1}, {"Prussian blue", 0.3}, {"bone black", 0.3}, {"red earth", 0.3}, {"lead white", 1.2}, name="shore_refl"}
math.randomseed(1401)
-- dark band right under the shore
local band = poly({{388,480},{430,481},{520,481},{620,481},{760,481},{900,481},{1000,481},{1000,489},{900,490},{760,488},{620,487},{520,488},{430,486},{388,483}}):roughen(1.2, 8, 1402)
local band2 = poly({{108,480},{180,480},{260,480},{258,484},{180,486},{110,483}}):roughen(1, 6, 1403)
work(band + band2, {hand="body", tool={kind="filbert", width=4}, pile=shore_refl, coverage=1.6, load=0.5, angle=0, length={8,20}, clip=true, seed=1404})
-- inverted tree reflections: soft vertical strokes
local b = brush{kind="round", width=2.4, point=0.4}
local n = 0
for _, t in ipairs(far_trees) do
  local x, base, h = t[1], t[2], t[3]
  if h > 8 and rand(0,1) < 0.8 then
    if n % 4 == 0 then b:load(shore_refl, 0.5) end
    local L = h * rand(0.5, 0.8)
    b:stroke({{x, 482}, {x + rand(-0.5, 0.5), 482 + L}}, {pressure={0.55, 0.05}})
    n = n + 1
  end
end
print(n)

--@ chunk 28
local soft = mask(function(x,y) return smoothstep(480, 483, y) * (1 - smoothstep(505, 520, y)) * smoothstep(95, 120, x) end)
blend(soft, {angle=math.pi/2, length={6, 16}, seed=1411})
blend(soft, {angle=0, length={20, 50}, pressure={0.1, 0.25}, seed=1412})

--@ chunk 29
palette{scrape={refl_dark, shore_refl}}
tree_dark = pile{{"Prussian blue", 0.6}, {"raw umber", 1}, {"bone black", 0.5}, name="tree_dark"}
land_dark = pile{{"raw umber", 1}, {"Prussian blue", 0.25}, {"bone black", 0.3}, {"red earth", 0.25}, {"lead white", 0.15}, name="land_dark"}
right_shore = {{628,749},{660,738},{700,726},{745,716},{790,707},{840,699},{900,692},{955,687},{1000,684}}
local pts = {}
for _, p in ipairs(right_shore) do pts[#pts+1] = {p[1], p[2]} end
pts[#pts+1] = {1000, 749}
right_land = poly(pts):roughen(2.5, 20, 1501)
work(right_land, {hand="body", pile=land_dark, coverage=2.2, load=0.7, clip=true, angle=0.1, length={20,50}, seed=1502})

--@ chunk 30
function big_spruce(cx, top, base, halfw, pile_, seed, opts)
  opts = opts or {}
  math.randomseed(seed)
  local lean = opts.lean or 0
  local fw = opts.fw or 16
  local f = brush{kind="fan", width=fw, lay=2.5}
  local fs = brush{kind="fan", width=fw*0.55, lay=2}
  local wob = noise{seed=seed, period=90, octaves=2}
  local env = noise{seed=seed + 7, period=opts.envp or 70, octaves=2}
  local function xc(y) return cx + lean * (base - y) + 2.5*wob(cx, y) end
  local tw = opts.trunk or 6
  local lead = brush{kind="round", width=tw, point=0.7}
  lead:load(pile_, 1.0)
  lead:gesture({{xc(top), top, 0.03}, {xc(top + (base-top)*0.25), top + (base-top)*0.25, 0.35}, {xc(base - (base-top)*0.3), base - (base-top)*0.3, 0.8}, {xc(base), base, 1.0}})
  f:load(pile_, 1.0); fs:load(pile_, 1.0)
  local y = top + 3
  local n = 0
  while y < base - (opts.skirt or 0) do
    local t = (y - top) / (base - top)
    local half = halfw * (0.04 + 0.96 * t^0.85) * (0.82 + 0.4 * env(0, y))
    local b = (t < 0.12) and fs or f
    local skip = (t > 0.3 and rand(0,1) < (opts.skip or 0.08))
    if not skip then
      for side = -1, 1, 2 do
        if rand(0,1) > (opts.gap or 0.1) then
          local L = half * rand(0.65, 1.05)
          if rand(0,1) < 0.1 then L = L * rand(1.15, 1.35) end
          local x0 = xc(y)
          local droop = L * (0.12 + 0.35 * t) * rand(0.7, 1.3)
          local lift = L * rand(-0.05, 0.14)
          b:stroke({{x0, y}, {x0 + side*L*0.45, y + droop*0.65}, {x0 + side*L*0.85, y + droop}, {x0 + side*L, y + droop - lift}}, {pressure={rand(0.6, 0.9), 0.05}, orient="across", ramps={0.05, 0.6}})
          n = n + 1
          if t > 0.15 and rand(0,1) < 0.75 then
            local L2 = L * rand(0.35, 0.7)
            local yy = y + rand(3, 7) * (0.5 + t)
            b:stroke({{x0, yy}, {x0 + side*L2*0.6, yy + droop*0.6}, {x0 + side*L2, yy + droop*0.9}}, {pressure={0.75, 0.1}, orient="across"})
            n = n + 1
          end
          if n % 3 == 0 then f:load(pile_, 0.85); fs:load(pile_, 0.8) end
        end
      end
    end
    y = y + (2.5 + 11 * t) * rand(0.6, 1.4)
  end
  return n
end
-- small trees at the tip of the point, back to front
print(big_spruce(700, 560, 728, 22, tree_dark, 1601, {fw=8, trunk=2.5}))
print(big_spruce(726, 470, 722, 32, tree_dark, 1602, {fw=10, trunk=3}))
print(big_spruce(672, 625, 735, 16, tree_dark, 1603, {fw=7, trunk=2}))
print(big_spruce(762, 380, 716, 42, tree_dark, 1604, {fw=12, trunk=4}))

--@ chunk 31
print(big_spruce(818, 290, 708, 50, tree_dark, 1611, {fw=13, trunk=4}))
print(big_spruce(985, 80, 690, 66, tree_dark, 1612, {fw=15, trunk=5}))
print(big_spruce(902, -40, 700, 88, tree_dark, 1613, {fw=17, trunk=7}))

--@ chunk 32
print(drying(300, 100), drying(700, 60), drying(150, 300), drying(500, 350))

--@ chunk 33
cloud_pink = pile{{"lead white", 4}, {"vermilion", 0.35}, {"chrome yellow", 0.15}, {"cobalt blue", 0.05}, blot=0.1, name="cloud_pink"}
cloud_body = pile{{"lead white", 3}, {"cobalt blue", 0.55}, {"vermilion", 0.15}, {"red earth", 0.08}, name="cloud_body"}
math.randomseed(1701)
local fb = brush{kind="filbert", width=10}
local fb2 = brush{kind="filbert", width=6}
local safe = rect(0, 0, 850, 265):soften(15)
-- three loose bands of wisps
local bands = {{y=95, x0=120, x1=640, n=5}, {y=150, x0=40, x1=560, n=6}, {y=200, x0=360, x1=820, n=4}, {y=60, x0=420, x1=820, n=3}}
for _, bd in ipairs(bands) do
  for i = 1, bd.n do
    local y = bd.y + rand(-14, 14)
    local x0 = rand(bd.x0, bd.x0 + (bd.x1 - bd.x0) * 0.5)
    local L = rand(90, 260)
    local x1 = math.min(bd.x1, x0 + L)
    local tilt = (x1 - x0) * rand(-0.02, 0.03)
    local b = (rand(0,1) < 0.5) and fb or fb2
    b:load(cloud_body, 0.45)
    b:stroke({{x0, y}, {(x0+x1)/2, y - rand(1, 5)}, {x1, y + tilt}}, {pressure={0.12, 0.35}, ramps={0.35, 0.35}, clip=safe})
    -- the lit underside, warmer toward the glow (left)
    local pinkness = clamp(1.1 - x0 / 800, 0.15, 1)
    if rand(0,1) < pinkness + 0.2 then
      b:load(cloud_pink, 0.45 * pinkness + 0.1)
      b:stroke({{x0 + rand(5, 20), y + 4}, {(x0+x1)/2, y + 2}, {x1 - rand(5, 25), y + tilt + 5}}, {pressure={0.1, 0.3}, ramps={0.35, 0.4}, clip=safe})
    end
  end
end
blend(rect(20, 30, 820, 225):soften(15), {angle=0, pressure={0.15, 0.3}, seed=1702})

--@ chunk 34
summit_halo = poly({{462,268},{478,232},{498,196},{520,160},{546,132},{572,152},{600,184},{628,218},{652,248},{666,268}}, true):soften(5)
local r = rag{width=40}
r:dip(0.9)
r:wipe(summit_halo, {pressure=0.75, angle=0, passes=2, refold=0.4, seed=1801})
r:refold(); r:dip(0.9)
r:wipe(summit_halo, {pressure=0.75, angle=math.pi/2, passes=1, refold=0.4, seed=1802})
print(r)

--@ chunk 35
palette{scrape={mist_refl_c, mist_warm}}
sky_patch = pile{{"cobalt blue", 1}, {"Prussian blue", 0.3}, {"vermilion", 0.08}, {"lead white", 1.0}, name="sky_patch"}
local region = summit_halo:grow(3) - mtn:shrink(3)
work(region, {hand="body", tool={kind="filbert", width=7}, pile=sky_patch, coverage=2.4, load=0.65, clip=true, angle=0.15, length={15,40}, seed=1811})
local ring = summit_halo:grow(16):soften(12) - mtn:grow(2)
blend(ring, {angle=0.1, pressure={0.15, 0.35}, length={20, 50}, seed=1812})

--@ chunk 36
local top = mtn * summit_halo:grow(5)
local function wwarm(x, y) return clamp(1 - x/600, 0, 1) * 0.8 end
local function wdark(x, y) return 0.6 + clamp(x/700, 0, 1) end
work(top, {hand="body", tool={kind="filbert", width=7}, piles={{mtn_dark, wdark}, {mtn_warm, wwarm}}, coverage=2.6, load=0.75, clip=true, angle=function(x,y) if x < 546 then return 2.05 else return 1.15 end end, length={15,40}, seed=1821})

--@ chunk 37
math.randomseed(1831)
-- west (lit) ridge, narrow knife, from the summit down-left
for i = 1, 16 do
  local x = lerp(470, 545, (i-1)/15) + rand(-3, 3)
  local a = 2.0 + rand(-0.15, 0.12)
  local L = rand(40, 75) * (0.7 + 0.5 * (x - 460)/90)
  snow_stroke(ks, snow_lit, x, rand(1, 3), L, a, {rand(0.15, 0.22), rand(0.28, 0.45)}, a + rand(-0.6, 0.6))
end
-- broad lit swaths between the west ridge and the central rib
local function rib(t) return 546 - 30*t, 166 + 150*t end
for i = 1, 16 do
  local t = rand(0.02, 0.8)
  local y0 = 170 + 115 * t
  local xr = select(1, rib((y0 - 166)/150))
  local xw = 546 - (y0 - 166) * (101/96)
  local x0 = lerp(xw + 4, xr - 4, rand(0.1, 0.9))
  local a = 1.95 + rand(-0.15, 0.2)
  local L = rand(28, 60)
  kb:wipe(); kb:load(snow_lit, rand(0.35, 0.5))
  kb:lay({{x0, y0}, {x0 + math.cos(a)*L*0.5, y0 + math.sin(a)*L*0.5}, {x0 + math.cos(a)*L, y0 + math.sin(a)*L}}, {pressure={rand(0.15, 0.22), rand(0.3, 0.55)}, angle=a + rand(0.7, 1.1)})
end
-- east (shadow) face
for i = 1, 12 do
  local x = lerp(549, 655, (i-1)/11) + rand(-4, 4)
  local a = 1.12 + rand(-0.15, 0.15)
  local L = rand(35, 65) * (1.2 - 0.5 * (x - 549)/100)
  snow_stroke(ks, snow_sh, x, rand(1, 3), L, a, {rand(0.2, 0.28), rand(0.32, 0.5)}, a + rand(-0.6, 0.6), 0.35)
end
for i = 1, 12 do
  local t = rand(0.02, 0.75)
  local y0 = 172 + 110 * t
  local xr = select(1, rib((y0 - 166)/150))
  local xe = 546 + (y0 - 166) * (122/98)
  local x0 = lerp(xr + 5, xe - 4, rand(0.1, 0.9))
  local a = 1.4 + rand(-0.2, 0.15)
  local L = rand(24, 50)
  kb:wipe(); kb:load(snow_sh, rand(0.3, 0.45))
  kb:lay({{x0, y0}, {x0 + math.cos(a)*L*0.5, y0 + math.sin(a)*L*0.5}, {x0 + math.cos(a)*L, y0 + math.sin(a)*L}}, {pressure={rand(0.2, 0.28), rand(0.35, 0.55)}, angle=a - rand(0.7, 1.1)})
end

--@ chunk 38
math.randomseed(1841)
local ribs = {
  {{470,300},{478,272},{487,248}}, {{500,292},{506,262},{513,232}}, {{524,286},{530,250},{537,214}},
  {{562,290},{566,262},{570,232}}, {{592,284},{589,258},{584,234}}, {{618,282},{612,262},{604,244}},
  {{644,288},{638,272},{630,258}}, {{546,250},{546,225},{546,200}}, {{556,232},{554,208},{551,186}},
}
for i, r in ipairs(ribs) do
  kn:wipe(); kn:load(mtn_dark, 0.5)
  kn:lay(r, {pressure={rand(0.3, 0.45), rand(0.55, 0.75)}, angle=math.atan(r[3][2]-r[1][2], r[3][1]-r[1][1]) + rand(-0.25, 0.25)})
end
-- a few short dark breaks on the east face (rock showing through the shadowed snow)
for i = 1, 8 do
  local x0 = rand(560, 640); local y0 = rand(200, 270)
  if y0 > skyline_y(x0) + 8 then
    local a = 1.15 + rand(-0.2, 0.2); local L = rand(10, 24)
    kn:wipe(); kn:load(mtn_dark, 0.4)
    kn:lay({{x0, y0}, {x0 + math.cos(a)*L, y0 + math.sin(a)*L}}, {pressure={0.4, 0.65}, angle=a + rand(-0.3, 0.3)})
  end
end
-- snow tongues back down the lit gullies
for i = 1, 8 do
  local x0 = rand(450, 535); local y0 = 248 + rand(0, 25) - (x0 - 450) * 0.25
  local a = 1.95 + rand(-0.15, 0.15); local L = rand(22, 50)
  kn:wipe(); kn:load(snow_lit, 0.35)
  kn:lay({{x0, y0}, {x0 + math.cos(a)*L*0.5, y0 + math.sin(a)*L*0.5}, {x0 + math.cos(a)*L, y0 + math.sin(a)*L}}, {pressure={0.2, 0.6}, angle=a + rand(-0.3, 0.3)})
end

--@ chunk 39
math.randomseed(1851)
local nomtn = -(mtn:grow(2))
local fb = brush{kind="filbert", width=9}
local fb2 = brush{kind="filbert", width=5}
-- wisps passing behind the summit, continuing the band at y~200 on both sides
local wisps = {
  {{392,212},{450,204},{520,198},{600,196},{680,201},{770,206}},
  {{430,176},{500,168},{580,163},{650,166},{720,172}},
  {{470,238},{540,232},{610,229},{690,233}},
  {{520,142},{590,136},{660,138},{740,146}},
}
for i, w in ipairs(wisps) do
  local b = (i % 2 == 0) and fb2 or fb
  b:load(cloud_body, 0.45)
  b:stroke(w, {pressure={0.15, 0.35}, ramps={0.35, 0.35}, clip=nomtn})
  b:load(cloud_pink, 0.3)
  local w2 = {}
  for j, p in ipairs(w) do w2[j] = {p[1] + 8, p[2] + 4} end
  b:stroke(w2, {pressure={0.1, 0.28}, ramps={0.4, 0.4}, clip=nomtn})
end
local ring = (rect(380, 120, 400, 140):soften(20)) * nomtn
blend(ring, {angle=0.02, pressure={0.15, 0.3}, length={30, 70}, seed=1852})

--@ chunk 40
palette{scrape={sky_patch, cloud_body, cloud_pink}}
print(big_spruce(862, 190, 712, 70, tree_dark, 1901, {fw=15, trunk=5}))
print(big_spruce(948, 330, 700, 55, tree_dark, 1902, {fw=13, trunk=4}))
print(big_spruce(790, 500, 714, 30, tree_dark, 1903, {fw=10, trunk=3}))

--@ chunk 41
bush_dark = pile{{"Prussian blue", 0.5}, {"raw umber", 1}, {"bone black", 0.3}, {"yellow ochre", 0.2}, name="bush_dark"}
math.randomseed(2001)
local fan = brush{kind="fan", width=16, lay=2}
local fan2 = brush{kind="fan", width=10, lay=2}
-- bushes: corner push-ups, dense at the base, ragged at the top
local n = 0
local function bush(cx, cy, rw, rh)
  for i = 1, math.floor(rw * rh / 25) do
    local u = rand(-1, 1)
    local x = cx + u * rw
    local topy = cy - rh * math.sqrt(math.max(0, 1 - u*u)) * rand(0.7, 1.05)
    local y = rand(topy, cy + 4)
    local b = (rand(0,1) < 0.6) and fan or fan2
    if n % 3 == 0 then fan:load(bush_dark, 0.8); fan2:load(bush_dark, 0.8) end
    b:touch(x, y, {pressure=rand(0.35, 0.7), drag={rand(-4, 4), -rand(4, 10)}, angle=rand(-0.5, 0.5)})
    n = n + 1
  end
end
bush(650, 742, 28, 18)
bush(700, 734, 40, 26)
bush(760, 726, 36, 22)
bush(835, 716, 48, 30)
bush(910, 706, 50, 26)
bush(975, 700, 40, 32)
print(n)

--@ chunk 42
palette{scrape={sky_glow}}
grass_dusk = pile{{"raw umber", 1}, {"yellow ochre", 0.75}, {"cobalt blue", 0.25}, {"red earth", 0.15}, {"lead white", 0.12}, name="grass_dusk"}
left_bank_line = {{-5,652},{30,656},{70,662},{110,668},{150,676},{190,686},{230,696},{270,706},{305,716},{340,727},{375,738},{405,749}}
local pts = {}
for _, p in ipairs(left_bank_line) do pts[#pts+1] = {p[1], p[2]} end
pts[#pts+1] = {405, 760}; pts[#pts+1] = {-5, 760}
left_bank = poly(pts, true):roughen(3, 22, 2101)
function lb_top(x)
  for i = 1, #left_bank_line - 1 do
    local a, b = left_bank_line[i], left_bank_line[i+1]
    if x >= a[1] and x <= b[1] then return a[2] + (x - a[1]) / (b[1] - a[1]) * (b[2] - a[2]) end
  end
  return 749
end
work(left_bank, {hand="body", piles={{land_dark, function(x,y) return smoothstep(lb_top(x)+8, lb_top(x)+50, y) + 0.12 end}, {grass_dusk, function(x,y) return 1 - smoothstep(lb_top(x)+8, lb_top(x)+50, y) end}}, coverage=2.5, load=0.75, clip=true, fill=true, angle=-1.35, length={10,30}, seed=2102})
blend(left_bank:shrink(3), {angle=-1.4, length={10,25}, seed=2103})

--@ chunk 43
rock_dark = pile{{"raw umber", 0.6}, {"cobalt blue", 0.6}, {"bone black", 0.3}, {"red earth", 0.2}, {"lead white", 0.5}, name="rock_dark"}
rock_lit = pile{{"lead white", 2}, {"yellow ochre", 0.5}, {"vermilion", 0.12}, {"cobalt blue", 0.25}, {"raw umber", 0.2}, blot=0.15, name="rock_lit"}
boulder1 = poly({{232,706},{240,688},{258,676},{282,672},{304,678},{318,692},{324,710},{318,724},{290,728},{256,726}}, true):roughen(2, 12, 2201)
boulder2 = poly({{326,724},{332,712},{346,706},{362,710},{370,722},{366,734},{340,736}}, true):roughen(1.5, 10, 2202)
boulder3 = poly({{120,676},{128,664},{146,658},{164,662},{172,674},{166,686},{136,688}}, true):roughen(1.5, 10, 2203)
local rocks = boulder1 + boulder2 + boulder3
work(rocks, {hand="body", tool={kind="filbert", width=8}, pile=rock_dark, coverage=2.5, load=0.7, clip=true, fill=true, angle=0.6, length={10,25}, seed=2204})
-- lit facets top-left with a small knife
math.randomseed(2205)
local kr = knife{width=16}
local facets = {
  {{246,690},{262,680},{282,676}}, {{240,700},{252,690},{268,684}}, {{284,676},{298,680},{306,688}},
  {{334,716},{344,710},{354,710}}, {{130,670},{142,662},{156,661}},
}
for _, f in ipairs(facets) do
  kr:wipe(); kr:load(rock_lit, 0.35)
  kr:lay(f, {pressure={0.2, 0.35}})
end

--@ chunk 44
local rocks = (boulder1 + boulder2 + boulder3):grow(1.5)
local r = rag{width=30}
r:dip(0.9)
r:wipe(rocks, {pressure=0.8, angle=0.3, passes=2, refold=0.35, seed=2301})
r:refold(); r:dip(0.9)
r:wipe(rocks, {pressure=0.8, angle=1.6, passes=2, refold=0.35, seed=2302})
print(r)

--@ chunk 45
palette{scrape={rock_dark, rock_lit}}
rock_sh = pile{{"raw umber", 1}, {"cobalt blue", 0.5}, {"bone black", 0.3}, {"lead white", 0.15}, name="rock_sh"}
rock_top = pile{{"lead white", 1}, {"cobalt blue", 0.3}, {"raw umber", 0.35}, {"vermilion", 0.04}, blot=0.15, name="rock_top"}
boulder1 = poly({{226,712},{230,694},{244,680},{262,670},{288,667},{310,673},{324,686},{332,704},{330,722},{312,731},{270,733},{240,728}}):roughen(1.5, 10, 2311)
boulder2 = poly({{322,730},{326,716},{338,705},{356,703},{370,712},{374,726},{366,737},{336,739}}):roughen(1.2, 8, 2312)
boulder3 = poly({{114,682},{118,668},{132,657},{150,654},{168,659},{176,671},{172,688},{140,692}}):roughen(1.2, 8, 2313)
rocks_m = boulder1 + boulder2 + boulder3
work(rocks_m, {hand="body", tool={kind="filbert", width=6}, pile=rock_sh, coverage=3.2, load=0.85, clip=true, fill=true, angle=0.5, length={8,20}, seed=2314})

--@ chunk 46
rock_warm = pile{{"lead white", 1}, {"yellow ochre", 0.4}, {"vermilion", 0.1}, {"raw umber", 0.35}, {"cobalt blue", 0.1}, blot=0.15, name="rock_warm"}
local fb = brush{kind="filbert", width=6}
local fs = brush{kind="filbert", width=4}
-- top planes (cool, from the sky) as short strokes following the top contour, inside the rock
local tops = {
  {{246,680},{262,672},{286,669},{306,674}}, {{240,690},{256,680},{276,676}}, {{292,676},{310,680},{320,690}},
  {{340,708},{354,705},{366,712}}, {{130,662},{148,657},{164,661}}, {{124,670},{136,663}},
}
for i, t in ipairs(tops) do
  fb:load(rock_top, 0.45)
  fb:stroke(t, {pressure={0.35, 0.2}, clip=rocks_m:shrink(1.5)})
end
-- warm left faces, catching the afterglow
local lefts = {
  {{232,696},{236,710},{240,722}}, {{238,686},{234,698}}, {{328,718},{326,728}}, {{120,670},{118,680}},
}
for i, t in ipairs(lefts) do
  fs:load(rock_warm, 0.45)
  fs:stroke(t, {pressure={0.4, 0.2}, clip=rocks_m:shrink(1.2)})
end
blend(rocks_m:shrink(2), {angle=1.2, pressure={0.1, 0.2}, length={6, 14}, seed=2321})

--@ chunk 47
math.randomseed(2331)
local kr = knife{width=12}
local spots = {{252,684,0.3},{270,678,0.1},{294,682,0.2},{312,692,0.5},{246,700,1.2},{140,664,0.2},{156,666,0.4},{350,712,0.3},{280,690,0.3}}
for _, s in ipairs(spots) do
  kr:wipe(); kr:load(rock_top, 0.3)
  local x, y, a = s[1], s[2], s[3]
  kr:lay({{x, y}, {x + 10*math.cos(a), y + 10*math.sin(a)}}, {pressure={0.45, 0.55}, angle=a + 1.2})
end
-- a few dark cracks
local rr = brush{kind="round", width=1.6, point=0.9}
rr:load(rock_sh, 0.7)
rr:gesture({{276,672,0.1},{280,690,0.5},{276,712,0.3},{280,728,0.0}})
rr:load(rock_sh, 0.6)
rr:gesture({{150,657,0.1},{146,672,0.4},{150,688,0.0}})

--@ chunk 48
palette{scrape={rock_warm, sky_low}}
grass_rim = pile{{"yellow ochre", 1}, {"lead white", 0.7}, {"vermilion", 0.12}, {"raw umber", 0.15}, blot=0.1, name="grass_rim"}
math.randomseed(2401)
local rg = brush{kind="rigger", width=2.2, point=1}
local rg2 = brush{kind="round", width=3, point=0.9}
local n = 0
local function blade(b, x, y0, h, lean)
  b:gesture({{x, y0, 0.7}, {x + lean*h*0.4, y0 - h*0.5, 0.4}, {x + lean*h, y0 - h, 0.0}})
end
for i = 1, 420 do
  local x = rand(-5, 410)
  local depth = rand(0, 1)^2 * 90
  local y0 = lb_top(x) + rand(-2, 2) + depth
  if left_bank:at(x, y0) > 0.4 then
    local h = rand(9, 30) * (1 + depth/90)
    local lean = rand(-0.35, 0.2)
    local b = (rand(0,1) < 0.6) and rg or rg2
    local p = (rand(0,1) < 0.5) and grass_dusk or land_dark
    if n % 2 == 0 then b:load(p, 0.7) end
    blade(b, x, y0, h, lean)
    n = n + 1
  end
end
local bases = {{228,330,729},{322,372,737},{114,176,689}}
for _, bs in ipairs(bases) do
  for i = 1, 40 do
    local x = rand(bs[1] - 5, bs[2] + 5)
    local y0 = bs[3] + rand(-2, 12)
    local h = rand(8, 22)
    local b = (rand(0,1) < 0.6) and rg or rg2
    local p = (rand(0,1) < 0.6) and grass_dusk or land_dark
    if n % 2 == 0 then b:load(p, 0.7) end
    blade(b, x, y0, h, rand(-0.4, 0.3))
    n = n + 1
  end
end
for i = 1, 70 do
  local x = rand(-5, 380)
  local y0 = lb_top(x) + rand(0, 18)
  if left_bank:at(x, y0) > 0.4 and rocks_m:at(x, y0 - 5) < 0.5 then
    local h = rand(9, 24)
    if n % 2 == 0 then rg:wipe(0.7); rg:load(grass_rim, 0.5) end
    blade(rg, x, y0, h, rand(-0.45, 0.05))
    n = n + 1
  end
end
print(n)

--@ chunk 49
print(drying(50, 50), drying(300, 600), drying(900, 300), drying(546, 200), drying(200, 720))

--@ chunk 50
palette{scrape={rock_sh, rock_top, mtn_warm}}
tree_hi_cool = pile{{"Prussian blue", 0.3}, {"raw umber", 0.5}, {"lead white", 1.0}, {"cobalt blue", 0.3}, {"yellow ochre", 0.3}, blot=0.15, name="tree_hi_cool"}
tree_hi_dim = pile{{"Prussian blue", 0.3}, {"raw umber", 0.6}, {"bone black", 0.1}, {"lead white", 0.7}, {"cobalt blue", 0.3}, {"yellow ochre", 0.35}, blot=0.15, name="tree_hi_dim"}
-- sparse branch pass that remembers where its branches are
function spruce_branches(cx, top, base, halfw, pile_, seed, opts)
  opts = opts or {}
  math.randomseed(seed)
  local fw = opts.fw or 16
  local f = brush{kind="fan", width=fw, lay=2.5}
  local fs = brush{kind="fan", width=fw*0.55, lay=2}
  local wob = noise{seed=seed, period=90, octaves=2}
  local env = noise{seed=seed + 7, period=70, octaves=2}
  local function xc(y) return cx + 2.5*wob(cx, y) end
  f:load(pile_, 1.0); fs:load(pile_, 1.0)
  local y = top + 3
  local n = 0
  local br = {}
  while y < base - (opts.skirt or 0) do
    local t = (y - top) / (base - top)
    local half = halfw * (0.04 + 0.96 * t^0.85) * (0.82 + 0.4 * env(0, y))
    local b = (t < 0.12) and fs or f
    for side = -1, 1, 2 do
      if rand(0,1) > (opts.gap or 0.55) then
        local L = half * rand(0.6, 1.0)
        local x0 = xc(y)
        local droop = L * (0.12 + 0.35 * t) * rand(0.7, 1.3)
        local lift = L * rand(-0.05, 0.14)
        b:stroke({{x0, y}, {x0 + side*L*0.45, y + droop*0.65}, {x0 + side*L*0.85, y + droop}, {x0 + side*L, y + droop - lift}}, {pressure={rand(0.6, 0.9), 0.05}, orient="across", ramps={0.05, 0.6}})
        br[#br+1] = {x0, y, side, L, droop, lift, t}
        n = n + 1
        if n % 3 == 0 then f:load(pile_, 0.85); fs:load(pile_, 0.8) end
      end
    end
    y = y + (3 + 13 * t) * rand(0.6, 1.4)
  end
  return br
end
function tree_highlights2(br, p, opts)
  opts = opts or {}
  local f = brush{kind="fan", width=opts.fw or 7, lay=1.4}
  local n = 0
  for i, b in ipairs(br) do
    local x0, y, side, L, droop, lift, t = table.unpack(b)
    local want = (side == -1) and (opts.left or 0.7) or (opts.right or 0.1)
    if opts.tmax and t > opts.tmax then want = 0 end
    if opts.tmin and t < opts.tmin then want = 0 end
    if rand(0,1) < want then
      local k = (L > 30) and math.floor(rand(1, 2.99)) or 1
      for j = 1, k do
        if n % 2 == 0 then f:wipe(0.6); f:load(p, opts.load or 0.4) end
        local u0 = rand(0.3, 0.7)
        local u1 = math.min(0.95, u0 + rand(0.15, 0.3))
        local xa, ya = x0 + side*L*u0, y + droop*u0*0.8 - 1.5
        local xb, yb = x0 + side*L*u1, y + droop*u1*0.9 - lift*u1 - 1.5
        f:stroke({{xa, ya}, {xb, yb}}, {pressure={opts.p0 or 0.32, 0.08}, orient="across"})
        n = n + 1
      end
    end
  end
  return n
end
TB = {}
TB[1] = spruce_branches(902, -40, 700, 80, tree_dark, 3001, {fw=16})
TB[2] = spruce_branches(985, 80, 690, 60, tree_dark, 3002, {fw=14})
TB[3] = spruce_branches(862, 190, 712, 64, tree_dark, 3003, {fw=14})
TB[4] = spruce_branches(948, 330, 700, 50, tree_dark, 3004, {fw=12})
TB[5] = spruce_branches(818, 290, 708, 46, tree_dark, 3005, {fw=12})
TB[6] = spruce_branches(762, 380, 716, 38, tree_dark, 3006, {fw=11})
TB[7] = spruce_branches(726, 470, 722, 29, tree_dark, 3007, {fw=9})
TB[8] = spruce_branches(790, 500, 714, 27, tree_dark, 3008, {fw=9})
local tot = 0
for i = 1, 8 do tot = tot + #TB[i] end
print(tot)

--@ chunk 51
math.randomseed(3101)
local n = 0
-- upper parts catch the cool sky; lower parts dim
for i = 1, 8 do
  local fw = (i <= 3) and 7 or 6
  n = n + tree_highlights2(TB[i], tree_hi_cool, {left=0.55, right=0.15, fw=fw, tmax=0.55, load=0.4})
  n = n + tree_highlights2(TB[i], tree_hi_dim, {left=0.5, right=0.1, fw=fw, tmin=0.4, load=0.35})
end
print(n)

--@ chunk 52
function cover_branches(br, p, fw)
  local f = brush{kind="fan", width=fw, lay=2.2}
  local n = 0
  for i, b in ipairs(br) do
    local x0, y, side, L, droop, lift = table.unpack(b)
    if n % 3 == 0 then f:reload(p, 0.85) end
    local function pt(u) return {x0 + side*L*u, y + droop*u*0.85 - lift*u*u} end
    f:stroke({pt(0.2), pt(0.5), pt(0.8), pt(1.0)}, {pressure={0.75, 0.15}, orient="across", ramps={0.05, 0.5}})
    n = n + 1
  end
  return n
end
local fws = {16, 14, 14, 12, 12, 11, 9, 9}
local n = 0
for i = 1, 8 do n = n + cover_branches(TB[i], tree_dark, fws[i]) end
print(n)

--@ chunk 53
tree_sky = pile{{"Prussian blue", 0.25}, {"raw umber", 0.5}, {"cobalt blue", 0.6}, {"lead white", 0.7}, {"yellow ochre", 0.12}, blot=0.15, name="tree_sky"}
function tree_lights(br, p, opts)
  opts = opts or {}
  local f = brush{kind="fan", width=opts.fw or 8, lay=1.5}
  local n = 0
  for i, b in ipairs(br) do
    local x0, y, side, L, droop, lift, t = table.unpack(b)
    t = t or 0.5
    local want = (side == -1) and (opts.left or 0.6) or (opts.right or 0.2)
    if opts.tmax and t > opts.tmax then want = want * 0.3 end
    if rand(0,1) < want then
      if n % 2 == 0 then f:wipe(0.7); f:load(p, opts.load or 0.45) end
      local function pt(u) return {x0 + side*L*u, y + droop*u*0.85 - lift*u*u - 1.5} end
      local u0 = rand(0.25, 0.5)
      f:stroke({pt(u0), pt((u0 + 0.95)/2), pt(0.95)}, {pressure={opts.p0 or 0.4, 0.08}, orient="across", ramps={0.15, 0.5}})
      n = n + 1
    end
  end
  return n
end
math.randomseed(3201)
local fws = {10, 9, 9, 8, 8, 7, 6, 6}
local n = 0
for i = 1, 8 do n = n + tree_lights(TB[i], tree_sky, {fw=fws[i], p0=0.35, left=0.6, right=0.2, tmax=0.75}) end
print(n)

--@ chunk 54
palette{scrape={tree_hi_cool, tree_hi_dim}}
local fws = {16, 14, 14, 12, 12, 11, 9, 9}
local n = 0
for i = 1, 8 do n = n + cover_branches(TB[i], tree_dark, fws[i]) end
print(n)

--@ chunk 55
palette{scrape={tree_sky}}
tree_mid2 = pile{{"Prussian blue", 0.4}, {"raw umber", 0.8}, {"bone black", 0.25}, {"cobalt blue", 0.5}, {"lead white", 0.35}, blot=0.1, name="tree_mid2"}
function tree_planes(br, p, opts)
  opts = opts or {}
  local f = brush{kind="fan", width=opts.fw or 12, lay=1.6}
  local n = 0
  for i, b in ipairs(br) do
    local x0, y, side, L, droop, lift, t = table.unpack(b)
    local want = (side == -1) and (opts.left or 0.55) or (opts.right or 0.25)
    if rand(0,1) < want then
      if n % 2 == 0 then f:wipe(0.5); f:load(p, opts.load or 0.5) end
      local function pt(u) return {x0 + side*L*u, y + droop*u*0.85 - lift*u*u - 2} end
      local u0 = rand(0.1, 0.35)
      f:stroke({pt(u0), pt(0.55), pt(0.8), pt(1.0)}, {pressure={opts.p0 or 0.5, 0.1}, orient="across", ramps={0.2, 0.5}})
      n = n + 1
    end
  end
  return n
end
math.randomseed(3301)
local fws = {13, 11, 11, 10, 10, 9, 7, 7}
local n = 0
for i = 1, 8 do n = n + tree_planes(TB[i], tree_mid2, {fw=fws[i], p0=0.42, left=0.5, right=0.15}) end
print(n)

--@ chunk 56
function break_branches(br, p, fw, seed)
  math.randomseed(seed)
  local f = brush{kind="fan", width=fw, lay=2.0}
  local n = 0
  for i, b in ipairs(br) do
    local x0, y, side, L, droop, lift = table.unpack(b)
    if n % 3 == 0 then f:reload(p, 0.75) end
    local dj = rand(0.75, 1.3)
    local dy = rand(-2.5, 1.5)
    local function pt(u) return {x0 + side*L*u, y + dy + droop*dj*u*0.85 - lift*u*u} end
    local u0 = rand(0.15, 0.6)
    local u1 = math.min(1.0, u0 + rand(0.2, 0.5))
    f:stroke({pt(u0), pt((u0+u1)/2), pt(u1)}, {pressure={rand(0.45, 0.7), 0.1}, orient="across", ramps={0.1, 0.5}})
    n = n + 1
  end
  return n
end
local fws = {14, 12, 12, 11, 11, 10, 8, 8}
local n = 0
for i = 1, 8 do n = n + break_branches(TB[i], tree_dark, fws[i], 3400 + i) end
print(n)

--@ chunk 57
print(drying(50, 50), drying(300, 600), drying(546, 250), drying(200, 450), drying(100, 720), drying(600, 700))

--@ chunk 58
math.randomseed(3501)
local kw = knife{width=40}
local function wline(p, x0, x1, y, blade, press, load)
  kw:wipe(); kw:load(p, load or 0.25)
  local xm = (x0 + x1) / 2 + rand(-10, 10)
  kw:lay({{x0, y}, {xm, y + rand(-0.6, 0.6)}, {x1, y + rand(-0.5, 0.5)}}, {pressure={press, press}, angle=blade})
end
-- over the mountain reflection: cool ripples reflecting the sky
local cool = {
  {338, 470, 588, 0.10}, {600, 742, 597, 0.10}, {455, 690, 616, 0.14},
  {760, 905, 611, 0.10}, {520, 640, 643, 0.18}, {700, 790, 652, 0.16},
  {372, 468, 674, 0.22}, {640, 712, 686, 0.2}, {430, 548, 708, 0.26},
}
for _, l in ipairs(cool) do wline(sky_mid, l[1], l[2], l[3], l[4], 0.6) end
-- glow reflection: warm streaks
local warm = {
  {30, 250, 568, 0.08}, {150, 330, 586, 0.1}, {10, 140, 607, 0.12}, {190, 300, 622, 0.14}, {60, 200, 641, 0.16},
}
for _, l in ipairs(warm) do wline(sky_low, l[1], l[2], l[3], l[4], 0.6) end
-- thin lines close under the far shore, where the water is far
local far = {{400, 560, 494, 0.05}, {610, 820, 498, 0.05}, {120, 330, 505, 0.06}, {860, 990, 503, 0.05}}
for _, l in ipairs(far) do wline(mist_cool, l[1], l[2], l[3], l[4], 0.6) end

--@ chunk 59
-- repair: re-stroke dark branches where the knife ripple lines crossed the spruces
local cross = {{597, 600, 742}, {611, 760, 905}, {652, 700, 790}, {686, 640, 712}, {498, 610, 820}, {503, 860, 990}}
local fws = {14, 12, 12, 11, 11, 10, 8, 8}
local f = {}
local n = 0
for i = 1, 8 do
  local fb = brush{kind="fan", width=fws[i], lay=2.2}
  for _, b in ipairs(TB[i]) do
    local x0, y, side, L, droop, lift = table.unpack(b)
    for _, c in ipairs(cross) do
      local yl, xa, xb = c[1], c[2], c[3]
      local xe = x0 + side * L
      local lo, hi = math.min(x0, xe), math.max(x0, xe)
      if y > yl - 22 and y < yl + 3 and hi > xa and lo < xb then
        if n % 2 == 0 then fb:reload(tree_dark, 0.85) end
        local function pt(u) return {x0 + side*L*u, y + droop*u*0.85 - lift*u*u} end
        fb:stroke({pt(0.05), pt(0.4), pt(0.75), pt(1.0)}, {pressure={0.8, 0.2}, orient="across", ramps={0.05, 0.5}})
        n = n + 1
      end
    end
  end
end
print(n)

--@ chunk 60
trees_p = {{700,560,728,22},{726,470,722,32},{672,625,735,16},{762,380,716,42},{818,290,708,50},{985,80,690,66},{902,-40,700,88},{862,190,712,70},{948,330,700,55},{790,500,714,30}}
local cross = {{497.5, 598, 815}, {502, 855, 1000}, {596, 592, 762}, {611, 760, 905}, {615, 640, 712}, {652, 690, 812}, {686, 630, 732}}
math.randomseed(3601)
local n = 0
for _, c in ipairs(cross) do
  local yl, xa, xb = c[1], c[2], c[3]
  for _, tp in ipairs(trees_p) do
    local cx, top, base, hw = tp[1], tp[2], tp[3], tp[4]
    if yl > top + 4 and yl < base then
      local t = (yl - top) / (base - top)
      local half = hw * (0.04 + 0.96 * t^0.85)
      local fw = clamp(hw * 0.2, 5, 14)
      local fb = brush{kind="fan", width=fw, lay=2.2}
      for side = -1, 1, 2 do
        local L = half * rand(0.85, 1.05)
        local xe = cx + side * L
        local lo, hi = math.min(cx, xe), math.max(cx, xe)
        if hi > xa and lo < xb then
          fb:reload(tree_dark, 0.85)
          local y0 = yl - rand(2, 4)
          local droop = L * rand(0.05, 0.12)
          fb:stroke({{cx, y0}, {cx + side*L*0.45, y0 + droop*0.6}, {cx + side*L*0.85, y0 + droop}, {cx + side*L, y0 + droop - L*0.03}}, {pressure={0.8, 0.15}, orient="across", ramps={0.05, 0.5}})
          n = n + 1
        end
      end
    end
  end
end
print(n)

--@ chunk 61
local lines = {
  {338, 470, 588}, {600, 690, 597}, {455, 690, 616}, {520, 640, 643}, {372, 468, 674}, {640, 680, 686}, {430, 548, 708},
  {30, 250, 568}, {150, 330, 586}, {10, 140, 607}, {190, 300, 622}, {60, 200, 641},
}
local m = nil
for _, l in ipairs(lines) do
  local r = ribbon({{l[1] - 6, l[3]}, {(l[1]+l[2])/2, l[3]}, {l[2] + 6, l[3]}}, 10)
  if m then m = m + r else m = r end
end
m = m:soften(3)
blend(m, {angle=0, pressure={0.3, 0.5}, length={20, 60}, seed=3701})

--@ chunk 62
print(palette())

--@ chunk 63
palette{scrape={tree_mid2, bush_dark, grass_rim, snow_sh}}
refl_fix = mix{{mtn_dark, 0.55}, {sky_mid, 0.3}, {water_deep, 0.15}, name="refl_fix"}
glow_fix = mix{{sky_low, 0.5}, {sky_mid, 0.4}, {water_deep, 0.1}, name="glow_fix"}
blue_fix = mix{{sky_mid, 0.75}, {water_deep, 0.25}, name="blue_fix"}
cap_fix = mix{{snow_lit, 0.55}, {sky_mid, 0.3}, {water_deep, 0.15}, name="cap_fix"}
local lines = {
  {338, 470, 588}, {600, 690, 597}, {455, 690, 616}, {520, 640, 643}, {372, 468, 674}, {640, 680, 686}, {430, 548, 708},
  {30, 250, 568}, {150, 330, 586}, {10, 140, 607}, {190, 300, 622}, {60, 200, 641},
}
local m = nil
for _, l in ipairs(lines) do
  local r = ribbon({{l[1] - 8, l[3]}, {(l[1]+l[2])/2, l[3]}, {l[2] + 8, l[3]}}, 16)
  if m then m = m + r else m = r end
end
m = m:soften(3)
fix_lines_m = m
local caps = refl_cap_lit + refl_cap_sh + refl_cap2
local function inR(x, y) return refl_mtn:at(x, y) end
local function inC(x, y) return caps:at(x, y) end
local function gl(x, y) return clamp(1 - (x - 80) / 300, 0, 1) end
local P = {
  {refl_fix, function(x, y) return inR(x, y) * (1 - inC(x, y)) end},
  {cap_fix, function(x, y) return inC(x, y) end},
  {glow_fix, function(x, y) return (1 - inR(x, y)) * (1 - inC(x, y)) * gl(x, y) end},
  {blue_fix, function(x, y) return (1 - inR(x, y)) * (1 - inC(x, y)) * (1 - gl(x, y)) end},
}
work(m, {hand="body", tool={kind="filbert", width=6}, piles=P, coverage=1.0, load=0.4, clip=true, angle=math.pi/2, length={8,16}, seed=3801})
blend(m, {angle=0, pressure={0.15, 0.3}, length={20, 60}, seed=3802})

--@ chunk 64
palette{scrape={refl_fix, blue_fix, cap_fix, glow_fix}}
caps_m = refl_cap_lit + refl_cap_sh + refl_cap2
local rgrow = refl_mtn:grow(3)
local cgrow = caps_m:grow(3)
glow_water = mask(function(x, y)
  if y < 532 or x > 645 then return 0 end
  local lim = (x < 420) and (lb_top(x) - 30) or 760
  if y > lim then return 0 end
  return smoothstep(532, 548, y) * (1 - smoothstep(lim - 6, lim, y))
end) - rgrow - cgrow
local function my(y) return 478 - (y - 478) end
local function wtop(x,y) return clamp((glow_d(x, my(y)) - 0.68)/0.35, 0, 1)^1.2 * 1.6 end
local function wmid(x,y) return math.exp(-((glow_d(x, my(y))-0.6)/0.2)^2) end
local function wglow(x,y) return math.exp(-((glow_d(x, my(y))-0.35)/0.16)^2) end
local function wlow(x,y) return clamp(1 - glow_d(x, my(y))/0.27, 0, 1) * 1.5 end
local function wdeep(x,y) return 0.15 + clamp((y - 600)/150, 0, 1) * 0.6 end
local P = {{sky_top, wtop}, {sky_mid, wmid}, {sky_glow, wglow}, {sky_low, wlow}, {water_deep, wdeep}}
work(glow_water, {hand="broad", piles=P, coverage=1.8, load=0.5, angle=0, angle_jitter=0.03, length={80,180}, clip=true, seed=3901})
blend(glow_water, {angle=0, seed=3902})
print(glow_water:area())

--@ chunk 65
local rgrow = refl_mtn:grow(3)
local seam = mask(function(x, y)
  if x > 640 then return 0 end
  return smoothstep(512, 528, y) * (1 - smoothstep(552, 568, y))
end) - rgrow
blend(seam, {angle=math.pi/2, length={12, 30}, seed=3911})
blend(seam, {angle=0, pressure={0.15, 0.3}, seed=3912})

--@ chunk 66
refl_dark = mix{{mtn_dark, 0.65}, {water_deep, 0.2}, {sky_mid, 0.15}, name="refl_dark"}
refl_warm = mix{{mtn_warm, 0.6}, {water_deep, 0.2}, {sky_mid, 0.2}, name="refl_warm"}
local cgrow = caps_m:grow(4)
local keepout = poly({{715,470},{1000,470},{1000,749},{648,749},{648,618},{690,556},{712,500}})
refl_redo = (refl_mtn * mask(function(x, y) return smoothstep(560, 580, y) end)) - cgrow - keepout
local function wwarm(x, y) return clamp(1 - x/600, 0, 1) * 0.8 end
local function wdark(x, y) return 0.6 + clamp(x/700, 0, 1) end
work(refl_redo, {hand="body", piles={{refl_dark, wdark}, {refl_warm, wwarm}}, coverage=1.5, load=0.6, clip=true, angle=math.pi/2, angle_jitter=0.04, length={20,50}, seed=4001})
blend(refl_redo:soften(4), {angle=math.pi/2, length={10, 25}, seed=4002})
print(refl_redo:area())

--@ chunk 67
print(palette())

--@ chunk 68
cap_mix = mix{{snow_lit, 0.5}, {refl_warm, 0.3}, {water_deep, 0.2}, name="cap_mix"}
local nz = noise{seed=4101, period=14, octaves=2}
local bars = poly({{424,664},{490,664},{490,684},{424,684}}):soften(3)
  + poly({{452,697},{566,697},{566,718},{452,718}}):soften(3)
  + poly({{620,674},{700,674},{700,696},{620,696}}):soften(3)
local P = {{cap_mix, function(x, y) return 0.6 + 0.6 * nz(x, y) end}, {refl_dark, function(x, y) return 0.5 - 0.5 * nz(x, y) end}}
work(bars, {hand="body", tool={kind="filbert", width=5}, piles=P, coverage=1.6, load=0.5, clip=true, angle=math.pi/2, length={8,18}, seed=4102})
local patch = poly({{648,586},{690,586},{692,606},{690,626},{648,626}}):soften(4)
work(patch, {hand="body", tool={kind="filbert", width=5}, piles={{refl_dark, 1}, {water_deep, 0.3}}, coverage=1.6, load=0.5, clip=true, angle=math.pi/2, length={8,18}, seed=4103})
blend((bars + patch):grow(3):soften(3), {angle=math.pi/2, length={8, 20}, seed=4104})

--@ chunk 69
palette{scrape={sky_glow, mtn_warm}}
refl_sky = mix{{sky_top, 0.6}, {water_deep, 0.25}, {sky_mid, 0.15}, name="refl_sky"}
zone = poly({{588,566},{640,560},{690,558},{712,562},{714,640},{710,700},{700,726},{660,738},{628,749},{588,749}}, true):roughen(3, 20, 4201):soften(3)
local caps = caps_m
local nz = noise{seed=4202, period=14, octaves=2}
local P = {
  {refl_dark, function(x, y) return refl_mtn:at(x, y) * (1 - caps:at(x, y)) end},
  {cap_mix, function(x, y) return caps:at(x, y) * (0.6 + 0.5 * nz(x, y)) end},
  {refl_dark, function(x, y) return caps:at(x, y) * (0.4 - 0.4 * nz(x, y)) end},
  {refl_sky, function(x, y) return 1 - refl_mtn:at(x, y) end},
}
work(zone, {hand="body", tool={kind="filbert", width=6}, piles=P, coverage=2.2, load=0.6, clip=true, angle=math.pi/2, angle_jitter=0.04, length={12,30}, seed=4203})
blend(zone, {angle=math.pi/2, length={10, 25}, seed=4204})

--@ chunk 70
local trees_keep = poly({{714,470},{1000,470},{1000,749},{714,749}})
local top_seam = ribbon({{592,562},{640,558},{690,557},{712,560}}, 22):soften(6) - trees_keep
local left_seam = ribbon({{590,566},{588,620},{588,680},{588,749}}, 24):soften(6)
blend(top_seam, {angle=math.pi/2, length={10, 25}, seed=4301})
blend(left_seam, {angle=0, pressure={0.2, 0.35}, length={15, 35}, seed=4302})
blend(left_seam, {angle=math.pi/2, length={10, 25}, seed=4303})

--@ chunk 71
local land_part = right_land * poly({{600,700},{718,700},{718,760},{600,760}})
work(land_part, {hand="body", pile=land_dark, coverage=2.2, load=0.7, clip=true, angle=0.1, length={15,35}, seed=4401})
print(big_spruce(700, 560, 728, 22, tree_dark, 1601, {fw=8, trunk=2.5}))
print(big_spruce(672, 625, 735, 16, tree_dark, 1603, {fw=7, trunk=2}))
bush_dark = pile{{"Prussian blue", 0.5}, {"raw umber", 1}, {"bone black", 0.3}, {"yellow ochre", 0.2}, name="bush_dark"}
math.randomseed(4402)
local fan = brush{kind="fan", width=16, lay=2}
local fan2 = brush{kind="fan", width=10, lay=2}
local n = 0
local function bush(cx, cy, rw, rh)
  for i = 1, math.floor(rw * rh / 25) do
    local u = rand(-1, 1)
    local x = cx + u * rw
    local topy = cy - rh * math.sqrt(math.max(0, 1 - u*u)) * rand(0.7, 1.05)
    local y = rand(topy, cy + 4)
    local b = (rand(0,1) < 0.6) and fan or fan2
    if n % 3 == 0 then fan:load(bush_dark, 0.8); fan2:load(bush_dark, 0.8) end
    b:touch(x, y, {pressure=rand(0.35, 0.7), drag={rand(-4, 4), -rand(4, 10)}, angle=rand(-0.5, 0.5)})
    n = n + 1
  end
end
bush(650, 744, 26, 14)
bush(700, 736, 34, 20)
print(n)

--@ chunk 72
local segs = {{497.5, 700, 800}, {502, 855, 1000}, {597, 700, 800}, {611, 760, 905}, {615, 690, 712}, {652.5, 700, 815}, {686.5, 690, 735}}
local rb = brush{kind="round", width=5, point=0, lay=2}
local n = 0
for _, s in ipairs(segs) do
  local yl, xa, xb = s[1], s[2], s[3]
  for _, tp in ipairs(trees_p) do
    local cx, top, base, hw = tp[1], tp[2], tp[3], tp[4]
    if yl > top + 4 and yl < base then
      local t = (yl - top) / (base - top)
      local half = hw * (0.04 + 0.96 * t^0.85) * 0.85
      local lo, hi = math.max(cx - half, xa), math.min(cx + half, xb)
      if hi > lo + 2 then
        -- two strokes from the trunk outward on each side within [lo, hi]
        for side = -1, 1, 2 do
          local x1 = (side < 0) and lo or hi
          if (side < 0 and x1 < cx) or (side > 0 and x1 > cx) then
            local x0 = clamp(cx, lo, hi)
            rb:reload(tree_dark, 1.0)
            rb:stroke({{x0, yl - 0.5}, {(x0 + x1)/2, yl}, {x1, yl + 0.5}}, {pressure={0.9, 0.5}})
            rb:reload(tree_dark, 1.0)
            rb:stroke({{x0, yl + 0.5}, {(x0 + x1)/2, yl}, {x1, yl - 0.3}}, {pressure={0.9, 0.5}})
            n = n + 2
          end
        end
      end
    end
  end
end
print(n)

--@ chunk 73
print(drying(500, 700), drying(600, 680), drying(450, 690), drying(546, 600))

--@ chunk 74
refl_cap_zone = poly({{408,646},{470,640},{540,638},{600,642},{656,650},{656,749},{430,749},{418,700}}, true)
local r = rag{width=44}
r:dip(0.9)
r:wipe(refl_cap_zone, {pressure=0.75, angle=math.pi/2, passes=2, refold=0.4, seed=4501})
r:refold(); r:dip(0.9)
r:wipe(refl_cap_zone, {pressure=0.75, angle=0, passes=2, refold=0.4, seed=4502})
print(r)

--@ chunk 75
palette{scrape={bush_dark, mist_cool}}
cap_sh_mix = mix{{snow_lit, 0.3}, {refl_dark, 0.4}, {water_deep, 0.15}, {sky_mid, 0.15}, name="cap_sh_mix"}
local zone = refl_cap_zone:grow(2)
local inside = refl_mtn
-- inverted snowline, ragged (hand-placed)
snow_r_line = {{405,655},{420,652},{436,658},{450,653},{462,660},{476,655},{490,662},{502,656},{514,664},{526,658},{538,666},{548,672},{560,668},{572,676},{586,672},{600,680},{614,676},{628,684},{642,680},{656,688}}
local pts = {}
for _, p in ipairs(snow_r_line) do pts[#pts+1] = {p[1], p[2]} end
pts[#pts+1] = {660, 760}; pts[#pts+1] = {400, 760}
local below_snow = poly(pts):roughen(2, 10, 4601)
local function rib_x(y) return 546 - 30 * (790 - y) / 150 end
snow_lit_r = below_snow * inside * mask(function(x, y) return x < rib_x(y) and 1 or 0 end)
snow_sh_r = below_snow * inside * mask(function(x, y) return x >= rib_x(y) and 1 or 0 end)
local dark_r = (inside - below_snow) * zone
local sky_r = zone - inside
local function gl(x, y) return clamp(1 - (x - 420) / 200, 0, 1) end
-- 1. dark mountain reflection above the snowline
work(dark_r, {hand="body", tool={kind="filbert", width=6}, pile=refl_dark, coverage=2.2, load=0.6, clip=true, angle=math.pi/2, length={12,30}, seed=4602})
-- 2. sky reflection outside the ridges
work(sky_r, {hand="body", tool={kind="filbert", width=6}, piles={{sky_low, function(x,y) return gl(x,y) end}, {sky_mid, function(x,y) return 0.5 end}, {refl_sky, function(x,y) return 1 - gl(x,y) end}}, coverage=2.2, load=0.6, clip=true, angle=math.pi/2, length={12,30}, seed=4603})
-- 3. the snow
work(snow_lit_r, {hand="body", tool={kind="filbert", width=6}, pile=cap_mix, coverage=2.2, load=0.6, clip=true, angle=math.pi/2 - 0.3, length={12,30}, seed=4604})
work(snow_sh_r, {hand="body", tool={kind="filbert", width=6}, pile=cap_sh_mix, coverage=2.2, load=0.6, clip=true, angle=math.pi/2 + 0.3, length={12,30}, seed=4605})

--@ chunk 76
cap_warm = mix{{snow_lit, 0.6}, {refl_warm, 0.25}, {sky_low, 0.15}, name="cap_warm"}
work(snow_lit_r:shrink(3), {hand="body", tool={kind="filbert", width=5}, pile=cap_warm, coverage=0.8, load=0.5, clip=true, angle=math.pi/2 - 0.3, length={10,24}, seed=4701})
math.randomseed(4702)
local ribs_r = {
  {{470,654},{478,684},{487,708}}, {{500,662},{506,694},{513,724}}, {{524,668},{530,706},{537,742}},
  {{562,666},{566,694},{570,724}}, {{592,672},{589,698},{584,722}}, {{618,674},{612,694},{604,712}},
  {{644,676},{638,690},{630,702}}, {{546,706},{546,731},{546,756}}, {{556,724},{554,748},{553,760}},
  {{452,652},{458,668},{462,680}}, {{580,672},{581,686}},
}
local fb = brush{kind="filbert", width=5}
for i, r in ipairs(ribs_r) do
  fb:reload(refl_dark, 0.7)
  local pts = {}
  for j, p in ipairs(r) do pts[j] = {p[1] + rand(-1, 1), p[2]} end
  fb:stroke(pts, {pressure={0.7, 0.05}, ramps={0.05, 0.6}})
end
-- the rib line between the lit and shaded faces: soften it with a few interleaved strokes
local function rib_x(y) return 546 - 30 * (790 - y) / 150 end
for i = 1, 14 do
  local y = rand(668, 748)
  local x = rib_x(y) + rand(-6, 6)
  local p = (rand(0,1) < 0.5) and cap_mix or cap_sh_mix
  fb:reload(p, 0.5)
  fb:stroke({{x, y}, {x + rand(-2, 2), y + rand(10, 20)}}, {pressure={0.5, 0.2}})
end

--@ chunk 77
local trees_keep = poly({{660,540},{1000,540},{1000,749},{660,749}})
local soft_zone = refl_cap_zone:grow(10):soften(10) - trees_keep
blend(soft_zone, {angle=math.pi/2, length={10, 24}, seed=4801})
blend(soft_zone, {angle=math.pi/2 + 0.05, length={10, 24}, seed=4802})

--@ chunk 78
cap_bright = mix{{snow_lit, 0.75}, {sky_low, 0.1}, {refl_warm, 0.15}, name="cap_bright"}
-- inverted west ridge as a polyline (from refl_line), and bands either side
local wr = {{405,640},{425,662},{455,690},{480,717},{505,744},{512,752}}
local outside_band = ribbon(wr, 40) - refl_mtn
local inside_band = (ribbon(wr, 36) * refl_mtn) * mask(function(x, y) return smoothstep(652, 664, y) end)
work(outside_band * rect(380, 640, 160, 110), {hand="body", tool={kind="filbert", width=5}, piles={{sky_mid, 1}, {refl_sky, 0.25}}, coverage=1.3, load=0.5, clip=true, angle=math.pi/2, length={10,24}, seed=4901})
work(inside_band, {hand="body", tool={kind="filbert", width=5}, pile=cap_bright, coverage=1.3, load=0.55, clip=true, angle=math.pi/2 - 0.35, length={10,24}, seed=4902})
blend((outside_band * rect(380, 640, 160, 110)):soften(4), {angle=math.pi/2, length={10, 22}, seed=4903})
blend(inside_band:soften(3), {angle=math.pi/2 - 0.2, length={10, 22}, seed=4904})

--@ chunk 79
local wr = {{405,640},{425,662},{455,690},{480,717},{505,744},{512,752}}
local ob = (ribbon(wr, 56) - refl_mtn:shrink(2)) * rect(370, 630, 180, 120)
blend(ob:soften(6), {angle=0.1, pressure={0.2, 0.35}, length={15, 40}, seed=5001})
local corner = poly({{630,680},{690,680},{700,749},{630,749}}):soften(6) - poly({{690,540},{1000,540},{1000,749},{690,749}})
blend(corner, {angle=math.pi/2, length={10, 22}, seed=5002})
blend(corner, {angle=0, pressure={0.2, 0.3}, length={10, 25}, seed=5003})

--@ chunk 80
local mA = ribbon({{703, 650}, {723, 650}}, 9):soften(2)
local mB = ribbon({{686, 685.5}, {697, 685.5}}, 9):soften(2) + ribbon({{703, 685.5}, {717, 685.5}}, 9):soften(2)
local mC = ellipse(711, 614, 6, 6):soften(2)
local m = mA + mB + mC
local r = rag{width=12}
r:dip(0.9)
r:wipe(m, {pressure=0.8, angle=0, passes=2, seed=5101})
r:refold(); r:dip(0.9)
r:wipe(m, {pressure=0.8, angle=math.pi/2, passes=1, seed=5102})
local caps = caps_m
local nz = noise{seed=5103, period=14, octaves=2}
local P = {
  {refl_dark, function(x, y) return refl_mtn:at(x, y) * (1 - caps:at(x, y)) end},
  {cap_mix, function(x, y) return caps:at(x, y) * (0.6 + 0.5 * nz(x, y)) end},
  {refl_dark, function(x, y) return caps:at(x, y) * (0.4 - 0.4 * nz(x, y)) end},
  {refl_sky, function(x, y) return 1 - refl_mtn:at(x, y) end},
}
local m2 = (ribbon({{701, 650}, {725, 650}}, 14) + ribbon({{684, 685.5}, {719, 685.5}}, 14) + ellipse(711, 614, 9, 9)):soften(3)
work(m2, {hand="body", tool={kind="filbert", width=5}, piles=P, coverage=2.0, load=0.6, clip=true, angle=math.pi/2, length={8,16}, seed=5104})
blend(m2, {angle=math.pi/2, length={6, 14}, seed=5105})

--@ chunk 81
function spruce_patch(cx, top, base, halfw, y0, y1, pile_, seed, fw, sides)
  math.randomseed(seed)
  local f = brush{kind="fan", width=fw, lay=2.5}
  f:load(pile_, 1.0)
  local y = y0
  local n = 0
  while y < y1 do
    local t = (y - top) / (base - top)
    local half = halfw * (0.04 + 0.96 * t^0.85) * rand(0.8, 1.1)
    for _, side in ipairs(sides or {-1, 1}) do
      local L = half * rand(0.7, 1.05)
      local droop = L * (0.12 + 0.35 * t) * rand(0.7, 1.3)
      local lift = L * rand(-0.05, 0.14)
      f:stroke({{cx, y}, {cx + side*L*0.45, y + droop*0.65}, {cx + side*L*0.85, y + droop}, {cx + side*L, y + droop - lift}}, {pressure={rand(0.6, 0.9), 0.05}, orient="across", ramps={0.05, 0.6}})
      n = n + 1
      if n % 3 == 0 then f:load(pile_, 0.85) end
    end
    y = y + (2.5 + 11 * t) * rand(0.6, 1.2)
  end
  return n
end
-- trunk of the small tree at x 700
local lead = brush{kind="round", width=2.6, point=0.6}
lead:load(tree_dark, 1.0)
lead:gesture({{700.5, 598, 0.6}, {700, 650, 0.75}, {699.5, 706, 0.85}})
print(spruce_patch(700, 560, 728, 22, 604, 700, tree_dark, 5201, 8))
-- left boughs of the tree at 726 over the gap
print(spruce_patch(726, 470, 722, 32, 640, 668, tree_dark, 5202, 10, {-1}))

--@ chunk 82
local m = (ribbon({{392, 494}, {480, 494}, {568, 494}}, 12) + ribbon({{602, 498}, {715, 498}, {828, 498}}, 12) + ribbon({{112, 505}, {225, 505}, {338, 505}}, 12)):soften(3)
local P = {{sky_mid, 1}, {water_deep, function(x, y) return (x > 380) and 0.4 or 0.15 end}}
work(m, {hand="body", tool={kind="filbert", width=6}, piles=P, coverage=1.0, load=0.4, clip=true, angle=math.pi/2, length={8,16}, seed=5301})
blend(m, {angle=0, pressure={0.15, 0.3}, length={20, 60}, seed=5302})

--@ chunk 83
palette{scrape={cap_warm, cap_bright, cap_sh_mix}}
water_F = mix{{sky_mid, 0.5}, {water_deep, 0.38}, {land_dark, 0.04}, {sky_low, 0.08}, name="water_F"}
water_L = mix{{sky_mid, 0.5}, {water_deep, 0.31}, {land_dark, 0.07}, {sky_low, 0.12}, name="water_L"}
local mL = ribbon({{106, 505}, {225, 505}, {344, 505}}, 15):soften(5)
local mR = (ribbon({{386, 494}, {480, 494}, {574, 494}}, 15) + ribbon({{596, 498}, {715, 498}, {834, 498}}, 15)):soften(5)
work(mL, {hand="body", tool={kind="filbert", width=6}, pile=water_L, coverage=2.2, load=0.6, clip=true, angle=0, length={15,35}, seed=5401})
work(mR, {hand="body", tool={kind="filbert", width=6}, pile=water_F, coverage=2.2, load=0.6, clip=true, angle=0, length={15,35}, seed=5402})
blend(mL + mR, {angle=0, pressure={0.15, 0.3}, length={20, 60}, seed=5403})

--@ chunk 84
local seam = mask(function(x, y)
  if x < 380 or x > 845 then return 0 end
  return smoothstep(480, 485, y) * (1 - smoothstep(500, 506, y)) * smoothstep(380, 392, x) * (1 - smoothstep(835, 845, x))
end)
blend(seam, {angle=math.pi/2, length={8, 18}, seed=5501})
-- trees: re-stroke branches in the band, then trunks
local idx = {5, 6, 7, 8}
local fws = {14, 12, 12, 11, 11, 10, 8, 8}
local n = 0
for _, i in ipairs(idx) do
  local fb = brush{kind="fan", width=fws[i], lay=2.2}
  for _, b in ipairs(TB[i]) do
    local x0, y, side, L, droop, lift = table.unpack(b)
    if y > 462 and y < 512 then
      if n % 2 == 0 then fb:reload(tree_dark, 0.9) end
      local function pt(u) return {x0 + side*L*u, y + droop*u*0.85 - lift*u*u} end
      fb:stroke({pt(0.0), pt(0.4), pt(0.75), pt(1.0)}, {pressure={0.85, 0.15}, orient="across", ramps={0.05, 0.5}})
      n = n + 1
    end
  end
end
print(n)
-- plus a fresh set of branches from each trunk in the band
local trees = {{818, 290, 708, 50, 14}, {762, 380, 716, 42, 12}, {726, 470, 722, 32, 10}, {790, 500, 714, 30, 9}}
for k, tp in ipairs(trees) do
  local lead = brush{kind="round", width=math.max(2.5, tp[5]*0.3), point=0.6}
  lead:load(tree_dark, 1.0)
  local ya = math.max(tp[2], 480)
  lead:gesture({{tp[1], ya, 0.5}, {tp[1], 496, 0.7}, {tp[1], 516, 0.8}})
  n = n + spruce_patch(tp[1], tp[2], tp[3], tp[4], math.max(tp[2] + 3, 482), 512, tree_dark, 5510 + k, tp[5])
end
print(n)

--@ chunk 85
trees_mask = nil
for _, tp in ipairs(trees_p) do
  local cx, top, base, hw = tp[1], tp[2], tp[3], tp[4]
  local p = poly({{cx, top - 4}, {cx + hw * 1.1, base}, {cx - hw * 1.1, base}})
  if trees_mask then trees_mask = trees_mask + p else trees_mask = p end
end
trees_mask = trees_mask:grow(4)
print(trees_mask:at(726, 500), trees_mask:at(700, 500), trees_mask:at(650, 500), trees_mask:at(818, 500))

--@ chunk 86
local band = mask(function(x, y)
  local top = (x > 380 or (x > 100 and x < 265)) and 489 or 485
  return smoothstep(top, top + 3, y) * (1 - smoothstep(528, 540, y))
end) - trees_mask
local function wl(x, y) return clamp(1 - (x - 300) / 150, 0, 1) end
work(band, {hand="broad", piles={{water_L, wl}, {water_F, function(x, y) return 1 - wl(x, y) end}}, coverage=1.0, load=0.3, pressure={0.2, 0.4}, angle=0, angle_jitter=0.02, length={150, 300}, clip=true, seed=5601})
blend(band, {angle=0, pressure={0.15, 0.3}, length={40, 100}, seed=5602})

--@ chunk 87
local edge = mask(function(x, y)
  return smoothstep(524, 532, y) * (1 - smoothstep(546, 556, y)) * smoothstep(240, 270, x)
end) - trees_mask - glow_water:grow(4)
blend(edge, {angle=math.pi/2, length={8, 18}, seed=5701})
blend(edge, {angle=math.pi/2 + 0.1, length={8, 18}, seed=5702})

--@ chunk 88
local A = left_bank * mask(function(x, y) return smoothstep(lb_top(x) + 28, lb_top(x) + 70, y) end) - rocks_m:grow(2)
work(A, {hand="body", pile=land_dark, coverage=1.5, load=0.7, clip=true, angle=-1.45, length={12,35}, seed=5801})
function tuft(x, y, h, n, piles, br, lean)
  for i = 1, n do
    local p = piles[math.random(#piles)]
    br:load(p, 0.6)
    local a = -math.pi/2 + (lean or 0) + rand(-0.5, 0.5)
    local hh = h * rand(0.45, 1.1)
    local bend = rand(-0.45, 0.45) + (lean or 0) * 0.5
    local x1, y1 = x + math.cos(a) * hh * 0.55, y + math.sin(a) * hh * 0.55
    local a2 = a + bend
    local x2, y2 = x1 + math.cos(a2) * hh * 0.5, y1 + math.sin(a2) * hh * 0.5
    br:gesture({{x + rand(-3, 3), y + rand(-2, 2), 0.75}, {x1, y1, 0.45}, {x2, y2, 0.0}})
  end
end
math.randomseed(5802)
local rg3 = brush{kind="rigger", width=2.4, point=1}
local n = 0
for i = 1, 70 do
  local x = rand(-5, 400)
  local d = rand(0, 1)^1.3 * (749 - lb_top(x))
  local y = lb_top(x) + d
  if left_bank:at(x, y) > 0.4 then
    tuft(x, y, rand(12, 26) * (1 + d / 120), math.floor(rand(3, 7)), {land_dark, grass_dusk, land_dark}, rg3, rand(-0.35, 0.1))
    n = n + 1
  end
end
print(n)

--@ chunk 89
local fws = {14, 12, 12, 11, 11, 10, 8, 8}
local n = 0
for i = 1, 5 do n = n + break_branches(TB[i], tree_dark, fws[i], 5900 + i) end
print(n)

--@ chunk 90
palette{scrape={water_F, water_L, refl_sky}}
alpenglow = pile{{"lead white", 5}, {"vermilion", 0.42}, {"chrome yellow", 0.3}, blot=0.15, name="alpenglow"}

--@ chunk 91
math.randomseed(6001)
local ka = knife{width=20}
local n = 0
-- along the upper west ridge of the main peak, just inside the edge
for i = 1, 9 do
  local x = lerp(492, 543, (i-1)/8) + rand(-3, 3)
  local y = skyline_y(x) + rand(2, 5)
  local a = 2.0 + rand(-0.15, 0.12)
  local L = rand(18, 40) * (0.6 + 0.6 * (x - 490) / 55)
  ka:wipe(); ka:load(alpenglow, rand(0.3, 0.4))
  ka:lay({{x, y}, {x + math.cos(a)*L*0.5, y + math.sin(a)*L*0.5}, {x + math.cos(a)*L, y + math.sin(a)*L}}, {pressure={rand(0.3, 0.4), rand(0.4, 0.55)}, angle=a + rand(0.7, 1.0)})
  n = n + 1
end
-- secondary peak's west face, a few
for i = 1, 4 do
  local x = lerp(700, 726, (i-1)/3) + rand(-2, 2)
  local y = skyline_y(x) + rand(2, 5)
  local a = 2.0 + rand(-0.15, 0.15)
  local L = rand(14, 26)
  ka:wipe(); ka:load(alpenglow, 0.3)
  ka:lay({{x, y}, {x + math.cos(a)*L, y + math.sin(a)*L}}, {pressure={0.35, 0.5}, angle=a + rand(0.7, 1.0)})
  n = n + 1
end
print(n)

--@ chunk 92
palette{scrape={alpenglow}}
sig = pile{{"red earth", 1}, {"yellow ochre", 0.3}, {"lead white", 0.35}, medium=0.15, name="sig"}
local rg = brush{kind="rigger", width=1.5, point=1}
rg:load(sig, 0.6)
rg:gesture({{972, 729, 0.3}, {965, 727, 0.5}, {960, 733, 0.6}, {962, 740, 0.55}, {970, 742, 0.3}})
rg:load(sig, 0.5)
rg:gesture({{958, 746, 0.15}, {972, 745.5, 0.4}, {986, 745, 0.05}})

--@ chunk 93
patch_mix = mix{{refl_dark, 0.6}, {cap_mix, 0.4}, name="patch_mix"}
local m = poly({{676,630},{732,630},{734,700},{676,700}}):soften(4)
local nz = noise{seed=6101, period=10, octaves=2}
work(m, {hand="body", tool={kind="filbert", width=4}, piles={{patch_mix, function(x,y) return 0.7 + 0.5*nz(x,y) end}, {refl_dark, function(x,y) return 0.5 - 0.5*nz(x,y) end}}, coverage=2.2, load=0.6, clip=true, angle=math.pi/2, length={10,24}, seed=6102})
blend(m, {angle=math.pi/2, length={8, 18}, seed=6103})
-- restate the small tree at x 700 and the left boughs of the tree at 726 and the 672 sapling
local lead = brush{kind="round", width=2.6, point=0.6}
lead:load(tree_dark, 1.0)
lead:gesture({{700, 560, 0.05}, {700.5, 600, 0.45}, {700, 660, 0.75}, {699.5, 712, 0.85}})
print(spruce_patch(700, 560, 728, 22, 563, 712, tree_dark, 6104, 8))
print(spruce_patch(726, 470, 722, 32, 626, 700, tree_dark, 6105, 10, {-1}))

--@ chunk 94
local m = poly({{668,624},{740,624},{742,706},{668,706}}):soften(10)
work(m, {hand="body", tool={kind="filbert", width=4}, pile=refl_dark, coverage=2.0, load=0.6, clip=true, angle=math.pi/2, length={10,24}, seed=6201})
blend(poly({{660,616},{748,616},{750,714},{660,714}}):soften(12), {angle=math.pi/2, length={8, 18}, seed=6202})

--@ chunk 95
local edge = (ribbon({{666, 620}, {666, 712}}, 14) + ribbon({{668, 618}, {744, 618}}, 12)):soften(5)
blend(edge, {angle=0, pressure={0.2, 0.35}, length={10, 25}, seed=6301})
print(big_spruce(700, 560, 728, 22, tree_dark, 1601, {fw=8, trunk=2.5}))
print(big_spruce(672, 625, 735, 16, tree_dark, 1603, {fw=7, trunk=2}))
print(spruce_patch(726, 470, 722, 32, 600, 720, tree_dark, 6302, 10, {-1}))
print(spruce_patch(762, 380, 716, 42, 640, 716, tree_dark, 6303, 11, {-1}))

--@ chunk 96
math.randomseed(6401)
local f = brush{kind="fan", width=9, lay=2}
local n = 0
local y = 600
while y < 716 do
  local t = (y - 470) / (722 - 470)
  local half = 32 * (0.04 + 0.96 * t^0.85)
  local L = half * rand(0.5, 1.0)
  local u0 = rand(0.1, 0.5)
  local droop = L * (0.12 + 0.35 * t) * rand(0.6, 1.4)
  if n % 3 == 0 then f:reload(tree_dark, 0.8) end
  local function pt(u) return {726 - L*u, y + droop*u*0.85} end
  f:stroke({pt(u0), pt((u0+1)/2), pt(1.0)}, {pressure={rand(0.5, 0.75), 0.08}, orient="across", ramps={0.1, 0.5}})
  n = n + 1
  y = y + rand(3, 9)
end
-- fringe touches below the boughs
local fr = brush{kind="fan", width=5, lay=1.8}
for i = 1, 18 do
  local yy = rand(610, 712)
  local t = (yy - 470) / 252
  local half = 32 * (0.04 + 0.96 * t^0.85)
  local x = 726 - half * rand(0.3, 0.95)
  if i % 4 == 1 then fr:reload(tree_dark, 0.8) end
  fr:stroke({{x, yy}, {x - rand(0, 2), yy + rand(4, 9)}}, {pressure={0.6, 0.05}, orient="across"})
end
print(n)

--@ chunk 97
ripple_c = mix{{sky_mid, 0.7}, {refl_dark, 0.3}, name="ripple_c"}
ripple_w = mix{{sky_mid, 0.6}, {sky_low, 0.25}, {water_deep, 0.15}, name="ripple_w"}
function wind_line(br, p, x0, y0, len, seed, pr)
  math.randomseed(seed)
  local x = x0
  local xe = x0 + len
  while x < xe do
    local seg = rand(12, 45)
    local x1 = math.min(xe, x + seg)
    local yy = y0 + rand(-0.6, 0.6)
    br:reload(p, rand(0.3, 0.5))
    local xm = (x + x1) / 2
    br:stroke({{x, yy + rand(-0.3, 0.3)}, {xm, yy + rand(-0.5, 0.5)}, {x1, yy + rand(-0.3, 0.3)}}, {pressure={rand(pr[1], pr[2]), 0.03}, ramps={0.35, 0.5}})
    x = x1 + rand(2, 14)
  end
end
local rg = brush{kind="rigger", width=2.5, point=1}
-- in the dark mountain reflection (keep left of the trees)
wind_line(rg, ripple_c, 420, 604, 170, 6501, {0.1, 0.2})
wind_line(rg, ripple_c, 520, 631, 110, 6502, {0.1, 0.2})
wind_line(rg, ripple_c, 600, 588, 40, 6503, {0.08, 0.16})
-- in the glow water, a little wider apart nearer the viewer
wind_line(rg, ripple_w, 40, 575, 180, 6504, {0.1, 0.18})
wind_line(rg, ripple_w, 140, 603, 150, 6505, {0.12, 0.2})
wind_line(rg, ripple_w, 20, 636, 120, 6506, {0.12, 0.22})

--@ chunk 98
print(wait(7 * 24 * 60))
print(drying(300, 100), drying(546, 250), drying(900, 300), drying(200, 700), drying(500, 650))

--@ chunk 99
print(drying(500,470), drying(480,604), drying(560,631), drying(900,300), drying(760,600), drying(300,700))
print(table.concat(tubes(), ", "))
print(palette())

--@ chunk 100
palette{scrape={sig, ripple_w, cap_mix, patch_mix, ripple_c}}
local fb = brush{kind="filbert", width=4}
local function cover(x0, x1, y0)
  local x = x0
  local n = 0
  fb:reload(refl_dark, 0.5)
  while x < x1 do
    local h = rand(2.8, 3.6)
    fb:stroke({{x, y0 - h}, {x + rand(-0.3, 0.3), y0 + h}}, {pressure={0.4, 0.35}})
    x = x + rand(2.5, 3.5)
    n = n + 1
    if n % 8 == 0 then fb:reload(refl_dark, 0.5) end
  end
end
cover(416, 596, 604)
cover(516, 636, 631)
cover(596, 646, 588)

--@ chunk 101
refl_lt = mix{{refl_dark, 0.88}, {sky_mid, 0.12}, name="refl_lt"}
local fb = brush{kind="filbert", width=4}
local function redab(x0, x1, y0)
  local x = x0 + rand(0, 3)
  while x < x1 do
    local p = (rand(0,1) < 0.6) and refl_lt or refl_dark
    fb:reload(p, rand(0.3, 0.45))
    local up, dn = rand(2.5, 6.5), rand(2.5, 6.5)
    fb:stroke({{x, y0 - up}, {x + rand(-0.4, 0.4), y0 + dn}}, {pressure={rand(0.3,0.45), 0.2}, ramps={0.15, 0.4}})
    x = x + rand(3, 7)
  end
end
redab(414, 598, 604)
redab(514, 638, 631)
redab(594, 648, 588)

--@ chunk 102
local m = ribbon({{410,604},{602,604}}, 20) + ribbon({{510,631},{642,631}}, 20) + ribbon({{590,588},{652,588}}, 20)
m = m:soften(4)
blend(m, {angle=math.pi/2, seed=7101})
blend(m, {angle=math.pi/2, seed=7102})

--@ chunk 103
print(drying(548,578), drying(546,572), drying(552,585))

--@ chunk 104
local fb = brush{kind="filbert", width=4}
for i = 0, 3 do
  fb:reload(refl_lt, 0.4)
  local x = 544 + i * 2.6 + rand(-0.4, 0.4)
  fb:stroke({{x, 566 + rand(-1,1)}, {x + 0.5, 591 + rand(-2,2)}}, {pressure={0.35, 0.25}, ramps={0.2, 0.4}})
end
local m = ellipse(549, 579, 12, 18):soften(5)
blend(m, {angle=math.pi/2, seed=7111})
blend(m, {angle=math.pi/2, seed=7112})

--@ chunk 105
print(wait(2*24*60))
print(drying(430,471), drying(600,468), drying(500,604), drying(900,300))

--@ chunk 106
F3 = mix{{far_tree, 0.65}, {sky_mid, 0.35}, name="F3"}
function far_spruce_c(b, x, base, h, w, p, clip)
  b:load(p, 0.75)
  local lean = rand(-0.04, 0.04)
  b:stroke({{x + lean*h, base - h}, {x, base}}, {pressure={0.05, 0.7}, clip=clip})
  local y = base - h + 1.5
  local i = 0
  while y < base do
    local t = (y - (base - h)) / h
    local half = w * (0.12 + 0.88 * t^0.9) * rand(0.55, 1.25)
    local xx = x + lean * (base - y)
    local sag = half * rand(0.15, 0.4)
    if rand(0,1) < 0.85 then b:stroke({{xx - half, y + sag}, {xx - half*0.4, y + sag*0.3}, {xx, y - 0.5}}, {pressure={0.15, 0.35}, clip=clip}) end
    if rand(0,1) < 0.85 then b:stroke({{xx, y - 0.5}, {xx + half*0.4, y + sag*0.3}, {xx + half, y + sag}}, {pressure={0.35, 0.15}, clip=clip}) end
    y = y + rand(1.2, 3.0) * (0.7 + 0.6*t)
    i = i + 1
    if i % 4 == 0 then b:load(p, 0.6) end
  end
end
local SL = {{385,477},{430,473},{520,472},{620,471},{760,470},{900,469},{1000,468}}
function shore_top(x)
  for i = 1, #SL - 1 do
    if x <= SL[i+1][1] then
      local t = (x - SL[i][1]) / (SL[i+1][1] - SL[i][1])
      return lerp(SL[i][2], SL[i+1][2], t)
    end
  end
  return 468
end
local clipm = -(trees_mask:grow(1))
local b = brush{kind="round", width=2.0, point=0.6}
math.randomseed(7201)
-- back row: lighter misty spires, sparse, clumped
local xb = uneven(70, 392, 795, 0.8, 0.7, 7202)
for _, x in ipairs(xb) do
  local s = 0.75 + 0.45 * (x - 390) / 400
  local h = rand(9, 17) * s
  if rand(0,1) < 0.18 then h = h * 1.3 end
  far_spruce_c(b, x, shore_top(x) + rand(-1, 0.5), h, h * rand(0.22, 0.3), F3, clipm)
end
-- front row: dark, dense, spiky, clumped
local xf = uneven(150, 390, 796, 0.75, 0.6, 7203)
for _, x in ipairs(xf) do
  local s = 0.75 + 0.4 * (x - 390) / 400
  local h = rand(6, 13) * s
  if rand(0,1) < 0.12 then h = h * 1.4 end
  far_spruce_c(b, x, shore_top(x) + 2 + rand(-0.5, 1.5), h, h * rand(0.24, 0.34), far_tree, clipm)
end

--@ chunk 107
print(drying(180,470), drying(180,477), drying(240,465))
F4 = mix{{far_tree, 0.5}, {sky_mid, 0.5}, name="F4"}
local b = brush{kind="round", width=1.9, point=0.6}
math.randomseed(7301)
local xb = uneven(10, 112, 258, 0.8, 0.8, 7302)
for _, x in ipairs(xb) do
  local h = rand(7, 13)
  far_spruce_c(b, x, 476 + rand(-1, 0.5), h, h * rand(0.22, 0.3), F4)
end
local xf = uneven(22, 110, 260, 0.85, 0.85, 7303)
for _, x in ipairs(xf) do
  local h = rand(3, 8)
  if rand(0,1) < 0.12 then h = h * 1.5 end
  far_spruce_c(b, x, 477.5 + rand(-0.5, 1), h, h * rand(0.26, 0.38), far_tree)
end

--@ chunk 108
print(wait(7*24*60))
print(drying(500,465), drying(180,470), drying(500,604), drying(549,579), drying(900,300))
