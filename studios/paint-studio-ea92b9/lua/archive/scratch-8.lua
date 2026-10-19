-- easel session "scratch": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box friedrich
--@ engine 7

--@ chunk 1
canvas{aspect=1.4, ground={{apply="knife", pile={{"red earth", 2}, {"yellow ochre", 2}, {"lead white", 1}}, texture=0.3, um=60}, {apply="brush", pile={{"lead white", 6}, {"yellow ochre", 0.35}, {"raw umber", 0.12}}, um=35}}, linen={16, 14}, seed=1774, size=650}

--@ chunk 2
s_glow = pile{{"lead white",5},{"Naples yellow",1.5},{"yellow ochre",0.25},{"vermilion",0.05}, name="s_glow"}
f_land = pile{{"lead white",1.2},{"smalt",1.1},{"raw umber",0.75},{"rose madder",0.1},{"Naples yellow",0.2},{"cobalt blue",0.2}, name="f_land"}
h_dark2 = pile{{"raw umber",1.5},{"bone black",0.8},{"green earth",0.4},{"Prussian blue",0.04}, name="h_dark2"}
hill2_pts = {{0,522},{60,510},{130,498},{200,489},{260,484},{330,481},{390,483},{440,488},{480,496},{515,510},{550,530},{590,556},{630,582},{680,600},{740,610},{850,617},{1000,622}}
far_top = {{0,462},{40,461},{70,457},{85,455},{100,457},{130,460},{180,461},{230,459},{250,455},{262,454},{275,457},{300,460},{360,461},{420,462},{470,460},{500,456},{515,455},{530,458},{560,460},{600,460},{625,457},{640,455},{690,455},{705,457},{740,458},{780,456},{820,452},{860,450},{900,451},{940,454},{970,457},{1000,458}}
work(above(far_top):grow(2), {hand="broad", pile=s_glow, angle=0, ruler=true, coverage=2.2, fill=true, clip=above(far_top):grow(2), seed=1})
local fb = below(far_top) * above(function(x) return 478 end)
work(fb, {hand="body", pile=f_land, angle=0, coverage=2.4, fill=true, clip=fb, seed=2})
local mm = below(function(x) return 476 end)
work(mm, {hand="broad", pile=pile{{"raw umber",1.2},{"green earth",0.8},{"yellow ochre",0.25},{"smalt",0.3},{"lead white",0.6}}, angle=0, coverage=2.2, fill=true, clip=mm, seed=3})
local hl = below(hill2_pts)
work(hl, {hand="body", pile=h_dark2, angle=0, coverage=2.4, fill=true, clip=hl, seed=4})
print(wait(5*24*60))

--@ chunk 3
function fig_parts(fx, fy, s)
  s = s or 1
  local function P(pts) local o = {} for i,p in ipairs(pts) do o[i] = {fx + p[1]*s, fy + p[2]*s} end return o end
  local parts = {}
  parts.head = ellipse(fx + 0.3*s, fy - 35.3*s, 3.0*s, 3.6*s)
  parts.cap  = poly(P{{-3.6,-37.2},{-2.8,-39.6},{0.2,-40.6},{3.4,-40.0},{4.6,-38.4},{3.8,-37.0},{0.5,-37.6}}, true)
  parts.coat = poly(P{{-1.8,-32.6},{2.2,-32.6},{5.4,-31.2},{6.5,-28},{6.9,-22},{7.2,-15},{7.0,-9.4},{3.0,-8.6},{-2.0,-8.8},{-6.4,-9.4},{-6.6,-16},{-6.2,-24},{-5.6,-29.6},{-4.6,-31.2}}, true)
  parts.legs = poly(P{{-3.7,-9.2},{-0.9,-9.2},{-1.2,-1.4},{-3.4,-1.4}}, true) + poly(P{{0.9,-9.2},{3.6,-9.2},{3.8,-1.4},{1.3,-1.4}}, true)
  parts.feet = ellipse(fx - 2.5*s, fy - 0.8*s, 2.3*s, 1.1*s) + ellipse(fx + 2.8*s, fy - 0.8*s, 2.3*s, 1.1*s)
  parts.stick = ribbon(P{{7.6,-17.5},{8.6,-8},{9.6,0.4}}, 0.9*s)
  return parts
end
fp = fig_parts(452, 491, 1)
fig_coat = pile{{"bone black",1},{"raw umber",0.8},{"Prussian blue",0.12},{"green earth",0.3}, name="fig_coat"}
fig_hair = pile{{"raw umber",1.2},{"bone black",0.5},{"red earth",0.25}, name="fig_hair"}
fig_legs = pile{{"raw umber",1},{"bone black",0.4},{"lead white",0.25},{"smalt",0.2}, name="fig_legs"}
fig_cap  = pile{{"bone black",1},{"raw umber",0.6},{"red earth",0.15}, name="fig_cap"}
local fb = brush{kind="round", width=1.6, point=0.6}
work(fp.legs + fp.feet, {hand="detail", tool=fb, pile=fig_legs, coverage=3, fill=true, angle=-math.pi/2, seed=11})
work(fp.coat, {hand="detail", tool=fb, pile=fig_coat, coverage=3, fill=true, angle=-math.pi/2, seed=12})
work(fp.head, {hand="detail", tool=fb, pile=fig_hair, coverage=3, fill=true, seed=13})
work(fp.cap, {hand="detail", tool=fb, pile=fig_cap, coverage=3, fill=true, angle=0, seed=14})
work(fp.stick, {hand="detail", tool=fb, pile=fig_hair, coverage=3, fill=true, seed=15})

--@ chunk 4
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
  parts.collar = poly(P{{-2.4,-32.8},{2.8,-32.8},{3.6,-31.2},{-3.2,-31.2}}, true)
  return parts
end
fp = fig_parts(600, 489, 1)
fig_hair = pile{{"bone black",1},{"raw umber",1},{"red earth",0.1}, name="fig_hair2"}
fig_legs = pile{{"raw umber",1},{"bone black",0.6},{"lead white",0.08},{"smalt",0.12}, name="fig_legs2"}
local fb = brush{kind="round", width=1.6, point=0.6}
work(fp.legs + fp.feet, {hand="detail", tool=fb, pile=fig_legs, coverage=3, fill=true, angle=-math.pi/2, seed=21})
work(fp.coat, {hand="detail", tool=fb, pile=fig_coat, coverage=3, fill=true, angle=-math.pi/2, seed=22})
work(fp.head, {hand="detail", tool=fb, pile=fig_hair, coverage=3, fill=true, seed=23})
work(fp.cap, {hand="detail", tool=fb, pile=fig_cap, coverage=3, fill=true, angle=0, seed=24})
work(fp.stick, {hand="detail", tool=fb, pile=fig_hair, coverage=3, fill=true, seed=25})

--@ chunk 5
wv_far  = pile{{"lead white",5},{"Naples yellow",1.3},{"yellow ochre",0.3},{"raw umber",0.25},{"vermilion",0.04}, name="wv_far"}
wv_mid  = pile{{"lead white",4},{"Naples yellow",0.6},{"smalt",0.5},{"raw umber",0.4}, name="wv_mid"}
wv_near = pile{{"lead white",3},{"smalt",0.8},{"cobalt blue",0.3},{"raw umber",0.6},{"rose madder",0.05}, name="wv_near"}
function stream(segs)
  for _, s in ipairs(segs) do
    local b = brush{kind="flat", width=s.w, stiffness=0.5}
    b:load(s.p, 0.6)
    b:stroke(s.pts, {pressure={0.55,0.45}, ramps={0.15,0.25}, orient="along", shake=0.3})
  end
end
stream{
  {pts={{700,492},{722,491.6},{745,492.2}}, w=1.4, p=wv_far},
  {pts={{740,494.5},{765,494.2},{792,495}}, w=1.6, p=wv_far},
  {pts={{800,500},{780,501.5},{752,503}}, w=2.0, p=wv_far},
  {pts={{745,510},{770,511},{805,513}}, w=2.4, p=wv_mid},
  {pts={{812,525},{850,527},{895,530}}, w=3.2, p=wv_mid},
  {pts={{880,548},{930,551},{1000,555}}, w=4.5, p=wv_near},
}

--@ chunk 6
function lens(x0, x1, y, th, seed, skew)
  skew = skew or 0
  local nz = noise{seed=seed, period=12, octaves=2}
  local top, bot = {}, {}
  local n = math.max(8, math.floor((x1-x0)/4))
  for i=0,n do
    local t = i/n
    local x = lerp(x0, x1, t)
    local env = math.sin(math.pi*t)^0.5
    local yy = y + skew*(t-0.5)
    top[#top+1] = {x, yy - th*0.45*env*(0.6+0.8*nz:at01(x, y))}
    bot[#bot+1] = {x, yy + th*0.55*env*(0.6+0.8*nz:at01(x+50, y))}
  end
  local pts = {}
  for i=1,#top do pts[#pts+1] = top[i] end
  for i=#bot,1,-1 do pts[#pts+1] = bot[i] end
  return poly(pts, true)
end
local wm = lens(680,750,520.5,1.8,1) + lens(735,800,524,2.2,2,1) + lens(745,815,532,2.6,3,-1) + lens(800,880,543,3.5,4,1.5) + lens(860,1004,560,5,5,3)
  + ribbon({{748,522},{745,527},{752,531}}, 1.2) + ribbon({{805,529},{812,535},{806,539}}, 1.4) + ribbon({{870,545},{880,551},{872,556}}, 2)
work(wm, {hand="detail", tool={kind="round", width=1.6, point=0.5}, piles={{wv_far, function(x,y) return clamp(1-(y-520)/25,0,1) end},{wv_mid, function(x,y) return clamp(1-math.abs(y-540)/15,0,1) end},{wv_near, function(x,y) return clamp((y-540)/20,0,1) end}}, coverage=3, fill=true, angle=0, seed=31})
