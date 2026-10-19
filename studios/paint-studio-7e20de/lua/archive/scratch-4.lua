-- easel session "scratch": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box every
--@ engine 7
--@ width 4800

--@ chunk 1
canvas{aspect=1.5, ground={{apply="knife", pile={{"lead white", 8}, {"yellow ochre", 0.3}}, texture=0.25, um=110}, {apply="brush", pile={{"lead white", 3}, {"red earth", 1.2}, {"raw umber", 1.0}, {"yellow ochre", 0.6}}, um=22}}, linen={16, 14}, seed=4417, size=900}

--@ chunk 2
s2 = pile{{"Prussian blue",0.6},{"ultramarine blue",0.4},{"bone black",0.35},{"lead white",1.2},{"raw umber",0.15}, name="s2"}
work(rect(0,0,1000,667), {hand="broad", pile=s2, coverage=2.2, fill=true, angle=0.03})
wait(2*24*60)
print(drying(300,300))

--@ chunk 3
hot = pile{{"lead white",3},{"Naples yellow",1},{"cadmium yellow",0.5}, name="hot"}
warm = pile{{"lead white",2},{"yellow ochre",0.7},{"orange vermilion",0.25},{"Naples yellow",0.4}, name="warm"}
mgray = mix{{warm,0.5},{s2,0.5}, name="mgray"}
local cx, cy = 300, 300
local gx, gy = cx+35, cy-8
local function d(x,y) return math.sqrt(((x-gx)/1.25)^2+(y-gy)^2) end
local R = 105
local m = ellipse(gx, gy, R*1.25, R):soften(10)
work(m, {hand="body", tool="filbert 12", piles={
   {hot, function(x,y) return clamp(1-d(x,y)/35,0,1)*3 end},
   {warm, function(x,y) return clamp(1-math.abs(d(x,y)-38)/25,0,1)*1.5 end},
   {mgray, function(x,y) return clamp(1-math.abs(d(x,y)-68)/25,0,1) end},
   {s2, function(x,y) return clamp((d(x,y)-75)/20,0,1)*2 end}},
   coverage=2.2, fill=true, length={15,40}, angle=function(x,y) return math.atan(y-gy, x-gx) + 1.57 end, curve={0.3,0.1}, pressure={0.4,0.7}})

--@ chunk 4
local cx, cy = 300, 300
flame_w = pile{{"lead white",3},{"lemon chrome",0.5}, name="flame_w"}
flame_y = pile{{"lead white",1},{"cadmium yellow",1},{"lemon chrome",0.3}, name="flame_y"}
flame_o = pile{{"cadmium yellow",1},{"orange vermilion",0.6},{"lead white",0.2}, name="flame_o"}
local bo = brush{kind="round", width=8, point=0.7, lay=2}
bo:load(flame_o, 0.8)
local tongues = {{-0.28,70,-8},{-0.1,95,6},{0.08,85,-5},{0.25,62,7},{-0.55,38,4},{0.6,34,-4}}
for i, t in ipairs(tongues) do
  local a, L, bend = t[1], t[2], t[3]
  local ca, sa = math.cos(a), math.sin(a)
  local function P(f, off) return {cx + ca*L*f - sa*off, cy + sa*L*f + ca*off} end
  local p1, p2, p3 = P(0.35, bend*0.5), P(0.7, bend), P(1.0, bend*0.4)
  bo:gesture({{cx+2, cy, 0.9},{p1[1],p1[2],0.85},{p2[1],p2[2],0.45},{p3[1],p3[2],0.0}}, {wobble=2})
  if i % 2 == 0 then bo:load(flame_o, 0.7) end
end
local by = brush{kind="round", width=8, point=0.6, lay=3}
by:load(flame_y, 0.9)
for i, t in ipairs({{-0.2,55,-4},{0.0,68,3},{0.15,58,-3},{-0.45,26,2},{0.45,26,-2}}) do
  local a, L, bend = t[1], t[2], t[3]
  local ca, sa = math.cos(a), math.sin(a)
  by:gesture({{cx+1, cy, 1.0},{cx+ca*L*0.5-sa*bend, cy+sa*L*0.5+ca*bend, 0.7},{cx+ca*L, cy+sa*L, 0.0}}, {wobble=1.5})
end
local bw = brush{kind="filbert", width=9, lay=5, stiffness=0.6}
bw:load(flame_w, 1.0)
bw:gesture({{cx-1, cy, 1.0},{cx+15, cy-1, 0.9},{cx+32, cy, 0.4},{cx+42, cy, 0.0}})
bw:gesture({{cx, cy+2, 0.9},{cx+18, cy+3, 0.6},{cx+30, cy+2, 0.0}})

--@ chunk 5
local cx, cy = 650, 300
fire_o = pile{{"cadmium yellow",0.6},{"orange vermilion",1},{"lead white",0.4}, name="fire_o"}
fire_r = pile{{"orange vermilion",0.6},{"red earth",0.6},{"lead white",0.3},{"bone black",0.08}, name="fire_r"}
smoke_rb = pile{{"red earth",0.5},{"raw umber",0.4},{"lead white",0.8},{"ultramarine blue",0.3},{"bone black",0.1}, name="smoke_rb"}
local gx, gy = cx+30, cy-4
local function d(x,y) return math.sqrt(((x-gx)/1.3)^2+(y-gy)^2) end
local m = ellipse(gx, gy, 120, 92):soften(10)
work(m, {hand="body", tool="filbert 10", piles={
   {fire_o, function(x,y) return clamp(1-d(x,y)/30,0,1)*3 end},
   {fire_r, function(x,y) return clamp(1-math.abs(d(x,y)-32)/20,0,1)*1.5 end},
   {smoke_rb, function(x,y) return clamp(1-math.abs(d(x,y)-58)/22,0,1) end},
   {s2, function(x,y) return clamp((d(x,y)-66)/18,0,1)*2 end}},
   coverage=2.2, fill=true, length={15,35}, angle=function(x,y) return math.atan(y-gy, x-gx) + 1.57 end, curve={0.3,0.1}, pressure={0.4,0.7}})
FL = {{-6,-6},{4,-16},{10,-30},{18,-14},{30,-24},{40,-36},{44,-18},{62,-22},{90,-14},{70,-6},{102,0},{72,6},{88,18},{60,14},{48,28},{52,40},{36,20},{24,30},{14,38},{12,18},{2,14},{-6,6}}
local pts = {}
for i, p in ipairs(FL) do pts[i] = {cx+p[1], cy+p[2]} end
local fm = poly(pts, false)
local function df(x,y) return math.sqrt(((x-cx-12)/1.6)^2+(y-cy)^2) end
work(fm, {hand="detail", tool={kind="round", width=6, point=0.6, lay=3}, piles={
   {flame_w, function(x,y) return clamp(1-df(x,y)/14,0,1)*3 end},
   {flame_y, function(x,y) return clamp(1-math.abs(df(x,y)-16)/10,0,1)*1.5 end},
   {flame_o, function(x,y) return clamp((df(x,y)-18)/10,0,1)*1.5 end}},
   coverage=3, fill=true, length={8,20}, angle=function(x,y) return math.atan(y-cy, x-cx) end, clip=true})

--@ chunk 6
local cx, cy = 300, 530
local gx, gy = cx+30, cy-4
local function d(x,y) return math.sqrt(((x-gx)/1.3)^2+(y-gy)^2) end
local m = ellipse(gx, gy, 120, 92):soften(10)
work(m, {hand="body", tool="filbert 10", piles={
   {fire_o, function(x,y) return clamp(1-d(x,y)/30,0,1)*3 end},
   {fire_r, function(x,y) return clamp(1-math.abs(d(x,y)-32)/20,0,1)*1.5 end},
   {smoke_rb, function(x,y) return clamp(1-math.abs(d(x,y)-58)/22,0,1) end},
   {s2, function(x,y) return clamp((d(x,y)-66)/18,0,1)*2 end}},
   coverage=2.2, fill=true, length={15,35}, angle=function(x,y) return math.atan(y-gy, x-gx) + 1.57 end, curve={0.3,0.1}, pressure={0.4,0.7}})
print(wait(24*60))
print(drying(330,526), drying(300,530), drying(380,500))

--@ chunk 7
print(wait(2*24*60))
print(drying(330,526), drying(300,530), drying(380,500), drying(400,560))

--@ chunk 8
print(wait(3*24*60))
print(drying(330,526), drying(300,530), drying(380,500), drying(400,560))

--@ chunk 9
local cx, cy = 300, 530
local function tongue(b, a, L, bend, p0)
  local ca, sa = math.cos(a), math.sin(a)
  local function P(f, off) return cx + ca*L*f - sa*off, cy + sa*L*f + ca*off end
  local x1,y1 = P(0.3, bend*0.4); local x2,y2 = P(0.65, bend); local x3,y3 = P(1.0, bend*0.2)
  b:gesture({{cx+1, cy, p0},{x1,y1,p0*0.95},{x2,y2,p0*0.5},{x3,y3,0.0}}, {wobble=2})
end
local bo = brush{kind="round", width=11, point=0.75, lay=3}
bo:load(fire_o, 0.9)
for i, t in ipairs({{-0.3,72,-9},{-0.1,98,7},{0.07,88,-6},{0.26,66,8},{-0.6,40,5},{0.62,36,-5},{-1.2,22,3},{1.25,20,-3}}) do
  tongue(bo, t[1], t[2], t[3], 0.9)
  if i % 2 == 0 then bo:load(fire_o, 0.8) end
end
local by = brush{kind="round", width=10, point=0.7, lay=4}
by:load(flame_y, 1.0)
for i, t in ipairs({{-0.22,58,-5},{-0.05,74,4},{0.12,62,-4},{-0.48,30,3},{0.45,30,-3}}) do
  tongue(by, t[1], t[2], t[3], 0.95)
  if i % 2 == 0 then by:load(flame_y, 0.9) end
end
local bw = brush{kind="filbert", width=10, lay=7, stiffness=0.6}
bw:load(flame_w, 1.0)
bw:gesture({{cx-2, cy, 1.0},{cx+14, cy-1, 0.95},{cx+30, cy, 0.5},{cx+44, cy, 0.0}})
bw:load(flame_w, 1.0)
bw:gesture({{cx, cy+3, 0.9},{cx+16, cy+4, 0.7},{cx+28, cy+3, 0.0}})
bw:gesture({{cx, cy-3, 0.9},{cx+16, cy-5, 0.6},{cx+26, cy-6, 0.0}})

--@ chunk 10
print(wait(4*24*60))
print(drying(680,296), drying(650,300), drying(700,340))
local cx, cy = 652, 300
-- (a) flame as an organic mask from outline, soft char
local o = outline{{cx-4,cy-4},{cx+20,cy-18},{cx+38,cy-30,"c"},{cx+44,cy-14},{cx+78,cy-20,"c"},{cx+62,cy-4},{cx+104,cy+2,"c"},{cx+64,cy+8},{cx+80,cy+22,"c"},{cx+44,cy+14},{cx+34,cy+32,"c"},{cx+18,cy+14},{cx-4,cy+5}, closed=true, char="soft", seed=5, amount=0.6, edge=2}
local fm = o:mask()
local function df(x,y) return math.sqrt(((x-cx-6)/1.8)^2+(y-cy)^2) end
work(fm, {hand="body", tool={kind="filbert", width=6, lay=3}, piles={
   {flame_w, function(x,y) return clamp(1-df(x,y)/12,0,1)*3 end},
   {flame_y, function(x,y) return clamp(1-math.abs(df(x,y)-15)/9,0,1)*1.5 end},
   {flame_o, function(x,y) return clamp((df(x,y)-16)/9,0,1)*1.5 end}},
   coverage=3, fill=true, length={8,22}, angle=function(x,y) return math.atan(y-cy, x-cx) end, clip=true})
