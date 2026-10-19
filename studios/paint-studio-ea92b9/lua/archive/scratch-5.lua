-- easel session "scratch": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box friedrich
--@ engine 7

--@ chunk 1
canvas{aspect=1.4, ground={{apply="knife", pile={{"red earth", 2}, {"yellow ochre", 2}, {"lead white", 1}}, texture=0.3, um=60}, {apply="brush", pile={{"lead white", 6}, {"yellow ochre", 0.35}, {"raw umber", 0.12}}, um=35}}, linen={16, 14}, seed=1774, size=650}

--@ chunk 2
s_zen  = pile{{"lead white",0.6},{"smalt",1.5},{"cobalt blue",0.8},{"Prussian blue",0.1},{"raw umber",0.15},{"bone black",0.04}, name="s_zen"}
s_top  = pile{{"lead white",1.5},{"smalt",1.2},{"cobalt blue",0.8},{"raw umber",0.08}, name="s_top"}
s_mid  = pile{{"lead white",3},{"cobalt blue",0.6},{"smalt",0.6},{"Naples yellow",0.2}, name="s_mid"}
s_grn  = pile{{"lead white",5},{"Naples yellow",1},{"cobalt blue",0.6}, name="s_grn"}
s_glow = pile{{"lead white",5},{"Naples yellow",1.5},{"yellow ochre",0.25},{"vermilion",0.05}, name="s_glow"}
local function wgt(c, r) return function(x,y) return math.max(0, 1 - math.abs(y-c)/r) end end
local sky = rect(0,0,1000,470)
work(sky, {hand="broad", piles={{s_zen,wgt(0,150)},{s_top,wgt(120,120)},{s_mid,wgt(235,110)},{s_grn,wgt(325,100)},{s_glow,wgt(420,100)}}, angle=0, coverage=2.6, fill=true, clip=sky, seed=111})
blend(sky, {angle=0}); blend(sky, {angle=0.04})
wait(3*24*60)
g_sky = pile{{"smalt",2},{"cobalt blue",0.35},{"rose madder",0.1},{"raw umber",0.16}, medium=0.75, name="g_sky"}
work(rect(0,0,1000,330), {hand="glaze", pile=g_sky, angle=0, coverage=1.8, clip=rect(0,0,1000,440), load_at=function(x,y) return clamp(1 - y/300, 0, 1)^1.2 end, seed=121})
for i=1,4 do blend(rect(0,0,1000,345), {angle=0, seed=i}) end
print(wait(3*24*60), drying(500,50))

--@ chunk 3
d1 = pile{{"lead white",1},{"smalt",1.6},{"cobalt blue",0.5},{"raw umber",0.28},{"rose madder",0.05}, name="d1"}
d2 = pile{{"lead white",1.6},{"smalt",1.3},{"cobalt blue",0.5},{"raw umber",0.18}, name="d2"}
d3 = pile{{"lead white",2.4},{"smalt",1},{"cobalt blue",0.5},{"raw umber",0.1}, thinner=0.5, name="d3"}
local function wgt(c, r) return function(x,y) return math.max(0, 1 - math.abs(y-c)/r) end end
-- left half: ruler-straight horizontal strokes, opaque, then horizontal blending
local mL = rect(0,0,500,240)
work(mL, {hand="broad", piles={{d1,wgt(0,110)},{d2,wgt(100,90)},{d3,wgt(190,80)}}, angle=0, ruler=true, coverage=2.4, fill=true, clip=rect(0,0,500,260),
  load_at=function(x,y) return clamp(1.15 - y/230, 0.15, 1) end, seed=11})
for i=1,3 do blend(rect(0,0,500,250), {angle=0, seed=20+i}) end
-- right half: same but with default curved strokes
local mR = rect(500,0,500,240)
work(mR, {hand="broad", piles={{d1,wgt(0,110)},{d2,wgt(100,90)},{d3,wgt(190,80)}}, angle=0, coverage=2.4, fill=true, clip=rect(500,0,500,260),
  load_at=function(x,y) return clamp(1.15 - y/230, 0.15, 1) end, seed=12})
for i=1,3 do blend(rect(500,0,500,250), {angle=0, seed=30+i}) end

--@ chunk 4
print(wait(2*24*60))
cl_dark = pile{{"lead white",1.2},{"smalt",0.7},{"rose madder",0.25},{"raw umber",0.3},{"Naples yellow",0.2}, name="cl_dark"}
cl_lit  = pile{{"lead white",3},{"Naples yellow",0.9},{"vermilion",0.12},{"rose madder",0.08},{"yellow ochre",0.1}, name="cl_lit"}
fl = brush{kind="filbert", width=6, stiffness=0.4}
-- cloud bars: each is a long thin stroke with a lit lower lip
local bars = {{560,392,980,388,0.5},{620,404,900,401,0.4},{700,372,1000,369,0.35}}
for i,b in ipairs(bars) do
  fl:reload(cl_dark, 0.45)
  fl:stroke({{b[1],b[2]},{(b[1]+b[3])/2, b[2]-2},{b[3],b[4]}}, {pressure={0.15,b[5]}, swell={0.4,1,1.2,0.7,0.3}, ramps={0.3,0.3}, shake=0.6})
end
local lip = brush{kind="round", width=2.5, point=0.6}
for i,b in ipairs(bars) do
  lip:reload(cl_lit, 0.45)
  lip:stroke({{b[1]+30,b[2]+2.5},{(b[1]+b[3])/2, b[2]+0.5},{b[3]-20,b[4]+2.5}}, {pressure={0.2,0.45}, ramps={0.3,0.3}, shake=0.4})
end
blend(rect(550,355,450,60), {angle=0})

--@ chunk 5
cl2 = pile{{"lead white",1.2},{"smalt",0.6},{"raw umber",0.45},{"rose madder",0.1},{"Naples yellow",0.25}, name="cl2"}
cl_lit2 = pile{{"lead white",3},{"Naples yellow",1.2},{"vermilion",0.1},{"yellow ochre",0.15}, name="cl_lit2"}
fl2 = brush{kind="filbert", width=5, stiffness=0.5}
local function bar(x0,x1,y,th,seed)
  -- several overlapping thin horizontal strokes, lifting at ends
  local n = 3
  for i=1,n do
    fl2:reload(cl2, 0.35)
    local xa = x0 + rand(-15,25); local xb = x1 + rand(-25,15)
    local yy = y + (i-2)*th*0.35
    fl2:stroke({{xa,yy+rand(-0.6,0.6)},{(xa+xb)/2+rand(-20,20), yy-0.8},{xb,yy+rand(-0.6,0.6)}}, {pressure={0.12,0.32}, swell={0.3,1,1,0.8,0.2}, ramps={0.35,0.4}, shake=0.5})
  end
  -- lit lower lip, thin, slightly shorter
  local lp = brush{kind="round", width=2, point=0.8}
  lp:reload(cl_lit2, 0.5)
  lp:stroke({{x0+40,y+th*0.6+1},{(x0+x1)/2,y+th*0.6},{x1-40,y+th*0.6+1}}, {pressure={0.25,0.4}, swell={0.2,1,1,0.3}, ramps={0.3,0.3}, shake=0.3})
end
bar(40,420,380,5)
bar(90,330,398,4)
bar(10,250,366,3)

--@ chunk 6
cl3 = pile{{"lead white",1.4},{"smalt",0.6},{"raw umber",0.4},{"rose madder",0.1},{"Naples yellow",0.3}, thinner=0.35, name="cl3"}
function cloud_lens(x0, x1, y, th, seed)
  local pts = {}
  local n = 14
  for i=0,n do
    local t = i/n
    local x = lerp(x0, x1, t)
    local h = th * math.sin(math.pi*t)^0.6 * (0.7 + 0.6*noise{seed=seed, period=60}:at01(x, y))
    pts[#pts+1] = {x, y - h*0.65}
  end
  for i=n,0,-1 do
    local t = i/n
    local x = lerp(x0, x1, t)
    local h = th * math.sin(math.pi*t)^0.8
    pts[#pts+1] = {x, y + h*0.35}
  end
  return poly(pts, true)
end
local c1 = cloud_lens(560, 990, 385, 9, 1) + cloud_lens(640, 900, 402, 6, 2) + cloud_lens(700, 1000, 368, 5, 3)
work(c1, {hand="body", tool="filbert 5", pile=cl3, angle=0, ruler=true, coverage=2, fill=true, clip=c1:grow(1), length={30,90}, seed=5})
blend(c1:grow(5):soften(3), {angle=0})

--@ chunk 7
moon_p = pile{{"lead white",4},{"Naples yellow",1},{"yellow ochre",0.06}, name="moon_p"}
local cx, cy, r = 770, 175, 13
local cres = ellipse(cx, cy, r, r) - ellipse(cx-4.5, cy-3.5, r*0.97, r*0.97)
work(cres:soften(0.6), {hand="detail", pile=moon_p, coverage=3, fill=true, seed=7})
-- star
local st = brush{kind="round", width=3, point=0.5}
st:load(moon_p, 0.6)
st:touch(842, 238, {pressure=0.5})

--@ chunk 8
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
oak_roots = {{252,497},{266,489},{279,475},{290,456},{318,456},{328,474},{343,488},{362,498},{330,500},{290,501}}
local tm = nil
for _, br in ipairs(oak) do
  local r = ribbon(br[1], br[2]); tm = tm and (tm + r) or r
end
tm = tm + poly(oak_roots, true)
oak_mask = tm:roughen(1.0, 5, 3)
t_dark = pile{{"raw umber",1.3},{"bone black",0.8},{"Prussian blue",0.1},{"red earth",0.1}, name="t_dark"}
t_warm = pile{{"raw umber",1.6},{"bone black",0.5},{"red earth",0.2},{"yellow ochre",0.1}, name="t_warm"}
local nz = noise{seed=77, period=40}
work(oak_mask, {hand="detail", piles={{t_dark, function(x,y) return 0.6 + 0.4*nz(x,y) end},{t_warm, function(x,y) return 0.4 - 0.4*nz(x,y) end}}, coverage=2.6, fill=true, angle=-math.pi/2, seed=271})
print("ok")

--@ chunk 9
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
    local t = i/n
    ws[#ws+1] = lerp(w0, w1, t^0.8)
  end
  return pts, ws
end
secs_def = {
  {248,314,-2.4,45,5}, {180,225,-1.2,35,3.5}, {161,278,2.5,30,3}, {136,285,-1.9,30,2.5},
  {216,209,-0.9,30,3}, {132,182,-2.2,28,2.5}, {150,158,-2.7,30,2.5}, {272,213,-2.3,32,3},
  {258,170,-1.1,25,2}, {312,300,-2.6,30,4}, {314,194,-2.2,30,3.5}, {352,178,-0.5,30,2.5},
  {360,263,-0.6,35,4}, {391,193,-2.0,25,2.5}, {361,208,-2.6,22,2}, {350,335,1.0,25,4},
  {441,304,-1.4,40,4.5}, {419,278,-0.4,30,3}, {426,211,-2.2,25,2}, {501,233,-0.3,28,2.5},
  {531,258,-1.3,30,2.5}, {561,253,0.3,25,1.8}, {430,352,1.4,20,2.5}, {270,330,2.8,25,4},
}
secs = {}
local sm = nil
for i, d in ipairs(secs_def) do
  local pts, ws = crooked(d[1], d[2], d[3], d[4], d[5], 0.9)
  secs[i] = {pts, ws}
  local r = ribbon(pts, ws); sm = sm and (sm + r) or r
end
sec_mask = sm:roughen(0.6, 4, 9)
local nz = noise{seed=79, period=40}
work(sec_mask, {hand="detail", piles={{t_dark, function(x,y) return 0.6 + 0.4*nz(x,y) end},{t_warm, function(x,y) return 0.4 - 0.4*nz(x,y) end}}, coverage=2.6, fill=true, seed=301})
