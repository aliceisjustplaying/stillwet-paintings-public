-- easel session "painting": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box friedrich
--@ engine 7

--@ chunk 1
canvas{size=650, aspect=1.4, linen={16,14}, seed=1774,
  ground={
    {pile={{"red earth",2},{"yellow ochre",2},{"lead white",1}}, um=60, apply="knife", texture=0.3},
    {pile={{"lead white",6},{"yellow ochre",0.35},{"raw umber",0.12}}, um=35, apply="brush"},
  }}
print(W, H)
print(table.concat(tubes(), ", "))

--@ chunk 2
-- Composition paths (globals)
HORIZ = 463
hill_pts = {{0,575},{100,561},{200,546},{300,539},{380,543},{450,556},{520,579},{600,603},{700,614},{850,619},{1000,623}}
far_pts  = {{0,466},{60,462},{130,459},{200,463},{300,464},{420,465},{520,463},{600,462},{700,463},{760,461},{820,458},{880,460},{950,463},{1000,462}}
-- tree skeleton: list of {points, widths}
tree = {
  trunk = {{{300,552},{304,500},{299,450},{297,415},{305,382}}, {40,30,28,27,25}},
  A  = {{{303,384},{272,334},{232,302},{192,252},{170,203},{150,170}}, {18,13,10,7,4.5,2}},
  A1 = {{{232,302},{192,306},{152,291},{122,296},{100,284}}, {7,4.5,3,1.8,0.8}},
  A2 = {{{192,252},{206,202},{199,160},{214,120}}, {6,4,2.4,0.9}},
  A3 = {{{170,203},{131,191},{114,164}}, {4,2.4,1}},
  B  = {{{306,382},{318,322},{311,262},{325,202},{321,158}}, {18,14,11,9.5,8.5}},
  B1 = {{{311,262},{281,222},{270,172},{251,131},{255,96}}, {7,5,3.5,2,0.8}},
  B2 = {{{325,202},{356,171},{371,131},{396,110}}, {6,4,2.2,0.8}},
  C  = {{{306,388},{346,361},{391,346},{431,321},{471,311},{511,291},{542,281}}, {16,12,10,7,5,3,1}},
  C1 = {{{391,346},{421,369},{451,376},{470,396}}, {5,3,2,0.8}},
  C2 = {{{431,321},{441,281},{431,241},{451,201}}, {6,4,2.5,0.9}},
  C3 = {{{471,311},{491,331},{521,336}}, {3,2,0.8}},
  C4 = {{{511,291},{516,261},{541,241}}, {3,2,0.8}},
  S  = {{{299,442},{274,431}}, {13,10}},
}
fig = {x=432, y=552, h=37}
moon = {x=770, y=232, r=13}
print("ok")

--@ chunk 3
local h = pencil("2H")
h:sketch(far_pts, {pressure=0.3})
h:sketch(hill_pts, {pressure=0.35})
-- limb edges
local function edges(pts, ws)
  local L, R = {}, {}
  for i=1,#pts do
    local a = pts[math.max(1,i-1)]; local b = pts[math.min(#pts,i+1)]
    local dx, dy = b[1]-a[1], b[2]-a[2]; local d = math.sqrt(dx*dx+dy*dy)
    local nx, ny = -dy/d, dx/d
    L[i] = {pts[i][1]+nx*ws[i]/2, pts[i][2]+ny*ws[i]/2}
    R[i] = {pts[i][1]-nx*ws[i]/2, pts[i][2]-ny*ws[i]/2}
  end
  return L, R
end
local hb = pencil("HB")
for k, br in pairs(tree) do
  local L, R = edges(br[1], br[2])
  hb:line(L, {pressure=0.35})
  hb:line(R, {pressure=0.35})
end
-- pool and channel
pool_pts = {{430,483},{560,481},{700,482},{860,484},{930,486}}
h:sketch(pool_pts, {pressure=0.25})
chan_pts = {{640,484},{690,498},{660,515},{620,530},{680,548},{780,565},{860,585},{940,605},{1000,612}}
h:sketch(chan_pts, {pressure=0.25})
-- moon
local mc = {}
for i=0,24 do local t=i/24*2*math.pi; mc[#mc+1]={moon.x+moon.r*math.cos(t), moon.y+moon.r*math.sin(t)} end
h:line(mc, {pressure=0.2})
-- figure: simple outline
hb:line({{fig.x-4,fig.y},{fig.x-6,fig.y-18},{fig.x-5,fig.y-30},{fig.x-2,fig.y-34},{fig.x,fig.y-37},{fig.x+3,fig.y-34},{fig.x+5,fig.y-30},{fig.x+6,fig.y-18},{fig.x+5,fig.y}}, {pressure=0.4})
-- church far
h:line({{642,465},{642,454},{668,452},{668,465}}, {pressure=0.3, smooth=false})
h:line({{668,458},{668,441},{675,441},{675,463}}, {pressure=0.3, smooth=false})
h:line({{668,441},{671.5,420},{675,441}}, {pressure=0.3, smooth=false})
print("drawn")

--@ chunk 4
l_dark = pile({{"raw umber",2},{"bone black",0.5},{"Prussian blue",0.12}, turps=0.6, name="l_dark"})
l_mid  = pile({{"raw umber",1},{"yellow ochre",0.8},{"green earth",1},{"lead white",0.3}, turps=0.6, name="l_mid"})
l_far  = pile({{"lead white",2},{"smalt",1},{"raw umber",0.4}, turps=0.55, name="l_far"})
fg_mask  = below(hill_pts)
far_mask = below(far_pts) * above(function(x) return 480 end)
mid_mask = below(function(x) return 478 end) - fg_mask
work(far_mask, {hand="body", pile=l_far, angle=0, coverage=1.2, clip=true, seed=101})
work(mid_mask, {hand="broad", pile=l_mid, angle=0, coverage=1.3, clip=mid_mask:grow(4), seed=102})
work(fg_mask:grow(3), {hand="broad", pile=l_dark, angle=-0.1, coverage=1.4, clip=fg_mask:grow(4), seed=103})

--@ chunk 5
l_mid2 = pile({{"raw umber",1.6},{"yellow ochre",0.5},{"green earth",0.8},{"bone black",0.15},{"lead white",0.4}, turps=0.6, name="l_mid2"})
work(mid_mask, {hand="body", pile=l_mid2, angle=0, coverage=2.2, fill=true, clip=mid_mask:grow(3), seed=104})
work(fg_mask:grow(3), {hand="body", pile=l_dark, angle=-0.05, coverage=2.2, fill=true, clip=fg_mask:grow(4), seed=105})
work(far_mask, {hand="detail", pile=l_far, angle=0, coverage=2, fill=true, seed=106})

--@ chunk 6
s_zen  = pile{{"lead white",0.6},{"smalt",1.5},{"cobalt blue",0.8},{"Prussian blue",0.1},{"raw umber",0.15},{"bone black",0.04}, name="s_zen"}
s_top  = pile{{"lead white",1.5},{"smalt",1.2},{"cobalt blue",0.8},{"raw umber",0.08}, name="s_top"}
s_mid  = pile{{"lead white",3},{"cobalt blue",0.6},{"smalt",0.6},{"Naples yellow",0.2}, name="s_mid"}
s_grn  = pile{{"lead white",5},{"Naples yellow",1},{"cobalt blue",0.6}, name="s_grn"}
s_glow = pile{{"lead white",5},{"Naples yellow",1.5},{"yellow ochre",0.25},{"vermilion",0.05}, name="s_glow"}
s_low  = pile{{"lead white",4},{"Naples yellow",1.4},{"yellow ochre",0.3},{"vermilion",0.2},{"rose madder",0.1}, name="s_low"}
local function wgt(c, r) return function(x,y) return math.max(0, 1 - math.abs(y-c)/r) end end
sky_mask = above(far_pts):grow(3)
work(sky_mask, {hand="broad", piles={{s_zen,wgt(0,150)},{s_top,wgt(120,120)},{s_mid,wgt(235,110)},{s_grn,wgt(325,100)},{s_glow,wgt(400,80)},{s_low,wgt(465,70)}}, angle=0, coverage=2.6, fill=true, clip=sky_mask, seed=111})
print(drying(500,100), drying(500,400))

--@ chunk 7
local m = above(far_pts):shrink(1)
blend(m, {angle=0})
blend(m, {angle=0.04})

--@ chunk 8
print(wait(3*24*60))
for _,p in ipairs({{500,50},{500,300},{500,440},{200,600},{700,520},{500,470}}) do print(p[1],p[2],drying(p[1],p[2])) end

--@ chunk 9
g_sky = pile{{"smalt",2},{"cobalt blue",0.35},{"rose madder",0.1},{"raw umber",0.16}, medium=0.75, name="g_sky"}
local m = rect(0,0,1000,330)
work(m, {hand="glaze", pile=g_sky, angle=0, coverage=1.8, clip=rect(0,0,1000,440), load_at=function(x,y) return clamp(1 - y/300, 0, 1)^1.2 end, seed=121})
blend(rect(0,0,1000,345), {angle=0})
blend(rect(0,0,1000,345), {angle=0.03})

--@ chunk 10
blend(rect(0,0,1000,300), {angle=0.0, seed=7})
blend(rect(0,0,1000,300), {angle=-0.03, seed=8})

--@ chunk 11
m_far  = pile{{"lead white",1.2},{"smalt",0.8},{"raw umber",0.6},{"rose madder",0.1},{"Naples yellow",0.2}, name="m_far"}
m_mid  = pile{{"raw umber",1.2},{"green earth",0.8},{"yellow ochre",0.25},{"smalt",0.3},{"lead white",0.35}, name="m_mid"}
m_near = pile{{"raw umber",1.5},{"green earth",0.5},{"bone black",0.2},{"yellow ochre",0.2},{"lead white",0.1}, name="m_near"}
f_hill = pile{{"raw umber",1.4},{"bone black",0.35},{"red earth",0.2},{"green earth",0.4}, name="f_hill"}
print("piles")

--@ chunk 12
m_far:add{{"smalt",0.4},{"raw umber",0.2}}
-- graded middle distance: far haze -> olive -> dark warm near the hill
local function band(y0, y1) return function(x,y) return clamp(1 - math.abs(y - y0)/y1, 0, 1) end end
local mm = below(function(x) return 474 end) - fg_mask
work(mm, {hand="body", piles={{m_far, band(474, 40)}, {m_mid, band(530, 55)}, {m_near, band(620, 70)}},
  angle=0, coverage=2.4, fill=true, clip=mm:grow(2), length={20,70},
  scale_at=function(x,y) return lerp(0.35, 1.1, clamp((y-474)/150,0,1)) end, seed=131})

--@ chunk 13
far_top = {{0,462},{40,461},{70,457},{85,455},{100,457},{130,460},{180,461},{230,459},{250,455},{262,454},{275,457},{300,460},{360,461},{420,462},{470,460},{500,456},{515,455},{530,458},{560,460},{600,460},{625,457},{640,455},{690,455},{705,457},{740,458},{780,456},{820,452},{860,450},{900,451},{940,454},{970,457},{1000,458}}
f_land = mix{{m_far, 1}, {s_top, 0.5}, name="f_land"}
f_land:add{{"raw umber",0.15}}
far_band = below(far_top) * above(function(x) return 478 end)
work(far_band, {hand="detail", pile=f_land, angle=0, coverage=2.5, fill=true, seed=141})

--@ chunk 14
print(wait(2*24*60))
for _,p in ipairs({{500,30},{100,150},{900,250},{500,500},{500,600},{700,465},{200,600}}) do print(p[1],p[2],drying(p[1],p[2])) end

--@ chunk 15
hill2_pts = {{0,522},{60,510},{130,498},{200,489},{260,484},{330,481},{390,483},{440,488},{480,496},{515,510},{550,530},{590,556},{630,582},{680,600},{740,610},{850,617},{1000,622}}
hill2 = below(hill2_pts):roughen(1.2, 8, 11)
-- paint only the new part plus overlap with old hill
local newpart = hill2 - fg_mask:shrink(6)
work(newpart, {hand="body", pile=f_hill, angle=0, coverage=2.4, fill=true, clip=hill2, seed=151})

--@ chunk 16
h_dark  = pile{{"raw umber",1.6},{"bone black",0.7},{"green earth",0.5},{"yellow ochre",0.15}, name="h_dark"}
h_crest = pile{{"raw umber",1.4},{"bone black",0.35},{"green earth",0.6},{"yellow ochre",0.3},{"smalt",0.25},{"lead white",0.25}, name="h_crest"}
local hall = hill2 + fg_mask
-- weight by depth into hill (distance from the top edge, approx via y offset from hill line)
local function hy(x)
  for i=1,#hill2_pts-1 do
    local a,b = hill2_pts[i], hill2_pts[i+1]
    if x>=a[1] and x<=b[1] then return lerp(a[2], b[2], (x-a[1])/(b[1]-a[1])) end
  end
  return 622
end
work(hall, {hand="body", piles={{h_crest, function(x,y) return clamp(1-(y-hy(x))/45,0,1) end},{h_dark, function(x,y) return clamp((y-hy(x))/45,0.05,1) end}},
  angle=function(x,y) return 0.04 end, coverage=3, fill=true, clip=hall, length={25,70}, seed=161})

--@ chunk 17
print(wait(3*24*60))
for _,p in ipairs({{200,520},{300,650},{600,560},{800,640},{800,520},{700,470}}) do print(p[1],p[2],drying(p[1],p[2])) end

--@ chunk 18
print(wait(4*24*60))
for _,p in ipairs({{200,520},{300,650},{600,560},{800,640},{800,520},{700,470},{100,600}}) do print(p[1],p[2],drying(p[1],p[2])) end

--@ chunk 19
h_dark2  = pile{{"raw umber",1.5},{"bone black",0.8},{"green earth",0.4},{"Prussian blue",0.04}, name="h_dark2"}
h_crest2 = pile{{"raw umber",1.5},{"bone black",0.5},{"green earth",0.6},{"yellow ochre",0.2},{"smalt",0.3},{"lead white",0.15}, name="h_crest2"}
local hall = hill2 + fg_mask
local function hy(x)
  for i=1,#hill2_pts-1 do
    local a,b = hill2_pts[i], hill2_pts[i+1]
    if x>=a[1] and x<=b[1] then return lerp(a[2], b[2], (x-a[1])/(b[1]-a[1])) end
  end
  return 622
end
work(hall, {hand="body", tool="filbert 7", piles={{h_crest2, function(x,y) return clamp(1-(y-hy(x))/35,0,1) end},{h_dark2, function(x,y) return clamp((y-hy(x))/35,0.05,1) end}},
  angle=0.03, coverage=2.6, fill=true, clip=hall, length={20,55}, seed=171})

--@ chunk 20
w_glow = pile{{"lead white",5},{"Naples yellow",1.4},{"yellow ochre",0.3},{"vermilion",0.06},{"raw umber",0.08}, name="w_glow"}
w_grn  = pile{{"lead white",4},{"Naples yellow",0.8},{"cobalt blue",0.5},{"raw umber",0.15}, name="w_grn"}
w_blue = pile{{"lead white",3},{"cobalt blue",0.7},{"smalt",0.6},{"raw umber",0.2}, name="w_blue"}
chan_pts2 = {{722,486},{760,488},{800,491},{835,495},{820,499},{770,503},{710,508},{668,514},{680,521},{730,527},{800,534},{880,543},{940,553},{1000,563}}
chan_w2   = {1.5,2.5,3,3.2,3.2,3.6,4,4.5,5,5.5,6.5,8,9.5,11}
pool1_pts = {{560,484},{600,482.5},{660,482},{720,483},{760,485.5}}
pool1_w   = {0.8,2.4,3,2.6,1.4}
pool2_pts = {{860,492},{900,491},{950,491.5},{990,493}}
pool2_w   = {0.8,2.2,2.4,1.2}
water_mask = (ribbon(chan_pts2, chan_w2) + ribbon(pool1_pts, pool1_w) + ribbon(pool2_pts, pool2_w)) - hill2
local function wy(y0, r) return function(x,y) return clamp(1-math.abs(y-y0)/r,0,1) end end
work(water_mask, {hand="detail", piles={{w_glow, wy(484,22)},{w_grn, wy(512,20)},{w_blue, wy(550,30)}}, angle=0, coverage=3, fill=true, seed=181})

--@ chunk 21
local k = knife{width=14}
local function scr(pts)
  k:scrape(pts, {pressure=1, angle=math.pi/2})
  k:wipe()
end
scr(chan_pts2)
scr(pool1_pts)
scr(pool2_pts)
-- second pass slightly offset to catch the wider near part
local off = {}
for i,p in ipairs(chan_pts2) do off[i] = {p[1], p[2]+ (chan_w2[i] > 6 and 3 or 0)} end
scr(off)
local off2 = {}
for i,p in ipairs(chan_pts2) do off2[i] = {p[1], p[2]- (chan_w2[i] > 6 and 3 or 0)} end
scr(off2)

--@ chunk 22
local r = rag{width=12}
for pass=1,3 do
  r:dip(0.9)
  r:wipe(chan_pts2, {pressure=0.8})
  r:refold(); r:dip(0.9)
  r:wipe(pool1_pts, {pressure=0.8})
  r:wipe(pool2_pts, {pressure=0.8})
  r:refold()
end
print(r)

--@ chunk 23
local area = (ribbon(chan_pts2, 22) + ribbon(pool1_pts, 16) + ribbon(pool2_pts, 16)) - hill2:grow(2)
for pass=1,3 do
  local r = rag{width=18}
  r:dip(0.95)
  r:wipe(area, {pressure=0.9, angle=0, passes=1, refold=0.3, seed=pass})
end

--@ chunk 24
local r = rag{width=14}
r:dip(0.95)
r:wipe({{930,560},{1000,565}}, {pressure=0.95})
r:refold(); r:dip(0.95)
r:wipe({{935,568},{1000,572}}, {pressure=0.95})
r:refold(); r:dip(0.95)
r:wipe({{870,535},{960,545}}, {pressure=0.9})
r:refold(); r:dip(0.95)
r:wipe({{570,483},{720,486}}, {pressure=0.9})

--@ chunk 25
g_sky2 = pile{{"smalt",2},{"cobalt blue",0.25},{"rose madder",0.12},{"raw umber",0.3}, medium=0.78, name="g_sky2"}
local m = rect(0,0,1000,230)
work(m, {hand="glaze", pile=g_sky2, angle=0, coverage=1.5, clip=rect(0,0,1000,300), load_at=function(x,y) return clamp(1 - y/220, 0, 1)^1.4 end, seed=191})
for i=1,4 do blend(rect(0,0,1000,260), {angle=(i%2==0) and 0.02 or -0.02, seed=200+i}) end

--@ chunk 26
d1 = pile{{"lead white",0.6},{"smalt",1.4},{"cobalt blue",0.8},{"raw umber",0.22},{"rose madder",0.04}, name="d1"}
d2 = pile{{"lead white",1.4},{"smalt",1.1},{"cobalt blue",0.7},{"raw umber",0.14}, name="d2"}
d3 = pile{{"lead white",2.4},{"smalt",0.9},{"cobalt blue",0.6},{"raw umber",0.08}, thinner=0.5, name="d3"}
print(palette())

--@ chunk 27
print(wait(3*24*60))
for _,p in ipairs({{500,20},{200,100},{800,180},{500,230}}) do print(p[1],p[2],drying(p[1],p[2])) end

--@ chunk 28
d0 = pile{{"lead white",0.35},{"smalt",1.5},{"cobalt blue",0.8},{"raw umber",0.3},{"rose madder",0.05}, name="d0"}
local function wgt(c, r) return function(x,y) return math.max(0, 1 - math.abs(y-c)/r) end end
local m = rect(0,0,1000,262)
work(m, {hand="broad", piles={{d0,wgt(0,95)},{d1,wgt(75,90)},{d2,wgt(155,85)},{d3,wgt(235,75)}}, angle=0, ruler=true, coverage=2.4, fill=true, clip=rect(0,0,1000,280),
  load_at=function(x,y) return clamp(1.25 - y/220, 0.12, 1) end, seed=211})
for i=1,3 do blend(rect(0,0,1000,275), {angle=0, seed=220+i}) end

--@ chunk 29
print(wait(2*24*60))
for _,p in ipairs({{500,20},{770,175},{840,240},{300,250}}) do print(p[1],p[2],drying(p[1],p[2])) end

--@ chunk 30
cl3 = pile{{"lead white",1.4},{"smalt",0.6},{"raw umber",0.45},{"rose madder",0.12},{"Naples yellow",0.3}, thinner=0.25, name="cl3"}
function cloud_lens(x0, x1, y, th, seed)
  local pts = {}
  local n = 16
  local nz = noise{seed=seed, period=50}
  for i=0,n do
    local t = i/n
    local x = lerp(x0, x1, t)
    local h = th * math.sin(math.pi*t)^0.6 * (0.6 + 0.8*nz:at01(x, y))
    pts[#pts+1] = {x, y - h*0.65}
  end
  for i=n,0,-1 do
    local t = i/n
    local x = lerp(x0, x1, t)
    local h = th * math.sin(math.pi*t)^0.9
    pts[#pts+1] = {x, y + h*0.35}
  end
  return poly(pts, true)
end
clouds = cloud_lens(590, 1010, 388, 8, 1) + cloud_lens(660, 905, 404, 5, 2) + cloud_lens(745, 1010, 371, 4.5, 3) + cloud_lens(40, 230, 400, 3.5, 4)
work(clouds, {hand="body", tool="filbert 5", pile=cl3, angle=0, ruler=true, coverage=2.2, fill=true, clip=clouds:grow(1), length={30,90}, seed=231})
blend(clouds:grow(3):soften(2), {angle=0, seed=232})

--@ chunk 31
local r = rag{width=16}
local area = clouds:grow(4)
for pass=1,2 do
  r = rag{width=16}
  r:dip(0.95)
  r:wipe(area, {pressure=0.85, angle=0, passes=1, refold=0.3, seed=240+pass})
end

--@ chunk 32
local area = cloud_lens(650, 915, 404, 7, 2):grow(5)
for pass=1,2 do
  local r = rag{width=14}
  r:dip(0.95)
  r:wipe(area, {pressure=0.9, angle=0, passes=1, refold=0.25, seed=250+pass})
end
local r = rag{width=12}; r:dip(0.95)
r:wipe({{655,404},{780,403.5},{910,404}}, {pressure=0.9})

--@ chunk 33
moon = {x=775, y=186, r=12.5}
moon_p = pile{{"lead white",4},{"Naples yellow",1},{"yellow ochre",0.06}, name="moon_p"}
local cres = ellipse(moon.x, moon.y, moon.r, moon.r) - ellipse(moon.x-5, moon.y-3.8, moon.r*0.98, moon.r*0.98)
moon_mask = cres:soften(0.6)
work(moon_mask, {hand="detail", pile=moon_p, coverage=3, fill=true, seed=261})
star = {x=846, y=236}
local st = brush{kind="round", width=4, point=0.5}
st:load(moon_p, 0.7)
st:touch(star.x, star.y, {pressure=0.55})

--@ chunk 34
local raw = {
  {{{305,548},{304,520},{301,490},{299,455},{300,425},{305,405}}, {58,46,40,37,35,33}},
  {{{292,418},{270,388},{248,372},{224,340},{206,302},{180,283},{161,246},{150,216},{141,188},{147,163}}, {22,18,16,13,11,9,7,5,3.5,2}},
  {{{224,340},{190,346},{161,336},{136,343},{111,331},{91,335}}, {9,7,5.5,4,2.8,1.6}},
  {{{206,302},{216,267},{206,236},{221,202},{213,172}}, {7.5,6,4.5,3,1.8}},
  {{{161,246},{132,240},{116,216},{96,206}}, {5,3.8,2.6,1.4}},
  {{{305,412},{312,372},{305,332},{318,292},{314,252},{326,217},{323,186}}, {25,21,18,15,13,12,11}},
  {{{305,334},{281,302},{272,271},{255,246},{258,216},{246,190}}, {9,7.5,6,4.5,3,1.8}},
  {{{318,292},{345,266},{352,236},{372,216},{378,186}}, {8,6.5,5,3.5,2}},
  {{{323,192},{335,167},{331,142}}, {4,2.8,1.4}},
  {{{316,412},{350,393},{381,388},{411,371},{441,362},{469,341},{501,332},{531,316},{561,311}}, {23,18,15.5,13,10.5,8.5,6,4,2}},
  {{{381,388},{403,404},{430,410},{448,425}}, {6,4.5,3,1.6}},
  {{{411,371},{419,336},{411,301},{426,269},{421,241}}, {8,6.5,5,3.5,2}},
  {{{469,341},{479,311},{501,291},{506,263}}, {5.5,4,3,1.6}},
  {{{501,332},{521,345},{546,346}}, {3.5,2.5,1.3}},
  {{{318,404},{344,361},{360,321},{385,291},{391,251},{410,226},{416,196}}, {16,13,11,9,7,5,3}},
  {{{385,291},{361,266},{356,236}}, {4.5,3.2,1.8}},
  {{{300,457},{276,448},{266,451}}, {15,12,11}},
}
local DY = -58
oak = {}
for i, br in ipairs(raw) do
  local pts = {}
  for j, p in ipairs(br[1]) do pts[j] = {p[1], p[2] + DY} end
  oak[i] = {pts, br[2]}
end
-- root flare, sitting on the crest (hill2 at x 300 ~ 483)
oak_roots = {{252,497},{266,489},{279,475},{290,456},{318,456},{328,474},{343,488},{362,498},{330,500},{290,501}}
local tm = nil
for _, br in ipairs(oak) do
  local r = ribbon(br[1], br[2])
  tm = tm and (tm + r) or r
end
tm = tm + poly(oak_roots, true)
oak_mask = tm:roughen(1.0, 5, 3)
print(oak_mask:at(300,300), oak_mask:at(300,480), oak_mask:at(500,100), oak_mask:area())

--@ chunk 35
t_dark = pile{{"raw umber",1.3},{"bone black",0.8},{"Prussian blue",0.1},{"red earth",0.1}, name="t_dark"}
t_warm = pile{{"raw umber",1.6},{"bone black",0.5},{"red earth",0.2},{"yellow ochre",0.1}, name="t_warm"}
local nz = noise{seed=77, period=40}
work(oak_mask, {hand="detail", piles={{t_dark, function(x,y) return 0.6 + 0.4*nz(x,y) end},{t_warm, function(x,y) return 0.4 - 0.4*nz(x,y) end}},
  coverage=2.6, fill=true, angle=-math.pi/2, seed=271})

--@ chunk 36
rd_m = brush{kind="round", width=4, point=1}
rd_l = brush{kind="round", width=7, point=1}
rg_s = brush{kind="rigger", width=1.6, point=1}
t_twig = pile{{"raw umber",1.2},{"bone black",0.8},{"Prussian blue",0.08},{"red earth",0.05}, medium=0.15, name="t_twig"}
sec = {
  {{180,225},{162,214},{141,192},{119,183},{101,160}, w={5,4,3,2,1}},
  {{136,285},{121,298},{104,303},{92,316}, w={3,2.4,1.6,0.8}},
  {{314,194},{337,181},{347,161},{367,150},{374,132}, w={5,4,3,2,1}},
  {{441,304},{453,281},{447,259},{462,236},{458,214}, w={5,4,3,2,1}},
  {{531,258},{547,241},{556,222},{553,206}, w={3.4,2.5,1.6,0.8}},
  {{255,188},{236,172},{232,150},{216,138}, w={4,3,2,1}},
  {{206,244},{186,232},{176,212}, w={4,2.6,1.2}},
  {{352,178},{368,165},{385,160}, w={3.5,2.4,1.2}},
  {{97,277},{80,268},{68,272}, w={2,1.4,0.8}},
  {{416,138},{406,118},{412,98}, w={2.6,1.8,0.8}},
  {{147,105},{140,86},{150,70}, w={2,1.4,0.7}},
  {{421,183},{436,170},{439,150}, w={2.6,1.8,0.8}},
}
for _, s in ipairs(sec) do
  local pts = {}
  local br = (s.w[1] > 3.6) and rd_l or rd_m
  for i, p in ipairs(s) do
    local pr = (i == #s) and 0.12 or math.max(0.3, br:pressure_for(s.w[i]))
    pts[#pts+1] = {p[1], p[2], pr}
  end
  br:reload(t_twig, 0.75)
  br:gesture(pts, {wobble=0.3, ramps={0.03, 0.3}})
end
-- a dead broken stub on the right of the trunk
local stub = poly({{317,388},{330,384},{340,382},{343,386},{340,393},{328,396},{317,398}}, true):roughen(0.8,4,5)
work(stub, {hand="detail", pile=t_dark, coverage=2.5, fill=true, seed=281})

--@ chunk 37
local k = knife{width=9}
for _, s in ipairs(sec) do
  local pts = {}
  -- start a little away from the parent limb
  local x0,y0,x1,y1 = s[1][1], s[1][2], s[2][1], s[2][2]
  local dx,dy = x1-x0, y1-y0; local d = math.sqrt(dx*dx+dy*dy)
  local off = math.min(0.6, (s.w[1]*0.9 + 3)/d)
  pts[1] = {x0+dx*off, y0+dy*off}
  for i=2,#s do pts[#pts+1] = {s[i][1], s[i][2]} end
  -- extend past the tip
  local a,b = s[#s-1], s[#s]
  local ex,ey = b[1]-a[1], b[2]-a[2]; local el = math.sqrt(ex*ex+ey*ey)
  pts[#pts+1] = {b[1]+ex/el*8, b[2]+ey/el*8}
  k:scrape(pts, {pressure=1})
  k:wipe()
  k:scrape(pts, {pressure=1})
  k:wipe()
end
-- the right stub
k = knife{width=18}
k:scrape({{321,389},{350,389}}, {pressure=1, angle=math.pi/2}); k:wipe()
k:scrape({{321,391},{350,391}}, {pressure=1, angle=math.pi/2}); k:wipe()

--@ chunk 38
for _, s in ipairs(sec) do
  local x0,y0,x1,y1 = s[1][1], s[1][2], s[2][1], s[2][2]
  local dx,dy = x1-x0, y1-y0; local d = math.sqrt(dx*dx+dy*dy)
  local off = math.min(0.75, (s.w[1]*0.9 + 7)/d)
  local pts = {{x0+dx*off, y0+dy*off}}
  for i=2,#s do pts[#pts+1] = {s[i][1], s[i][2]} end
  local a,b = s[#s-1], s[#s]
  local ex,ey = b[1]-a[1], b[2]-a[2]; local el = math.sqrt(ex*ex+ey*ey)
  pts[#pts+1] = {b[1]+ex/el*6, b[2]+ey/el*6}
  for pass=1,2 do
    local r = rag{width=6}
    r:dip(0.95)
    r:wipe(pts, {pressure=0.85})
  end
end

--@ chunk 39
for _, s in ipairs(sec) do
  local x0,y0,x1,y1 = s[1][1], s[1][2], s[2][1], s[2][2]
  local dx,dy = x1-x0, y1-y0; local d = math.sqrt(dx*dx+dy*dy)
  local off = math.min(0.8, (s.w[1]*0.9 + 10)/d)
  local pts = {{x0+dx*off, y0+dy*off}}
  for i=2,#s do pts[#pts+1] = {s[i][1], s[i][2]} end
  local a,b = s[#s-1], s[#s]
  local ex,ey = b[1]-a[1], b[2]-a[2]; local el = math.sqrt(ex*ex+ey*ey)
  pts[#pts+1] = {b[1]+ex/el*8, b[2]+ey/el*8}
  local r = rag{width=10}
  r:dip(0.95)
  r:wipe(pts, {pressure=0.95})
end

--@ chunk 40
for i=1,2 do
  local r = rag{width=9}
  r:dip(0.95)
  r:wipe({{354,389},{331,390}}, {pressure=0.95})
  r = rag{width=9}; r:dip(0.95)
  r:wipe({{354,394},{331,394}}, {pressure=0.95})
end

--@ chunk 41
local nz = noise{seed=78, period=40}
work(oak_mask, {hand="detail", piles={{t_dark, function(x,y) return 0.6 + 0.4*nz(x,y) end},{t_warm, function(x,y) return 0.4 - 0.4*nz(x,y) end}},
  coverage=1.5, fill=true, angle=-math.pi/2, seed=291})

--@ chunk 42
function crooked(x, y, ang, len, w0, w1, jit)
  jit = jit or 0.38
  local pts, ws = {{x,y}}, {w0}
  local n = math.max(3, math.floor(len/9 + 0.5))
  local a = ang
  local cx, cy = x, y
  for i=1,n do
    local seg = len/n * rand(0.75, 1.25)
    a = a + randn(0, jit)
    a = a + 0.35*(ang - a) + 0.05*((-math.pi/2) - a)
    cx, cy = cx + seg*math.cos(a), cy + seg*math.sin(a)
    pts[#pts+1] = {cx, cy}
    ws[#ws+1] = lerp(w0, w1, (i/n)^0.8)
  end
  return pts, ws
end
function along(pts, ws, fn, spacing, minw)
  local acc = rand(0.3, 1.0)*spacing
  for i=1,#pts-1 do
    local x0,y0,x1,y1 = pts[i][1],pts[i][2],pts[i+1][1],pts[i+1][2]
    local dx,dy = x1-x0, y1-y0
    local d = math.sqrt(dx*dx+dy*dy)
    local la = math.atan(dy, dx)
    local s = acc
    while s < d do
      local t = s/d
      local wl = lerp(ws[i], ws[i+1], t)
      if wl >= minw then fn(x0+dx*t, y0+dy*t, la, wl, i + t) end
      s = s + spacing*rand(0.6, 1.4)
    end
    acc = s - d
  end
end
function upside(la)
  local s1 = la - math.pi/2
  return (math.sin(s1) < 0) and -1 or 1
end
function grow_crown(limbs, opts)
  local out = {}
  for li, L in ipairs(limbs) do
    along(L[1], L[2], function(x, y, la, wl, pos)
      local side = upside(la); if math.random() < 0.3 then side = -side end
      local a = la + side*rand(0.45, 1.05)
      a = a + 0.25*((-math.pi/2) - a)
      local w0 = math.min(opts.maxw or 6, wl*rand(0.4, 0.6))
      local len = rand(0.7, 1.3) * (opts.len or 45) * math.min(1.5, 0.5 + wl/12)
      local ox, oy = x + math.cos(a)*wl*0.3, y + math.sin(a)*wl*0.3
      local pts, ws = crooked(ox, oy, a, len, w0, 0.9, 0.4)
      out[#out+1] = {pts, ws, level=2}
      local k = math.random(1, 3)
      for j=1,k do
        local idx = math.random(math.max(2, #pts-3), #pts-1)
        local p = pts[idx]
        local pa = math.atan(pts[idx+1][2]-p[2], pts[idx+1][1]-p[1])
        local s2 = (math.random()<0.5) and -1 or 1
        local a2 = pa + s2*rand(0.4, 1.0); a2 = a2 + 0.2*((-math.pi/2) - a2)
        local p2, w2 = crooked(p[1], p[2], a2, rand(12, 28), math.max(1.0, ws[idx]*0.7), 0.8, 0.45)
        out[#out+1] = {p2, w2, level=3}
      end
    end, opts.spacing or 34, opts.minw or 3.5)
  end
  return out
end
local limbs = {}
for i=2,16 do limbs[#limbs+1] = oak[i] end
crown = grow_crown(limbs, {spacing=34, len=42, minw=3.5, maxw=6})
-- a broken stub on the right of the trunk, over the scraped ghost
crown[#crown+1] = {{{316,392},{330,386},{343,381},{350,377}}, {11,9,8,7.5}, level=2}
print(#crown)
local sm = nil
for _, b in ipairs(crown) do local r = ribbon(b[1], b[2]); sm = sm and (sm + r) or r end
crown_mask = sm:roughen(0.5, 4, 9) - oak_mask
local nz = noise{seed=79, period=40}
work(crown_mask, {hand="detail", piles={{t_dark, function(x,y) return 0.6 + 0.4*nz(x,y) end},{t_warm, function(x,y) return 0.4 - 0.4*nz(x,y) end}}, coverage=2.6, fill=true, seed=301})

--@ chunk 43
rg_s = brush{kind="rigger", width=1.6, point=1}
function fine(x, y, ang, len, pl)
  local pts = {}
  local n = 3
  local cx, cy, a = x, y, ang
  pts[1] = {cx, cy, 0.42}
  for i=1,n do
    local seg = len/n * rand(0.7, 1.3)
    a = a + randn(0, 0.4); a = a + 0.15*((-math.pi/2) - a)
    cx, cy = cx + seg*math.cos(a), cy + seg*math.sin(a)
    pts[#pts+1] = {cx, cy, (i==n) and 0.05 or lerp(0.42, 0.3, i/n)}
  end
  if rg_s:fullness() < 0.45 then rg_s:reload(pl, 0.7) end
  rg_s:gesture(pts, {wobble=0.15, ramps={0.02, 0.35}})
end
rg_s:reload(t_twig, 0.7)
local cnt = 0
for bi, b in ipairs(crown) do
  local pts = b[1]
  if #pts >= 2 and bi < #crown then
    local tip = pts[#pts]; local pre = pts[#pts-1]
    local a = math.atan(tip[2]-pre[2], tip[1]-pre[1])
    if math.random() < 0.75 then
      local k = math.random(2, 4)
      for j=1,k do
        fine(tip[1], tip[2], a + randn(0, 0.6), rand(7, 16), t_twig)
        cnt = cnt + 1
      end
    end
  end
end
-- also the tips of the main limbs (not the broken leader L2 / index 6, nor stub 17)
for i, L in ipairs(oak) do
  if i ~= 1 and i ~= 6 and i ~= 17 then
    local pts = L[1]; local tip = pts[#pts]; local pre = pts[#pts-1]
    local a = math.atan(tip[2]-pre[2], tip[1]-pre[1])
    for j=1,math.random(2,3) do fine(tip[1], tip[2], a + randn(0, 0.5), rand(9, 18), t_twig); cnt = cnt + 1 end
  end
end
print(cnt)

--@ chunk 44
local k = knife{width=22}
for i=1,2 do
  k:scrape({{276,392},{252,392}}, {pressure=1, angle=math.pi/2}); k:wipe()
end
for i=1,2 do
  local r = rag{width=8}; r:dip(0.95)
  r:wipe({{273,388},{254,388}}, {pressure=0.95})
  r = rag{width=8}; r:dip(0.95)
  r:wipe({{273,396},{254,396}}, {pressure=0.95})
end

--@ chunk 45
print(wait(4*24*60))
for _,p in ipairs({{300,420},{300,300},{230,200},{340,385},{200,520},{700,560},{500,470}}) do print(p[1],p[2],drying(p[1],p[2])) end

--@ chunk 46
g_hill = pile{{"bone black",1},{"raw umber",1.2},{"green earth",0.6},{"Prussian blue",0.06}, medium=0.7, name="g_hill"}
hall_mask = (hill2 + fg_mask) - oak_mask:grow(1.5)
work(hall_mask, {hand="glaze", pile=g_hill, angle=0.02, coverage=1.8, fill=true, clip=hall_mask, seed=311})
blend(hall_mask, {angle=0, seed=312})
blend(hall_mask, {angle=0.08, seed=313})

--@ chunk 47
local base = (oak_mask * below(function(x) return 470 end)):grow(1)
work(base, {hand="glaze", pile=g_hill, angle=0, coverage=2.2, fill=true, clip=base, seed=321})
blend(base:grow(3):soften(2), {angle=0, seed=322})

--@ chunk 48
local lump = (oak_mask:grow(2) * below(function(x) return 487 end))
work(lump, {hand="detail", pile=h_dark2, angle=0, coverage=2.5, fill=true, seed=331})
blend(lump:grow(4):soften(3), {angle=0, seed=332})

--@ chunk 49
print(wait(5*24*60))
for _,p in ipairs({{300,420},{300,300},{340,385},{300,495},{200,560},{600,650},{700,560}}) do print(p[1],p[2],drying(p[1],p[2])) end

--@ chunk 50
sky_fix = mix{{s_glow,0.85},{s_grn,0.15}, name="sky_fix"}
local protect = oak_mask:grow(1) + crown_mask:grow(1)
local m = (rect(236,376,26,20) + rect(214,392,16,10) + rect(316,394,14,9)) - protect
work(m, {hand="detail", tool={kind="filbert", width=4}, pile=sky_fix, angle=0, coverage=2.5, fill=true, clip=m, seed=341})

--@ chunk 51
local protect = oak_mask:grow(0.5) + crown_mask:grow(0.5)
local m = rect(256,377,16,9) - protect
work(m, {hand="detail", tool={kind="filbert", width=3}, pile=sky_fix, angle=0, coverage=2.5, fill=true, clip=m, seed=342})

--@ chunk 52
function clump_band(x0, x1, yb, hmin, hmax, seed, lobe)
  lobe = lobe or 6
  local nz = noise{seed=seed, period=lobe*3, octaves=3}
  local pts = {}
  local x = x0
  pts[#pts+1] = {x0, yb}
  while x <= x1 do
    local t = (x - x0)/(x1 - x0)
    local env = math.sin(math.pi*t)^0.35
    local h = lerp(hmin, hmax, nz:at01(x, yb)) * env
    pts[#pts+1] = {x, yb - h}
    x = x + lobe*rand(0.4, 0.8)
  end
  pts[#pts+1] = {x1, yb}
  return poly(pts, true)
end
hedge_far = mix{{f_land,0.6},{m_mid,0.4}, name="hedge_far"}
hedge_far:add{{"smalt",0.1},{"raw umber",0.1}}
hedge_mid = mix{{m_mid,0.6},{m_near,0.4}, name="hedge_mid"}
hedge_mid:add{{"bone black",0.08},{"smalt",0.1}}
print(hedge_far, hedge_mid)

--@ chunk 53
hedge_far:add{{"raw umber",0.12},{"smalt",0.15},{"bone black",0.04}}
print(hedge_far)

--@ chunk 54
local c1 = clump_band(560, 640, 481.5, 1.5, 3.5, 401, 4)
local c2 = clump_band(770, 880, 487, 2, 5.5, 402, 5)
local c3 = clump_band(890, 1004, 499, 3, 8, 403, 6)
local c4 = clump_band(640, 715, 512, 4, 10, 404, 6)
local c5 = clump_band(985, 1004, 540, 2, 6, 405, 6)
far_clumps = c1 + c2
near_clumps = c3 + c4
local tb = brush{kind="round", width=2, point=0.5}
work(far_clumps, {hand="detail", tool=tb, pile=hedge_far, coverage=3, fill=true, angle=0, seed=411})
work(near_clumps, {hand="detail", tool=tb, pile=hedge_mid, coverage=3, fill=true, angle=-math.pi/2, seed=412})

--@ chunk 55
function clump_trees(x0, x1, yb, hmin, hmax, seed)
  local m = rect(x0, yb - hmin*0.6, x1 - x0, hmin*0.6 + 0.5)
  local x = x0 + rand(0, 2)
  while x < x1 do
    local t = (x - x0)/(x1 - x0)
    local env = 0.45 + 0.55*math.sin(math.pi*t)^0.5
    local h = rand(hmin, hmax) * env
    local rx = h*rand(0.35, 0.6)
    m = m + ellipse(x, yb - h + h*0.45, rx, h*0.5)
    x = x + rx*rand(0.9, 1.6)
  end
  return m:roughen(0.5, 2.5, seed)
end
local t1 = clump_trees(562, 640, 481.8, 2, 5, 501)
local t2 = clump_trees(772, 880, 487.5, 2.5, 7, 502)
local t3 = clump_trees(892, 1004, 499.5, 4, 11, 503)
local t4 = clump_trees(642, 715, 512.5, 5, 13, 504)
local tb = brush{kind="round", width=1.8, point=0.5}
work(t1 + t2, {hand="detail", tool=tb, pile=hedge_far, coverage=3, fill=true, angle=-math.pi/2, seed=421})
work(t3 + t4, {hand="detail", tool=tb, pile=hedge_mid, coverage=3, fill=true, angle=-math.pi/2, seed=422})

--@ chunk 56
print(wait(4*24*60))
for _,p in ipairs({{600,480},{820,485},{950,497},{680,510},{300,495},{455,488}}) do print(p[1],p[2],drying(p[1],p[2])) end

--@ chunk 57
print(wait(6*24*60))
for _,p in ipairs({{600,480},{820,485},{950,497},{680,510},{300,495}}) do print(p[1],p[2],drying(p[1],p[2])) end

--@ chunk 58
print(wait(8*24*60))
for _,p in ipairs({{600,480},{820,485},{950,497},{680,510},{940,494}}) do print(p[1],p[2],drying(p[1],p[2])) end

--@ chunk 59
function lens(x0, x1, y, th, seed, skew)
  skew = skew or 0
  local nz = noise{seed=seed, period=14, octaves=2}
  local top, bot = {}, {}
  local n = math.max(8, math.floor((x1-x0)/4))
  for i=0,n do
    local t = i/n
    local x = lerp(x0, x1, t)
    local env = math.sin(math.pi*t)^0.4
    local yy = y + skew*(t-0.5)
    top[#top+1] = {x, yy - th*0.4*env*(0.75+0.5*nz:at01(x, y))}
    bot[#bot+1] = {x, yy + th*0.6*env*(0.5+1.0*nz:at01(x+50, y))}
  end
  local pts = {}
  for i=1,#top do pts[#pts+1] = top[i] end
  for i=#bot,1,-1 do pts[#pts+1] = bot[i] end
  return poly(pts, true)
end
wv_far  = pile{{"lead white",5},{"Naples yellow",1.3},{"yellow ochre",0.3},{"raw umber",0.25},{"vermilion",0.04}, name="wv_far"}
wv_dim  = pile{{"lead white",3},{"Naples yellow",0.8},{"smalt",0.4},{"raw umber",0.45},{"rose madder",0.05}, name="wv_dim"}
bay_mask = (lens(492, 1012, 481.5, 7.5, 7, 1) + lens(690, 860, 486.5, 4, 8) + lens(885, 1005, 504.5, 3.2, 9, 0.5)) - hill2:grow(1)
work(bay_mask, {hand="detail", tool={kind="flat", width=3}, piles={{wv_far, function(x,y) return clamp((y-477.5)/5,0.1,1) end},{wv_dim, function(x,y) return clamp(1-(y-477.5)/5,0,1) end}}, coverage=3, fill=true, angle=0, seed=431})

--@ chunk 60
church_col = mix{{f_land,1}, name="church_col"}
church_col:add{{"smalt",0.15},{"raw umber",0.15},{"bone black",0.03}}
local nave  = poly({{646,458},{646,451.5},{651,448.5},{661,448.5},{661,458}})
local tower = rect(661,440.5,5.2,17.5)
local spire = poly({{660.6,441},{663.6,424},{666.6,441}})
church_mask = (nave + tower + spire):soften(0.3)
work(church_mask, {hand="detail", tool={kind="round", width=1.4, point=0.6}, pile=church_col, coverage=3, fill=true, angle=-math.pi/2, seed=441})

--@ chunk 61
g_tree = pile{{"bone black",1},{"raw umber",1.1},{"Prussian blue",0.07}, medium=0.72, name="g_tree"}
local tm = (oak_mask + crown_mask) * above(function(x) return 492 end)
work(tm, {hand="detail", tool={kind="filbert", width=5}, pile=g_tree, coverage=1.8, fill=true, angle=-math.pi/2, seed=451})

--@ chunk 62
print(drying(265,391), drying(300,391))
for i=1,3 do
  local r = rag{width=7}; r:dip(0.95)
  r:wipe({{252,387},{277,388}}, {pressure=0.95})
  r = rag{width=7}; r:dip(0.95)
  r:wipe({{252,394},{277,395}}, {pressure=0.95})
end

--@ chunk 63
local k = knife{width=15}
for i=1,2 do
  k:scrape({{281,390},{250,390}}, {pressure=1, angle=math.pi/2}); k:wipe()
end
for i=1,2 do
  local r = rag{width=6}; r:dip(0.95)
  r:wipe({{280,386},{252,386}}, {pressure=1})
  r = rag{width=6}; r:dip(0.95)
  r:wipe({{280,392},{252,392}}, {pressure=1})
  r = rag{width=6}; r:dip(0.95)
  r:wipe({{280,397},{252,397}}, {pressure=1})
end

--@ chunk 64
for _,x in ipairs({252,258,264,270,276,280,284}) do io_s = drying(x,390); print(x, io_s, drying(x,380), drying(x,400)) end

--@ chunk 65
local k = knife{width=8}
for _,y in ipairs({384,389,394,398}) do
  k:scrape({{282,y},{248,y}}, {pressure=1}); k:wipe()
end
for _,x in ipairs({252,258,264,270,276,280}) do print(x, drying(x,390)) end

--@ chunk 66
print(wait(5*24*60))
for _,p in ipairs({{300,300},{270,390},{200,200},{450,250},{290,470}}) do print(p[1],p[2],drying(p[1],p[2])) end

--@ chunk 67
print(wait(5*24*60))
for _,p in ipairs({{300,300},{300,400},{290,470},{150,180}}) do print(p[1],p[2],drying(p[1],p[2])) end

--@ chunk 68
local keep = nil
for i=1,16 do local r = ribbon(oak[i][1], oak[i][2]); keep = keep and (keep + r) or r end
keep = keep:roughen(1.0, 5, 3)
trunk_keep = keep
local m = rect(246, 378, 40, 24) - keep:grow(0.3) - crown_mask:grow(0.5)
work(m, {hand="detail", tool={kind="filbert", width=3}, pile=sky_fix, angle=0, coverage=3, fill=true, clip=m, seed=461})

--@ chunk 69
oak_mask = trunk_keep + poly(oak_roots, true):roughen(1.0,5,3)
print(oak_mask:at(265,390), oak_mask:at(300,390))

--@ chunk 70
function fig_parts(fx, fy, s)
  s = s or 1
  local function P(pts) local o = {} for i,p in ipairs(pts) do o[i] = {fx + p[1]*s, fy + p[2]*s} end return o end
  local parts = {}
  parts.head = ellipse(fx + 0.4*s, fy - 35.0*s, 2.9*s, 3.5*s)
  parts.cap  = poly(P{{-3.2,-36.6},{-3.0,-38.8},{-0.8,-40.2},{2.4,-40.3},{4.4,-39.0},{4.2,-37.2},{0.8,-37.4}}, true)
  parts.coat = poly(P{{-1.6,-32.4},{2.4,-32.4},{5.2,-31.0},{6.3,-28},{6.8,-22},{7.4,-15},{7.6,-9.6},{3.0,-8.8},{-2.0,-9.0},{-6.8,-9.6},{-6.9,-16},{-6.3,-24},{-5.6,-29.4},{-4.4,-31.0}}, true)
  parts.legs = poly(P{{-3.7,-9.4},{-0.9,-9.4},{-1.2,-1.4},{-3.4,-1.4}}, true) + poly(P{{0.9,-9.4},{3.6,-9.4},{3.8,-1.4},{1.3,-1.4}}, true)
  parts.feet = ellipse(fx - 2.5*s, fy - 0.8*s, 2.3*s, 1.1*s) + ellipse(fx + 2.8*s, fy - 0.8*s, 2.3*s, 1.1*s)
  parts.stick = ribbon(P{{7.9,-16.5},{8.8,-8},{9.8,0.4}}, 0.9*s)
  return parts
end
fig = {x=458, y=491.5, s=1.05}
fp = fig_parts(fig.x, fig.y, fig.s)
fig_coat = pile{{"bone black",1},{"raw umber",0.8},{"Prussian blue",0.12},{"green earth",0.3}, name="fig_coat"}
fig_hair = pile{{"bone black",1},{"raw umber",1},{"red earth",0.1}, name="fig_hair"}
fig_legs = pile{{"raw umber",1},{"bone black",0.6},{"lead white",0.08},{"smalt",0.12}, name="fig_legs"}
fig_cap  = pile{{"bone black",1},{"raw umber",0.6},{"red earth",0.15}, name="fig_cap"}
local fb = brush{kind="round", width=1.6, point=0.6}
work(fp.legs + fp.feet, {hand="detail", tool=fb, pile=fig_legs, coverage=3, fill=true, angle=-math.pi/2, seed=471})
work(fp.coat, {hand="detail", tool=fb, pile=fig_coat, coverage=3, fill=true, angle=-math.pi/2, seed=472})
work(fp.head, {hand="detail", tool=fb, pile=fig_hair, coverage=3, fill=true, seed=473})
work(fp.cap, {hand="detail", tool=fb, pile=fig_cap, coverage=3, fill=true, angle=0, seed=474})
work(fp.stick, {hand="detail", tool=fb, pile=fig_hair, coverage=3, fill=true, seed=475})

--@ chunk 71
fig_legs2 = pile{{"raw umber",1},{"bone black",0.9},{"red earth",0.05}, name="fig_legs2"}
local fb = brush{kind="round", width=1.4, point=0.6}
work(fp.legs, {hand="detail", tool=fb, pile=fig_legs2, coverage=3, fill=true, angle=-math.pi/2, seed=476})

--@ chunk 72
hf_deep  = pile{{"raw umber",1.3},{"bone black",0.8},{"green earth",0.4},{"Prussian blue",0.03}, medium=0.3, name="hf_deep"}
hf_base  = pile{{"raw umber",1.4},{"bone black",0.6},{"green earth",0.5},{"yellow ochre",0.1}, medium=0.3, name="hf_base"}
hf_slope = pile{{"raw umber",1.3},{"green earth",0.7},{"yellow ochre",0.35},{"bone black",0.3},{"lead white",0.1}, medium=0.3, name="hf_slope"}
function hy(x)
  for i=1,#hill2_pts-1 do
    local a,b = hill2_pts[i], hill2_pts[i+1]
    if x>=a[1] and x<=b[1] then return lerp(a[2], b[2], (x-a[1])/(b[1]-a[1])) end
  end
  return 622
end
local function slope(x) return math.atan(hy(x+15) - hy(x-15), 30) end
hill_all = hill2 + fg_mask
local m = hill_all - oak_mask:grow(0.5)
local nz = noise{seed=501, period=160}
work(m, {hand="body", tool="filbert 9", piles={
    {hf_slope, function(x,y) local d = y - hy(x); return clamp(smoothstep(380, 620, x) * (1 - d/110), 0, 1) * 0.9 end},
    {hf_base,  function(x,y) local d = y - hy(x); return clamp(1 - math.abs(d - 60)/90, 0.05, 1) * (0.8 + 0.3*nz(x,y)) end},
    {hf_deep,  function(x,y) local d = y - hy(x); return clamp((d - 60)/80, 0, 1) end}},
  angle=function(x,y) local d = clamp((y - hy(x))/120, 0, 1); return lerp(slope(x), 0.02, d) end,
  coverage=2.4, fill=true, clip=m, length={25,70}, seed=511})

--@ chunk 73
hf_deep2 = pile{{"bone black",1},{"raw umber",1.2},{"green earth",0.3},{"Prussian blue",0.05}, medium=0.25, name="hf_deep2"}
local m = hill_all - oak_mask:grow(0.5)
work(m, {hand="body", tool="filbert 9", piles={
    {hf_deep2, function(x,y) local d = y - hy(x); return 1 - 0.7*clamp(smoothstep(420, 640, x) * (1 - d/90), 0, 1) end},
    {hf_slope, function(x,y) local d = y - hy(x); return 0.7*clamp(smoothstep(420, 640, x) * (1 - d/90), 0, 1) end}},
  angle=function(x,y) local d = clamp((y - hy(x))/120, 0, 1); return lerp(math.atan(hy(x+15) - hy(x-15), 30), 0.02, d) end,
  coverage=1.8, fill=true, clip=m, length={25,70}, seed=521})

--@ chunk 74
for _,p in ipairs({{300,495},{300,505},{300,515},{270,510},{340,510},{200,520}}) do print(p[1],p[2],drying(p[1],p[2])) end

--@ chunk 75
local fixm = (rect(236, 476, 140, 52) * below(function(x) return hy(x) + 3.5 end)):roughen(0.8, 4, 61)
work(fixm, {hand="body", tool="filbert 7", piles={{hf_deep2, 0.75},{hf_base, 0.25}}, angle=0.0,
  coverage=2.6, fill=true, clip=fixm, length={15,40}, seed=531})
-- soften seam into the open surroundings
blend((rect(232, 478, 148, 54) * below(function(x) return hy(x) + 6 end)), {angle=0, seed=532})

--@ chunk 76
sky_low = mix{{s_low,0.55},{s_glow,0.45}, name="sky_low"}
fig_mask = (fp.head + fp.cap + fp.coat + fp.legs + fp.feet + fp.stick)
print(sky_low)

--@ chunk 77
sky_low:add{{"lead white",0.25},{"raw umber",0.012},{"cobalt blue",0.008}}
print(sky_low)

--@ chunk 78
saddle_pts = {{392,461.5},{410,462.5},{425,465},{440,467.5},{458,468.5},{474,467},{488,463},{500,458.5},{512,455.5}}
local m = (below(far_top) * above(saddle_pts)) * rect(390,440,125,40) - fig_mask:grow(0.6)
print(m:area())
work(m, {hand="detail", tool={kind="filbert", width=2.5}, pile=sky_low, angle=0, coverage=3, fill=true, clip=m, seed=541})

--@ chunk 79
print(palette())

--@ chunk 80
f_land2 = pile{{"lead white",0.33},{"smalt",0.31},{"raw umber",0.24},{"rose madder",0.02},{"Naples yellow",0.03},{"cobalt blue",0.07}, name="f_land2"}

--@ chunk 81
local m = rect(503,450,15,26) * below(far_top)
work(m, {hand="detail", tool={kind="filbert", width=2.5}, pile=f_land2, angle=0, coverage=3, fill=true, clip=m, seed=551})

--@ chunk 82
local m = rect(495,452,14,26) * below(saddle_pts) * below(far_top) * above(function(x) return 478 end)
work(m, {hand="detail", tool={kind="round", width=2, point=0.4}, pile=f_land2, angle=-math.pi/2, coverage=3, fill=true, clip=m, seed=552})

--@ chunk 83
print(wait(8*24*60))
for _,p in ipairs({{430,463},{200,600},{600,640},{450,520},{510,465},{300,505},{458,470}}) do print(p[1],p[2],drying(p[1],p[2])) end

--@ chunk 84
print(wait(5*24*60))
for _,p in ipairs({{450,520},{300,505},{458,470},{350,560},{100,650}}) do print(p[1],p[2],drying(p[1],p[2])) end

--@ chunk 85
local land_under = below(far_top) * below(saddle_pts) * above(function(x) return 477 end)
local m = (rect(385,455,9,25) + rect(508,450,11,30)) * land_under
work(m, {hand="detail", tool={kind="round", width=1.6, point=0.4}, pile=f_land2, angle=0, coverage=3.5, fill=true, clip=m, seed=561})

--@ chunk 86
local land_under = below(far_top) * below(saddle_pts) * above(function(x) return 477.5 end)
local m = rect(505,448,20,32) * land_under
work(m, {hand="detail", tool={kind="filbert", width=2.5}, pile=f_land2, angle=-math.pi/2, coverage=4, fill=true, clip=m, seed=562})
print(m:at(514,465), m:at(514,476), m:at(514,456))

--@ chunk 87
local m = rect(503,448,22,32) * below(far_top) * above(function(x) return 477.5 end)
print(m:at(514,465), m:at(514,476), m:at(514,450))
work(m, {hand="detail", tool={kind="filbert", width=2.5}, pile=f_land2, angle=-math.pi/2, coverage=4, fill=true, clip=m, seed=563})

--@ chunk 88
local m = rect(383,452,11,28) * below(far_top) * above(function(x) return 477.5 end) * below(function(x) return (x < 392) and 0 or 461.5 end)
local m2 = rect(383,452,9,28) * below(far_top) * above(function(x) return 477.5 end)
print(m2:at(388,462), m2:at(388,455))
work(m2, {hand="detail", tool={kind="filbert", width=2.5}, pile=f_land2, angle=-math.pi/2, coverage=4, fill=true, clip=m2, seed=564})

--@ chunk 89
m_far = pile{{"lead white",1.2},{"smalt",1.2},{"raw umber",0.8},{"rose madder",0.1},{"Naples yellow",0.2}, name="m_far"}
m_mid = pile{{"raw umber",1.2},{"green earth",0.8},{"yellow ochre",0.25},{"smalt",0.3},{"lead white",0.35}, name="m_mid"}
copse_far  = mix{{f_land2,0.8},{m_mid,0.2}, name="copse_far"}
copse_near = mix{{f_land2,0.5},{m_mid,0.5}, name="copse_near"}

--@ chunk 90
copse_far:add{{"raw umber",0.06},{"smalt",0.04}}

--@ chunk 91
copse_near:add{{"raw umber",0.08},{"smalt",0.04}}

--@ chunk 92
function copse_cover(x0, x1, yb, hmax, seed, extra)
  extra = extra or 1.5
  local m = rect(x0 - 3, yb - 2.5, (x1 - x0) + 7, 4.2)
  local x = x0 - 2
  while x < x1 + 4 do
    local t = clamp((x - x0)/(x1 - x0), 0, 1)
    local env = 0.45 + 0.55*math.sin(math.pi*t)^0.5
    local hneed = 1.05*hmax*env + extra
    local h = hneed * rand(1.0, 1.22)
    local rx = rand(2.5, 4.5) + h*0.25
    m = m + ellipse(x, yb - h + h*0.5, rx, h*0.5)
    x = x + rx*rand(0.6, 1.0)
  end
  return m:roughen(0.5, 2.5, seed)
end
cop_near = copse_cover(642, 715, 512.5, 13, 601)
cop_far  = copse_cover(892, 1004, 499.5, 11, 602) - rect(0,502.5,1000,10)
local tb = brush{kind="round", width=1.8, point=0.5}
work(cop_near, {hand="detail", tool=tb, pile=copse_near, coverage=3.5, fill=true, angle=-math.pi/2, seed=611})
work(cop_far, {hand="detail", tool=tb, pile=copse_far, coverage=3.5, fill=true, angle=-math.pi/2, seed=612})

--@ chunk 93
copse_near2 = mix{{copse_near,0.45},{hedge_mid,0.55}, name="copse_near2"}
copse_far2  = mix{{copse_far,0.55},{hedge_far,0.45}, name="copse_far2"}
local tb = brush{kind="round", width=1.8, point=0.5}
work(cop_near, {hand="detail", tool=tb, pile=copse_near2, coverage=3, fill=true, angle=-math.pi/2, seed=621})
work(cop_far, {hand="detail", tool=tb, pile=copse_far2, coverage=3, fill=true, angle=-math.pi/2, seed=622})

--@ chunk 94
blend(cop_near, {angle=0, seed=631})
blend(cop_far, {angle=0, seed=632})

--@ chunk 95
spit_col = mix{{m_far,0.6},{hedge_far,0.4}, name="spit_col"}
spit_col:add{{"raw umber",0.05}}
local s1 = poly({{574,485},{586,481.5},{598,479.2},{612,478.4},{628,478.6},{640,480.5},{652,485}}, true)
local s2 = poly({{736,485.5},{752,482.2},{770,481.2},{786,482},{800,485.5}}, true)
local s3 = poly({{858,486},{868,481.5},{880,479.3},{896,478.8},{908,480.6},{920,486}}, true)
local s4 = poly({{520,484},{535,481.8},{548,482.3},{556,485}}, true)
spits = (s1 + s2 + s3 + s4):roughen(0.4, 3, 71)
work(spits, {hand="detail", tool={kind="round", width=1.6, point=0.5}, pile=spit_col, coverage=3.5, fill=true, angle=0, seed=641})

--@ chunk 96
pool_c = pile{{"lead white",3},{"cobalt blue",0.45},{"smalt",0.5},{"raw umber",0.5},{"Naples yellow",0.35}, name="pool_c"}
pool_w = pile{{"lead white",3.5},{"Naples yellow",0.6},{"smalt",0.3},{"raw umber",0.35},{"cobalt blue",0.15}, name="pool_w"}

--@ chunk 97
pool_c:add{{"cobalt blue",0.25},{"smalt",0.3},{"raw umber",0.1}}

--@ chunk 98
m_near = pile{{"raw umber",1.5},{"green earth",0.5},{"bone black",0.2},{"yellow ochre",0.2},{"lead white",0.1}, name="m_near"}
local function plens(x0, x1, y, th, seed, skew)
  skew = skew or 0
  local nz = noise{seed=seed, period=18, octaves=2}
  local top, bot = {}, {}
  local n = math.max(10, math.floor((x1-x0)/4))
  for i=0,n do
    local t = i/n
    local x = lerp(x0, x1, t)
    local env = math.sin(math.pi*t)^0.45
    local yy = y + skew*(t-0.5)
    top[#top+1] = {x, yy - th*0.42*env*(0.7+0.6*nz:at01(x, y))}
    bot[#bot+1] = {x, yy + th*0.58*env*(0.6+0.8*nz:at01(x+70, y))}
  end
  local pts = {}
  for i=1,#top do pts[#pts+1] = top[i] end
  for i=#bot,1,-1 do pts[#pts+1] = bot[i] end
  return poly(pts, true)
end
near_pool = (plens(800, 968, 557, 9, 81, 2) + plens(842, 905, 548.5, 3.2, 82, 0.5)):roughen(0.4, 3, 83)
work(near_pool, {hand="detail", tool={kind="flat", width=3}, piles={{pool_w, function(x,y) return clamp(1-(y-545)/14,0.05,1) end},{pool_c, function(x,y) return clamp((y-548)/10,0.05,1) end}}, coverage=3.5, fill=true, angle=0, seed=651})

--@ chunk 99
pool_d = mix{{pool_c,0.7},{m_far,0.3}, name="pool_d"}
work(near_pool, {hand="detail", tool={kind="flat", width=3}, piles={{pool_w, function(x,y) return clamp(1-(y-546)/8,0.0,1)*0.6 end},{pool_d, function(x,y) return clamp((y-547)/8,0.1,1) end}}, coverage=2.5, fill=true, angle=0, seed=661})

--@ chunk 100
mead = mix{{m_mid,0.45},{m_near,0.55}, name="mead"}

--@ chunk 101
mead2 = mix{{m_mid,0.6},{m_near,0.22},{m_far,0.18}, name="mead2"}

--@ chunk 102
local fleck = (rect(960, 535, 42, 40) + rect(875, 525, 125, 50)) - near_pool:grow(3) - hill2:grow(1)
work(fleck, {hand="body", tool="filbert 5", piles={{mead2, function(x,y) return clamp(1-(y-525)/50,0.1,1) end},{mead, function(x,y) return clamp((y-525)/50,0.1,1) end}}, angle=0.0, coverage=2.2, fill=true, clip=fleck, length={15,40}, seed=671})

--@ chunk 103
local bm = (rect(850, 520, 152, 60) - near_pool:grow(0.5)):soften(4)
blend(bm, {angle=0, seed=681})
blend(bm, {angle=0.05, seed=682})

--@ chunk 104
local k = knife{width=12}
for y=522,592,5 do
  k:scrape({{1004,y},{790,y}}, {pressure=1, angle=math.pi/2}); k:wipe()
end
for pass=1,2 do
  local r = rag{width=18}; r:dip(0.95)
  r:wipe(rect(790,520,214,72), {pressure=0.9, angle=0, refold=0.25, seed=690+pass})
end
for _,p in ipairs({{880,557},{950,560},{820,540},{900,575}}) do print(p[1],p[2],drying(p[1],p[2])) end

--@ chunk 105
s_mid  = pile{{"lead white",3},{"cobalt blue",0.6},{"smalt",0.6},{"Naples yellow",0.2}, name="s_mid"}
s_grn  = pile{{"lead white",5},{"Naples yellow",1},{"cobalt blue",0.6}, name="s_grn"}
sk300 = mix{{s_grn,0.65},{s_mid,0.35}, name="sk300"}
sk340 = mix{{s_grn,0.72},{s_glow,0.22},{s_mid,0.06}, name="sk340"}
print("ok")

--@ chunk 106
droop = {}
for i, b in ipairs(crown) do
  local p = b[1]
  local s, e = p[1], p[#p]
  local dx, dy = e[1]-s[1], e[2]-s[2]
  local a = math.atan(dy, dx)
  if dy > 4 and math.sin(a) > 0.35 then
    droop[#droop+1] = i
    print(i, b.level, string.format("%.0f,%.0f -> %.0f,%.0f", s[1], s[2], e[1], e[2]))
  end
end
print(#droop, #crown)

--@ chunk 107
local function region_for(ids)
  local m = nil
  for _, i in ipairs(ids) do
    local b = crown[i]
    local r = ribbon(b[1], b[2]):grow(3)
    local tip = b[1][#b[1]]
    r = r + ellipse(tip[1], tip[2], 17, 17)
    m = m and (m + r) or r
  end
  return m
end
local isdroop = {}
for _, i in ipairs(droop) do isdroop[i] = true end
local km = nil
for i, b in ipairs(crown) do
  if not isdroop[i] then local r = ribbon(b[1], b[2]); km = km and (km + r) or r end
end
keep_crown = km:roughen(0.5, 4, 9)
keep_all = trunk_keep + keep_crown
local reg = region_for({35,36,37,38}) - keep_all:grow(1.2)
local function wy(y0, y1) return function(x,y) return clamp((y - y0)/(y1 - y0), 0, 1) end end
work(reg, {hand="detail", tool={kind="filbert", width=3}, piles={{sk300, function(x,y) return 1 - wy(295,345)(x,y) + 0.02 end},{sk340, function(x,y) return wy(295,345)(x,y) + 0.02 end}}, angle=0, coverage=3, fill=true, clip=reg, seed=701})

--@ chunk 108
local m = nil
for _, i in ipairs({29,30,31}) do
  local b = crown[i]
  local r = ribbon(b[1], b[2]):grow(3)
  local tip = b[1][#b[1]]
  r = r + ellipse(tip[1], tip[2], 17, 17)
  m = m and (m + r) or r
end
local reg = m - keep_all:grow(1.2)
local function wy(y0, y1) return function(x,y) return clamp((y - y0)/(y1 - y0), 0, 1) end end
work(reg, {hand="detail", tool={kind="filbert", width=3}, piles={{sk300, function(x,y) return 1 - wy(295,345)(x,y) + 0.02 end},{sk340, function(x,y) return wy(295,345)(x,y) + 0.02 end}}, angle=0, coverage=3, fill=true, clip=reg, seed=702})

--@ chunk 109
sk100 = mix{{d1,0.45},{d2,0.55}, name="sk100"}

--@ chunk 110
sk130 = mix{{d2,0.55},{d3,0.45}, name="sk130"}
-- 1. bare the dead sprig at the top of the broken leader: remove fine twigs around its tip
local sprig = oak[9]
local tip = sprig[1][#sprig[1]]
print("sprig tip", tip[1], tip[2])
local r1 = ellipse(tip[1], tip[2] - 4, 20, 22) - ribbon(sprig[1], sprig[2]):grow(0.8) - keep_all:grow(1.0)
-- 2. break L1 (oak[2]) at y ~ 122: remove its last part + twigs
local L1 = oak[2]
local r2 = (rect(128, 80, 36, 42) - keep_crown:grow(1.0))
local function wy(y0, y1) return function(x,y) return clamp((y - y0)/(y1 - y0), 0, 1) end end
work(r1 + r2, {hand="detail", tool={kind="filbert", width=3}, piles={{sk100, function(x,y) return 1 - wy(90,135)(x,y) + 0.02 end},{sk130, function(x,y) return wy(90,135)(x,y) + 0.02 end}}, angle=0, coverage=3, fill=true, clip=r1 + r2, seed=711})
-- 3. far-left limb end (oak[3]) hooks
local L1a = oak[3]
local t3 = L1a[1][#L1a[1]]
print("L1a tip", t3[1], t3[2])
local r3 = ellipse(t3[1] - 4, t3[2], 22, 16) - ribbon(L1a[1], L1a[2]):grow(0.8) - keep_all:grow(1.0)
work(r3, {hand="detail", tool={kind="filbert", width=3}, pile=sk300, angle=0, coverage=3, fill=true, clip=r3, seed=712})

--@ chunk 111
local k = knife{width=10}
local function scrape_rect(x0, y0, x1, y1)
  for y = y0, y1, 4 do
    k:scrape({{x1, y}, {x0, y}}, {pressure=1, angle=math.pi/2}); k:wipe()
  end
end
scrape_rect(124, 76, 168, 126)
scrape_rect(306, 56, 356, 112)
scrape_rect(62, 258, 112, 296)
for _,p in ipairs({{140,100},{320,70},{80,277}}) do print(p[1],p[2],drying(p[1],p[2])) end

--@ chunk 112
for pass=1,3 do
  local r = rag{width=12}; r:dip(0.95)
  r:wipe(rect(126,78,40,46), {pressure=0.9, angle=0, refold=0.2, seed=720+pass})
  r = rag{width=12}; r:dip(0.95)
  r:wipe(ellipse(331,80,22,24), {pressure=0.9, angle=0, refold=0.2, seed=730+pass})
  r = rag{width=12}; r:dip(0.95)
  r:wipe(ellipse(87,277,24,18), {pressure=0.9, angle=0, refold=0.2, seed=740+pass})
end

--@ chunk 113
local function pw(pts, w)
  for i=1,2 do
    local r = rag{width=w}; r:dip(0.95)
    r:wipe(pts, {pressure=0.95})
  end
end
pw({{127,76},{127,126}}, 6)
pw({{165,76},{165,126}}, 6)
pw({{108,272},{88,272}}, 5)
pw({{108,281},{88,281}}, 5)
pw({{110,277},{86,277}}, 5)
pw({{312,58},{350,58}}, 6)
pw({{309,60},{309,100}}, 6)
pw({{353,60},{353,100}}, 6)

--@ chunk 114
sk95 = mix{{d1,0.67},{d2,0.33}, name="sk95"}
sk277 = mix{{s_mid,0.52},{s_grn,0.48}, name="sk277"}
print(drying(140,100), drying(140,140))

--@ chunk 115
sk95:add{{"smalt",0.04},{"rose madder",0.006}}
print(sk95)

--@ chunk 116
local patch = rect(127,78,42,41):roughen(1.5, 6, 801) * above(function(x) return 119 + 2*math.sin(x/3) end)
work(patch, {hand="detail", tool={kind="filbert", width=3}, pile=sk95, angle=0, coverage=3, fill=true, clip=patch, seed=802})

--@ chunk 117
for pass=1,3 do
  local r = rag{width=12}; r:dip(0.95)
  r:wipe(rect(129,80,38,37), {pressure=0.9, angle=0, refold=0.2, seed=810+pass})
end
local function pw(pts, w)
  for i=1,2 do local r = rag{width=w}; r:dip(0.95); r:wipe(pts, {pressure=0.95}) end
end
pw({{127,77},{127,120}}, 6); pw({{168,77},{168,120}}, 6); pw({{127,78},{168,78}}, 6)

--@ chunk 118
print(wait(3*24*60))
for _,p in ipairs({{140,100},{331,80},{87,277},{160,320},{900,560},{600,483}}) do print(p[1],p[2],drying(p[1],p[2])) end

--@ chunk 119
sk120 = mix{{sk95,0.5},{sk100,0.5}, name="sk120"}
local core = rect(126,76,44,44) * above(function(x) return 119 + 2*math.sin(x/3) end)
local soft = core:blur(4)
work(soft, {hand="detail", tool={kind="filbert", width=3}, piles={{sk95, function(x,y) return clamp(1-(y-78)/45,0.02,1) end},{sk120, function(x,y) return clamp((y-78)/45,0.02,1) end}}, angle=0, coverage=3, fill=true, clip=soft, seed=821})

--@ chunk 120
for pass=1,3 do
  local r = rag{width=14}; r:dip(0.95)
  r:wipe(rect(120,70,56,52), {pressure=0.9, angle=0, refold=0.2, seed=830+pass})
end

--@ chunk 121
t_a = mix{{d1,0.7},{d0,0.3}, name="t_a"}
t_b = mix{{d1,0.4},{d0,0.6}, name="t_b"}
local b = brush{kind="filbert", width=5}
b:reload(t_a, 0.6); b:stroke({{132,84},{150,84}}, {pressure=0.6})
b:reload(t_b, 0.6); b:stroke({{132,94},{150,94}}, {pressure=0.6})
b:reload(sk95, 0.6); b:stroke({{132,104},{150,104}}, {pressure=0.6})

--@ chunk 122
local core = rect(124,72,48,50) * above(function(x) return 121 + 2*math.sin(x/3) end)
local soft = core:blur(3)
work(soft, {hand="detail", tool={kind="filbert", width=3}, piles={{t_a, function(x,y) return clamp(1-(y-90)/40,0.05,1) end},{sk95, function(x,y) return clamp((y-90)/40,0.0,1) end}}, angle=0, coverage=3.5, fill=true, clip=soft, seed=841})

--@ chunk 123
for pass=1,4 do
  local r = rag{width=14}; r:dip(0.95)
  r:wipe(rect(118,66,60,60), {pressure=0.95, angle=(pass%2==0) and 0 or math.pi/2, refold=0.15, seed=850+pass})
end

--@ chunk 124
print(wait(4*24*60))
for _,p in ipairs({{140,100},{150,80},{125,120},{160,320},{600,483},{900,560}}) do print(p[1],p[2],drying(p[1],p[2])) end

--@ chunk 125
c1 = mix{{d1,0.55},{d0,0.25},{d2,0.2}, name="c1"}
c2 = mix{{d1,0.5},{d2,0.5}, name="c2"}
local b = brush{kind="filbert", width=4}
b:reload(c1, 0.6); b:stroke({{124,76},{138,76}}, {pressure=0.6})
b:reload(c2, 0.6); b:stroke({{124,86},{138,86}}, {pressure=0.6})
b:reload(d1, 0.6); b:stroke({{160,76},{174,76}}, {pressure=0.6})
b:reload(d2, 0.6); b:stroke({{160,86},{174,86}}, {pressure=0.6})

--@ chunk 126
c3 = mix{{d0,1}, name="c3"}
c4 = mix{{d0,0.85},{d1,0.15}, name="c4"}
c4:add{{"raw umber",0.04},{"smalt",0.1}}
local b = brush{kind="filbert", width=4}
b:reload(c3, 0.6); b:stroke({{124,60},{138,60}}, {pressure=0.6})
b:reload(c4, 0.6); b:stroke({{160,60},{174,60}}, {pressure=0.6})

--@ chunk 127
pA = mix{{d0,0.9},{c1,0.1}, name="pA"}
pB = mix{{d0,0.65},{c1,0.35}, name="pB"}
pC = mix{{d0,0.4},{c1,0.6}, name="pC"}
local b = brush{kind="filbert", width=4}
b:reload(pA, 0.6); b:stroke({{124,96},{136,96}}, {pressure=0.6})
b:reload(pB, 0.6); b:stroke({{124,106},{136,106}}, {pressure=0.6})
b:reload(pC, 0.6); b:stroke({{124,116},{136,116}}, {pressure=0.6})
b:reload(pB, 0.6); b:stroke({{160,96},{172,96}}, {pressure=0.6})
b:reload(pC, 0.6); b:stroke({{160,106},{172,106}}, {pressure=0.6})
b:reload(c1, 0.6); b:stroke({{160,116},{172,116}}, {pressure=0.6})

--@ chunk 128
local k = knife{width=8}
for _,y in ipairs({60,76,86,96,106,116}) do
  k:scrape({{120,y},{140,y}}, {pressure=1}); k:wipe()
  k:scrape({{156,y},{178,y}}, {pressure=1}); k:wipe()
end
local cutY = 121
local region = rect(110,48,76,78) - (keep_all:grow(1) * below(function(x) return cutY end))
local soft = region:blur(3) * rect(100,40,96,90)
patch_soft = soft
work(soft, {hand="detail", tool={kind="filbert", width=3}, piles={
   {d0, function(x,y) return clamp(1 - (y-50)/75, 0.0, 1)*0.85 + 0.02 end},
   {c1, function(x,y) return clamp((y-50)/75, 0.0, 1) + 0.15 end}},
  angle=0, coverage=3.5, fill=true, clip=soft, seed=861})

--@ chunk 129
local k = knife{width=12}
for y=46,128,4 do
  k:scrape({{188,y},{108,y}}, {pressure=1, angle=math.pi/2}); k:wipe()
end
for pass=1,3 do
  local r = rag{width=14}; r:dip(0.95)
  r:wipe(rect(108,44,80,82), {pressure=0.95, angle=(pass%2==0) and 0 or math.pi/2, refold=0.15, seed=870+pass})
end

--@ chunk 130
print(wait(5*24*60))
for _,p in ipairs({{140,90},{150,60},{125,120},{600,483},{500,100}}) do print(p[1],p[2],drying(p[1],p[2])) end

--@ chunk 131
K = (trunk_keep + keep_crown) - rect(106,40,86,81)
local m = rect(0,0,1000,178) - K:grow(0.6) - ellipse(775,186,20,20)
restate_mask = m
local function wgt(c, r) return function(x,y) return math.max(0, 1 - math.abs(y-c)/r) end end
work(m, {hand="broad", piles={{d0,wgt(0,95)},{d1,wgt(75,90)},{d2,wgt(155,85)}}, angle=0, ruler=true, coverage=2.4, fill=true, clip=m,
  load_at=function(x,y) return clamp(1 - (y-125)/50, 0.0, 1) end, seed=881})
for i=1,3 do blend(m, {angle=0, seed=890+i}) end

--@ chunk 132
local bm = rect(0,145,1000,65) - K:grow(0.6) - ellipse(775,186,14,14)
for i=1,3 do blend(bm, {angle=(i==2) and 0.06 or -0.04, seed=900+i}) end

--@ chunk 133
local function wgt(c, r) return function(x,y) return math.max(0, 1 - math.abs(y-c)/r) end end
local prot = K:grow(0.8) + ellipse(775,186,14,14)
local bandB = rect(0,120,1000,95) - prot
work(bandB, {hand="broad", piles={{d2,wgt(140,40)},{d3,wgt(195,45)}}, angle=0, ruler=true, coverage=1.6, fill=true, clip=bandB, load_at=function(x,y) return clamp(1 - math.abs(y-165)/50, 0.0, 0.6) end, seed=911})
local bmB = (rect(0,105,1000,120)):blur(25) - prot
for i=1,3 do blend(bmB, {angle=0, seed=920+i}) end

--@ chunk 134
local function wgt(c, r) return function(x,y) return math.max(0, 1 - math.abs(y-c)/r) end end
local prot = K:grow(0.8)
local zone = (rect(60,40,520,150) - prot)
work(zone, {hand="body", tool="filbert 6", piles={{d0,wgt(0,95)},{d1,wgt(75,90)},{d2,wgt(155,85)},{d3,wgt(235,75)}}, angle=0, ruler=true, coverage=2.2, fill=true, clip=zone,
  length={20,50}, load_at=function(x,y) return clamp(1 - (y-150)/50, 0.0, 1) end, seed=931})
local bz = (rect(50,30,540,170)):blur(15) - prot
for i=1,2 do blend(bz, {angle=0, seed=940+i}) end

--@ chunk 135
print(wait(5*24*60))
for _,p in ipairs({{140,100},{300,60},{500,160},{150,200},{775,186}}) do print(p[1],p[2],drying(p[1],p[2])) end

--@ chunk 136
tree_body = mix{{t_dark,0.6},{g_tree,0.4}, name="tree_body"}
print(tree_body)

--@ chunk 137
local bulges = poly({{284,392},{278,402},{274,414},{275,426},{279,436},{285,442}}, true)
  + poly({{283,345},{276,352},{271,362},{273,372},{280,380},{286,384}}, true)
  + poly({{315,402},{321,410},{323,421},{321,433},{316,440}}, true)
  + poly({{316,440},{322,447},{327,456},{326,462},{318,462}}, true)
  + poly({{280,445},{274,452},{270,460},{284,462}}, true)
trunk_bulges = bulges:roughen(0.9, 5, 41)
work(trunk_bulges, {hand="detail", tool={kind="round", width=2.2, point=0.5}, pile=tree_body, coverage=3, fill=true, angle=-math.pi/2, seed=951})

--@ chunk 138
-- area to restore to sky: the stub beyond a splintered end
local cut = poly({{336,368},{358,366},{360,394},{334,396},{337,389},{333,385},{339,381},{335,377},{340,373}})
local m = cut - K:grow(0.5) - trunk_bulges
-- check we don't hit other limbs
print(m:area(), m:at(345,380), m:at(330,380))
work(m, {hand="detail", tool={kind="filbert", width=2.5}, pile=sky_fix, angle=0, coverage=3.5, fill=true, clip=m, seed=961})

--@ chunk 139
local cut = poly({{336,368},{358,366},{360,394},{334,396},{337,389},{333,385},{339,381},{335,377},{340,373}})
local m = cut - trunk_keep:grow(0.5) - trunk_bulges
print(m:area(), m:at(345,380), m:at(334,380))
work(m, {hand="detail", tool={kind="filbert", width=2.5}, pile=sky_fix, angle=0, coverage=3.5, fill=true, clip=m, seed=962})

--@ chunk 140
local m = (poly({{70,264},{118,262},{122,284},{70,286}}, true) - K:grow(0.6)):blur(1.5)
work(m, {hand="detail", tool={kind="filbert", width=2.5}, piles={{sk277, 0.6},{sk300, 0.4}}, angle=0, coverage=3.5, fill=true, clip=m, seed=971})
local m2 = (ellipse(130,192,18,12) - K:grow(0.6)):blur(1.5)
work(m2, {hand="detail", tool={kind="filbert", width=2.5}, piles={{sk277, 0.35},{s_mid, 0.65}}, angle=0, coverage=3.5, fill=true, clip=m2, seed=972})

--@ chunk 141
for pass=1,3 do
  local r = rag{width=10}; r:dip(0.95)
  r:wipe(ellipse(130,192,20,14), {pressure=0.95, angle=0, refold=0.15, seed=980+pass})
end

--@ chunk 142
for pass=1,3 do
  local r = rag{width=14}; r:dip(0.95)
  r:wipe(ellipse(130,192,28,20), {pressure=0.95, angle=(pass%2==0) and 0 or math.pi/2, refold=0.12, seed=990+pass})
end
local k = knife{width=10}
for y=176,210,4 do k:scrape({{158,y},{102,y}}, {pressure=1, angle=math.pi/2}); k:wipe() end

--@ chunk 143
print(wait(5*24*60))
for _,p in ipairs({{130,192},{95,275},{345,380},{290,420},{300,60}}) do print(p[1],p[2],drying(p[1],p[2])) end

--@ chunk 144
print(wait(3*24*60))
for _,p in ipairs({{95,275},{345,380},{340,390}}) do print(p[1],p[2],drying(p[1],p[2])) end

--@ chunk 145
s_top = pile{{"lead white",1.5},{"smalt",1.2},{"cobalt blue",0.8},{"raw umber",0.08}, name="s_top"}
local function wgt(c, r) return function(x,y) return math.max(0, 1 - math.abs(y-c)/r) end end
TREE = K + trunk_bulges
local band = rect(0,160,320,180) - TREE:grow(0.6)
work(band, {hand="broad", piles={{s_top,wgt(120,120)},{s_mid,wgt(235,110)},{s_grn,wgt(325,100)},{s_glow,wgt(400,80)}}, angle=0, ruler=true, coverage=2.2, fill=true, clip=band,
  load_at=function(x,y) return clamp(1 - math.abs(y-250)/90, 0.0, 1)^0.7 * clamp((320-x)/80, 0, 1) end, seed=1001})
local bz = rect(0,150,340,200):blur(20) - TREE:grow(0.6)
for i=1,3 do blend(bz, {angle=0, seed=1010+i}) end

--@ chunk 146
local function wgt(c, r) return function(x,y) return math.max(0, 1 - math.abs(y-c)/r) end end
local band = rect(250,150,400,300) - TREE:grow(0.6) - fig_mask:grow(2) - below(far_top):grow(1)
work(band, {hand="broad", piles={{s_top,wgt(120,120)},{s_mid,wgt(235,110)},{s_grn,wgt(325,100)},{s_glow,wgt(400,80)},{s_low,wgt(465,70)}}, angle=0, ruler=true, coverage=2.2, fill=true, clip=band,
  load_at=function(x,y) return clamp((y-150)/60, 0.0, 1)^0.7 * clamp(math.min(x-250, 650-x)/80, 0, 1) end, seed=1021})
local bz = (rect(240,140,420,320):blur(20) - TREE:grow(0.6)) * above(far_top):shrink(2)
for i=1,3 do blend(bz, {angle=0, seed=1030+i}) end

--@ chunk 147
print(drying(459,452), drying(663,440), drying(459,470))
local headz = ellipse(458.5, 452, 9, 10)
local churchz = rect(642, 420, 30, 40)
for pass=1,3 do
  local r = rag{width=6}; r:dip(0.95)
  r:wipe(headz, {pressure=0.95, angle=(pass%2==0) and 0 or math.pi/2, refold=0.1, seed=1040+pass})
  r = rag{width=6}; r:dip(0.95)
  r:wipe(churchz, {pressure=0.95, angle=(pass%2==0) and 0 or math.pi/2, refold=0.1, seed=1050+pass})
end

--@ chunk 148
print(wait(4*24*60))
for _,p in ipairs({{100,250},{400,300},{495,458},{600,420},{459,452}}) do print(p[1],p[2],drying(p[1],p[2])) end

--@ chunk 149
local function cy(x) return 463.5 - 8.5 * smoothstep(482, 520, x) end
local pts = {}
for x=478,524,2 do pts[#pts+1] = {x, cy(x)} end
local m = below(pts) * rect(478,450,46,16) * above(function(x) return 466 end)
work(m, {hand="detail", tool={kind="round", width=1.6, point=0.4}, pile=f_land2, angle=0, coverage=3.5, fill=true, clip=m, seed=1061})
-- head: hair colour again, small
local hb = brush{kind="round", width=1.6, point=0.6}
work(fp.head:shrink(0.4), {hand="detail", tool=hb, pile=fig_hair, coverage=3, fill=true, seed=1062})
work(fp.cap:shrink(0.3), {hand="detail", tool=hb, pile=fig_cap, coverage=3, fill=true, angle=0, seed=1063})

--@ chunk 150
t_twig = pile{{"raw umber",1.2},{"bone black",0.8},{"Prussian blue",0.08},{"red earth",0.05}, medium=0.15, name="t_twig"}
rg_s = brush{kind="rigger", width=1.6, point=1}
rd_m = brush{kind="round", width=4, point=1}
function angular_pts(x, y, ang, len, nseg, jit, upb)
  local nodes = {{x, y, ang}}
  local a = ang
  local cx, cy = x, y
  for i=1,nseg do
    local seg = len/nseg * rand(0.7, 1.3)
    a = a + randn(0, jit)
    a = a + upb*((-math.pi/2) - a) + 0.3*(ang - a)
    cx, cy = cx + seg*math.cos(a), cy + seg*math.sin(a)
    nodes[#nodes+1] = {cx, cy, a}
  end
  return nodes
end
function draw_angular(br, nodes, w0, pl)
  local pts = {}
  local n = #nodes
  for i=1,n-1 do
    local a, b = nodes[i], nodes[i+1]
    for k=0,2 do
      local t = k/3
      local tt = ((i-1) + t)/(n-1)
      local w = w0*(1 - 0.75*tt)
      local p = math.max(0.3, br:pressure_for(math.max(w, 0.7)))
      pts[#pts+1] = {lerp(a[1], b[1], t), lerp(a[2], b[2], t), p}
    end
  end
  pts[#pts+1] = {nodes[n][1], nodes[n][2], 0.08}
  if br:fullness() < 0.45 then br:reload(pl, 0.75) end
  br:gesture(pts, {wobble=0.1, ramps={0.02, 0.25}})
end
function oak_spray(x, y, ang, len, w, depth, pl)
  local br = (w > 1.7) and rd_m or rg_s
  local nodes = angular_pts(x, y, ang, len, math.random(2, 3), 0.45, 0.1)
  draw_angular(br, nodes, w, pl)
  if depth > 0 then
    local tip = nodes[#nodes]
    local wc = math.max(0.8, w*0.62)
    oak_spray(tip[1], tip[2], tip[3] + randn(0, 0.25), len*rand(0.55, 0.8), wc, depth-1, pl)
    for j=1,math.random(1, 2) do
      local s = (math.random()<0.5) and -1 or 1
      oak_spray(tip[1], tip[2], tip[3] + s*rand(0.5, 1.0), len*rand(0.45, 0.7), wc, depth-1, pl)
    end
    if #nodes > 2 and math.random() < 0.5 then
      local nd = nodes[2]
      local s = (math.random()<0.5) and -1 or 1
      oak_spray(nd[1], nd[2], nd[3] + s*rand(0.6, 1.1), len*rand(0.4, 0.6), wc, depth-1, pl)
    end
  end
end
-- choose tips
tips = {}
for i, b in ipairs(crown) do
  local p = b[1]
  if #p >= 2 and i < #crown then
    local e, pr = p[#p], p[#p-1]
    tips[#tips+1] = {e[1], e[2], math.atan(e[2]-pr[2], e[1]-pr[1]), b.level}
  end
end
for i, L in ipairs(oak) do
  if i ~= 1 and i ~= 6 and i ~= 9 and i ~= 17 then
    local p = L[1]; local e, pr = p[#p], p[#p-1]
    tips[#tips+1] = {e[1], e[2], math.atan(e[2]-pr[2], e[1]-pr[1]), 1}
  end
end
print(#tips)

--@ chunk 151
rg_s:reload(t_twig, 0.75); rd_m:reload(t_twig, 0.75)
local Kg = K:grow(1.5)
local nb, ns, nd, nskip = 0, 0, 0, 0
local nz = noise{seed=1071, period=120}
for _, t in ipairs(tips) do
  local x, y, a = t[1], t[2], t[3]
  if Kg:at(x, y) < 0.3 then
    nskip = nskip + 1
  else
    local bare_p = (y < 115) and 0.6 or 0.22
    local dense = nz:at01(x, y)  -- clusters of denser growth
    local r = math.random()
    if r < bare_p then
      nb = nb + 1
    elseif dense > 0.55 and math.random() < 0.7 then
      oak_spray(x, y, a + randn(0, 0.2), rand(18, 26), 1.8, 2, t_twig); nd = nd + 1
    else
      oak_spray(x, y, a + randn(0, 0.25), rand(11, 18), 1.4, 1, t_twig); ns = ns + 1
    end
  end
end
print("bare", nb, "small", ns, "dense", nd, "skipped", nskip)

--@ chunk 152
haze_twig = mix{{t_twig,0.55},{d2,0.45}, name="haze_twig"}
hr = brush{kind="rigger", width=1.0, point=1}
function hair(x, y, ang, len, pl)
  local nodes = angular_pts(x, y, ang, len, 2, 0.35, 0.08)
  local pts = {}
  for i, nd in ipairs(nodes) do pts[#pts+1] = {nd[1], nd[2], (i==#nodes) and 0.05 or 0.3} end
  if hr:fullness() < 0.4 then hr:reload(pl, 0.6) end
  hr:gesture(pts, {wobble=0.05, ramps={0.02, 0.4}})
end
hr:reload(haze_twig, 0.6)
local Kg = K:grow(1.5)
local n = 0
for _, t in ipairs(tips) do
  local x, y, a = t[1], t[2], t[3]
  if Kg:at(x, y) >= 0.3 and y > 100 and math.random() < 0.4 then
    for j=1,math.random(2,4) do
      local sx, sy = x + math.cos(a)*rand(4, 12), y + math.sin(a)*rand(4, 12)
      hair(sx, sy, a + randn(0, 0.6), rand(6, 13), haze_twig); n = n + 1
    end
  end
end
print(n)

--@ chunk 153
lev = pile{{"bone black",1},{"raw umber",1.2},{"green earth",0.3},{"Prussian blue",0.05}, medium=0.5, name="lev"}
lev_sl = pile{{"raw umber",1.3},{"green earth",0.7},{"yellow ochre",0.3},{"bone black",0.4},{"lead white",0.06}, medium=0.5, name="lev_sl"}
local k = knife{width=50}
local rows = 0
for r=0,12 do
  local d = 27 + r*21
  local x = -30 + (r % 3) * 35
  while x < 1030 do
    local x1 = math.min(x + rand(170, 230), 1035)
    local skip = false
    if r == 0 and ((x1 > 235 and x < 372) or (x1 > 425 and x < 492)) then skip = true end
    if not skip then
      local pts = {}
      for xx = x, x1, 15 do
        local yy = math.min(hy(clamp(xx,0,1000)) + d, 745)
        pts[#pts+1] = {xx, yy}
      end
      if #pts >= 2 then
        local mid = pts[math.floor(#pts/2)+1]
        local onslope = clamp(smoothstep(430, 620, mid[1]) * (1 - (d-27)/60), 0, 1)
        local p = (onslope > 0.5) and lev_sl or lev
        k:load(p, 1.0)
        k:lay(pts, {pressure={0.12,0.12}})
        rows = rows + 1
      end
    end
    x = x1 + 2
  end
end
print(rows)

--@ chunk 154
for _,p in ipairs({{50,540},{100,560},{150,580},{200,620},{300,560},{500,600},{100,680}}) do print(p[1],p[2],drying(p[1],p[2])) end

--@ chunk 155
local k = knife{width=50}
local pts = {}
for xx = -30, 230, 20 do pts[#pts+1] = {xx, math.min(hy(clamp(xx,0,1000)) + 44, 745)} end
k:scrape(pts, {pressure=1}); k:wipe()
print(drying(100,560), drying(150,580))

--@ chunk 156
for _,p in ipairs({{75,579},{42,608},{150,560},{60,590},{170,585},{120,600},{20,560}}) do print(p[1],p[2],drying(p[1],p[2])) end

--@ chunk 157
for _,p in ipairs({{60,560},{62,560},{64,560},{66,560},{68,560},{70,560},{72,560},{74,560},{76,560},{78,560}}) do io_d = drying(p[1],p[2]); print(p[1],p[2],io_d) end

--@ chunk 158
local k = knife{width=50}
local pts = {}
for xx = 230, 490, 52 do pts[#pts+1] = {xx, math.min(hy(xx) + 63, 745)} end
k:scrape(pts, {pressure=1}); k:wipe()
print(#pts)

--@ chunk 159
function scrape_row(r, k)
  local d = 25 + r*19
  local x = -30
  while x < 1020 do
    local x1 = math.min(x + 260, 1035)
    local pts = {}
    for xx = x, x1, 52 do
      pts[#pts+1] = {xx, math.min(hy(clamp(xx,0,1000)) + d, 745)}
    end
    if pts[#pts][1] < x1 then pts[#pts+1] = {x1, math.min(hy(clamp(x1,0,1000)) + d, 745)} end
    local skip = (r == 0 and ((x1 > 235 and x < 372) or (x1 > 425 and x < 492)))
    if not skip then k:scrape(pts, {pressure=1}); k:wipe() end
    if x1 >= 1035 then break end
    x = x1 - 10
  end
end
local k = knife{width=50}
for r=0,13 do scrape_row(r, k) end
print("ok")

--@ chunk 160
for _,p in ipairs({{40,560},{60,575},{80,580},{150,560},{200,570},{230,575},{100,620},{300,600}}) do print(p[1],p[2],drying(p[1],p[2])) end

--@ chunk 161
local area = (rect(0,500,620,140) * hill_all) - oak_mask:grow(3) - fig_mask:grow(3)
for pass=1,2 do
  local r = rag{width=30}
  r:dip(0.95)
  r:wipe(area, {pressure=0.95, angle=0.02, passes=1, refold=0.25, seed=1100+pass})
end
for _,p in ipairs({{80,580},{150,560},{200,570},{230,575}}) do print(p[1],p[2],drying(p[1],p[2])) end

--@ chunk 162
print(wait(7*24*60))
for _,p in ipairs({{80,580},{150,560},{200,570},{230,575},{500,560},{800,650}}) do print(p[1],p[2],drying(p[1],p[2])) end

--@ chunk 163
print(wait(7*24*60))
for _,p in ipairs({{80,580},{150,560},{200,570},{230,575},{100,600},{300,560}}) do print(p[1],p[2],drying(p[1],p[2])) end

--@ chunk 164
hb_main = pile{{"bone black",1},{"raw umber",1.2},{"green earth",0.35},{"Prussian blue",0.05}, medium=0.4, name="hb_main"}
hb_rim  = pile{{"raw umber",1.3},{"green earth",0.7},{"yellow ochre",0.25},{"bone black",0.45},{"lead white",0.06}, medium=0.4, name="hb_rim"}
hb_low  = pile{{"bone black",1.2},{"raw umber",1},{"Prussian blue",0.06},{"green earth",0.2}, medium=0.4, name="hb_low"}
local m = hill_all - oak_mask:grow(0.5) - fig_mask:grow(1)
local function rimw(x,y) local d = y - hy(x); return clamp(smoothstep(430, 640, x) * (1 - d/70), 0, 1) * 0.85 end
local function loww(x,y) local d = y - hy(x); return clamp((d - 70)/110, 0, 1) end
work(m, {hand="body", tool="filbert 9", piles={
    {hb_rim, function(x,y) return rimw(x,y) end},
    {hb_low, function(x,y) return loww(x,y)*(1-rimw(x,y)) end},
    {hb_main, function(x,y) return math.max(0.03, (1-loww(x,y))*(1-rimw(x,y))) end}},
  angle=function(x,y) local d = clamp((y - hy(x))/120, 0, 1); return lerp(math.atan(hy(x+15) - hy(x-15), 30), 0.02, d) end,
  coverage=2.2, fill=true, clip=m, length={30,80}, seed=1201})

--@ chunk 165
function plens(x0, x1, y, th, seed, skew)
  skew = skew or 0
  local nz = noise{seed=seed, period=18, octaves=2}
  local top, bot = {}, {}
  local n = math.max(10, math.floor((x1-x0)/4))
  for i=0,n do
    local t = i/n
    local x = lerp(x0, x1, t)
    local env = math.sin(math.pi*t)^0.45
    local yy = y + skew*(t-0.5)
    top[#top+1] = {x, yy - th*0.42*env*(0.7+0.6*nz:at01(x, y))}
    bot[#bot+1] = {x, yy + th*0.58*env*(0.6+0.8*nz:at01(x+70, y))}
  end
  local pts = {}
  for i=1,#top do pts[#pts+1] = top[i] end
  for i=#bot,1,-1 do pts[#pts+1] = bot[i] end
  return poly(pts, true)
end
pool2 = (plens(812, 952, 556, 8, 91, 2) + plens(925, 1004, 561, 5, 92, 1) + plens(760, 815, 551, 3, 93, 0.5)):roughen(0.4, 3, 94)
pool_sky = pile{{"lead white",3},{"cobalt blue",0.55},{"smalt",0.6},{"raw umber",0.55},{"Naples yellow",0.3}, name="pool_sky"}
pool_bank = mix{{m_mid,0.5},{m_far,0.3},{pool_sky,0.2}, name="pool_bank"}
print(pool2:area())

--@ chunk 166
pool_sky:add{{"cobalt blue",0.2},{"smalt",0.25},{"raw umber",0.2}}
print(pool_sky)

--@ chunk 167
local fb = brush{kind="flat", width=3}
work(pool2, {hand="detail", tool=fb, pile=pool_sky, coverage=3.5, fill=true, angle=0, seed=1211})
local shifted = (plens(812, 952, 558, 8, 91, 2) + plens(925, 1004, 563, 5, 92, 1) + plens(760, 815, 553, 3, 93, 0.5)):roughen(0.4, 3, 94)
pool_refl = pool2 - shifted
work(pool_refl, {hand="detail", tool={kind="round", width=1.4, point=0.4}, pile=pool_bank, coverage=3, fill=true, angle=0, seed=1212})

--@ chunk 168
function plens2(x0, x1, y, th, seed, skew)
  skew = skew or 0
  local nz = noise{seed=seed, period=40, octaves=2}
  local top, bot = {}, {}
  local n = math.max(10, math.floor((x1-x0)/5))
  for i=0,n do
    local t = i/n
    local x = lerp(x0, x1, t)
    local env = math.sin(math.pi*t)^0.7
    local yy = y + skew*(t-0.5)
    top[#top+1] = {x, yy - th*0.55*env*(0.5+1.0*nz:at01(x, y))}
    bot[#bot+1] = {x, yy + th*0.45*env*(0.8+0.4*nz:at01(x+70, y))}
  end
  local pts = {}
  for i=1,#top do pts[#pts+1] = top[i] end
  for i=#bot,1,-1 do pts[#pts+1] = bot[i] end
  return poly(pts, true)
end
cl_a = pile{{"lead white",3},{"Naples yellow",0.7},{"smalt",0.35},{"rose madder",0.1},{"raw umber",0.2}, name="cl_a"}
cl_c = pile{{"lead white",2.6},{"Naples yellow",0.6},{"smalt",0.5},{"rose madder",0.1},{"raw umber",0.3}, name="cl_c"}
cloud_bars = plens2(830, 1012, 383.5, 9, 11, 2) + plens2(875, 1012, 371.5, 4, 16, 0) + plens2(645, 875, 380.5, 5.5, 12, 1) + plens2(690, 785, 392.5, 3, 15, 0)
local fb = brush{kind="flat", width=3}
work(cloud_bars, {hand="detail", tool=fb, piles={{cl_c, 0.6},{cl_a, 0.4}}, coverage=3, fill=true, angle=0, seed=1301})

--@ chunk 169
local extra = plens2(892, 1012, 389.5, 5, 17, 1) + plens2(555, 640, 385, 2, 18, 0)
cloud_bars = cloud_bars + extra
local fb = brush{kind="flat", width=3}
work(extra, {hand="detail", tool=fb, piles={{cl_c, 0.6},{cl_a, 0.4}}, coverage=3, fill=true, angle=0, seed=1302})

--@ chunk 170
print(wait(8*24*60))
for _,p in ipairs({{300,510},{200,560},{500,560},{391,478},{880,556},{900,385}}) do print(p[1],p[2],drying(p[1],p[2])) end

--@ chunk 171
local bowl = (ellipse(300, 508, 58, 22) * below(function(x) return hy(x) + 6 end)) - oak_mask:grow(1)
work(bowl:blur(3), {hand="body", tool="filbert 7", pile=hb_main, angle=0.02, coverage=2.6, fill=true, clip=bowl:blur(3), length={20,45}, seed=1311})

--@ chunk 172
local reg = (rect(225, 470, 170, 70) * below(function(x) return hy(x) + 2 end)) - oak_mask:grow(0.5)
local soft = reg:blur(6) - oak_mask:grow(0.5)
work(soft, {hand="body", tool="filbert 5", piles={{hb_main,0.6},{hb_low,0.4}}, angle=0.02, coverage=3, fill=true, clip=soft, length={15,35}, seed=1312})
-- the light speck right of the trunk
local b = brush{kind="round", width=3, point=0.3}
b:load(hb_main, 0.6); b:touch(391, 478.5, {pressure=0.5})

--@ chunk 173
print(wait(10*24*60))
for _,p in ipairs({{300,508},{250,500},{380,520}}) do print(p[1],p[2],drying(p[1],p[2])) end

--@ chunk 174
print(wait(5*24*60))
print(drying(250,500), drying(300,505))
g_shadow = pile{{"bone black",1.2},{"raw umber",0.8},{"Prussian blue",0.06}, medium=0.75, name="g_shadow"}
local reg = (ellipse(305, 507, 72, 28) * below(function(x) return hy(x) + 1 end)) - oak_mask:grow(0.5)
local soft = reg:blur(8) - oak_mask:grow(0.5)
work(soft, {hand="detail", tool={kind="filbert", width=6}, pile=g_shadow, coverage=2.5, fill=true, angle=0, clip=soft, seed=1321})

--@ chunk 175
for pass=1,3 do
  local r = rag{width=20}; r:dip(0.95)
  r:wipe((ellipse(305, 510, 80, 34) * below(function(x) return hy(x) + 3 end)), {pressure=0.9, angle=0, refold=0.2, seed=1330+pass})
end
oak_clean = (trunk_keep * above(function(x) return hy(x) + 3 end)) + (poly(oak_roots, true):roughen(1.0,5,3) * above(function(x) return hy(x) + 3 end))
print(oak_clean:at(300,505), oak_clean:at(300,470), oak_mask:at(300,505))

--@ chunk 176
print(wait(8*24*60))
for _,p in ipairs({{250,500},{300,505},{360,520},{240,525},{350,478}}) do print(p[1],p[2],drying(p[1],p[2])) end

--@ chunk 177
local reg = (rect(200, 470, 220, 85) * below(function(x) return hy(x) + 0.5 end)) - oak_clean:grow(0.5)
local soft = (reg:blur(6) * below(function(x) return hy(x) + 0.5 end)) - oak_clean:grow(0.5)
work(soft, {hand="body", tool="filbert 7", piles={{hb_main,0.7},{hb_low,0.3}}, angle=0.02, coverage=3, fill=true, clip=soft, length={20,50}, seed=1341})

--@ chunk 178
tuft_p = pile{{"bone black",1},{"raw umber",0.7},{"green earth",0.25},{"Prussian blue",0.06}, medium=0.2, name="tuft_p"}
trg = brush{kind="rigger", width=1.4, point=1}
function tuft2(x, y, size, pl)
  local n = math.random(8, 14)
  for i=1,n do
    local a = -math.pi/2 + randn(0, 0.3)
    local L = size * rand(0.35, 1.0)
    local bx = x + randn(0, size*0.25)
    local by = y + rand(0.8, 1.8)
    local bend = randn(0, 0.2)
    local mx, my = bx + math.cos(a)*L*0.5, by + math.sin(a)*L*0.5
    local ex, ey = bx + math.cos(a+bend)*L, by + math.sin(a+bend)*L
    if trg:fullness() < 0.4 then trg:reload(pl, 0.6) end
    trg:gesture({{bx, by, 0.32}, {mx, my, 0.22}, {ex, ey, 0.03}}, {wobble=0.03, ramps={0.02, 0.5}})
  end
end
function bump(x, y, w, h, pl, seed)
  local m = ellipse(x, y + h*0.2, w/2, h):roughen(0.5, 2, seed) * above(function(xx) return y + 3 end)
  work(m, {hand="detail", tool={kind="round", width=1.4, point=0.5}, pile=pl, coverage=3, fill=true, seed=seed})
end
trg:reload(tuft_p, 0.6)
local x = 4
local nb, nt = 0, 0
while x < 650 do
  local nearTree = (x > 248 and x < 366)
  local nearFig = (x > 440 and x < 474)
  if not nearTree and not nearFig then
    local y = hy(x) + 0.6
    local r = math.random()
    if r < 0.32 then bump(x, y, rand(6, 15), rand(1.2, 3.0), tuft_p, 1400 + nb); nb = nb + 1
    elseif r < 0.72 then tuft2(x, y, rand(3, 6.5), tuft_p); nt = nt + 1 end
  end
  x = x + rand(9, 30)
end
print(nb, nt)

--@ chunk 179
mead_hz = mix{{m_far,0.55},{m_mid,0.25},{s_glow,0.2}, name="mead_hz"}

--@ chunk 180
local butt = poly({{280,444},{275,452},{270,460},{264,468},{257,476},{252,481},{270,482},{288,481},{288,450}}, true):roughen(0.8, 4, 77)
local m = butt * above(function(x) return hy(x) + 2 end)
work(m, {hand="detail", tool={kind="round", width=2.2, point=0.5}, pile=tree_body, coverage=3, fill=true, angle=-math.pi/2, seed=1501})

--@ chunk 181
hz_top = mix{{m_far,0.5},{s_glow,0.3},{m_mid,0.2}, name="hz_top"}
hz_bot = mix{{m_far,0.45},{m_mid,0.45},{s_glow,0.1}, name="hz_bot"}
local b = brush{kind="filbert", width=4}
b:reload(hz_top, 0.6); b:stroke({{20,482},{40,482}}, {pressure=0.6})
b:reload(hz_bot, 0.6); b:stroke({{20,498},{40,498}}, {pressure=0.6})

--@ chunk 182
hz_top = mix{{m_far,0.72},{m_mid,0.18},{s_glow,0.1}, name="hz_top"}
hz_bot = mix{{m_far,0.55},{m_mid,0.4},{m_near,0.05}, name="hz_bot"}
local b = brush{kind="filbert", width=4}
b:reload(hz_top, 0.6); b:stroke({{60,482},{80,482}}, {pressure=0.6})
b:reload(hz_bot, 0.6); b:stroke({{60,498},{80,498}}, {pressure=0.6})

--@ chunk 183
hz_top = mix{{m_far,0.55},{m_mid,0.25},{m_near,0.2}, name="hz_top"}
hz_bot = mix{{m_far,0.4},{m_mid,0.35},{m_near,0.25}, name="hz_bot"}
local b = brush{kind="filbert", width=4}
b:reload(hz_top, 0.6); b:stroke({{100,482},{118,482}}, {pressure=0.6})
b:reload(hz_bot, 0.6); b:stroke({{100,492},{118,492}}, {pressure=0.6})

--@ chunk 184
lm_top = mix{{m_far,0.64},{m_mid,0.22},{m_near,0.09},{s_glow,0.05}, name="lm_top"}
lm_bot = mix{{m_far,0.5},{m_mid,0.33},{m_near,0.17}, name="lm_bot"}
local strip = (rect(0,474,262,50) * above(function(x) return hy(x) + 1.5 end)) * below(far_top) - oak_clean:grow(0.5)
left_strip = strip
work(strip, {hand="body", tool="filbert 5", piles={{lm_top, function(x,y) return clamp(1-(y-476)/30,0.05,1) end},{lm_bot, function(x,y) return clamp((y-476)/30,0.05,1) end}},
  angle=0, ruler=true, coverage=2.6, fill=true, clip=strip, length={30,70}, seed=1511})

--@ chunk 185
for _,p in ipairs({{614,572},{633,583},{560,540},{600,563}}) do print(p[1],p[2],drying(p[1],p[2]), string.format("%.1f", hy(p[1]))) end

--@ chunk 186
local k = knife{width=12}
local pts = {}
for x = 500, 690, 19 do pts[#pts+1] = {x, hy(x) - 1} end
k:scrape(pts, {pressure=1}); k:wipe()
pts = {}
for x = 500, 690, 19 do pts[#pts+1] = {x, hy(x) + 2} end
k:scrape(pts, {pressure=1}); k:wipe()
for _,p in ipairs({{614,572},{633,583}}) do print(p[1],p[2],drying(p[1],p[2])) end

--@ chunk 187
for pass=1,3 do
  local pts = {}
  for x = 500, 690, 19 do pts[#pts+1] = {x, hy(x) - 0.5} end
  local r = rag{width=7}; r:dip(0.95)
  r:wipe(pts, {pressure=0.95})
end

--@ chunk 188
function bank(x0, x1, hmax, seed)
  local nz = noise{seed=seed, period=6, octaves=2}
  local pts = {}
  for x = x0, x1, 1.5 do
    local t = (x - x0)/(x1 - x0)
    local env = math.sin(math.pi*t)^0.6
    pts[#pts+1] = {x, hy(x) - hmax*env*(0.55 + 0.45*nz:at01(x, 0))}
  end
  for x = x1, x0, -3 do pts[#pts+1] = {x, hy(x) + 4} end
  return poly(pts, true)
end
local b1 = bank(493, 526, 4.5, 1601)
local b2 = bank(598, 650, 5.5, 1602)
banks = b1 + b2
work(banks, {hand="detail", tool={kind="round", width=1.4, point=0.5}, piles={{hb_main,0.7},{tuft_p,0.3}}, coverage=3.5, fill=true, angle=0, seed=1603})

--@ chunk 189
print(wait(6*24*60))
for _,p in ipairs({{614,572},{633,583},{510,505},{100,490}}) do print(p[1],p[2],drying(p[1],p[2])) end

--@ chunk 190
print(wait(8*24*60))
for _,p in ipairs({{614,572},{633,583},{510,505},{100,490},{620,575}}) do print(p[1],p[2],drying(p[1],p[2])) end

--@ chunk 191
print(wait(6*24*60))
for _,p in ipairs({{633,583},{510,505},{620,575}}) do print(p[1],p[2],drying(p[1],p[2])) end

--@ chunk 192
-- fill the light gap between bank and the hill along the right slope: a band just under/around the crest
local band = nil
local pts = {}
for x = 480, 700, 4 do pts[#pts+1] = {x, hy(x) + 2.5} end
band = ribbon(pts, 6)
local m = (band + banks) * below(function(x) return hy(x) - 1 end)
local m2 = m + (banks:grow(1.5) * below(function(x) return hy(x) - 6 end))
work(m2, {hand="detail", tool={kind="round", width=1.8, point=0.4}, pile=hb_main, coverage=3.5, fill=true, angle=0, seed=1701})

--@ chunk 193
local m = (rect(470, 480, 260, 140) * below(function(x) return hy(x) + 0.5 end)) * above(function(x) return hy(x) + 40 end)
blend(m, {angle=function(x,y) return math.atan(hy(x+15) - hy(x-15), 30) end, seed=1702})
blend(m, {angle=function(x,y) return math.atan(hy(x+15) - hy(x-15), 30) + 0.1 end, seed=1703})

--@ chunk 194
local m = (rect(470, 480, 290, 170):blur(30)) * below(function(x) return hy(x) + 0.5 end)
for i=1,3 do
  blend(m, {angle=function(x,y) return math.atan(hy(x+15) - hy(x-15), 30)*0.6 + (i-2)*0.15 end, seed=1710+i})
end

--@ chunk 195
print(wait(15*24*60))
for _,p in ipairs({{620,600},{700,620},{300,600},{900,560},{900,385},{120,490}}) do print(p[1],p[2],drying(p[1],p[2])) end

--@ chunk 196
local b = brush{kind="round", width=2.5, point=0.5}
b:load(t_twig, 0.7)
b:gesture({{142,131,0.6},{141,126,0.55},{142,121,0.45}}, {ramps={0.05,0.1}})
b:reload(t_twig, 0.7)
b:gesture({{151,128,0.6},{152,123,0.5},{154,119,0.4}}, {ramps={0.05,0.1}})
b:reload(t_twig, 0.7)
b:gesture({{156,127,0.4},{161,124,0.3},{168,121,0.1}}, {ramps={0.05,0.3}})
-- white speck right of trunk on crest
local s = brush{kind="round", width=3, point=0.3}
s:load(hb_main, 0.7); s:touch(390.5, 479, {pressure=0.6}); s:touch(392, 480, {pressure=0.6})

--@ chunk 197
local b = brush{kind="rigger", width=1.6, point=1}
b:load(t_twig, 0.7)
b:gesture({{153,128,0.5},{159,124,0.4},{166,120,0.05}}, {ramps={0.05,0.4}})
b:reload(t_twig, 0.7)
b:gesture({{141,128,0.5},{141.5,124,0.4},{143,119,0.05}}, {ramps={0.05,0.4}})

--@ chunk 198
-- slope the step: fill a wedge from (488,463) rising to (506,455)
local wedge = poly({{486,463.8},{494,461.5},{500,459},{505,456.5},{509,455.3},{509,464},{486,464}}, true)
local m = wedge * above(function(x) return 470 end) - fig_mask:grow(1)
work(m, {hand="detail", tool={kind="round", width=1.4, point=0.4}, pile=f_land2, coverage=4, fill=true, angle=0, clip=m, seed=1801})

--@ chunk 199
local cutc = poly({{500,452},{516,452},{516,454.2},{512,454.6},{508,455.6},{504,457.2},{500,459}}, true)
local m = cutc * below(function(x) return 450 end)
work(m, {hand="detail", tool={kind="round", width=1.4, point=0.4}, pile=sky_low, coverage=4, fill=true, angle=0, clip=m, seed=1802})

--@ chunk 200
g_near = pile{{"bone black",1.2},{"raw umber",0.9},{"Prussian blue",0.08}, medium=0.7, name="g_near"}
local hillm = hill_all * below(function(x) return hy(x) + 6 end)
local m = hillm - fig_mask:grow(1)
work(m, {hand="glaze", pile=g_near, angle=0.02, coverage=2, fill=true, clip=m, load_at=function(x,y) return clamp((y-575)/130, 0, 1) end, seed=1901})

--@ chunk 201
print(wait(7*24*60))
for _,p in ipairs({{300,690},{300,520},{700,650},{200,600}}) do print(p[1],p[2],drying(p[1],p[2])) end

--@ chunk 202
cool_t = pile{{"bone black",1},{"raw umber",1.2},{"green earth",0.35},{"Prussian blue",0.05},{"lead white",0.35},{"smalt",0.3},{"cobalt blue",0.18}, thinner=0.5, name="cool_t"}
-- top plane of the hill: from the crest down ~38 units, strongest left of the figure, fading right along the slope
local top = (hill_all * above(function(x) return hy(x) + 38 end)) * below(function(x) return hy(x) + 1.2 end)
local fade = top:times(function(x,y)
  local d = (y - hy(x)) / 38
  local fx = 1 - smoothstep(420, 600, x)
  return clamp(1 - d, 0, 1) * (0.35 + 0.65*fx)
end)
local m = fade - oak_clean:grow(1) - fig_mask:grow(1)
work(m, {hand="body", tool="filbert 7", pile=cool_t, angle=function(x,y) return math.atan(hy(x+15) - hy(x-15), 30) end, coverage=1.5, clip=m, length={30,70},
  load_at=function(x,y) return clamp(1 - (y - hy(x))/38, 0, 1) end, seed=1911})

--@ chunk 203
local band = (hill_all * above(function(x) return hy(x) + 60 end)) * below(function(x) return hy(x) + 1.5 end) - oak_clean:grow(1.5) - fig_mask:grow(2)
blend(band, {angle=0.02, seed=1921})
blend(band, {angle=-0.05, seed=1922})

--@ chunk 204
print(string.format("%.1f %.1f %.1f", hy(240), hy(250), hy(262)))
local root = poly({{274,452},{268,460},{262,468},{256,474},{249,479},{242,483.5},{236,485.5},{250,486},{266,486},{280,484},{282,460}}, true):roughen(0.7, 3, 1931)
local m = root * above(function(x) return hy(x) + 2 end)
work(m, {hand="detail", tool={kind="round", width=2, point=0.5}, pile=tree_body, coverage=3.5, fill=true, angle=-0.6, seed=1932})

--@ chunk 205
-- a gentle swell in the left profile
local sw = {}
for x = 30, 120, 3 do
  local t = (x - 30)/90
  sw[#sw+1] = {x, hy(x) - 4.2*math.sin(math.pi*t)^1.5}
end
for x = 120, 30, -6 do sw[#sw+1] = {x, hy(x) + 4} end
local swell = poly(sw, true):roughen(0.5, 3, 1941)
work(swell, {hand="detail", tool={kind="round", width=1.8, point=0.4}, pile=hb_main, coverage=3.5, fill=true, angle=0, seed=1942})
-- tussocks: clump body + blades
function tussock(x, w, h, seed)
  local y = hy(x) + 1
  local body = ellipse(x, y - h*0.35, w/2, h*0.55):roughen(0.8, 2.5, seed) * above(function(xx) return y + 3 end)
  work(body, {hand="detail", tool={kind="round", width=1.6, point=0.5}, pile=tuft_p, coverage=3.5, fill=true, seed=seed})
  trg:reload(tuft_p, 0.6)
  for i=1,math.random(10,16) do
    local bx = x + randn(0, w*0.25)
    local by = y - h*0.4 + rand(0, h*0.3)
    local a = -math.pi/2 + randn(0, 0.35)
    local L = h * rand(0.6, 1.3)
    local bend = randn(0, 0.2)
    if trg:fullness() < 0.4 then trg:reload(tuft_p, 0.6) end
    trg:gesture({{bx, by, 0.4}, {bx + math.cos(a)*L*0.5, by + math.sin(a)*L*0.5, 0.28}, {bx + math.cos(a+bend)*L, by + math.sin(a+bend)*L, 0.03}}, {wobble=0.03, ramps={0.02, 0.5}})
  end
end
tussock(128, 13, 6.5, 1951)
tussock(187, 10, 5, 1952)
tussock(22, 15, 7, 1953)
tussock(404, 8, 4, 1954)

--@ chunk 206
local k = knife{width=10}
for _, t in ipairs({{128,13,7},{187,10,6},{22,15,8},{404,8,5}}) do
  local x, w, h = t[1], t[2], t[3]
  local y = hy(x)
  for yy = y - h - 2, y + 2, 3 do
    k:scrape({{x - w, yy}, {x + w, yy}}, {pressure=1}); k:wipe()
  end
end
for _, t in ipairs({{128,13,7},{187,10,6},{22,15,8},{404,8,5}}) do
  local r = rag{width=8}; r:dip(0.95)
  r:wipe(ellipse(t[1], hy(t[1]) - t[3]/2, t[2], t[3]), {pressure=0.95, angle=0, refold=0.1, seed=t[1]})
end

--@ chunk 207
print(wait(8*24*60))
for _,p in ipairs({{128,494},{22,515},{187,485},{80,500},{250,480}}) do print(p[1],p[2],drying(p[1],p[2])) end

--@ chunk 208
print(wait(6*24*60))
print(drying(250,480), drying(260,470))
-- new left crest profile
function hyL(x)
  local base = hy(x)
  local s1 = 0
  if x > 25 and x < 125 then local t = (x-25)/100; s1 = 3.8*math.sin(math.pi*t)^1.3 end
  local d1 = 0
  if x > 140 and x < 200 then local t = (x-140)/60; d1 = -1.5*math.sin(math.pi*t) end
  return base - s1 - d1
end
local top = {}
for x = -2, 262, 3 do top[#top+1] = {x, hyL(x)} end
-- meadow above the new profile (x 0..250), below far land
local mead_zone = (rect(0, 474, 252, 40) * below(far_top)) * above(top) - oak_clean:grow(1)
work(mead_zone, {hand="body", tool="filbert 5", piles={{lm_top, function(x,y) return clamp(1-(y-476)/30,0.05,1) end},{lm_bot, function(x,y) return clamp((y-476)/30,0.05,1) end}},
  angle=0, ruler=true, coverage=2.6, fill=true, clip=mead_zone, length={30,70}, seed=1961})
-- hill below the new profile, narrow band
local hb = (below(top) * above(function(x) return hyL(x) + 14 end)) * rect(0,470,262,60) - oak_clean:grow(1)
work(hb, {hand="detail", tool={kind="round", width=2, point=0.4}, piles={{hb_main,0.8},{cool_t,0.2}}, coverage=3.5, fill=true, angle=0, clip=hb, seed=1962})

--@ chunk 209
local root = poly({{274,452},{268,460},{262,468},{256,474},{249,479},{242,483.5},{236,485.5},{250,486},{266,486},{280,484},{282,460}}, true):roughen(0.7, 3, 1931)
local m = root * above(function(x) return hyL(x) + 2 end)
work(m, {hand="detail", tool={kind="round", width=2, point=0.5}, pile=tree_body, coverage=3.5, fill=true, angle=-0.6, seed=1971})
oak_clean = oak_clean + root

--@ chunk 210
print(wait(7*24*60))
for _,p in ipairs({{128,490},{60,500},{200,484},{250,478},{540,520}}) do print(p[1],p[2],drying(p[1],p[2])) end

--@ chunk 211
trg = brush{kind="rigger", width=1.4, point=1}
function grass_clump(x, y, w, h, lean)
  local n = math.floor(w * 2.2)
  trg:reload(tuft_p, 0.6)
  for i=1,n do
    local t = rand(-1, 1)
    local bx = x + t*w/2
    local hh = h * (1 - 0.7*t*t) * rand(0.5, 1.15)
    local a = -math.pi/2 + lean + randn(0, 0.22) + t*0.25
    local bend = lean*0.6 + randn(0, 0.15)
    if trg:fullness() < 0.4 then trg:reload(tuft_p, 0.6) end
    trg:gesture({{bx, y + 1, 0.42}, {bx + math.cos(a)*hh*0.5, y + 1 + math.sin(a)*hh*0.5, 0.3}, {bx + math.cos(a+bend)*hh, y + 1 + math.sin(a+bend)*hh, 0.03}}, {wobble=0.03, ramps={0.02, 0.5}})
  end
end
grass_clump(132, hyL(132), 16, 8, 0.22)
grass_clump(64, hyL(64), 10, 5.5, 0.25)
grass_clump(205, hyL(205), 12, 6, 0.2)
grass_clump(398, hy(398), 8, 4, 0.25)
grass_clump(585, hy(585) + 0.5, 11, 6, 0.3)
grass_clump(545, hy(545) + 0.5, 8, 4.5, 0.3)
grass_clump(508, hy(508) + 0.5, 6, 3.5, 0.3)

--@ chunk 212
local b = brush{kind="round", width=3, point=1}
b:load(t_twig, 0.75)
b:gesture({{116,272,0.62},{108,274.5,0.55},{101,276,0.5},{94,279.5,0.42},{86,281,0.35},{78,283.5,0.25},{72,286,0.05}}, {wobble=0.1, ramps={0.02,0.2}})
rg_s:reload(t_twig, 0.7); rd_m:reload(t_twig, 0.7)
oak_spray(94, 279.5, -2.2, 12, 1.4, 1, t_twig)
oak_spray(86, 281, 2.6, 9, 1.2, 0, t_twig)
oak_spray(104, 275, -1.7, 10, 1.3, 1, t_twig)

--@ chunk 213
function zigzag(br, x, y, ang, len, p0, pl)
  local n = math.random(3, 5)
  local pts = {{x, y, p0}}
  local cx, cy = x, y
  local nodes = {}
  local sgn = (math.random() < 0.5) and -1 or 1
  for i=1,n do
    local a = ang + sgn*rand(0.25, 0.55) + randn(0, 0.12)
    sgn = -sgn
    local seg = len/n * rand(0.7, 1.3)
    cx, cy = cx + seg*math.cos(a), cy + seg*math.sin(a)
    pts[#pts+1] = {cx, cy, (i==n) and 0.04 or lerp(p0, 0.28, i/n)}
    nodes[#nodes+1] = {cx, cy, a}
  end
  if br:fullness() < 0.4 then br:reload(pl, 0.65) end
  br:gesture(pts, {wobble=0.05, ramps={0.02, 0.35}})
  return nodes
end
function cluster(x, y, ang, size, gens, pl, br, p0)
  p0 = p0 or 0.45
  local nodes = zigzag(br, x, y, ang + randn(0, 0.2), size, p0, pl)
  if gens <= 0 then return end
  for i, nd in ipairs(nodes) do
    if i < #nodes and math.random() < 0.6 then
      local side = (math.random()<0.5) and -1 or 1
      cluster(nd[1], nd[2], nd[3] + side*rand(0.8, 1.4), size*rand(0.4, 0.65), gens-1, pl, br, math.max(0.3, p0-0.08))
    end
  end
  local tip = nodes[#nodes]
  if math.random() < 0.7 then cluster(tip[1], tip[2], tip[3] + randn(0, 0.5), size*rand(0.4, 0.6), gens-1, pl, br, math.max(0.3, p0-0.08)) end
end
rg_s = brush{kind="rigger", width=1.6, point=1}
rg_s:reload(t_twig, 0.65)
local Kg = K:grow(1.5)
local cx0, cy0 = 310, 250
local n = 0
for _, t in ipairs(tips) do
  local x, y, a = t[1], t[2], t[3]
  if Kg:at(x, y) >= 0.3 then
    local r = math.sqrt((x-cx0)^2 + (y-cy0)^2)
    local outer = r > 140
    local p = outer and 0.55 or 0.3
    if math.random() < p then
      cluster(x, y, a, rand(13, 22), 2, t_twig, rg_s, 0.42)
      n = n + 1
    end
  end
end
print(n)

--@ chunk 214
rg_h = brush{kind="rigger", width=1.6, point=1}
rg_h:reload(haze_twig, 0.6)
local Kg = K:grow(1.5)
local n = 0
for _, t in ipairs(tips) do
  local x, y, a = t[1], t[2], t[3]
  if Kg:at(x, y) >= 0.3 then
    local r = math.sqrt((x-310)^2 + (y-250)^2)
    if r > 120 and math.random() < 0.6 then
      for j=1,math.random(1,2) do
        local ox, oy = x + math.cos(a)*rand(3, 9), y + math.sin(a)*rand(3, 9)
        cluster(ox, oy, a + randn(0, 0.5), rand(9, 15), 1, haze_twig, rg_h, 0.34)
        n = n + 1
      end
    end
  end
end
print(n)

--@ chunk 215
print(drying(582,546))
local m = (ellipse(583, 545, 13, 8):blur(2)) * above(function(x) return hy(x) - 1.5 end)
work(m, {hand="detail", tool={kind="filbert", width=2.5}, pile=mead2, coverage=3, fill=true, angle=0, clip=m, seed=2001})

--@ chunk 216
print(drying(390,477))
local m = ellipse(390.5, 477.5, 3.5, 2.6):blur(0.8) * above(function(x) return hy(x) - 0.3 end)
work(m, {hand="detail", tool={kind="round", width=1.6, point=0.4}, pile=lm_top, coverage=4, fill=true, angle=0, clip=m, seed=2011})

--@ chunk 217
for _,p in ipairs({{300,420},{278,410},{320,450},{265,475},{285,470}}) do print(p[1],p[2],drying(p[1],p[2])) end
local butt = poly({{280,444},{275,452},{270,460},{264,468},{257,476},{252,481},{270,482},{288,481},{288,450}}, true):roughen(0.8, 4, 77)
trunk_sil = ((trunk_keep + trunk_bulges + butt + oak_clean) * rect(240, 330, 110, 160)) * above(function(x) return hyL and hyL(x) + 1 or hy(x) + 1 end)
print(trunk_sil:area())

--@ chunk 218
local m = trunk_sil * above(function(x) return 466 end)
work(m, {hand="detail", tool={kind="filbert", width=4}, pile=g_tree, coverage=2, fill=true, angle=-math.pi/2, clip=m, seed=2021})

--@ chunk 219
local band = (trunk_keep * rect(200, 250, 220, 85)):times(function(x,y) return clamp((y - 250)/60, 0, 1) end)
work(band, {hand="detail", tool={kind="filbert", width=4}, pile=g_tree, coverage=1.6, fill=true, angle=-math.pi/2, clip=trunk_keep * rect(200,250,220,90),
  load_at=function(x,y) return clamp((y - 255)/60, 0.1, 1) end, seed=2031})

--@ chunk 220
print(drying(664,518))
local m = ellipse(664.5, 518.5, 3.2, 2.2):blur(0.8)
work(m, {hand="detail", tool={kind="round", width=1.6, point=0.4}, pile=mead2, coverage=4, fill=true, angle=0, clip=m, seed=2041})

--@ chunk 221
print(drying(150,520), drying(400,500), drying(500,510))
g_hill2 = pile{{"bone black",1},{"raw umber",1.2},{"green earth",0.35},{"Prussian blue",0.05},{"smalt",0.15}, medium=0.78, name="g_hill2"}
local top = (hill_all * above(function(x) return hyL(x) + 50 end)) * below(function(x) return hyL(x) + 2.5 end) - oak_clean:grow(1.5) - fig_mask:grow(2)
work(top, {hand="glaze", pile=g_hill2, angle=0.02, coverage=1.3, fill=true, clip=top, seed=2051})

--@ chunk 222
local top = (hill_all * above(function(x) return hyL(x) + 34 end)) * below(function(x) return hyL(x) + 3 end) - oak_clean:grow(3) - fig_mask:grow(4)
for pass=1,2 do
  local r = rag{width=16}; r:dip(0.6)
  r:wipe(top, {pressure=0.6, angle=0.02, refold=0.25, seed=2060+pass})
end

--@ chunk 223
star_p = pile{{"lead white",5},{"Naples yellow",0.6}, name="star_p"}
local st = brush{kind="round", width=3, point=0.5}
st:load(star_p, 0.8)
st:touch(star.x, star.y, {pressure=0.6})

--@ chunk 224
print(wait(30*24*60))

--@ chunk 225
print(TREE:area(), K:area())
for _,p in ipairs({{120,180},{150,140},{300,200},{450,240},{520,290},{400,330}}) do print(p[1],p[2],string.format("%.2f %.2f",TREE:at(p[1],p[2]), TREE:shrink(0.4):at(p[1],p[2])), drying(p[1],p[2])) end
print(g_tree)

--@ chunk 226
crown_glz = TREE:shrink(0.3) * rect(0, 0, 1000, 345)
work(crown_glz, {hand="detail", tool={kind="filbert", width=4}, pile=g_tree, coverage=2, fill=true, clip=crown_glz,
  load_at=function(x,y) return clamp((345 - y)/45, 0.15, 1) end, seed=2101})
print(crown_glz:area())

--@ chunk 227
print(wait(5*24*60))
for _,p in ipairs({{300,200},{320,300},{200,250}}) do print(drying(p[1],p[2])) end

--@ chunk 228
print(wait(6*24*60))
for _,p in ipairs({{300,200},{320,300},{200,250},{310,150},{450,300}}) do print(drying(p[1],p[2])) end

--@ chunk 229
local names = {}
for k, v in pairs(_G) do if type(v) == "function" then names[#names+1] = k end end
table.sort(names)
print(table.concat(names, " "))

--@ chunk 230
tb = brush{kind="round", width=1.2, point=1}
function seg_pts(pts_in, p0, p1)
  local L = 0
  for i=2,#pts_in do L = L + math.sqrt((pts_in[i][1]-pts_in[i-1][1])^2 + (pts_in[i][2]-pts_in[i-1][2])^2) end
  local out, acc = {}, 0
  for i=1,#pts_in-1 do
    local a, b = pts_in[i], pts_in[i+1]
    local d = math.sqrt((b[1]-a[1])^2 + (b[2]-a[2])^2)
    local n = math.max(2, math.floor(d/1.5))
    for k=0,n-1 do
      local t = k/n
      local s = (acc + d*t)/L
      out[#out+1] = {lerp(a[1], b[1], t), lerp(a[2], b[2], t), lerp(p0, p1, s^0.8)}
    end
    acc = acc + d
  end
  out[#out+1] = {pts_in[#pts_in][1], pts_in[#pts_in][2], p1}
  return out
end
-- tw: a fine crooked continuation from a prong end (x0,y0) toward (x1,y1)
-- bend: sideways offset of the elbow (units, + = to the right of travel); spur: nil or side (+1/-1) for a short near-right-angle spur at the elbow
function tw(x0, y0, x1, y1, bend, spur, pl, p0)
  pl = pl or t_twig; p0 = p0 or 0.65
  local dx, dy = x1 - x0, y1 - y0
  local L = math.sqrt(dx*dx + dy*dy)
  local ux, uy = dx/L, dy/L
  local nx, ny = -uy, ux
  local bx, by = x0 - 1.3*ux, y0 - 1.3*uy
  local t = rand(0.35, 0.55)
  local ex, ey = x0 + dx*t + nx*bend, y0 + dy*t + ny*bend
  if tb:fullness() < 0.4 then tb:reload(pl, 0.7) end
  tb:gesture(seg_pts({{bx,by},{x0,y0},{ex,ey},{x1,y1}}, p0, 0.02), {wobble=0.03, ramps={0.02, 0.15}})
  if spur then
    local a = math.atan(y1 - ey, x1 - ex) + spur*rand(1.1, 1.45)
    local sl = rand(2.5, 5)
    tb:gesture(seg_pts({{ex,ey},{ex + sl*math.cos(a), ey + sl*math.sin(a)}}, 0.42, 0.02), {wobble=0.02, ramps={0.02, 0.2}})
  end
end
tb:reload(t_twig, 0.7)
print("ok")

--@ chunk 231
local Kg = K:grow(1.5)
local n = 0
for i, t in ipairs(tips) do
  if Kg:at(t[1], t[2]) >= 0.3 and t[1] < 210 and t[2] < 220 then
    print(i, string.format("%.0f %.0f %.2f", t[1], t[2], t[3])); n = n + 1
  end
end
print(n)

--@ chunk 232
local b = crown[20]
local p = b[1]
for i=1,#p do print(string.format("%.1f %.1f %.2f", p[i][1], p[i][2], b[2][i] or -1)) end
print(#crown, #oak, b.level)
local lv = {}
for i, c in ipairs(crown) do lv[c.level] = (lv[c.level] or 0) + 1 end
for k, v in pairs(lv) do print("level", k, v) end

--@ chunk 233
-- crooked tapering shoot from (x,y) at angle a: 2-3 elbows, optional near-right-angle spur, fine point
function shoot(x, y, a, len, p0, pl, spur_p)
  pl = pl or t_twig; p0 = p0 or 0.6; spur_p = spur_p or 0.4
  local nseg = math.random(2, 3)
  local pts = {{x, y}}
  local cx, cy, ca = x, y, a
  local sgn = (math.random() < 0.5) and -1 or 1
  local elbows = {}
  for i=1,nseg do
    local seg = len/nseg * rand(0.7, 1.3)
    if i > 1 then ca = ca + sgn*rand(0.35, 0.7); sgn = -sgn end
    ca = ca + 0.12*((-math.pi/2) - ca)   -- slight upward pull
    cx, cy = cx + seg*math.cos(ca), cy + seg*math.sin(ca)
    pts[#pts+1] = {cx, cy}
    elbows[#elbows+1] = {cx, cy, ca}
  end
  if tb:fullness() < 0.4 then tb:reload(pl, 0.7) end
  tb:gesture(seg_pts(pts, p0, 0.02), {wobble=0.03, ramps={0.02, 0.15}})
  if math.random() < spur_p and #elbows >= 2 then
    local e = elbows[1]
    local s = (math.random() < 0.5) and -1 or 1
    local sa = e[3] + s*rand(1.1, 1.45)
    local sl = rand(2.5, 5.5)
    tb:gesture(seg_pts({{e[1], e[2]}, {e[1] + sl*math.cos(sa), e[2] + sl*math.sin(sa)}}, 0.42, 0.02), {wobble=0.02, ramps={0.02, 0.2}})
  end
end
tb:reload(t_twig, 0.7)
local n = 0
for _, i in ipairs({15,16,17,18,19,20,21,22,23,24,25,47,49,50,146}) do
  local t = tips[i]
  if math.random() < 0.6 then
    local s = (math.random() < 0.5) and -1 or 1
    shoot(t[1], t[2], t[3] + s*rand(0.6, 1.0), rand(12, 22), 0.6, t_twig, 0.45)
    n = n + 1
  end
end
print(n)

--@ chunk 234
-- tail from a prong: joint (jx,jy) -> prong end (ex,ey); continue len units with an elbow (bend radians) and optional spur side
function ptail(jx, jy, ex, ey, len, bend, spur, pl)
  pl = pl or t_twig
  local a = math.atan(ey - jy, ex - jx)
  local sx, sy = ex - 2.2*math.cos(a), ey - 2.2*math.sin(a)
  local l1 = len * rand(0.35, 0.5)
  local mx, my = ex + l1*math.cos(a), ey + l1*math.sin(a)
  local a2 = a + bend
  local fx, fy = mx + (len - l1)*math.cos(a2), my + (len - l1)*math.sin(a2)
  if tb:fullness() < 0.4 then tb:reload(pl, 0.7) end
  tb:gesture(seg_pts({{sx,sy},{ex,ey},{mx,my},{fx,fy}}, 0.68, 0.02), {wobble=0.03, ramps={0.02, 0.15}})
  if spur then
    local sa = a + spur*rand(1.15, 1.45)
    local sl = rand(2.5, 5)
    tb:gesture(seg_pts({{mx,my},{mx + sl*math.cos(sa), my + sl*math.sin(sa)}}, 0.42, 0.02), {wobble=0.02, ramps={0.02, 0.2}})
  end
end
tb:reload(t_twig, 0.7)
ptail(170, 137, 167.5, 130.8, 10, 0.55, 1)
ptail(197.5, 149.6, 201.7, 146.7, 9, -0.5)
ptail(139, 118, 135, 113, 8, -0.6)
ptail(165, 121, 170.4, 121.2, 11, -0.5, -1)

--@ chunk 235
local done = {}
for _, i in ipairs({15,16,17,18,19,20,21,22,23,24,25,47,49,50,146}) do done[i] = true end
local Kg = K:grow(1.5)
tb:reload(t_twig, 0.7)
local n1, n2, nb = 0, 0, 0
for i, t in ipairs(tips) do
  if not done[i] and Kg:at(t[1], t[2]) >= 0.3 then
    local r = math.random()
    local x, y, a = t[1], t[2], t[3]
    if y < 105 and r < 0.45 then
      nb = nb + 1  -- stag-head: leave bare
    elseif r < 0.3 then
      nb = nb + 1
    elseif r < 0.8 then
      local s = (math.random() < 0.5) and -1 or 1
      shoot(x, y, a + s*rand(0.5, 1.0), rand(11, 21), 0.6, t_twig, 0.45); n1 = n1 + 1
    else
      local s = (math.random() < 0.5) and -1 or 1
      shoot(x, y, a + s*rand(0.5, 0.9), rand(12, 20), 0.6, t_twig, 0.5)
      shoot(x, y, a - s*rand(0.2, 0.6), rand(8, 14), 0.55, t_twig, 0.3); n2 = n2 + 1
    end
  end
end
print("bare", nb, "one", n1, "two", n2)

--@ chunk 236
local m = nil
for i, c in ipairs(crown) do
  local r = ribbon(c[1], c[2])
  m = m and (m + r) or r
end
local lm = nil
for i, L in ipairs(oak) do
  local r = ribbon(L[1], L[2])
  lm = lm and (lm + r) or r
end
all_br = (m + lm):roughen(0.5, 4, 9)
for _,p in ipairs({{455,240},{448,236},{460,245},{120,180},{510,250},{440,232}}) do print(p[1],p[2],string.format("%.2f %.2f %.2f", all_br:at(p[1],p[2]), K:at(p[1],p[2]), TREE:at(p[1],p[2]))) end
print(all_br:area(), K:area())

--@ chunk 237
mid_twig = mix{{t_twig,0.75},{d2,0.25}, name="mid_twig"}
tb:reload(mid_twig, 0.7)
-- through the grey cluster at 440-465, 228-262
shoot(436, 252, -0.75, 18, 0.55, mid_twig, 0.5)
shoot(448, 258, -1.05, 16, 0.55, mid_twig, 0.5)
shoot(452, 238, -1.6, 13, 0.5, mid_twig, 0.4)
shoot(446, 246, -2.3, 12, 0.5, mid_twig, 0.4)

--@ chunk 238
for _, x in ipairs({0,100,200,300,400,450,500,550,600,650,700,800,900,1000}) do print(x, string.format("%.1f %.1f", hy(x), hyL(x))) end
print(hill_all:area())
for _,p in ipairs({{300,600},{550,650},{800,690},{150,650}}) do print(p[1],p[2],drying(p[1],p[2])) end

--@ chunk 239
g_front = pile{{"bone black",1.2},{"raw umber",0.7},{"Prussian blue",0.12}, medium=0.75, name="g_front"}
local function crest(x) if x < 262 then return hyL(x) else return hy(x) end end
local function xb(y) return 470 + (y - 500) * 150/214 end
local reg = (hill_all * below(function(x) return crest(x) + 38 end)) * mask(function(x, y) return (x < xb(y) + 2) and 1 or 0 end)
local m = reg - fig_mask:grow(2) - oak_clean:grow(2)
work(m, {hand="glaze", pile=g_front, coverage=1.6, fill=true, clip=m,
  angle=function(x, y) local d = xb(y) - x; return lerp(0.96, 0.02, clamp(d/70, 0, 1)) end,
  load_at=function(x, y)
    local d = y - crest(x)
    local top = smoothstep(42, 95, d)
    local side = clamp((xb(y) - x)/38, 0, 1)
    local bot = lerp(1, 0.7, clamp((y - 640)/70, 0, 1))
    return top * side * bot
  end, seed=2201})
print(m:area())

--@ chunk 240
local function crest(x) if x < 262 then return hyL(x) else return hy(x) end end
local function xb(y) return 470 + (y - 500) * 150/214 end
local nz = noise{seed=2211, period=70, octaves=2}
local band = (hill_all * below(function(x) return crest(x) + 60 end)) * mask(function(x, y) local d = x - xb(y); return (d > -30 and d < 55) and 1 or 0 end)
local m = band - fig_mask:grow(2)
work(m, {hand="body", tool="filbert 9", pile=g_front, coverage=1.8, fill=true, clip=m, length={14,32},
  angle=0.96, angle_jitter=0.15,
  load_at=function(x, y)
    local d = x - xb(y) + 16*nz(x, y)   -- distance past the boundary, wobbled
    local top = smoothstep(55, 100, y - crest(x))
    return clamp(0.55 - d/70, 0, 0.55) * top
  end, seed=2212})

--@ chunk 241
for _,p in ipairs({{950,503},{990,503},{900,503},{990,558},{950,557}}) do print(p[1],p[2], string.format("bay %.2f pool2 %.2f near_pool %.2f", bay_mask:at(p[1],p[2]), pool2:at(p[1],p[2]), near_pool:at(p[1],p[2])), drying(p[1],p[2])) end

--@ chunk 242
for _,y in ipairs({500,502,504,506}) do
  local s = {}
  for _,x in ipairs({890,920,950,980,995}) do s[#s+1] = string.format("%.2f/%.2f", bay_mask:at(x,y), pool2:at(x, y+57)) end
  print(y, table.concat(s, " "))
end

--@ chunk 243
local b = brush{kind="filbert", width=3}
b:reload(mead2, 0.6); b:stroke({{962,512},{980,512}}, {pressure=0.6})
b:reload(lm_bot, 0.6); b:stroke({{962,520},{980,520}}, {pressure=0.6})
b:reload(mead2, 0.6); b:stroke({{962,572},{980,572}}, {pressure=0.6})
b:reload(mead, 0.6); b:stroke({{962,580},{980,580}}, {pressure=0.6})

--@ chunk 244
for pass=1,3 do
  local r = rag{width=8}; r:dip(0.95)
  r:wipe(rect(958, 507, 26, 18), {pressure=0.95, angle=0, refold=0.15, seed=2300+pass})
  r = rag{width=8}; r:dip(0.95)
  r:wipe(rect(958, 567, 26, 18), {pressure=0.95, angle=0, refold=0.15, seed=2310+pass})
end

--@ chunk 245
for _, x in ipairs({940,955,965,975,990}) do
  local lo, hi = nil, nil
  for y = 540, 575, 0.5 do
    if pool2:at(x, y) > 0.5 then lo = lo or y; hi = y end
  end
  local blo, bhi = nil, nil
  for y = 495, 512, 0.5 do
    if bay_mask:at(x, y) > 0.5 then blo = blo or y; bhi = y end
  end
  print(x, lo, hi, blo, bhi)
end

--@ chunk 246
pool_cov = mix{{lm_bot,0.5},{mead,0.5}, name="pool_cov"}
local b = brush{kind="filbert", width=3}
b:reload(lm_bot, 0.6); b:stroke({{940,545},{952,545}}, {pressure=0.6})
b:reload(pool_cov, 0.6); b:stroke({{960,545},{972,545}}, {pressure=0.6})
b:reload(mead, 0.6); b:stroke({{980,545},{992,545}}, {pressure=0.6})
b:reload(lm_bot, 0.6); b:stroke({{940,576},{952,576}}, {pressure=0.6})
b:reload(pool_cov, 0.6); b:stroke({{960,576},{972,576}}, {pressure=0.6})
b:reload(mead, 0.6); b:stroke({{980,576},{992,576}}, {pressure=0.6})

--@ chunk 247
for pass=1,3 do
  local r = rag{width=8}; r:dip(0.95)
  r:wipe(rect(936, 540, 62, 10), {pressure=0.95, angle=0, refold=0.15, seed=2320+pass})
  r = rag{width=8}; r:dip(0.95)
  r:wipe(rect(936, 571, 62, 10), {pressure=0.95, angle=0, refold=0.15, seed=2330+pass})
end

--@ chunk 248
local pc = poly({{957,555.5},{979,561.8},{957,568},{1006,568},{1006,555.5}}) * pool2:grow(1.6)
local pcs = pc:blur(0.6)
work(pcs, {hand="detail", tool={kind="filbert", width=2.5}, piles={{pool_cov, function(x,y) return clamp((576-y)/31, 0.02, 1) end},{mead, function(x,y) return clamp((y-545)/31, 0.02, 1) end}},
  angle=0, coverage=4, fill=true, clip=pcs, seed=2341})
local bc = poly({{961,501.5},{977,505},{961,508.5},{1006,508.5},{1006,501.5}}) * bay_mask:grow(1.6)
local bcs = bc:blur(0.6)
work(bcs, {hand="detail", tool={kind="filbert", width=2.5}, pile=lm_bot, angle=0, coverage=4, fill=true, clip=bcs, seed=2342})

--@ chunk 249
local m = ellipse(994.5, 555.5, 5, 2):blur(0.6)
work(m, {hand="detail", tool={kind="round", width=1.6, point=0.4}, piles={{pool_cov,0.6},{mead,0.4}}, coverage=4, fill=true, angle=0, clip=m, seed=2351})

--@ chunk 250
pool_dk = mix{{pool_sky,0.8},{pile{{"smalt",0.6},{"raw umber",0.45},{"cobalt blue",0.15},{"bone black",0.05}, medium=0.8},0.2}, name="pool_dk"}
pool_dk:add{{"raw umber",0.05},{"cobalt blue",0.03}}
local pc = poly({{957,555.5},{979,561.8},{957,568},{1006,568},{1006,555.5}}) * pool2:grow(1.6)
local m = (pool2:shrink(0.3) - pool_refl:grow(0.3) - pc:grow(1.5) - ellipse(994.5,555.5,6,3))
print(m:area())
work(m, {hand="detail", tool={kind="flat", width=3}, pile=pool_dk, coverage=3.5, fill=true, angle=0, clip=m, seed=2361})

--@ chunk 251
print(drying(390,477), drying(348,479))
local b = brush{kind="round", width=2, point=0.4}
b:reload(lm_top, 0.6); b:stroke({{358,475},{364,475}}, {pressure=0.5})
b:reload(m_far, 0.6); b:stroke({{369,475},{375,475}}, {pressure=0.5})
b:reload(mead_hz, 0.6); b:stroke({{405,475},{411,475}}, {pressure=0.5})
b:reload(hz_top, 0.6); b:stroke({{416,475},{422,475}}, {pressure=0.5})

--@ chunk 252
smudge_p = mix{{m_far,0.5},{lm_top,0.5}, name="smudge_p"}
local m = (ellipse(388.5, 475, 5, 5.5):blur(1.2) * above(function(x) return hy(x) - 0.5 end)) - fig_mask:grow(2)
work(m, {hand="detail", tool={kind="round", width=1.6, point=0.4}, pile=smudge_p, coverage=4, fill=true, angle=0, clip=m, seed=2371})
local m2 = (ellipse(348, 478, 4, 4):blur(1.2) * above(function(x) return hy(x) - 0.5 end))
work(m2, {hand="detail", tool={kind="round", width=1.6, point=0.4}, pile=smudge_p, coverage=4, fill=true, angle=0, clip=m2, seed=2372})

--@ chunk 253
for pass=1,3 do
  local r = rag{width=6}; r:dip(0.95)
  r:wipe(ellipse(388.5, 475, 7, 6), {pressure=0.95, angle=0, refold=0.1, seed=2380+pass})
  r = rag{width=6}; r:dip(0.95)
  r:wipe(ellipse(348, 478, 6, 5), {pressure=0.95, angle=0, refold=0.1, seed=2390+pass})
end
local b = brush{kind="round", width=2, point=0.4}
b:reload(f_land2, 0.6); b:stroke({{392,472},{398,472}}, {pressure=0.5})
b:reload(m_far, 0.6); b:stroke({{392,477},{398,477}}, {pressure=0.5})

--@ chunk 254
print(type(far_top))
if type(far_top) == "function" then for _,x in ipairs({370,380,388,395,405}) do print(x, string.format("%.1f %.1f", far_top(x), hy(x))) end end
print(f_land2, m_far)

--@ chunk 255
local m = below(far_top)
for _,y in ipairs({455,460,465,470,475,478}) do print(y, string.format("%.2f %.2f", m:at(388,y), m:at(370,y))) end

--@ chunk 256
local m = (ellipse(389, 471.5, 6, 6.5):blur(1.5) * above(function(x) return hy(x) - 0.8 end) * below(far_top)) - fig_mask:grow(2)
work(m, {hand="detail", tool={kind="round", width=1.6, point=0.4}, piles={{f_land2, function(x,y) return clamp((477-y)/10, 0.05, 1) end},{m_far, function(x,y) return clamp((y-467)/10, 0.05, 1) end}}, coverage=4, fill=true, angle=0, clip=m, seed=2401})

--@ chunk 257
local m = ((ellipse(389, 472, 10, 7) + ellipse(348, 477.5, 8, 4.5)) * above(function(x) return hy(x) - 1 end) * below(far_top)) - fig_mask:grow(2.5)
blend(m, {tool={kind="badger", width=6}, angle=0, seed=2411})

--@ chunk 258
for k, v in pairs(fp) do print(k, v:area()) end
print(fig.x, fig.y, fig.h)

--@ chunk 259
print(drying(456,485), drying(458,470))
g_legs = pile{{"bone black",1},{"raw umber",0.8},{"Prussian blue",0.05}, medium=0.7, name="g_legs"}
local m = fp.legs:shrink(0.15)
work(m, {hand="detail", tool={kind="round", width=1.2, point=0.5}, pile=g_legs, coverage=2.5, fill=true, angle=math.pi/2, clip=m, seed=2421})

--@ chunk 260
print(wait(8*24*60))
for _,p in ipairs({{456,485},{389,472},{970,560},{600,640},{300,650},{150,180}}) do print(p[1],p[2],drying(p[1],p[2])) end
