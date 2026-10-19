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
gf = pile{{"lead white",1},{"green earth",0.4},{"raw umber",0.45},{"Prussian blue",0.1},{"bone black",0.18},{"yellow ochre",0.2}, name="gf"}
shbt = pile{{"bone black",0.8},{"raw umber",0.8},{"ultramarine blue",0.5},{"green earth",0.3}, thinner=0.6, name="shbt"}
ztrou2 = pile{{"bone black",1},{"raw umber",0.7},{"green earth",0.25},{"ultramarine blue",0.15}, name="ztrou2"}
zd_mid = pile{{"bone black",0.5},{"raw umber",0.6},{"green earth",0.6},{"yellow ochre",0.2},{"lead white",0.04}, name="zd_mid"}
legdk = pile{{"bone black",1},{"raw umber",0.5},{"ultramarine blue",0.2}, name="legdk"}
local G = rect(660, 520, 280, 140)
local nz = noise{seed=1201, period=110, octaves=4, stretch={0, 5}}
local nz2 = noise{seed=1202, period=40, octaves=3, stretch={0, 3}}
local function depth(y) return clamp((y-485)/180,0,1) end
work(G, {hand="body", tool="filbert 12", piles={
  {gf, function(x,y) local d = depth(y); return clamp(1-d*3.2,0,1)*1.6 + clamp(nz(x,y)-0.15,0,1)*1.2*clamp(1-d*1.6,0,1) end},
  {gm, function(x,y) local d = depth(y); return clamp(1-math.abs(d-0.35)*3.2,0,1)*1.2 + clamp(nz2(x,y),0,1)*0.3 end},
  {gd, function(x,y) local d = depth(y); return clamp((d-0.45)*2.4,0,1)*1.5 + clamp(-nz(x,y)-0.2,0,1)*0.8*d end}},
  coverage=2.3, fill=true, clip=G, angle=function(x,y) return 0.02*math.sin(x/80) + 0.03*nz2(x,y) end,
  length={25,75}, scale_at=function(x,y) return 0.3 + 0.9*depth(y) end, pressure={0.45,0.8}, seed=12001})
print(wait(20*24*60))
OLDF = poly({{742,520},{763,520},{760,560},{757,575},{755,585},{754,595},{752,601},{730,606},{712,604},{712,600},{724,595},{733,585},{735,575},{738,560}}, true)
OLDR = poly({{830,520},{856,520},{870,560},{876,575},{880,585},{886,595},{889,600},{888,606},{868,606},{866,600},{863,595},{857,585},{852,575},{844,560}}, true)
local L = OLDF + OLDR
work(L, {hand="body", tool={kind="filbert", width=4}, piles={{ztrou2,1},{zd_mid, function(x,y) local c = (x < 800) and (746 + (575-y)*0.2) or (866 - (575-y)*0.45); return clamp((c - x)/8,0,1)*1.3 end}},
  coverage=2.5, fill=true, clip=L, length={8,22}, angle=function(x,y) return x < 800 and 1.75 or 1.2 end, seed=24001})
local r = brush{kind="round", width=1.6, point=0.7}
r:load(legdk, 0.7)
r:gesture({{738,540,0.5},{735,575,0.6},{733,585,0.6},{724,595,0.5},{712,601,0.4}})
r:load(legdk, 0.7)
r:gesture({{862,540,0.5},{876,575,0.6},{886,595,0.6},{889,602,0.4}})
-- cast shadows down from feet
local sh = (poly({{708,604},{756,603},{770,660},{700,660}}) + poly({{866,604},{892,604},{930,660},{860,660}})):blur(3)
work(sh, {hand="scumble", pile=shbt, coverage=1.35, fill=true, clip=sh, seed=777})
print(wait(30*24*60))

--@ chunk 3
zs_d = pile{{"green earth",1},{"bone black",0.45},{"raw umber",0.4}, name="zs_d"}
zs_m = pile{{"green earth",1},{"raw umber",0.3},{"yellow ochre",0.3},{"lead white",0.3},{"bone black",0.15}, name="zs_m"}
zs_l = pile{{"lead white",1},{"yellow ochre",0.5},{"green earth",0.4},{"Naples yellow",0.3},{"orange vermilion",0.06}, name="zs_l"}
cavity = pile{{"bone black",1},{"raw umber",0.5},{"green earth",0.3}, name="cavity"}
z_moon = pile{{"lead white",1},{"Prussian blue",0.12},{"green earth",0.3},{"bone black",0.12}, name="z_moon"}
function zfeet_shapes(OLDLEG)
  local hemF = {{724,586},{731,585},{735,589},{738,584},{742,590},{746,585},{749,589},{752,583},{756,586},{764,585}}
  local hemR = {{850,586},{855,586},{859,590},{862,585},{866,591},{870,586},{874,589},{878,584},{882,588},{892,586}}
  local function under(h) local pts = {} for _,p in ipairs(h) do pts[#pts+1]=p end; pts[#pts+1]={h[#h][1],640}; pts[#pts+1]={h[1][1],640}; return poly(pts) end
  ZF = {hemF=hemF, hemR=hemR}
  ZF.below = under(hemF) + under(hemR)
  ZF.ankF = poly({{739,584},{750,584},{751,592},{753,597},{740,597},{738,591}}, true)
  ZF.footF = poly({{740,592},{748,593},{754,595},{757,599},{756,603.5},{740,604},{726,604},{716,603.6},{713.5,602},{716,600},{726,598},{734,596}}, true)
  ZF.ragF = poly({{751,585},{756,585},{756.5,592},{754.5,597},{752.5,591}}, true)
  ZF.ankR = poly({{862,584},{873,584},{876,592},{877,595},{866,596},{863,591}}, true)
  ZF.footR = poly({{866,592},{876,592},{881,595},{882,599},{876,601.5},{866,603.5},{858,605},{849,605},{847.5,603},{852,601},{858,598}}, true)
  ZF.ragR = poly({{876,585},{882,586},{885.5,595},{883.5,599},{879.5,593}}, true)
  ZF.skin = (ZF.ankF + ZF.footF + ZF.ankR + ZF.footR) * ZF.below
  ZF.rags = (ZF.ragF + ZF.ragR) * ZF.below - ZF.skin
  ZF.rest = (OLDLEG * ZF.below) - ZF.skin - ZF.rags
end
function zfeet_lay()
  local nz2 = noise{seed=1202, period=40, octaves=3, stretch={0, 3}}
  local function depth(y) return clamp((y-485)/180,0,1) end
  -- 1. ground where the old trouser column was
  work(ZF.rest, {hand="detail", tool={kind="filbert", width=3}, piles={
     {gm, function(x,y) local d = depth(y); return clamp(1-math.abs(d-0.35)*3.2,0,1)*1.2 + clamp(nz2(x,y),0,1)*0.3 + 0.1 end},
     {gd, function(x,y) local d = depth(y); return clamp((d-0.45)*2.4,0,1)*1.5 end}},
     coverage=3.5, fill=true, clip=ZF.rest, length={4,10}, angle=0.02, seed=40001})
  -- 2. bony ankles and feet: lit from the flash (up-left), dark inside the trouser mouth
  local S = ZF.skin
  local function lit(x,y)
    local a = 0
    for _, d in ipairs({1.5, 3, 4.5}) do a = a + (1 - S:at(x - 0.55*d, y - 0.83*d)) end
    return a/3
  end
  local function hemdark(x,y) return clamp(1 - (y - 586)/6, 0, 1) end
  work(S, {hand="detail", tool={kind="filbert", width=2.4}, piles={
     {zs_d, 1},
     {zs_m, function(x,y) return lit(x,y)*1.6*(1-hemdark(x,y)) end},
     {cavity, function(x,y) return hemdark(x,y)*2 end}},
     coverage=3.5, fill=true, clip=S, length={3,7}, angle=function(x,y) return (y > 594) and 3.1 or 1.7 end, seed=40002})
  -- 3. tattered strips of trouser at the back
  work(ZF.rags, {hand="detail", tool={kind="filbert", width=2}, piles={{ztrou2,1},{legdk,0.4}}, coverage=3.5, fill=true, clip=ZF.rags, length={3,8}, angle=1.6, seed=40003})
end
zfeet_shapes((OLDF + OLDR):grow(2))
zfeet_lay()

--@ chunk 4
local nz = noise{seed=1201, period=110, octaves=4, stretch={0, 5}}
local nz2 = noise{seed=1202, period=40, octaves=3, stretch={0, 3}}
local function depth(y) return clamp((y-485)/180,0,1) end
local G = rect(10, 520, 260, 140) + rect(290, 520, 260, 140)
work(G, {hand="body", tool="filbert 12", piles={
  {gf, function(x,y) local d = depth(y); return clamp(1-d*3.2,0,1)*1.6 + clamp(nz(x,y)-0.15,0,1)*1.2*clamp(1-d*1.6,0,1) end},
  {gm, function(x,y) local d = depth(y); return clamp(1-math.abs(d-0.35)*3.2,0,1)*1.2 + clamp(nz2(x,y),0,1)*0.3 end},
  {gd, function(x,y) local d = depth(y); return clamp((d-0.45)*2.4,0,1)*1.5 + clamp(-nz(x,y)-0.2,0,1)*0.8*d end}},
  coverage=2.3, fill=true, clip=G, angle=function(x,y) return 0.02*math.sin(x/80) + 0.03*nz2(x,y) end,
  length={25,75}, scale_at=function(x,y) return 0.3 + 0.9*depth(y) end, pressure={0.45,0.8}, seed=12002})
print(wait(20*24*60))
function oldlegs(dx)
  local F = poly({{742+dx,520},{763+dx,520},{760+dx,560},{757+dx,575},{755+dx,585},{754+dx,595},{752+dx,601},{730+dx,606},{712+dx,604},{712+dx,600},{724+dx,595},{733+dx,585},{735+dx,575},{738+dx,560}}, true)
  local R = poly({{830+dx,520},{856+dx,520},{870+dx,560},{876+dx,575},{880+dx,585},{886+dx,595},{889+dx,600},{888+dx,606},{868+dx,606},{866+dx,600},{863+dx,595},{857+dx,585},{852+dx,575},{844+dx,560}}, true)
  return F, R
end
for _, dx in ipairs({-380, -680}) do
  local F, R = oldlegs(dx)
  local L = F + R
  work(L, {hand="body", tool={kind="filbert", width=4}, piles={{ztrou2,1},{zd_mid, function(x,y) local c = (x < 800+dx) and (746+dx + (575-y)*0.2) or (866+dx - (575-y)*0.45); return clamp((c - x)/8,0,1)*1.3 end}},
    coverage=2.5, fill=true, clip=L, length={8,22}, angle=function(x,y) return x < 800+dx and 1.75 or 1.2 end, seed=24002})
  local r = brush{kind="round", width=1.6, point=0.7}
  r:load(legdk, 0.7)
  r:gesture({{738+dx,540,0.5},{735+dx,575,0.6},{733+dx,585,0.6},{724+dx,595,0.5},{712+dx,601,0.4}})
  r:load(legdk, 0.7)
  r:gesture({{862+dx,540,0.5},{876+dx,575,0.6},{886+dx,595,0.6},{889+dx,602,0.4}})
  local sh = (poly({{708+dx,604},{756+dx,603},{770+dx,660},{700+dx,660}}) + poly({{866+dx,604},{892+dx,604},{930+dx,660},{860+dx,660}})):blur(3)
  work(sh, {hand="scumble", pile=shbt, coverage=1.35, fill=true, clip=sh, seed=778})
end
print(wait(30*24*60))
for _, p in ipairs({{740,600},{870,600},{745,590}}) do print(drying(p[1],p[2])) end

--@ chunk 5
function zfeet_shapes(OLDLEG, dx)
  dx = dx or 0
  local function P(pts) local o = {} for i,p in ipairs(pts) do o[i] = {p[1]+dx, p[2]} end return o end
  local hemF = P{{724,586},{731,585},{735,589},{738,584},{742,590},{746,585},{749,589},{752,583},{756,586},{764,585}}
  local hemR = P{{850,586},{855,586},{859,590},{862,585},{866,591},{870,586},{874,589},{878,584},{882,588},{892,586}}
  local function under(h) local pts = {} for _,p in ipairs(h) do pts[#pts+1]=p end; pts[#pts+1]={h[#h][1],640}; pts[#pts+1]={h[1][1],640}; return poly(pts) end
  ZF = {hemF=hemF, hemR=hemR, dx=dx}
  ZF.below = under(hemF) + under(hemR)
  ZF.ankF = poly(P{{739.5,584},{749.5,584},{751,591},{752,595},{740,595},{739,590}}, true)
  ZF.footF = poly(P{{740,592.5},{733,596},{725,598.6},{718,600.6},{714,602.4},{715,604},{728,604.2},{742,603.6},{752,604},{756.5,601.5},{756,597},{752,593.5}}, true)
  ZF.ragF = poly(P{{751,585},{756,585},{756.5,592},{754.5,596.5},{752.5,591}}, true)
  ZF.ankR = poly(P{{862.5,584},{872.5,584},{875,591},{876,594},{866,595},{863.5,590}}, true)
  ZF.footR = poly(P{{866,592},{876,592},{880.5,594.5},{881.5,598.5},{876,601},{866,603.4},{858,604.8},{850,605},{848,603.6},{852,601.5},{858,598.5}}, true)
  ZF.ragR = poly(P{{876,585},{882,586},{885.5,595},{883.5,599},{879.5,593}}, true)
  ZF.skin = (ZF.ankF + ZF.footF + ZF.ankR + ZF.footR) * ZF.below
  ZF.rags = (ZF.ragF + ZF.ragR) * ZF.below - ZF.skin
  ZF.rest = (OLDLEG * ZF.below) - ZF.skin - ZF.rags
end
function zfeet_lay2()
  local dx = ZF.dx
  local nz2 = noise{seed=1202, period=40, octaves=3, stretch={0, 3}}
  local function depth(y) return clamp((y-485)/180,0,1) end
  work(ZF.rest, {hand="detail", tool={kind="filbert", width=3}, piles={
     {gm, function(x,y) local d = depth(y); return clamp(1-math.abs(d-0.35)*3.2,0,1)*1.2 + clamp(nz2(x-dx,y),0,1)*0.3 + 0.1 end},
     {gd, function(x,y) local d = depth(y); return clamp((d-0.45)*2.4,0,1)*1.5 end}},
     coverage=3.5, fill=true, clip=ZF.rest, length={4,10}, angle=0.02, seed=40001})
  local S = ZF.skin
  local function lit(x,y)
    local a = 0
    for _, d in ipairs({1.2, 2.4, 3.6}) do a = a + (1 - S:at(x - 0.55*d, y - 0.83*d)) end
    return a/3
  end
  local function lower(x,y)  -- the shadowed side of the foot, near the ground
    local a = 0
    for _, d in ipairs({1.5, 3}) do a = a + (1 - S:at(x + 0.2*d, y + d)) end
    return a/2
  end
  local function hemdark(x,y) return clamp(1 - (y - 586)/5, 0, 1) end
  work(S, {hand="detail", tool={kind="filbert", width=2.2}, piles={
     {zs_d, 1},
     {cavity, function(x,y) return hemdark(x,y)*2.5 + lower(x,y)*0.9 + 0.25 end},
     {zs_m, function(x,y) local l = lit(x,y); return clamp(l*1.8-0.5,0,1)*1.6*(1-hemdark(x,y)) end}},
     coverage=3.5, fill=true, clip=S, length={3,6}, angle=function(x,y) return (y > 593) and 3.0 or 1.7 end, seed=40002})
  work(ZF.rags, {hand="detail", tool={kind="filbert", width=2}, piles={{ztrou2,1},{legdk,0.4}}, coverage=3.5, fill=true, clip=ZF.rags, length={3,8}, angle=1.6, seed=40003})
end
local F, R = oldlegs(-380)
zfeet_shapes((F + R):grow(2), -380)
zfeet_lay2()

--@ chunk 6
function zfeet_lay3()
  local dx = ZF.dx
  local nz = noise{seed=1201, period=110, octaves=4, stretch={0, 5}}
  local nz2 = noise{seed=1202, period=40, octaves=3, stretch={0, 3}}
  local function depth(y) return clamp((y-485)/180,0,1) end
  work(ZF.rest, {hand="detail", tool={kind="filbert", width=3}, piles={
    {gf, function(x,y) local d = depth(y); return clamp(1-d*3.2,0,1)*1.6 + clamp(nz(x-dx,y)-0.15,0,1)*1.2*clamp(1-d*1.6,0,1) end},
    {gm, function(x,y) local d = depth(y); return clamp(1-math.abs(d-0.35)*3.2,0,1)*1.2 + clamp(nz2(x-dx,y),0,1)*0.3 end},
    {gd, function(x,y) local d = depth(y); return clamp((d-0.45)*2.4,0,1)*1.5 + clamp(-nz(x-dx,y)-0.2,0,1)*0.8*d end}},
     coverage=3.5, fill=true, clip=ZF.rest, length={4,10}, angle=0.02, seed=40001})
  local S = ZF.skin
  local function lit(x,y)
    local a = 0
    for _, d in ipairs({1.0, 2.0}) do a = a + (1 - S:at(x - 0.55*d, y - 0.83*d)) end
    return a/2
  end
  local function lower(x,y)
    local a = 0
    for _, d in ipairs({1.5, 3}) do a = a + (1 - S:at(x + 0.2*d, y + d)) end
    return a/2
  end
  local function hemdark(x,y) return clamp(1 - (y - 586)/5, 0, 1) end
  work(S, {hand="detail", tool={kind="filbert", width=2.2}, piles={
     {zs_d, 1},
     {cavity, function(x,y) return hemdark(x,y)*2.5 + lower(x,y)*1.0 + 0.4 end},
     {zs_m, function(x,y) local l = lit(x,y); return clamp(l*1.6-0.4,0,1)*1.3*(1-hemdark(x,y)) end}},
     coverage=3.5, fill=true, clip=S, length={3,6}, angle=function(x,y) return (y > 593) and 3.0 or 1.7 end, seed=40002})
  work(ZF.rags, {hand="detail", tool={kind="filbert", width=2}, piles={{ztrou2,1},{legdk,0.4}}, coverage=3.5, fill=true, clip=ZF.rags, length={3,8}, angle=1.6, seed=40003})
end
local F, R = oldlegs(-680)
zfeet_shapes((F + R):grow(2), -680)
zfeet_lay3()

--@ chunk 7
shad = pile{{"raw umber",0.8},{"bone black",0.7},{"ultramarine blue",0.45},{"green earth",0.2},{"lead white",0.1}, name="shad"}
stone_l = pile{{"lead white",0.7},{"raw umber",0.4},{"yellow ochre",0.25},{"green earth",0.15},{"bone black",0.1}, name="stone_l"}
stone_d = pile{{"raw umber",0.8},{"bone black",0.5},{"ultramarine blue",0.2}, name="stone_d"}
sage_d = pile{{"raw umber",0.8},{"bone black",0.6},{"green earth",0.6},{"ultramarine blue",0.15}, name="sage_d"}
sage_l = pile{{"lead white",0.6},{"green earth",0.6},{"raw umber",0.3},{"Prussian blue",0.08},{"yellow ochre",0.15}, name="sage_l"}
-- a dark foreground ground band (as the painting's bottom strip: gm/gd + shbt shadow over part)
local G = rect(20, 380, 900, 110)
local nz2 = noise{seed=1202, period=40, octaves=3, stretch={0, 3}}
work(G, {hand="body", tool="filbert 12", piles={{gm, function(x,y) return 0.6 + clamp(nz2(x,y),0,1)*0.3 end},{gd, 1.2}},
  coverage=2.3, fill=true, clip=G, angle=0.02, length={25,75}, scale_at=1.1, pressure={0.45,0.8}, seed=50001})
print(wait(20*24*60))
local sh = rect(500, 380, 420, 110):blur(3)
work(sh, {hand="scumble", pile=shbt, coverage=1.35, fill=true, clip=sh, seed=50002})
print(wait(10*24*60))
-- the old stones and sage, as on the painting
function stone_old(cx, cy, w, h, seed)
  local m = ellipse(cx, cy, w/2, h/2):roughen(w*0.08, w*0.3, seed) * above({{0,cy+h*0.3},{1000,cy+h*0.3}})
  work(m, {hand="detail", tool={kind="filbert", width=math.max(2, w*0.25)}, piles={{stone_d,1},{stone_l, function(x,y) return clamp((cy-y)/h*2 + (x-cx)/w*0.5 + 0.3,0,1)*1.5 end}},
    coverage=3, fill=true, clip=m, length={3,8}, angle=0.0, seed=seed})
  local sh = ellipse(cx - w*0.3, cy + h*0.32, w*0.55, h*0.18) - m
  work(sh, {hand="detail", tool={kind="round", width=2}, pile=shad, coverage=2.5, fill=true, clip=sh, length={3,8}, angle=0.0, seed=seed+1})
end
function sage2_old(cx, cy, w, h, seed)
  local m = ellipse(cx, cy - h*0.45, w*0.5, h*0.55):roughen(w*0.1, w*0.25, seed):soften(1.5) * above({{0,cy},{1000,cy}})
  stipple(m, {pile=sage_d, width=w*0.1, coverage=2.4, cluster=0.5, pressure={0.4,0.8}, seed=seed})
  local top = m * mask(function(x,y) return clamp(((x-cx)/w*0.9 - (y-(cy-h*0.55))/h*1.2) + 0.2, 0, 1) end)
  stipple(top, {pile=sage_l, width=w*0.07, coverage=1.3, cluster=0.6, pressure={0.35,0.65}, seed=seed+1})
end
stone_old(100, 440, 20, 9, 52)
stone_old(300, 440, 26, 11, 53)
stone_old(620, 440, 20, 9, 52)
stone_old(820, 440, 26, 11, 53)
sage2_old(200, 470, 56, 26, 43)
sage2_old(720, 475, 56, 26, 43)
print(wait(30*24*60))

--@ chunk 8
stone_m = mix{{stone_d, 0.6}, {stone_l, 0.4}, name="stone_m"}
stone_dd = mix{{stone_d, 0.6}, {shad, 0.4}, name="stone_dd"}
sage_m = mix{{sage_d, 0.6}, {sage_l, 0.4}, name="sage_m"}
-- a rock: flat-bottomed, lit on the side toward the moon (mx,my direction)
function rock(cx, cy, w, h, seed, mdx, mdy)
  math.randomseed(seed)
  local pts = {}
  local n = 9
  for i = 0, n do
    local a = math.pi + i/n*math.pi        -- from left, over the top, to the right
    local r = 1 + (math.random()-0.5)*0.35
    pts[#pts+1] = {cx + math.cos(a)*w/2*r, cy + math.sin(a)*h*r}
  end
  pts[#pts+1] = {cx + w/2*0.9, cy + h*0.12}
  pts[#pts+1] = {cx - w/2*0.9, cy + h*0.15}
  local m = poly(pts, true)
  local function lit(x,y)
    local a = 0
    for _, d in ipairs({1, 2, 3.5}) do a = a + (1 - m:at(x + mdx*d, y + mdy*d)) end
    return a/3
  end
  work(m, {hand="detail", tool={kind="filbert", width=math.max(2, w*0.18)}, piles={
     {stone_dd, function(x,y) return 0.6 + smoothstep(cy - h*0.3, cy + h*0.1, y)*1.2 end},
     {stone_d, 0.8},
     {stone_m, function(x,y) return clamp(lit(x,y)*1.8 - 0.3, 0, 1)*1.6 end}},
     coverage=3.5, fill=true, clip=m, length={2,6}, angle=0.2, seed=seed})
  -- the crest catching the moon: a short hairline on the lit shoulder
  local r = brush{kind="round", width=1.3, point=0.85}
  r:load(stone_l, 0.45)
  local best = {}
  for i = 1, #pts - 2 do
    local p = pts[i]
    local ux, uy = p[1]-cx, p[2]-cy
    if (ux*mdx + uy*mdy) > 0 then best[#best+1] = {p[1] - mdx*0.8, p[2] - mdy*0.8 + 0.6} end
  end
  if #best >= 2 then
    local g = {}
    for i, p in ipairs(best) do g[#g+1] = {p[1], p[2], (i == 1 or i == #best) and 0.1 or 0.45} end
    r:gesture(g, {clip=m:grow(0.5)})
  end
  -- a contact shadow on the sand, falling down-left (away from the moon)
  local sh = (ellipse(cx - w*0.25, cy + h*0.22, w*0.62, h*0.3) - m):blur(1)
  work(sh, {hand="detail", tool={kind="round", width=2}, pile=shad, coverage=2.5, fill=true, clip=sh, length={3,7}, angle=0.05, seed=seed+1})
  return m
end
-- a sage clump: dark mass at the base, twiggy strokes up and out, a few dim moonlit tips
function sagebrush(cx, cy, w, h, seed, mdx, mdy, old)
  math.randomseed(seed)
  local base = ellipse(cx, cy - h*0.3, w*0.42, h*0.35):roughen(w*0.08, w*0.2, seed)
  if old then base = base + old end
  stipple(base, {pile=sage_d, width=math.max(2, w*0.09), coverage=3.5, cluster=0.3, pressure={0.5,0.9}, seed=seed})
  local r = brush{kind="round", width=math.max(1.6, w*0.035), point=0.85}
  local n = math.floor(w*0.55)
  for i = 1, n do
    local t = (i - 0.5)/n
    local a = -math.pi/2 + (t - 0.5)*2.3 + (math.random()-0.5)*0.3
    local L = h*(0.75 + math.random()*0.5) * (1 - 0.35*math.abs(t-0.5)*2)
    local x0 = cx + (t-0.5)*w*0.35
    local y0 = cy - h*0.05
    local x1, y1 = x0 + math.cos(a)*L*0.55, y0 + math.sin(a)*L*0.55
    local x2, y2 = x0 + math.cos(a + (math.random()-0.5)*0.4)*L, y0 + math.sin(a)*L
    r:load(sage_d, 0.55)
    r:gesture({{x0, y0, 0.8},{x1, y1, 0.55},{x2, y2, 0.0}}, {wobble=0.4})
  end
  -- moonlit tips on the side toward the moon
  r:load(sage_m, 0.4)
  for i = 1, math.floor(w*0.18) do
    local t = 0.45 + math.random()*0.55
    local a = -math.pi/2 + (t - 0.5)*2.0
    local L = h*(0.6 + math.random()*0.4)
    local x0 = cx + (t-0.5)*w*0.5 + math.cos(a)*L*0.45
    local y0 = cy - h*0.1 + math.sin(a)*L*0.45
    r:gesture({{x0, y0, 0.45},{x0 + math.cos(a)*L*0.4, y0 + math.sin(a)*L*0.4, 0.0}}, {wobble=0.3})
  end
  -- its shadow on the sand, down-left
  local sh = (ellipse(cx - w*0.2, cy + h*0.05, w*0.55, h*0.16)):blur(1.5) * below({{0, cy - h*0.1},{1000, cy - h*0.1}})
  work(sh, {hand="detail", tool={kind="round", width=2.2}, pile=shad, coverage=2, fill=true, clip=sh, length={3,8}, angle=0.05, seed=seed+2})
end
rock(100, 440, 22, 6, 61, 0.7, -0.7)
rock(300, 440, 28, 7, 62, 0.6, -0.8)
local oldsage = ellipse(200, 470 - 26*0.45, 56*0.5, 26*0.55):roughen(5.6, 14, 43):soften(1.5) * above({{0,470},{1000,470}})
sagebrush(200, 471, 58, 24, 63, 0.6, -0.8, oldsage)

--@ chunk 9
gshad = mix{{gd, 0.55}, {shad, 0.25}, {pile{{"bone black",1},{"raw umber",0.6}}, 0.2}, name="gshad"}
sage_g = pile{{"lead white",0.35},{"green earth",0.6},{"raw umber",0.45},{"bone black",0.25},{"Prussian blue",0.04}, name="sage_g"}
sage_dg = mix{{sage_d, 0.6}, {sage_g, 0.4}, name="sage_dg"}
function sagebrush2(cx, cy, w, h, seed, mdx, mdy, old)
  math.randomseed(seed)
  local sh = (ellipse(cx - w*0.22, cy + h*0.06, w*0.5, h*0.13)):blur(1.5) * below({{0, cy - h*0.1},{1000, cy - h*0.1}})
  work(sh, {hand="detail", tool={kind="round", width=2.2}, pile=gshad, coverage=2, fill=true, clip=sh, length={3,8}, angle=0.05, seed=seed+2})
  local base = ellipse(cx, cy - h*0.22, w*0.36, h*0.26):roughen(w*0.07, w*0.15, seed)
  if old then base = base + old end
  stipple(base, {pile=sage_d, width=math.max(2, w*0.08), coverage=3.5, cluster=0.3, pressure={0.5,0.9}, seed=seed})
  local r = brush{kind="round", width=math.max(1.6, w*0.03), point=0.9}
  local n = math.floor(w*0.7)
  for i = 1, n do
    local t = (i - 0.5)/n + (math.random()-0.5)/n
    local a = -math.pi/2 + (t - 0.5)*2.6 + (math.random()-0.5)*0.25
    local L = h*(0.8 + math.random()*0.45) * (1 - 0.3*math.abs(t-0.5)*2)
    local x0 = cx + (t-0.5)*w*0.25
    local y0 = cy - h*0.02
    local bend = (math.random()-0.5)*0.35
    local x1, y1 = x0 + math.cos(a)*L*0.5, y0 + math.sin(a)*L*0.5
    local x2, y2 = x0 + math.cos(a+bend)*L, y0 + math.sin(a+bend)*L
    local litside = clamp((math.cos(a)*mdx + math.sin(a)*mdy), 0, 1)
    local p = (litside > 0.66 and sage_g) or (litside > 0.33 and sage_dg) or sage_d
    r:load(p, 0.6)
    r:gesture({{x0, y0, 0.7},{x1, y1, 0.5},{x2, y2, 0.0}}, {wobble=0.3})
  end
  local s = brush{kind="round", width=math.max(1.4, w*0.028), point=0.6}
  for i = 1, math.floor(w*0.3) do
    local t = 0.35 + math.random()*0.65
    local a = -math.pi/2 + (t - 0.5)*2.2
    local L = h*(0.55 + math.random()*0.45)
    local x0 = cx + (t-0.5)*w*0.25 + math.cos(a)*L
    local y0 = cy + math.sin(a)*L
    s:load(sage_g, 0.4)
    s:touch(x0, y0, {pressure=0.5, drag={math.cos(a)*1.5, math.sin(a)*1.5}})
  end
end
sagebrush2(450, 471, 58, 24, 64, 0.6, -0.8)
rock(560, 445, 24, 6, 65, 0.6, -0.8)
sagebrush2(650, 450, 26, 12, 66, 0.6, -0.8)

--@ chunk 10
function tuft(cx, cy, w, h, seed, mdx, mdy, old)
  math.randomseed(seed)
  local sh = (ellipse(cx - w*0.2, cy + h*0.05, w*0.48, h*0.12)):blur(1.5) * below({{0, cy - h*0.1},{1000, cy - h*0.1}})
  work(sh, {hand="detail", tool={kind="round", width=2.2}, pile=gshad, coverage=2, fill=true, clip=sh, length={3,8}, angle=0.05, seed=seed+2})
  local base = ellipse(cx, cy - h*0.15, w*0.3, h*0.2):roughen(w*0.06, w*0.12, seed)
  if old then base = base + old end
  stipple(base, {pile=sage_d, width=math.max(2, w*0.07), coverage=3.5, cluster=0.3, pressure={0.5,0.9}, seed=seed})
  local r = brush{kind="round", width=math.max(1.5, w*0.028), point=0.9}
  local n = math.floor(w*0.8)
  local blades = {}
  for i = 1, n do
    local t = math.random()
    local spread = (t - 0.5)*2              -- -1 left .. 1 right
    local a = -math.pi/2 + spread*1.15 + (math.random()-0.5)*0.5
    local L = h*(0.5 + math.random()*0.75) * (1 - 0.35*math.abs(spread))
    local x0 = cx + spread*w*0.2 + (math.random()-0.5)*w*0.1
    local y0 = cy - h*0.02
    local droop = spread*0.5 + (math.random()-0.5)*0.3       -- outer blades arch over
    local x1, y1 = x0 + math.cos(a)*L*0.5, y0 + math.sin(a)*L*0.5
    local a2 = a + droop
    local x2, y2 = x1 + math.cos(a2)*L*0.5, y1 + math.sin(a2)*L*0.5 + math.abs(spread)*L*0.12
    blades[#blades+1] = {x0,y0,x1,y1,x2,y2, clamp(math.cos(a)*mdx + math.sin(a)*mdy, 0, 1)}
  end
  -- dark blades first, lighter (moon-side) blades on top
  table.sort(blades, function(p, q) return p[7] < q[7] end)
  for _, b in ipairs(blades) do
    local p = (b[7] > 0.75 and math.random() < 0.6 and sage_g) or (b[7] > 0.4 and sage_dg) or sage_d
    r:load(p, 0.6)
    r:gesture({{b[1], b[2], 0.75},{b[3], b[4], 0.5},{b[5], b[6], 0.0}}, {wobble=0.3})
  end
end
function rock2(cx, cy, w, h, seed, mdx, mdy)
  math.randomseed(seed)
  local pts = {}
  local n = 9
  for i = 0, n do
    local a = math.pi + i/n*math.pi
    local r = 1 + (math.random()-0.5)*0.35
    pts[#pts+1] = {cx + math.cos(a)*w/2*r, cy + math.sin(a)*h*r}
  end
  pts[#pts+1] = {cx + w/2*0.9, cy + h*0.12}
  pts[#pts+1] = {cx - w/2*0.9, cy + h*0.15}
  local m = poly(pts, true)
  local sh = (ellipse(cx - w*0.25, cy + h*0.2, w*0.6, h*0.28) - m):blur(1)
  work(sh, {hand="detail", tool={kind="round", width=2}, pile=gshad, coverage=2.5, fill=true, clip=sh, length={3,7}, angle=0.05, seed=seed+1})
  local function lit(x,y)
    local a = 0
    for _, d in ipairs({1, 2, 3.5}) do a = a + (1 - m:at(x + mdx*d, y + mdy*d)) end
    return a/3
  end
  work(m, {hand="detail", tool={kind="filbert", width=math.max(2, w*0.18)}, piles={
     {stone_dd, function(x,y) return 0.6 + smoothstep(cy - h*0.3, cy + h*0.1, y)*1.2 end},
     {stone_d, 0.8},
     {stone_m, function(x,y) return clamp(lit(x,y)*1.8 - 0.3, 0, 1)*1.6 end}},
     coverage=3.5, fill=true, clip=m, length={2,6}, angle=0.2, seed=seed})
  local r = brush{kind="round", width=1.3, point=0.85}
  r:load(stone_l, 0.45)
  local best = {}
  for i = 1, #pts - 2 do
    local p = pts[i]
    if ((p[1]-cx)*mdx + (p[2]-cy)*mdy) > 0 then best[#best+1] = {p[1] - mdx*0.8, p[2] - mdy*0.8 + 0.6} end
  end
  if #best >= 2 then
    local g = {}
    for i, p in ipairs(best) do g[#g+1] = {p[1], p[2], (i == 1 or i == #best) and 0.1 or 0.45} end
    r:gesture(g, {clip=m:grow(0.5)})
  end
  return m
end
tuft(760, 471, 56, 26, 71, 0.6, -0.8)
tuft(860, 452, 30, 14, 72, 0.6, -0.8)
rock2(700, 452, 30, 8, 73, 0.6, -0.8)
local oldsage = ellipse(720, 475 - 26*0.45, 56*0.5, 26*0.55):roughen(5.6, 14, 43):soften(1.5) * above({{0,475},{1000,475}})
tuft(720, 476, 60, 28, 74, 0.6, -0.8, oldsage)

--@ chunk 11
-- ground over an old pale stone and its shadow (in the dark, unshadowed band on the left part)
local m = ellipse(300, 441, 18, 8)
work(m, {hand="detail", tool={kind="filbert", width=3}, piles={{gm, 0.7},{gd, 1.2}}, coverage=3.5, fill=true, clip=m:soften(2), length={4,10}, angle=0.02, seed=81001})
rock2(600, 470, 30, 8, 83, 0.6, -0.8)
rock2(120, 470, 16, 5, 84, 0.6, -0.8)

--@ chunk 12
function tuft3(cx, cy, w, h, seed, lean, nlit)
  math.randomseed(seed)
  local sh = (ellipse(cx - w*0.18, cy + h*0.06, w*0.5, h*0.12)):blur(1.5) * below({{0, cy - h*0.1},{1000, cy - h*0.1}})
  work(sh, {hand="detail", tool={kind="round", width=2.2}, pile=gshad, coverage=2, fill=true, clip=sh, length={3,8}, angle=0.05, seed=seed+2})
  -- a low ragged clump, wider than tall
  local base = (ellipse(cx, cy - h*0.18, w*0.42, h*0.26):roughen(w*0.08, w*0.1, seed) + ellipse(cx + w*0.12, cy - h*0.3, w*0.2, h*0.2):roughen(w*0.05, w*0.08, seed+5)) * above({{0, cy+1},{1000, cy+1}})
  stipple(base, {pile=sage_d, width=math.max(2, w*0.06), coverage=4, cluster=0.3, pressure={0.5,0.9}, seed=seed})
  local r = brush{kind="round", width=math.max(1.4, w*0.022), point=0.9}
  local n = math.floor(w*0.55)
  local blades = {}
  for i = 1, n do
    local spread = math.random()*2 - 1
    local a = -math.pi/2 + lean + spread*0.9 + (math.random()-0.5)*0.4
    local L = h*(0.35 + math.random()*0.55)
    local x0 = cx + spread*w*0.3
    local y0 = cy - h*(0.1 + math.random()*0.25)
    local a2 = a + lean*0.8 + (math.random()-0.5)*0.4
    local x1, y1 = x0 + math.cos(a)*L*0.55, y0 + math.sin(a)*L*0.55
    local x2, y2 = x1 + math.cos(a2)*L*0.45, y1 + math.sin(a2)*L*0.45
    blades[#blades+1] = {x0,y0,x1,y1,x2,y2}
  end
  for i, b in ipairs(blades) do
    r:load(i <= n - nlit and sage_d or sage_dg, 0.6)
    r:gesture({{b[1], b[2], 0.7},{b[3], b[4], 0.45},{b[5], b[6], 0.0}}, {wobble=0.3})
  end
  -- a few moonlit tips on the right/top, short
  local s = brush{kind="round", width=math.max(1.3, w*0.02), point=0.9}
  for i = 1, nlit do
    local b = blades[n - i + 1]
    s:load(sage_g, 0.45)
    s:gesture({{b[3], b[4], 0.35},{b[5], b[6], 0.0}}, {wobble=0.2})
  end
end
-- over the dark band, where the old pale tuft trials are not
tuft3(420, 485, 70, 26, 101, 0.35, 5)
tuft3(530, 470, 38, 16, 102, 0.3, 3)
tuft3(900, 485, 70, 26, 103, 0.35, 5)

--@ chunk 13
local G = rect(20, 510, 900, 110)
local nz2 = noise{seed=1202, period=40, octaves=3, stretch={0, 3}}
work(G, {hand="body", tool="filbert 12", piles={{gm, function(x,y) return 0.9 + clamp(nz2(x,y),0,1)*0.3 end},{gd, 1.0},{gf, 0.25}},
  coverage=2.3, fill=true, clip=G, angle=0.02, length={25,75}, scale_at=1.1, pressure={0.45,0.8}, seed=50011})
print(wait(25*24*60))

--@ chunk 14
function tuft4(cx, cy, w, h, seed, lean, nlit, litlen)
  math.randomseed(seed)
  litlen = litlen or 0.6
  local sh = (ellipse(cx - w*0.18, cy + h*0.06, w*0.5, h*0.12)):blur(1.5) * below({{0, cy - h*0.1},{1000, cy - h*0.1}})
  work(sh, {hand="detail", tool={kind="round", width=2.2}, pile=gshad, coverage=2, fill=true, clip=sh, length={3,8}, angle=0.05, seed=seed+2})
  local base = (ellipse(cx, cy - h*0.18, w*0.42, h*0.26):roughen(w*0.08, w*0.1, seed) + ellipse(cx + w*0.12, cy - h*0.3, w*0.2, h*0.2):roughen(w*0.05, w*0.08, seed+5)) * above({{0, cy+1},{1000, cy+1}})
  stipple(base, {pile=sage_d, width=math.max(2, w*0.06), coverage=4, cluster=0.3, pressure={0.5,0.9}, seed=seed})
  local r = brush{kind="round", width=math.max(1.4, w*0.022), point=0.9}
  local n = math.floor(w*0.55)
  local blades = {}
  for i = 1, n do
    local spread = math.random()*2 - 1
    local a = -math.pi/2 + lean + spread*0.9 + (math.random()-0.5)*0.4
    local L = h*(0.35 + math.random()*0.55)
    local x0 = cx + spread*w*0.3
    local y0 = cy - h*(0.1 + math.random()*0.25)
    local a2 = a + lean*0.8 + (math.random()-0.5)*0.4
    local x1, y1 = x0 + math.cos(a)*L*0.55, y0 + math.sin(a)*L*0.55
    local x2, y2 = x1 + math.cos(a2)*L*0.45, y1 + math.sin(a2)*L*0.45
    -- how much it faces the moon (up-right)
    local face = (math.cos(a)*0.6 - math.sin(a)*0.8) + spread*0.3
    blades[#blades+1] = {x0,y0,x1,y1,x2,y2, face}
  end
  table.sort(blades, function(p,q) return p[7] < q[7] end)
  for i, b in ipairs(blades) do
    r:load(i <= n - nlit and sage_d or sage_dg, 0.6)
    r:gesture({{b[1], b[2], 0.7},{b[3], b[4], 0.45},{b[5], b[6], 0.0}}, {wobble=0.3})
  end
  local s = brush{kind="round", width=math.max(1.3, w*0.02), point=0.9}
  for i = 1, nlit do
    local b = blades[n - i + 1]
    local t = 1 - litlen
    local xs, ys = lerp(b[1], b[5], t), lerp(b[2], b[6], t)
    s:load(sage_g, 0.5)
    s:gesture({{xs, ys, 0.4},{b[3]*0.3 + b[5]*0.7, b[4]*0.3 + b[6]*0.7, 0.3},{b[5], b[6], 0.0}}, {wobble=0.2})
  end
end
tuft4(120, 600, 74, 30, 111, 0.35, 6, 0.6)
tuft4(320, 590, 40, 17, 112, 0.3, 4, 0.6)
tuft4(520, 600, 74, 30, 113, 0.35, 9, 0.75)
tuft4(720, 590, 40, 17, 114, 0.3, 5, 0.75)

--@ chunk 15
-- ring of thinned scumble over the dry ground, then try lifting half of it with a spirits rag at once
local ring = (ellipse(200, 600, 26, 9) - ellipse(200, 600, 20, 5)):blur(2) + (ellipse(400, 600, 26, 9) - ellipse(400, 600, 20, 5)):blur(2)
work(ring, {hand="scumble", tool={kind="filbert", width=5}, pile=shbt, coverage=1.4, fill=true, clip=ring, angle=0.05, length={6,12}, seed=42001})
print(drying(200, 591))
local r = rag{width=8}
-- top arc of the left ring
for k = 1, 3 do
  r:dip(0.9)
  r:wipe({{176,597},{186,592},{200,590},{214,592},{224,597}}, {pressure={0.8,0.8}})
  r:refold()
end
print(r)

--@ chunk 16
boot = pile{{"raw umber",1},{"bone black",0.5},{"red earth",0.35},{"lead white",0.06}, name="boot"}
boot2 = pile{{"bone black",1},{"raw umber",0.8},{"red earth",0.15}, name="boot2"}
boot_lit = pile{{"raw umber",0.5},{"red earth",0.35},{"yellow ochre",0.4},{"orange vermilion",0.08},{"lead white",0.3}, name="boot_lit"}
function bootshape(dx, dy)
  local P = {{264,590},{288,592},{294,600},{306,605},{320,609},{331,614},{333,621},{300,623},{276,623},{270,612}}
  local o = {} for i,p in ipairs(P) do o[i] = {p[1]+dx, p[2]+dy} end
  return poly(o, true)
end
for i, dx in ipairs({-240, -120, 0}) do
  local bm = bootshape(dx, -50)
  work(bm, {hand="detail", tool={kind="filbert", width=3}, pile=boot, coverage=3, fill=true, clip=true, length={4,10}, angle=0.1, seed=60001+i})
end
print(wait(20*24*60))
for i, dx in ipairs({-240, -120, 0}) do
  local bm = bootshape(dx, -50)
  work(bm, {hand="detail", tool={kind="filbert", width=3}, pile=boot2, coverage=3.5, fill=true, clip=true, length={4,10}, angle=0.1, seed=60011+i})
end
print(wait(60*24*60))

--@ chunk 17
local crumb = pile{{"raw umber",0.5},{"red earth",0.45},{"yellow ochre",0.3},{"bone black",0.3},{"lead white",0.1}, blot=0.3, name="crumb"}
for i, dx in ipairs({-240, -120, 0}) do
  local bm = bootshape(dx, -50)
  stipple(bm, {pile=crumb, width=2.5, coverage=3, cluster=0.5, pressure={0.6,1.0}, drag=1.5, clip=bm, seed=61000+i})
  work(bm, {hand="detail", tool={kind="filbert", width=3, lay=2}, pile=boot2, coverage=1.5, fill=false, clip=true, length={3,7}, angle=0.1, seed=61010+i})
end
print(wait(40*24*60))
print(drying(80,555))

--@ chunk 18
boot_m = pile{{"raw umber",0.8},{"bone black",0.5},{"red earth",0.2},{"yellow ochre",0.15},{"lead white",0.12}, name="boot_m"}
boot_rim = pile{{"raw umber",0.5},{"lead white",0.45},{"Prussian blue",0.08},{"bone black",0.2},{"yellow ochre",0.12}, name="boot_rim"}
function bootpass(bm, opts)
  local function lit(x,y)
    local a = 0
    for _, d in ipairs({1, 2, 3}) do a = a + (1 - bm:at(x + 0.5*d, y - 0.85*d)) end
    return a/3
  end
  local tool = {kind="filbert", width=3, lay=opts.lay or 1}
  work(bm, {hand="detail", tool=tool, piles={
      {boot2, 1},
      {boot_m, function(x,y) return clamp(lit(x,y)*1.5 - 0.2, 0, 1)*1.2 end},
      {boot_rim, function(x,y) return clamp(lit(x,y)*2 - 1.1, 0, 1)*1.0 end}},
    coverage=opts.cov or 3.5, fill=true, clip=bm, length={3,8}, angle=0.12, seed=opts.seed})
end
bootpass(bootshape(-240,-50), {lay=1, cov=3.5, seed=62001})
bootpass(bootshape(-120,-50), {lay=3, cov=3, seed=62002})
-- C: knife slab, then the lit pass lighter on top
local bm = bootshape(0,-50)
local k = knife{width=10}
k:load(boot2, 1)
for y = 538, 575, 4 do k:lay({{258,y},{340,y}}, {pressure={0.6,0.6}}) ; if (y % 12) == 2 then k:load(boot2, 1) end end
print("knife done")

--@ chunk 19
cglaze = pile{{"bone black",0.6},{"raw umber",0.8},{"ultramarine blue",0.3}, medium=0.78, name="cglaze"}
function bootat(dx, dy)
  local P = {{264,590},{288,592},{294,600},{306,605},{320,609},{331,614},{333,621},{300,623},{276,623},{270,612}}
  local o = {} for i,p in ipairs(P) do o[i] = {p[1]+dx, p[2]+dy} end
  return poly(o, true)
end
-- A (x 400s) and B (x 600s): identical history up to the glaze; only A gets cglaze
local A, B = bootat(150, -290), bootat(350, -290)
for i, m in ipairs({A, B}) do
  work(m, {hand="detail", tool={kind="filbert", width=3}, pile=boot, coverage=3, fill=true, clip=true, length={4,10}, angle=0.1, seed=63000+i})
  work(m, {hand="detail", tool={kind="filbert", width=3}, pile=boot2, coverage=3.5, fill=true, clip=true, length={4,10}, angle=0.1, seed=63010+i})
end
print(wait(20*24*60))
work(A, {hand="glaze", tool={kind="filbert", width=6, stiffness=0.3}, pile=cglaze, coverage=2, fill=true, angle=0.1, clip=A})
print(wait(120*24*60))
print(drying(450,320), drying(650,320))
bootpass(A, {lay=1, cov=3.5, seed=63101})
bootpass(B, {lay=1, cov=3.5, seed=63102})

--@ chunk 20
print(wait(14*24*60))
print(drying(450,320), drying(650,320))
bscum = pile{{"bone black",1},{"raw umber",0.7},{"ultramarine blue",0.2},{"red earth",0.1}, thinner=0.6, name="bscum"}
for i, m in ipairs({bootat(150, -290), bootat(350, -290)}) do
  local function lit(x,y)
    local a = 0
    for _, d in ipairs({1, 2, 3}) do a = a + (1 - m:at(x + 0.5*d, y - 0.85*d)) end
    return a/3
  end
  local M = m:shrink(0.5):blur(1)
  work(M, {hand="scumble", tool={kind="filbert", width=4}, pile=bscum, coverage=1.4, fill=true, clip=m, angle=0.12, length={5,10},
    load_at=function(x,y) return lerp(0.9, 0.25, clamp(lit(x,y)*1.6, 0, 1)) end, seed=64000+i})
end

--@ chunk 21
local bmid = pile{{"raw umber",0.8},{"bone black",0.3},{"red earth",0.25},{"yellow ochre",0.3},{"lead white",0.12}, blot=0.25, name="bmid"}
C1, C2b = bootat(150, -200), bootat(350, -200)
for i, m in ipairs({C1, C2b}) do
  work(m, {hand="detail", tool={kind="filbert", width=3, lay=4, hair=0.8}, pile=bmid, coverage=3, fill=true, clip=m, length={3,7}, angle=0.4, seed=65000+i})
end
print(wait(25*24*60))
print(drying(450,410), drying(650,410))
for i, m in ipairs({C1, C2b}) do bootpass(m, {lay=1, cov=3.5, seed=65100+i}) end
print(wait(14*24*60))
print(drying(450,410), drying(650,410))

--@ chunk 22
local m = C1
local function lit(x,y)
  local a = 0
  for _, d in ipairs({1, 2, 3}) do a = a + (1 - m:at(x + 0.5*d, y - 0.85*d)) end
  return a/3
end
local M = m:shrink(0.5):blur(1)
work(M, {hand="scumble", tool={kind="filbert", width=4}, pile=bscum, coverage=1.4, fill=true, clip=m, angle=0.12, length={5,10},
  load_at=function(x,y) return lerp(0.9, 0.25, clamp(lit(x,y)*1.6, 0, 1)) end, seed=66001})
print(wait(10*24*60))
print(drying(450,410))

--@ chunk 23
-- two more ridged substrates, same history as the painting's boots (mid-brown, ridged, then a bootpass)
local bmid = pile{{"raw umber",0.8},{"bone black",0.3},{"red earth",0.25},{"yellow ochre",0.3},{"lead white",0.12}, blot=0.25, name="bmid"}
C3, C4 = bootat(-150, -200), bootat(-150, -120)
for i, m in ipairs({C3, C4}) do
  work(m, {hand="detail", tool={kind="filbert", width=3, lay=4, hair=0.8}, pile=bmid, coverage=3, fill=true, clip=m, length={3,7}, angle=0.4, seed=67000+i})
end
print(wait(25*24*60))
for i, m in ipairs({C3, C4}) do bootpass(m, {lay=1, cov=3.5, seed=67100+i}) end
print(wait(14*24*60))
print(drying(150,410), drying(150,490), drying(650,410), drying(450,410))

--@ chunk 24
boot2f = pile{{"bone black",1},{"raw umber",0.8},{"red earth",0.15}, medium=0.25, name="boot2f"}
boot_mf = pile{{"raw umber",0.8},{"bone black",0.5},{"red earth",0.2},{"yellow ochre",0.15},{"lead white",0.12}, medium=0.25, name="boot_mf"}
boot_rimf = pile{{"raw umber",0.5},{"lead white",0.45},{"Prussian blue",0.08},{"bone black",0.2},{"yellow ochre",0.12}, medium=0.15, name="boot_rimf"}
function bootfill(bm, seed, lay)
  local function lit(x,y)
    local a = 0
    for _, d in ipairs({1, 2, 3}) do a = a + (1 - bm:at(x + 0.5*d, y - 0.85*d)) end
    return a/3
  end
  work(bm, {hand="detail", tool={kind="filbert", width=3, lay=lay}, piles={
      {boot2f, 1},
      {boot_mf, function(x,y) return clamp(lit(x,y)*1.5 - 0.2, 0, 1)*1.2 end},
      {boot_rimf, function(x,y) return clamp(lit(x,y)*2 - 1.1, 0, 1)*1.0 end}},
    coverage=3.5, fill=true, clip=bm, length={3,8}, angle=0.12, pressure={0.7,1.0}, seed=seed})
end
-- (a) fluid dark body, lay 3, over C2b
bootfill(C2b, 68001, 3)
-- (b) same fluid paint, lay 1.5, over C3
bootfill(C3, 68002, 1.5)
-- (c) small knife fills furrows with boot2 (no medium), over C4, then the lit edge by brush
local k = knife{width=4}
local y0 = C4
for y = 471, 501, 2.5 do
  local xs = {}
  for x = 110, 190, 1 do if C4:shrink(2.2):at(x, y) > 0.5 then xs[#xs+1] = x end end
  if #xs > 1 then
    k:load(boot2, 0.9)
    k:lay({{xs[1], y},{xs[#xs], y}}, {pressure={0.85,0.85}, angle=1.5708})
  end
end
print("ok")

--@ chunk 25
local bmid = pile{{"raw umber",0.8},{"bone black",0.3},{"red earth",0.25},{"yellow ochre",0.3},{"lead white",0.12}, blot=0.25, name="bmid"}
C5, C6 = bootat(-150, -40), bootat(50, -40)
for i, m in ipairs({C5, C6}) do
  work(m, {hand="detail", tool={kind="filbert", width=3, lay=4, hair=0.8}, pile=bmid, coverage=3, fill=true, clip=m, length={3,7}, angle=0.4, seed=69000+i})
end
print(wait(25*24*60))
for i, m in ipairs({C5, C6}) do bootpass(m, {lay=1, cov=3.5, seed=69100+i}) end
print(wait(14*24*60))
-- C5: opaque, no medium, lay 3
bootpass(C5, {lay=3, cov=3.5, seed=69201})
-- C6: opaque, no medium, lay 2, then a light blend to close the furrows
bootpass(C6, {lay=2, cov=4, seed=69202})
print(wait(20*24*60))

--@ chunk 26
print(type(varnish), type(oil_out), type(glaze), type(dry))

--@ chunk 27
local bmid = pile{{"raw umber",0.8},{"bone black",0.3},{"red earth",0.25},{"yellow ochre",0.3},{"lead white",0.12}, blot=0.25, name="bmid"}
C7, C8 = bootat(450, -40), bootat(600, -40)
for i, m in ipairs({C7, C8}) do
  work(m, {hand="detail", tool={kind="filbert", width=3, lay=4, hair=0.8}, pile=bmid, coverage=3, fill=true, clip=m, length={3,7}, angle=0.4, seed=70000+i})
end
print(wait(25*24*60))
for i, m in ipairs({C7, C8}) do bootpass(m, {lay=1, cov=3.5, seed=70100+i}) end
print(wait(14*24*60))
boot2m = pile{{"bone black",1},{"raw umber",0.8},{"red earth",0.15}, medium=0.15, name="boot2m"}
-- C7: dark only, lay 6, medium .15
work(C7, {hand="detail", tool={kind="filbert", width=3, lay=6}, pile=boot2m, coverage=3, fill=true, clip=C7, length={3,8}, angle=0.12, seed=70201})
-- C8: dark only, no medium, lay 6
work(C8, {hand="detail", tool={kind="filbert", width=3, lay=6}, pile=boot2, coverage=3, fill=true, clip=C8, length={3,8}, angle=0.12, seed=70202})
print(wait(30*24*60))
print(drying(750,565), drying(900,565))

--@ chunk 28
local m = ellipse(150, 590, 44, 20):blur(5)
work(m, {hand="scumble", tool={kind="filbert", width=6}, pile=shbt, coverage=1.4, fill=true, clip=m, angle=1.4, length={6,14}, seed=43201, load_at=function(x,y) return 0.85 end})
local m2 = ellipse(520, 590, 44, 20):blur(5)
work(m2, {hand="scumble", tool={kind="filbert", width=6}, pile=shbt, coverage=1.4, fill=true, clip=m2, angle=1.4, length={6,14}, seed=43202, load_at=function(x,y) return 0.85 end})
print(drying(150,590))
local r = rag{width=14}
for k = 1, 2 do
  for y = 572, 608, 6 do r:dip(0.9); r:wipe({{100,y},{200,y}}, {pressure={0.85,0.85}}); r:refold() end
end
print(r)

--@ chunk 29
gw = pile{{"raw umber",0.8},{"yellow ochre",0.6},{"red earth",0.15},{"lead white",0.22},{"green earth",0.2}, name="gw"}
gnear = mix{{gd, 0.7}, {shad, 0.3}, name="gnear"}
-- a dark dry ground band, then a khaki blob like the painting's (detail pass + body pass), fresh
local G = rect(20, 620, 900, 45)
work(G, {hand="body", tool="filbert 12", piles={{gd, 1.2},{gm, 0.5}}, coverage=2.3, fill=true, clip=G, angle=0.02, length={25,75}, pressure={0.45,0.8}, seed=71001})
print(wait(30*24*60))
local nz2 = noise{seed=1202, period=40, octaves=3, stretch={0, 3}}
for i, cx in ipairs({120, 320, 520}) do
  local C = ellipse(cx, 642, 50, 18):roughen(4, 15, 9):soften(2)
  work(C, {hand="detail", tool={kind="filbert", width=3.5}, piles={{gm, 1.0},{gw, 0.6},{gd, 0.5}}, coverage=3.5, fill=true, clip=C, length={5,12}, angle=0.02, seed=71010+i})
  work(C:grow(4):soften(6), {hand="body", tool={kind="filbert", width=5}, piles={{gm, 1.1},{gw, 0.5}}, coverage=2.2, fill=true, clip=C:grow(9), edge="lost", length={8,18}, angle=0.02, pressure={0.4,0.7}, seed=71020+i})
end
print(drying(120,642))

--@ chunk 30
-- A: spirits rag only
local r = rag{width=14}
for k = 1, 3 do
  for y = 618, 666, 5 do r:dip(0.9); r:wipe({{60,y},{180,y}}, {pressure={0.85,0.85}}); r:refold() end
end
print(r)
-- B: dark wet-into-wet overpaint
local nz2 = noise{seed=1202, period=40, octaves=3, stretch={0, 3}}
local CB_ = ellipse(320, 642, 50, 18):roughen(4, 15, 9):grow(10):soften(4)
work(CB_, {hand="body", tool={kind="filbert", width=5}, piles={{gnear, 1},{gd, 0.6}}, coverage=3, fill=true, clip=CB_:grow(3), edge="lost", length={8,18}, angle=0.02, pressure={0.5,0.8}, seed=71101})
-- C: rag 2 rounds, then dark overpaint lighter
local r2 = rag{width=14}
for k = 1, 2 do
  for y = 618, 666, 5 do r2:dip(0.9); r2:wipe({{460,y},{580,y}}, {pressure={0.85,0.85}}); r2:refold() end
end
local CC = ellipse(520, 642, 50, 18):roughen(4, 15, 9):grow(10):soften(4)
work(CC, {hand="body", tool={kind="filbert", width=5}, piles={{gnear, 1},{gd, 0.6}}, coverage=2, fill=true, clip=CC:grow(3), edge="lost", length={8,18}, angle=0.02, pressure={0.5,0.8}, seed=71102})

--@ chunk 31
for k = 1, 2 do
  for y = 618, 666, 5 do
    local r = rag{width=14}
    r:dip(0.9); r:wipe({{185,y},{60,y}}, {pressure={0.85,0.85}}); r:refold(); r:dip(0.9); r:wipe({{60,y},{185,y}}, {pressure={0.85,0.85}})
  end
end

--@ chunk 32
function darkblades(cx, cy, w, h, seed, n, lean)
  math.randomseed(seed)
  local r = brush{kind="round", width=math.max(1.5, w*0.026), point=0.9}
  for i = 1, n do
    local spread = math.random()*2 - 1
    local a = -math.pi/2 + lean + spread*1.0 + (math.random()-0.5)*0.4
    local L = h*(0.45 + math.random()*0.6) * (1 - 0.3*math.abs(spread))
    local x0 = cx + spread*w*0.18
    local y0 = cy - h*0.02
    local a2 = a + spread*0.4 + (math.random()-0.5)*0.3
    local x1, y1 = x0 + math.cos(a)*L*0.5, y0 + math.sin(a)*L*0.5
    local x2, y2 = x1 + math.cos(a2)*L*0.5, y1 + math.sin(a2)*L*0.5
    r:load((math.random() < 0.75) and sage_d or sage_dg, 0.6)
    r:gesture({{x0, y0, 0.8},{x1, y1, 0.5},{x2, y2, 0.0}}, {wobble=0.3})
  end
  -- dense dark base so the blades grow from a mass
  local base = ellipse(cx, cy - h*0.1, w*0.24, h*0.14):roughen(w*0.04, w*0.1, seed)
  stipple(base, {pile=sage_d, width=math.max(2, w*0.06), coverage=3, cluster=0.3, pressure={0.5,0.9}, seed=seed})
end
darkblades(760, 471, 56, 26, 81, 30, 0.15)

--@ chunk 33
local bmid = pile{{"raw umber",0.8},{"bone black",0.3},{"red earth",0.25},{"yellow ochre",0.3},{"lead white",0.12}, blot=0.25, name="bmid"}
T1, T2 = bootat(150, -380), bootat(350, -380)
for i, m in ipairs({T1, T2}) do
  work(m, {hand="detail", tool={kind="filbert", width=3, lay=4, hair=0.8}, pile=bmid, coverage=3, fill=true, clip=m, length={3,7}, angle=0.4, seed=72000+i})
end
print(wait(30*24*60))
local b2med = pile{{"bone black",1},{"raw umber",0.8},{"red earth",0.15}, medium=0.2, name="b2med"}
-- identical handling, only the medium differs
work(T1, {hand="detail", tool={kind="filbert", width=3}, pile=boot2, coverage=3.5, fill=true, clip=T1, length={3,8}, angle=0.12, seed=72101})
work(T2, {hand="detail", tool={kind="filbert", width=3}, pile=b2med, coverage=3.5, fill=true, clip=T2, length={3,8}, angle=0.12, seed=72101})
print(wait(30*24*60))
print(drying(450,225), drying(650,225))

--@ chunk 34
local r = brush{kind="round", width=1.6, point=0.85}
r:load(boot_rim, 0.4)
local dx, dy = 150, -380
local function P(t) local o = {} for i,p in ipairs(t) do o[i] = {p[1]+dx, p[2]+dy, p[3]} end return o end
r:gesture(P{{268,591.5,0.15},{282,592.8,0.4},{291,598,0.4},{304,603.8,0.35},{318,607.8,0.3},{329,612.6,0.1}}, {clip=T1})
r:load(boot_rim, 0.3)
r:gesture(P{{330,615,0.2},{332,619,0.3},{331,621,0.05}}, {clip=T1})
