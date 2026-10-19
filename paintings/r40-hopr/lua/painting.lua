-- easel session "painting": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box hopper
--@ engine 5

--@ chunk 1
canvas{size=900, aspect=1.6, linen={18,16}, seed=4127,
  ground={{pile={{"lead white",10},{"yellow ochre",0.25}}, um=90, apply="knife", texture=0.3}}}
print(W,H)
print(table.concat(tubes(), ", "))

--@ chunk 2
VPX, VPY = 2200, 330
function fy(x, h) return VPY + (h - VPY) * (VPX - x) / VPX end
-- facade quad helper: x0..x1, heights h0..h1 (at x=0 scale)
function fquad(x0, x1, h0, h1)
  return poly({{x0, fy(x0,h0)}, {x1, fy(x1,h0)}, {x1, fy(x1,h1)}, {x0, fy(x0,h1)}})
end
pen = pencil("2B")
local function hl(x0,x1,h) pen:rule({x0, fy(x0,h)}, {x1, fy(x1,h)}, {pressure=0.35}) end
local function vl(x,h0,h1) pen:rule({x, fy(x,h0)}, {x, fy(x,h1)}, {pressure=0.35}) end
CX = 720
hl(0, CX, 40); hl(0, CX, 72); hl(0, CX, 250); hl(0,CX,288)
hl(0, CX, 470)
vl(CX, 40, 470)
-- shop window
hl(110,600,298); hl(110,600,445); vl(110,298,445); vl(600,298,445); vl(270,298,445); vl(440,298,445)
-- door
vl(28,298,470); vl(92,298,470); hl(28,92,298)
-- upper windows
for _,w in ipairs{{55,150},{225,315},{395,478},{555,628}} do
  hl(w[1],w[2],118); hl(w[1],w[2],228); vl(w[1],118,228); vl(w[2],118,228)
end
-- curb line
pen:rule({0,545},{CX+20, fy(CX+20,545)}, {pressure=0.3})
-- far building across cross street
pen:rule({745,130},{1000,118},{pressure=0.3})
pen:rule({745,130},{745,395},{pressure=0.3})
pen:rule({745,395},{1000,390},{pressure=0.3})
print(fy(CX,40), fy(CX,470), fy(CX,545))

--@ chunk 3
CX = 720; FX = 790
local function L(x0,x1,h) return {x0, fy(x0,h)}, {x1, fy(x1,h)} end
facade = poly({{0,fy(0,40)},{CX,fy(CX,40)},{CX,fy(CX,470)},{0,fy(0,470)}})
shopwin = fquad(110,600,298,445)
door = fquad(28,92,298,470)
fascia = fquad(0,CX,250,288)
uw = {fquad(55,150,118,228), fquad(225,315,118,228), fquad(395,478,118,228), fquad(555,628,118,228)}
farb = poly({{FX,fy(FX,-60)},{1000,fy(1000,-60)},{1000,fy(1000,470)},{FX,fy(FX,470)}})
slot = poly({{CX,190},{FX,186},{FX,fy(FX,470)},{CX,fy(CX,470)}})
walk = poly({{0,fy(0,470)},{1000,fy(1000,470)},{1000,fy(1000,545)},{0,fy(0,545)}})
street = below(function(x) return fy(x,545) end)
sky = everywhere() - facade - farb - slot - walk - street
P = {}
P.sky = pile{{"ultramarine blue",2},{"viridian",1.5},{"bone black",1.5},{"lead white",1.2}, turps=0.5, name="sky"}
P.brick = pile{{"red earth",2},{"bone black",2},{"burnt sienna",1},{"ultramarine blue",0.5}, turps=0.5, name="brick"}
P.fascia = pile{{"viridian",1},{"bone black",2},{"burnt sienna",0.5},{"lead white",0.4}, turps=0.5, name="fascia"}
P.shop = pile{{"lead white",10},{"pale cadmium",1.2},{"viridian",0.2}, turps=0.4, name="shop"}
P.walk = pile{{"lead white",3},{"yellow ochre",1},{"bone black",0.3}, turps=0.5, name="walk"}
P.street = pile{{"bone black",2},{"ultramarine blue",1},{"burnt sienna",0.6},{"yellow ochre",0.5},{"lead white",0.6}, turps=0.5, name="street"}
P.far = pile{{"bone black",2},{"ultramarine blue",1.5},{"viridian",0.5},{"lead white",0.5}, turps=0.5, name="far"}
P.warm = pile{{"lead white",4},{"deep cadmium",1},{"yellow ochre",1}, turps=0.4, name="warm"}
P.win = pile{{"bone black",2},{"ultramarine blue",1},{"viridian",0.4},{"lead white",0.3}, turps=0.5, name="win"}
local up = facade - shopwin - door - fascia
for i=1,4 do up = up - uw[i] end
work(sky, {hand="broad", pile=P.sky, coverage=2, fill=true, angle=0.05})
work(up, {hand="body", pile=P.brick, coverage=2, fill=true, edge="firm"})
work(fascia, {hand="body", pile=P.fascia, coverage=2, fill=true, angle=fy(1,0)-fy(0,0), clip=true})
work(farb, {hand="body", pile=P.far, coverage=2, fill=true})
work(slot, {hand="body", pile=P.far, coverage=2, fill=true, clip=true})
work(street, {hand="broad", pile=P.street, coverage=2, fill=true, angle=-0.1})
work(walk, {hand="body", pile=P.walk, coverage=2, fill=true, angle=-0.07, clip=true})

--@ chunk 4
work(shopwin, {hand="body", pile=P.shop, coverage=2, fill=true, clip=true})
work(door, {hand="body", pile=P.win, coverage=2, fill=true, clip=true, angle=math.pi/2})
for i=1,4 do
  work(uw[i], {hand="body", pile=(i==3) and P.warm or P.win, coverage=2, fill=true, clip=true})
end

--@ chunk 5
print(wait(20*60))
for _,p in ipairs{{300,60},{300,150},{300,370},{300,500},{300,590},{900,300}} do print(p[1],p[2],drying(p[1],p[2])) end

--@ chunk 6
print(wait(2*24*60))
for _,p in ipairs{{300,60},{300,150},{300,370},{300,500},{300,590},{900,300}} do print(p[1],p[2],drying(p[1],p[2])) end

--@ chunk 7
print(wait(2*24*60))
for _,p in ipairs{{300,60},{300,150},{300,370},{300,500},{300,590},{900,300},{440,200}} do print(p[1],p[2],drying(p[1],p[2])) end

--@ chunk 8
Q = {}
Q.skyhi = pile{{"ultramarine blue",2},{"viridian",1.2},{"bone black",2},{"lead white",0.7}, turps=0.3, name="skyhi"}
Q.skylo = pile{{"ultramarine blue",1.5},{"viridian",1.3},{"bone black",1.2},{"lead white",1.5},{"yellow ochre",0.2}, turps=0.3, name="skylo"}
Q.brick = pile{{"red earth",1.5},{"bone black",2.5},{"burnt sienna",0.8},{"ultramarine blue",0.5}, turps=0.3, name="brick2"}
Q.far = pile{{"bone black",2.5},{"ultramarine blue",1},{"viridian",0.6},{"red earth",0.3},{"lead white",0.3}, turps=0.3, name="far2"}
local function wy(y) return clamp((y-20)/180,0,1) end
work(sky, {hand="broad", piles={{Q.skyhi, function(x,y) return 1-wy(y) end},{Q.skylo, function(x,y) return wy(y) end}}, coverage=2.5, fill=true, clip=true, angle=0.02})
local up = facade - shopwin - door - fascia
for i=1,4 do up = up - uw[i] end
upmask = up
work(up, {hand="body", pile=Q.brick, coverage=2.5, fill=true, clip=true, angle=function(x,y) return -0.13 + 0.13*0 end})
work(farb, {hand="body", pile=Q.far, coverage=2.5, fill=true, clip=true, angle=-0.1})

--@ chunk 9
V2X, V2Y = 24, 330
function B(x) return x, fy(x,470) end
function sCurb(x)
  local bx, by = B(x)
  return (215*(2200-V2X)/2200) / ((by-330) + 215*(bx-V2X)/2200)
end
function gpt(x, f) -- point on ground ray through facade base x, f=0 at wall, 1 at curb, >1 past
  local bx, by = B(x)
  local s = 1 + f*(sCurb(x)-1)
  return V2X + s*(bx-V2X), V2Y + s*(by-V2Y)
end
for _,x in ipairs{110,270,440,600} do local a,b = gpt(x,1); print(x, a, b) end
Q.walkd = pile{{"bone black",2},{"yellow ochre",0.6},{"burnt sienna",0.5},{"ultramarine blue",0.3},{"lead white",0.5}, turps=0.3, name="walkd"}
Q.walkl = pile{{"lead white",3},{"yellow ochre",0.6},{"pale cadmium",0.25},{"bone black",0.12},{"viridian",0.05}, turps=0.25, name="walkl"}
Q.street = pile{{"bone black",2.5},{"ultramarine blue",1},{"burnt sienna",0.6},{"viridian",0.2},{"lead white",0.3}, turps=0.3, name="street2"}

--@ chunk 10
for _,x in ipairs{720,730,780,790} do local a,b = gpt(x,1); print(x, a, b, gpt(x,1.4)) end

--@ chunk 11
sidewall = poly({{CX,103},{FX,fy(FX,-60)},{FX,fy(FX,470)},{CX,412}})
slotsky = poly({{CX,60},{FX,60},{FX,fy(FX,-60)},{CX,103}})
Q.side = pile{{"bone black",2.5},{"ultramarine blue",0.6},{"burnt sienna",0.6},{"viridian",0.3},{"lead white",0.2}, turps=0.3, name="side"}
work(slotsky, {hand="body", pile=Q.skylo, coverage=2.5, fill=true, clip=true})
work(sidewall, {hand="body", pile=Q.side, coverage=2.5, fill=true, clip=true, angle=math.pi/2})
-- ground in slot below side wall base
slotground = poly({{CX,412},{FX,fy(FX,470)},{FX,fy(FX,470)+3},{CX,424}})
-- crosswalk wedge on main sidewalk
local a1,b1 = gpt(730,1.6); local a2,b2 = gpt(780,1.6)
wedge = poly({{730,fy(730,470)},{780,fy(780,470)},{a2,b2},{a1,b1}}) * walk
walkonly = walk - wedge
-- spill panels
local function panel(x0,x1,f0,f1)
  local p = {}
  local ax,ay = gpt(x0,f0); p[#p+1]={ax,ay}
  ax,ay = gpt(x1,f0); p[#p+1]={ax,ay}
  ax,ay = gpt(x1,f1); p[#p+1]={ax,ay}
  ax,ay = gpt(x0,f1); p[#p+1]={ax,ay}
  return poly(p)
end
spill = (panel(112,266,0.14,1.08) + panel(274,436,0.14,1.08) + panel(444,598,0.14,1.08)) * walk
spillfade = spill:soften(4)
work(walkonly, {hand="body", pile=Q.walkd, coverage=2.5, fill=true, clip=true, angle=-0.06})
work(wedge + slotground, {hand="body", pile=Q.street, coverage=2.5, fill=true, clip=true})

--@ chunk 12
work(street, {hand="broad", pile=Q.street, coverage=2.5, fill=true, clip=true, angle=-0.08})

--@ chunk 13
local function wy(y) return clamp((y-20)/180,0,1) end
local patch = (rect(700,40,110,80) * sky) + slotsky
patch = patch - sidewall - facade - farb
work(patch, {hand="body", piles={{Q.skyhi, function(x,y) return 1-wy(y) end},{Q.skylo, function(x,y) return wy(y) end}}, coverage=2.5, fill=true, clip=true, angle=0.02})
blend(rect(690,30,130,90) - sidewall - facade - farb, {angle=0})

--@ chunk 14
local function st(x) return fy(FX,-60) + (x - FX) * (330 - fy(FX,-60)) / (V2X - FX) end
local xi
for x = 720, 400, -0.5 do
  if st(x) >= fy(x,40) then xi = x break end
end
print(xi, st(720), fy(720,40))
tri = poly({{xi, fy(xi,40)}, {CX, st(CX)}, {CX+3, st(CX+3)}, {CX+3, fy(CX,40)+2}, {CX, fy(CX,40)}})
sidewall2 = tri + sidewall
work(tri, {hand="detail", pile=Q.side, coverage=3, fill=true, clip=true})
work(sidewall2, {hand="body", pile=Q.side, coverage=2, fill=true, clip=true, angle=math.pi/2})

--@ chunk 15
print(wait(3*24*60))
for _,p in ipairs{{300,60},{300,150},{300,480},{300,590},{900,300},{750,300}} do print(p[1],p[2],drying(p[1],p[2])) end

--@ chunk 16
print(wait(24*60))
for _,p in ipairs{{300,480},{600,470},{900,300},{750,300}} do print(p[1],p[2],drying(p[1],p[2])) end

--@ chunk 17
R = {}
R.wall = pile{{"lead white",10},{"pale cadmium",0.8},{"viridian",0.25},{"yellow ochre",0.2}, turps=0.2, name="wall"}
R.wallR = pile{{"lead white",8},{"cadmium yellow",0.6},{"yellow ochre",0.7},{"viridian",0.1}, turps=0.2, name="wallR"}
-- right side wall inside: from window right edge (600) back to corner at x=525, edges toward VP2
local function toV2(x, y, nx) -- point on line from (x,y) toward VP2 at new x nx
  return nx, y + (nx - x) * (V2Y - y) / (V2X - x)
end
BKX = 525
local t1x, t1y = 600, fy(600, 250)   -- above window top
local b1x, b1y = 600, fy(600, 480)
local _, t2y = toV2(t1x, t1y, BKX)
local _, b2y = toV2(b1x, b1y, BKX)
rwall = poly({{BKX, t2y}, {600, t1y}, {600, b1y}, {BKX, b2y}}) * shopwin
bwall = shopwin - rwall
work(bwall, {hand="body", pile=R.wall, coverage=2, fill=true, clip=true, angle=0})
work(rwall, {hand="body", pile=R.wallR, coverage=2, fill=true, clip=true, angle=math.pi/2})
print(t2y, b2y)

--@ chunk 18
print(wait(2*24*60))
for _,p in ipairs{{300,480},{600,470},{900,300},{750,300},{300,370},{560,370}} do print(p[1],p[2],drying(p[1],p[2])) end

--@ chunk 19
R.cfront = pile{{"yellow ochre",2},{"burnt sienna",1.2},{"lead white",1.2},{"bone black",0.3}, turps=0.2, name="cfront"}
R.ctop = pile{{"lead white",6},{"yellow ochre",0.8},{"burnt sienna",0.15}, turps=0.15, name="ctop"}
R.door = pile{{"burnt sienna",1.5},{"bone black",1},{"yellow ochre",0.8},{"lead white",0.6}, turps=0.2, name="backdoor"}
local function cy(x, h) return 330 + (h - 330) * (VPX - x) / VPX * 0.97 end
CT0, CT1 = 130, 455
ctopm = poly({{CT0-30, cy(CT0-30,393)}, {CT1, cy(CT1,393)}, {CT1, cy(CT1,399)}, {CT0-30, cy(CT0-30,399)}}) * shopwin
cfrontm = poly({{CT0-30, cy(CT0-30,399)}, {CT1, cy(CT1,399)}, {CT1, 460}, {CT0-30, 460}}) * shopwin
backdoorm = poly({{468, fy(468,322)}, {505, fy(505,322)}, {505, 430}, {468, 430}}) * bwall
work(backdoorm, {hand="detail", pile=R.door, coverage=3, fill=true, clip=true, angle=math.pi/2})
work(cfrontm, {hand="detail", pile=R.cfront, coverage=3, fill=true, clip=true, angle=math.pi/2})
work(ctopm, {hand="detail", pile=R.ctop, coverage=3, fill=true, clip=true, angle=-0.03})

--@ chunk 20
R.cfront2 = pile{{"yellow ochre",1.5},{"burnt sienna",1.3},{"bone black",0.5},{"lead white",0.7}, turps=0.15, name="cfront2"}
R.door2 = pile{{"burnt sienna",1.2},{"bone black",1.3},{"yellow ochre",0.6},{"lead white",0.4}, turps=0.15, name="backdoor2"}
work(cfrontm, {hand="detail", tool={kind="flat", width=5}, pile=R.cfront2, coverage=4, fill=true, clip=true, angle=math.pi/2, length={8,20}})
work(backdoorm, {hand="detail", tool={kind="flat", width=5}, pile=R.door2, coverage=4, fill=true, clip=true, angle=math.pi/2, length={8,20}})
work(ctopm, {hand="detail", pile=R.ctop, coverage=4, fill=true, clip=true, angle=-0.03})

--@ chunk 21
R.bag = pile{{"lead white",6},{"bone black",0.12},{"ultramarine blue",0.06},{"yellow ochre",0.1}, turps=0.15, name="bag"}
R.bagsh = pile{{"lead white",4},{"bone black",0.4},{"ultramarine blue",0.15},{"yellow ochre",0.3}, turps=0.15, name="bagsh"}
-- rack mass: irregular lower edge
rackm = poly({{527,323},{598,321},{598,393},{590,395},{582,392},{574,394},{566,391},{558,393},{549,390},{540,392},{532,389},{527,390}}) * shopwin
work(rackm, {hand="detail", pile=R.bag, coverage=4, fill=true, clip=true, angle=math.pi/2, length={10,30}})
-- rail
local b = brush{kind="round", width=1.6, point=0.5}
b:load(R.door2, 0.6)
b:stroke({{527,322.4},{599,321.2}}, {pressure=0.7})

--@ chunk 22
local b = brush{kind="round", width=2.2, point=0.6}
local xs = {591, 583, 576, 570, 564, 559, 554, 549, 545, 541, 537, 533, 530}
for i,x in ipairs(xs) do
  b:reload(R.bagsh, 0.5)
  local w = 1 + (#xs - i) * 0.04
  b:stroke({{x, 325}, {x - 0.4, 360}, {x - 0.8, 390}}, {pressure={0.55*w, 0.35}, ramps={0.1,0.3}})
end
R.hem1 = pile{{"ultramarine blue",1},{"bone black",1},{"lead white",0.3}, turps=0.15}
R.hem2 = pile{{"red earth",1},{"bone black",0.8},{"burnt sienna",0.5},{"lead white",0.3}, turps=0.15}
R.hem3 = pile{{"yellow ochre",1},{"burnt sienna",0.6},{"bone black",0.5},{"lead white",0.5}, turps=0.15}
local hems = {{594,R.hem1,7},{579,R.hem2,5},{566,R.hem3,4},{552,R.hem1,4},{539,R.hem2,3}}
for _,h in ipairs(hems) do
  local m = poly({{h[1]-h[3], 389},{h[1]+h[3],389},{h[1]+h[3]-1, 401},{h[1]-h[3]+1,400}}) * shopwin
  work(m, {hand="detail", pile=h[2], coverage=4, fill=true, clip=true, angle=math.pi/2})
end

--@ chunk 23
-- cover hems with right-wall color
local hemzone = rect(527, 388, 75, 16) * shopwin - rackm:shrink(1)
work(hemzone, {hand="detail", pile=R.wallR, coverage=5, fill=true, clip=true, angle=0})
-- bags back to front: x (center), half width, bottom y
local bags = {{531,4,384},{536,4.5,396},{541,4.5,388},{547,5,399},{553,5.5,390},{560,6,402},{568,6.5,393},{577,7,404},{588,8,397}}
for i,bg in ipairs(bags) do
  local x, hw, by = bg[1], bg[2], bg[3]
  local m = poly({{x-1,323},{x+1,323},{x+hw,329},{x+hw+0.5,by-2},{x+hw-1,by},{x-hw+1,by+0.5},{x-hw-0.5,by-2},{x-hw,329}}, true) * shopwin
  work(m, {hand="detail", pile=R.bag, coverage=4, fill=true, clip=true, angle=math.pi/2})
  -- shadow side (left) of each bag
  local sh = poly({{x-hw,329},{x-hw+2.2,330},{x-hw+2.5,by-1},{x-hw-0.3,by-1}}) * m
  work(sh, {hand="detail", pile=R.bagsh, coverage=3, fill=true, clip=true, angle=math.pi/2})
end

--@ chunk 24
R.dress = pile{{"viridian",1},{"bone black",1},{"ultramarine blue",0.4},{"lead white",0.6}, turps=0.1, name="dress"}
R.dressl = pile{{"viridian",1},{"bone black",0.6},{"ultramarine blue",0.3},{"lead white",1.5}, turps=0.1, name="dressl"}
R.skin = pile{{"lead white",3},{"red earth",0.45},{"yellow ochre",0.5},{"cadmium yellow",0.1}, turps=0.1, name="skin"}
R.skinsh = pile{{"lead white",1.5},{"red earth",0.6},{"yellow ochre",0.5},{"bone black",0.15}, turps=0.1, name="skinsh"}
R.hair = pile{{"burnt sienna",2},{"red earth",0.6},{"bone black",0.4},{"lead white",0.2}, turps=0.1, name="hair"}
local ctop = function(x) return 330 + (393 - 330) * (VPX - x) / VPX * 0.97 end
print(ctop(300), ctop(340))
-- torso: shoulders ~ y 362, waist hidden behind counter top
torso = poly({{307,364},{314,360.5},{326,360.5},{334,364},{336,372},{337,ctop(337)},{303,ctop(303)},{305,372}}, true)
work(torso, {hand="detail", pile=R.dress, coverage=5, fill=true, clip=true, angle=math.pi/2})

--@ chunk 25
neck = poly({{316.5,355},{321,355},{321.5,361.5},{316,361.5}})
work(neck, {hand="detail", pile=R.skinsh, coverage=5, fill=true, clip=true, angle=math.pi/2})
head = ellipse(316, 351, 5.2, 6.6)
work(head, {hand="detail", pile=R.skin, coverage=5, fill=true, clip=true})
-- hair cap on top and back (right), bun at nape
hairm = (ellipse(318.5, 348.5, 6.2, 5.6) - ellipse(312.5, 353.5, 5, 5.2)) + ellipse(323.5, 352, 2.8, 2.6)
work(hairm, {hand="detail", pile=R.hair, coverage=5, fill=true, clip=true})
-- forearms on the counter
armL = ribbon({{306,371},{303,377},{299,381}}, {4.2,3.8,3.4})
armR = ribbon({{333,371},{326,377},{318,381}}, {4.2,3.8,3.4})
work(armL + armR, {hand="detail", pile=R.skin, coverage=5, fill=true, clip=true})
-- sleeves over the elbows
sleeves = ellipse(306.5, 369, 3.6, 3.5) + ellipse(332.5, 369, 3.6, 3.5)
work(sleeves, {hand="detail", pile=R.dress, coverage=5, fill=true, clip=true})

--@ chunk 26
-- restate torso with squarer shoulders, covering the drooping arms
torso2 = poly({{304,365},{309,361.5},{326,361},{334,363.5},{337,368},{338,ctopf and 0 or 381.5},{302,382.5},{302.5,370}})
work(torso2, {hand="detail", pile=R.dress, coverage=6, fill=true, clip=true, angle=math.pi/2})
-- forearms lying on the counter, toward the left
armL2 = ribbon({{305,378.5},{298,380.5},{293,381.5}}, {4,3.6,3.2})
armR2 = ribbon({{331,378},{322,380},{312,381.3}}, {4,3.6,3.2})
work(armL2 + armR2, {hand="detail", pile=R.skin, coverage=6, fill=true, clip=true})
-- light on shoulder tops
shtop = poly({{305,365},{309,361.8},{326,361.2},{333.5,363.6},{332,365},{324,363.2},{310,363.6}})
work(shtop, {hand="detail", pile=R.dressl, coverage=4, fill=true, clip=true, angle=0})

--@ chunk 27
Q.walkm = mix{{Q.walkl, 0.5}, {Q.walkd, 0.5}, name="walkm"}
local function tf(x,y) local b0, b1 = fy(x,470), fy(x,545); return clamp((y-b0)/(b1-b0),0,1) end
local function ang(x,y) return math.atan(y-V2Y, x-V2X) end
local function panel(x0,x1,f0,f1)
  local p = {}
  local ax,ay = gpt(x0,f0); p[#p+1]={ax,ay}
  ax,ay = gpt(x1,f0); p[#p+1]={ax,ay}
  ax,ay = gpt(x1,f1); p[#p+1]={ax,ay}
  ax,ay = gpt(x0,f1); p[#p+1]={ax,ay}
  return poly(p)
end
spillP = {panel(112,267,0.13,1.0), panel(273,437,0.13,1.0), panel(443,598,0.13,1.0)}
spill = (spillP[1] + spillP[2] + spillP[3]) * walkonly
work(spill, {hand="body", tool="filbert 5", piles={{Q.walkl, function(x,y) return 1 - tf(x,y) end},{Q.walkm, function(x,y) return tf(x,y)*0.9 end}},
  coverage=3, fill=true, clip=true, angle=ang, length={15,40}})

--@ chunk 28
local function tf(x,y) local b0, b1 = fy(x,470), fy(x,545); return clamp((y-b0)/(b1-b0),0,1) end
r = rag()
local m1 = mask(function(x,y) return (tf(x,y) > 0.45 and y > fy(x,470)) and 1 or 0 end) * spill:grow(6)
local m2 = mask(function(x,y) return (tf(x,y) > 0.75 and y > fy(x,470)) and 1 or 0 end) * spill:grow(6)
r:wipe(m1, {pressure=0.35, angle=-0.06, refold=0.4})
r:refold()
r:wipe(m2, {pressure=0.5, angle=-0.06, refold=0.4})

--@ chunk 29
r = rag{width=14}
r:dip(0.6)
local pts = {}
for x = 140, 820, 20 do pts[#pts+1] = {x, fy(x,545) + 6} end
r:wipe(pts, {pressure=0.6})
r:refold(); r:dip(0.5)
r:wipe(pts, {pressure=0.6})

--@ chunk 30
print(wait(24*60))
for _,p in ipairs{{300,370},{200,480},{560,370},{320,370},{300,330}} do print(p[1],p[2],drying(p[1],p[2])) end

--@ chunk 31
FONT = {
 C={{{0.95,0.82},{0.75,1},{0.3,1},{0.05,0.78},{0.05,0.22},{0.3,0},{0.75,0},{0.95,0.18}}},
 L={{{0.12,1},{0.12,0},{0.9,0}}},
 E={{{0.9,1},{0.12,1},{0.12,0},{0.9,0}},{{0.12,0.52},{0.72,0.52}}},
 A={{{0.02,0},{0.5,1},{0.98,0}},{{0.24,0.38},{0.76,0.38}}},
 N={{{0.1,0},{0.1,1},{0.9,0},{0.9,1}}},
 R={{{0.12,0},{0.12,1},{0.65,1},{0.9,0.86},{0.9,0.64},{0.65,0.5},{0.12,0.5}},{{0.52,0.5},{0.92,0}}},
 S={{{0.9,0.84},{0.7,1},{0.3,1},{0.1,0.84},{0.1,0.66},{0.3,0.53},{0.7,0.47},{0.9,0.34},{0.9,0.16},{0.7,0},{0.3,0},{0.08,0.16}}},
}
R.cream = pile{{"lead white",5},{"yellow ochre",0.6},{"cadmium yellow",0.15},{"bone black",0.03}, turps=0.15, name="cream"}
local function s(x) return (VPX - x) / VPX end
local b = brush{kind="round", width=3.6, point=0.2}
local word = "CLEANERS"
local x = 168
for i = 1, #word do
  local sc = s(x)
  local w = 33 * sc
  for _, st in ipairs(FONT[word:sub(i,i)]) do
    local pts = {}
    for _, uv in ipairs(st) do
      local px = x + uv[1]*w
      pts[#pts+1] = {px, fy(px, 279 - uv[2]*20)}
    end
    b:reload(R.cream, 0.7)
    b:stroke(pts, {pressure=0.62*sc^0.5, ramps={0.05,0.05}})
  end
  x = x + 52 * sc
end
print(x)

--@ chunk 32
R.shade = pile{{"yellow ochre",2},{"deep cadmium",0.8},{"lead white",2},{"burnt sienna",0.3}, turps=0.15, name="shade"}
R.room = pile{{"lead white",5},{"cadmium yellow",0.7},{"yellow ochre",0.4}, turps=0.15, name="room"}
R.sash = pile{{"bone black",1.5},{"burnt sienna",1},{"red earth",0.5},{"lead white",0.2}, turps=0.15, name="sash"}
local x0, x1 = 395, 478
-- room (lower part, below shade at h 175)
local roomm = fquad(x0+5, x1-5, 175, 224)
local shadem = fquad(x0+5, x1-5, 122, 175)
work(shadem, {hand="detail", tool={kind="flat", width=4}, pile=R.shade, coverage=4, fill=true, clip=true, angle=math.pi/2})
work(roomm, {hand="detail", tool={kind="flat", width=4}, pile=R.room, coverage=4, fill=true, clip=true, angle=math.pi/2})

--@ chunk 33
-- sash frame lines
local b = brush{kind="flat", width=3.2}
local function hl(x0,x1,h) b:reload(R.sash,0.6); b:stroke({{x0, fy(x0,h)},{x1, fy(x1,h)}}, {pressure=0.6}) end
local function vl(x,h0,h1) b:reload(R.sash,0.6); b:stroke({{x, fy(x,h0)},{x, fy(x,h1)}}, {pressure=0.6}) end
local x0, x1 = 395, 478
hl(x0, x1, 120); hl(x0, x1, 226); vl(x0+1.5, 118, 228); vl(x1-1.5, 118, 228)
hl(x0, x1, 172.5)   -- meeting rail
-- shade bottom edge (pull bar) slightly darker
local bb = brush{kind="round", width=1.6}
bb:reload(R.hair, 0.5)
bb:stroke({{x0+5, fy(x0+5,176)},{x1-5, fy(x1-5,176)}}, {pressure=0.5})
-- a curtain sliver on right side of room
local cm = poly({{x1-14, fy(x1-14,175)},{x1-5, fy(x1-5,175)},{x1-5, fy(x1-5,224)},{x1-11, fy(x1-11,224)}})
work(cm, {hand="detail", pile=R.shade, coverage=4, fill=true, clip=true, angle=math.pi/2})
-- sill
local sill = fquad(x0-4, x1+4, 228, 234)
work(sill, {hand="detail", pile=R.sash, coverage=4, fill=true, clip=true, angle=0})

--@ chunk 34
R.fwin = pile{{"bone black",2.5},{"ultramarine blue",1.2},{"viridian",0.4},{"lead white",0.15}, turps=0.15, name="fwin"}
R.fwinlit = pile{{"lead white",3},{"deep cadmium",0.6},{"yellow ochre",0.8},{"burnt sienna",0.15}, turps=0.15, name="fwinlit"}
R.fwindim = pile{{"yellow ochre",1},{"burnt sienna",0.6},{"bone black",0.8},{"lead white",0.6}, turps=0.15, name="fwindim"}
fwins = {}
local rows = {{-20,32},{75,127},{170,222},{265,317}}
local cols = {{812,842},{868,898},{924,954},{980,1010}}
for ri, r in ipairs(rows) do
  for ci, c in ipairs(cols) do
    local m = fquad(c[1], math.min(c[2],1000), r[1], r[2]) * farb
    local p = R.fwin
    if ri == 2 and ci == 2 then p = R.fwinlit end
    if ri == 3 and ci == 4 then p = R.fwindim end
    if ri == 1 and ci == 3 then p = R.fwindim end
    work(m, {hand="detail", pile=p, coverage=4, fill=true, clip=true, angle=math.pi/2})
  end
end

--@ chunk 35
print(wait(3*24*60))
for _,p in ipairs{{300,370},{200,480},{560,370},{320,370},{300,330},{900,200},{300,200},{430,200}} do print(p[1],p[2],drying(p[1],p[2])) end

--@ chunk 36
S = {}
S.brickT = pile{{"red earth",1},{"bone black",3},{"burnt sienna",0.6},{"ultramarine blue",0.6}, medium=0.05, name="brickT"}
S.brickB = pile{{"red earth",1.4},{"bone black",2.6},{"burnt sienna",0.8},{"ultramarine blue",0.4}, medium=0.05, name="brickB"}
local function t(x,y) return clamp((y - fy(x,60)) / (fy(x,240) - fy(x,60)), 0, 1) end
local upper = upmask * mask(function(x,y) return y < fy(x,250) and 1 or 0 end)
work(upper, {hand="body", piles={{S.brickT, function(x,y) return 1-t(x,y) end},{S.brickB, function(x,y) return t(x,y) end}},
  coverage=2.5, fill=true, clip=true, angle=function(x,y) return math.atan(VPY - y, VPX - x) end})

--@ chunk 37
S.skyT = pile{{"ultramarine blue",2},{"viridian",1},{"bone black",2.2},{"lead white",0.8}, medium=0.05, name="skyT"}
S.skyB = pile{{"ultramarine blue",1.2},{"viridian",1.4},{"bone black",1},{"lead white",2.4},{"yellow ochre",0.25}, medium=0.05, name="skyB"}
local function t(x,y) return clamp((y-10)/150,0,1)^1.3 end
local skyall = sky + slotsky
skyall = skyall - facade - farb - sidewall2
work(skyall, {hand="broad", piles={{S.skyT, function(x,y) return 1-t(x,y) end},{S.skyB, function(x,y) return t(x,y) end}}, coverage=2.5, fill=true, clip=true, angle=0.03})

--@ chunk 38
-- tone down two of the lit far windows: one becomes a drawn shade (dim ochre-grey), one back to dark
S.fshade = pile{{"yellow ochre",1},{"bone black",1.2},{"burnt sienna",0.5},{"lead white",0.5}, medium=0.05, name="fshade"}
local m1 = fquad(924, 954, -20, 32) * farb
local m2 = fquad(980, 1000, 170, 222) * farb
work(m1, {hand="detail", pile=S.fshade, coverage=4, fill=true, clip=true, angle=math.pi/2})
work(m2, {hand="detail", pile=R.fwin, coverage=4, fill=true, clip=true, angle=math.pi/2})
-- one window with a half-pulled shade
local m3 = fquad(812, 842, 265, 290) * farb
work(m3, {hand="detail", pile=S.fshade, coverage=4, fill=true, clip=true, angle=math.pi/2})

--@ chunk 39
S.far = pile{{"bone black",3},{"ultramarine blue",1},{"viridian",0.5},{"burnt sienna",0.4},{"lead white",0.35}, medium=0.05, name="far3"}
S.side = pile{{"bone black",3},{"ultramarine blue",0.7},{"burnt sienna",0.7},{"viridian",0.3},{"lead white",0.15}, medium=0.05, name="side3"}
local rows = {{-20,32},{75,127},{170,222},{265,317}}
local cols = {{812,842},{868,898},{924,954},{980,1010}}
local wins
for _, r in ipairs(rows) do for _, c in ipairs(cols) do
  local q = fquad(c[1], math.min(c[2],1000), r[1], r[2])
  wins = wins and (wins + q) or q
end end
farwins = wins * farb
work(farb - farwins, {hand="body", pile=S.far, coverage=2.5, fill=true, clip=true, angle=-0.1})
work(sidewall2, {hand="body", pile=S.side, coverage=2.5, fill=true, clip=true, angle=math.pi/2})

--@ chunk 40
print(wait(2*24*60))
for _,p in ipairs{{200,480},{560,370},{320,370},{300,200},{100,180},{900,300},{60,400},{400,580}} do print(p[1],p[2],drying(p[1],p[2])) end

--@ chunk 41
S.glass = pile{{"bone black",3},{"ultramarine blue",1},{"viridian",0.6},{"lead white",0.25}, medium=0.05, name="glass"}
S.dshade = pile{{"yellow ochre",1},{"bone black",1.5},{"burnt sienna",0.4},{"lead white",0.9}, medium=0.05, name="dshade"}
S.sash = pile{{"bone black",2},{"burnt sienna",0.8},{"lead white",0.5},{"yellow ochre",0.3}, medium=0.05, name="dsash"}
local specs = {{55,150,155},{225,315,128},{555,628,172}}
for _, s in ipairs(specs) do
  local x0, x1, hs = s[1], s[2], s[3]
  work(fquad(x0+4, x1-4, hs, 224), {hand="detail", tool={kind="flat", width=4}, pile=S.glass, coverage=4, fill=true, clip=true, angle=math.pi/2})
  work(fquad(x0+4, x1-4, 122, hs), {hand="detail", tool={kind="flat", width=4}, pile=S.dshade, coverage=4, fill=true, clip=true, angle=math.pi/2})
end

--@ chunk 42
local b = brush{kind="flat", width=3.4}
local function hl(x0,x1,h,p) b:reload(p or S.sash,0.6); b:stroke({{x0, fy(x0,h)},{x1, fy(x1,h)}}, {pressure=0.6}) end
local function vl(x,h0,h1,p) b:reload(p or S.sash,0.6); b:stroke({{x, fy(x,h0)},{x, fy(x,h1)}}, {pressure=0.6}) end
for _, s in ipairs{{55,150},{225,315},{555,628}} do
  local x0, x1 = s[1], s[2]
  hl(x0, x1, 120); hl(x0, x1, 226); vl(x0+1.5, 118, 228); vl(x1-1.5, 118, 228); hl(x0, x1, 172.5)
  work(fquad(x0-4, x1+4, 228, 234), {hand="detail", pile=S.sash, coverage=4, fill=true, clip=true, angle=0})
end

--@ chunk 43
S.ceil = pile{{"lead white",6},{"yellow ochre",0.5},{"viridian",0.12},{"bone black",0.15}, medium=0.05, name="ceil"}
S.tube = pile{{"lead white",10},{"pale cadmium",0.3},{"viridian",0.06}, name="tube"}
-- ceiling: band at top of window, its lower edge (back wall top) slightly lower and converging
local backtop = function(x) return fy(x, 307) end
ceilm = poly({{100, fy(100,296)}, {610, fy(610,296)}, {610, fy(610,303)}, {525, fy(525,305)}, {100, backtop(100)}}) * shopwin
work(ceilm, {hand="detail", tool={kind="flat", width=3}, pile=S.ceil, coverage=4, fill=true, clip=true, angle=-0.05})
-- fluorescent tubes: two fixtures receding toward the back, drawn as short bright bars
local b = brush{kind="flat", width=2.2}
for _, seg in ipairs{{150, 240, 302.5}, {290, 380, 302.5}, {400, 500, 303.2}} do
  b:reload(S.tube, 0.8)
  b:stroke({{seg[1], fy(seg[1], seg[3])}, {seg[2], fy(seg[2], seg[3])}}, {pressure=0.7})
end

--@ chunk 44
S.frame = pile{{"bone black",2},{"burnt sienna",1},{"red earth",0.5},{"lead white",0.3}, medium=0.05, name="frame"}
local function mull(x, w)
  local m = poly({{x-w, fy(x-w,296)}, {x+w, fy(x+w,296)}, {x+w, fy(x+w,447)}, {x-w, fy(x-w,447)}})
  work(m, {hand="detail", tool={kind="flat", width=3}, pile=S.frame, coverage=5, fill=true, clip=true, angle=math.pi/2})
end
mull(270, 2.6); mull(440, 2.4)
-- frame lips: a thin bar at top and bottom of glass
local top = fquad(108, 602, 295, 299)
local bot = fquad(108, 602, 442, 447)
work(top + bot, {hand="detail", tool={kind="flat", width=3}, pile=S.frame, coverage=5, fill=true, clip=true, angle=-0.05})
local l = fquad(107, 112, 296, 446); local r = fquad(598, 603, 296, 446)
work(l + r, {hand="detail", tool={kind="flat", width=3}, pile=S.frame, coverage=5, fill=true, clip=true, angle=math.pi/2})

--@ chunk 45
S.fix = pile{{"lead white",3},{"bone black",0.5},{"viridian",0.2},{"yellow ochre",0.2}, medium=0.05, name="fix"}
local b = brush{kind="flat", width=2.4}
local c = brush{kind="round", width=0.8, point=0.8}
for _, f in ipairs{{165, 245}, {335, 410}} do
  local x0, x1 = f[1], f[2]
  local h = 311
  -- cords
  c:reload(S.frame, 0.4)
  c:stroke({{x0+8, fy(x0+8,301)}, {x0+8, fy(x0+8,h-1)}}, {pressure=0.4})
  c:reload(S.frame, 0.4)
  c:stroke({{x1-8, fy(x1-8,301)}, {x1-8, fy(x1-8,h-1)}}, {pressure=0.4})
  -- housing
  b:reload(S.fix, 0.7)
  b:stroke({{x0, fy(x0,h)}, {x1, fy(x1,h)}}, {pressure=0.7})
  -- glowing underside
  local u = brush{kind="flat", width=1.6}
  u:reload(S.tube, 0.8)
  u:stroke({{x0+1, fy(x0,h)+2.1}, {x1-1, fy(x1,h)+2.1}}, {pressure=0.6})
end
-- wall clock
local clockc = {205, fy(205, 338)}
work(ellipse(clockc[1], clockc[2], 7, 7.2), {hand="detail", pile=S.frame, coverage=5, fill=true, clip=true})
work(ellipse(clockc[1], clockc[2], 5.4, 5.6), {hand="detail", pile=S.tube, coverage=5, fill=true, clip=true})
c:reload(S.frame, 0.5); c:stroke({{clockc[1], clockc[2]}, {clockc[1]+0.5, clockc[2]-4}}, {pressure=0.5})
c:reload(S.frame, 0.5); c:stroke({{clockc[1], clockc[2]}, {clockc[1]+3, clockc[2]+1}}, {pressure=0.5})

--@ chunk 46
FC = {360, 250}
function edgept(xb, ytarget_fn)
  local bx, by = xb, fy(xb, 470)
  local dx, dy = bx - FC[1], by - FC[2]
  -- find t where y = ytarget_fn(x)
  local lo, hi = 1, 6
  for i = 1, 60 do
    local t = (lo + hi) / 2
    local x, y = FC[1] + t*dx, FC[2] + t*dy
    if y < ytarget_fn(x) then lo = t else hi = t end
  end
  local t = (lo + hi) / 2
  return FC[1] + t*dx, FC[2] + t*dy
end
local curb = function(x) return fy(x, 545) end
local inner = function(x) return fy(x, 478) end
local street2 = function(x) return fy(x, 545) + 70 end
for _, xb in ipairs{112, 267, 273, 437, 443, 598} do
  local a, b = edgept(xb, inner); local c, d = edgept(xb, curb); local e, f = edgept(xb, street2)
  print(xb, math.floor(a), math.floor(b), math.floor(c), math.floor(d), math.floor(e), math.floor(f))
end

--@ chunk 47
FC = {360, 225}
local curb = function(x) return fy(x, 545) end
local inner = function(x) return fy(x, 478) end
local far = function(x) return fy(x, 545) + 75 end
local function pane(x0, x1, f0, f1)
  local a,b = edgept(x0, f0); local c,d = edgept(x1, f0); local e,f = edgept(x1, f1); local g,h = edgept(x0, f1)
  return poly({{a,b},{c,d},{e,f},{g,h}})
end
spW = (pane(112,267,inner,curb) + pane(273,437,inner,curb) + pane(443,598,inner,curb)) * walk
spS = (pane(112,267,curb,far) + pane(273,437,curb,far) + pane(443,598,curb,far)) * street
for _, xb in ipairs{112, 598} do local c,d = edgept(xb, curb); print(xb, c, d) end
S.spA = pile{{"lead white",3},{"yellow ochre",0.7},{"pale cadmium",0.18},{"bone black",0.22},{"viridian",0.05}, medium=0.05, name="spA"}
S.walkd = pile{{"bone black",2.2},{"yellow ochre",0.6},{"burnt sienna",0.5},{"ultramarine blue",0.35},{"lead white",0.45}, medium=0.05, name="walkd2"}
S.spB = mix{{S.spA, 0.55}, {S.walkd, 0.45}, name="spB"}

--@ chunk 48
local function tf(x,y) local b0, b1 = fy(x,470), fy(x,545); return clamp((y-b0)/(b1-b0),0,1) end
-- dark sidewalk outside the light (the wedge and curb handled later)
local darkwalk = walkonly - spW
work(darkwalk, {hand="body", pile=S.walkd, coverage=2.5, fill=true, clip=true, angle=-0.06})
local function ang(x,y) return math.atan(y - FC[2], x - FC[1]) end
work(spW, {hand="body", tool="filbert 6", piles={{S.spA, function(x,y) return (1 - tf(x,y))^1.2 end},{S.spB, function(x,y) return tf(x,y) end}},
  coverage=3, fill=true, clip=true, angle=ang, length={15,40}})

--@ chunk 49
S.street = pile{{"bone black",2.5},{"ultramarine blue",1},{"burnt sienna",0.6},{"viridian",0.2},{"lead white",0.3}, medium=0.05, name="street3"}
S.stlit = mix{{S.spB, 0.5}, {S.street, 0.5}, name="stlit"}
local function ts(x,y) local b0 = fy(x,545); return clamp((y-b0)/75,0,1) end
local function ang(x,y) return math.atan(y - FC[2], x - FC[1]) end
-- whole street: base dark, with lit fan grading in
local zone = street * mask(function(x,y) return (y < fy(x,545) + 110) and 1 or 0 end)
local lit = spS:blur(10)
work(zone, {hand="body", tool="filbert 10", piles={
   {S.stlit, function(x,y) return lit:at(x,y) * (1 - ts(x,y))^1.5 end},
   {S.street, function(x,y) return 1 - lit:at(x,y) * (1 - ts(x,y))^1.5 + 0.02 end}},
  coverage=3, fill=true, clip=true, angle=function(x,y) return lit:at(x,y) > 0.1 and ang(x,y) or -0.07 end, length={20,60}})

--@ chunk 50
S.streetD = pile{{"bone black",3},{"ultramarine blue",1},{"burnt sienna",0.7},{"viridian",0.2},{"lead white",0.15}, medium=0.05, name="streetD"}
local function tb(x,y) return clamp((y - (fy(x,545)+80)) / 80, 0, 1) end
local zone = street * mask(function(x,y) return (y > fy(x,545) + 85) and 1 or 0 end)
work(zone, {hand="broad", piles={{S.street, function(x,y) return 1 - tb(x,y) end},{S.streetD, function(x,y) return tb(x,y) end}},
  coverage=2.5, fill=true, clip=true, angle=-0.06})

--@ chunk 51
local zone = (spS:grow(25)) * street * mask(function(x,y) return (y > fy(x,545) + 3) and 1 or 0 end)
blend(zone, {angle=-0.06})
print(drying(300, 560))

--@ chunk 52
blend(spW:shrink(1.5), {angle=-0.06})

--@ chunk 53
print(wait(3*24*60))
for _,p in ipairs{{200,500},{300,560},{300,600},{60,400},{900,300},{760,300},{320,370},{100,180}} do print(p[1],p[2],drying(p[1],p[2])) end

--@ chunk 54
print(wait(6*24*60))
for _,p in ipairs{{200,500},{300,560},{300,600},{900,300},{760,300},{320,370},{100,180},{300,100},{500,30}} do print(p[1],p[2],drying(p[1],p[2])) end

--@ chunk 55
-- door: dark wood frame, glass panel with dim reflection, kick panel
S.doorwood = pile{{"bone black",2},{"burnt sienna",1.2},{"red earth",0.4},{"lead white",0.25}, medium=0.05, name="doorwood"}
S.doorglass = pile{{"bone black",2.5},{"ultramarine blue",0.6},{"viridian",0.5},{"yellow ochre",0.2},{"lead white",0.35}, medium=0.05, name="doorglass"}
work(door, {hand="detail", tool={kind="flat", width=4}, pile=S.doorwood, coverage=5, fill=true, clip=true, angle=math.pi/2})
local glass = fquad(36, 84, 306, 420)
work(glass, {hand="detail", tool={kind="flat", width=4}, pile=S.doorglass, coverage=5, fill=true, clip=true, angle=math.pi/2})

--@ chunk 56
-- faint reflection of the lit window in the door glass: a narrow pale-greenish streak
S.refl = pile{{"lead white",1.2},{"bone black",1},{"viridian",0.3},{"yellow ochre",0.3}, medium=0.05, name="refl"}
local b = brush{kind="flat", width=3}
b:reload(S.refl, 0.35)
b:stroke({{74, fy(74,312)}, {72, fy(72,415)}}, {pressure=0.35})
-- door handle
local h = brush{kind="round", width=2, point=0.3}
h:reload(S.fix, 0.5)
h:stroke({{80, fy(80,380)}, {80, fy(80,392)}}, {pressure=0.6})
-- transom
local tr = fquad(36, 84, 286, 300) * facade
-- curb: lit top edge as thin line, then a dark face
S.curbtop = pile{{"lead white",2},{"yellow ochre",0.5},{"bone black",0.35},{"pale cadmium",0.1}, medium=0.05, name="curbtop"}
S.curbface = pile{{"bone black",2.2},{"burnt sienna",0.5},{"ultramarine blue",0.4},{"yellow ochre",0.3},{"lead white",0.5}, medium=0.05, name="curbface"}
curbface = poly({{0, fy(0,545)}, {1000, fy(1000,545)}, {1000, fy(1000,545)+3.5}, {0, fy(0,545)+6}})
work(curbface, {hand="detail", tool={kind="flat", width=3}, pile=S.curbface, coverage=5, fill=true, clip=true, angle=-0.07})

--@ chunk 57
-- the lit lip of the curb, only where the window light reaches it
local lip = poly({{0, fy(0,545)-2.2}, {1000, fy(1000,545)-1.6}, {1000, fy(1000,545)+0.4}, {0, fy(0,545)+0.5}}) * spW:grow(3)
work(lip, {hand="detail", tool={kind="flat", width=2}, pile=S.curbtop, coverage=4, fill=true, clip=true, angle=-0.07})

--@ chunk 58
for _,p in ipairs{{200,340},{380,350},{560,350},{500,300},{300,420},{316,350},{205,338}} do print(p[1],p[2],drying(p[1],p[2])) end

--@ chunk 59
S.wallHi = pile{{"lead white",10},{"pale cadmium",0.7},{"viridian",0.12}, medium=0.05, name="wallHi"}
S.wallLo = pile{{"lead white",8},{"yellow ochre",0.6},{"viridian",0.3},{"bone black",0.2}, medium=0.05, name="wallLo"}
local function ctop(x) return 330 + (393 - 330) * (VPX - x) / VPX * 0.97 end
local function mull(x, w) return poly({{x-w-1, 0}, {x+w+1, 0}, {x+w+1, 625}, {x-w-1, 625}}) end
wallzone = bwall * mask(function(x,y) return (y > fy(x,309) and y < ctop(x) - 0.5) and 1 or 0 end)
wallzone = wallzone - mull(270, 2.6) - mull(440, 2.4) - backdoorm:grow(1) - ellipse(205, fy(205,338), 8.5, 8.7)
  - (torso2 + head + hairm + neck + armL2 + armR2 + sleeves):grow(1.2)
local function t(x,y) local a, b = fy(x,312), ctop(x); return clamp((y-a)/(b-a),0,1) end
local function side(x) return clamp((x - 330) / 200, -1, 1) end
work(wallzone, {hand="body", tool="filbert 6", piles={{S.wallHi, function(x,y) return (1-t(x,y)) end},{S.wallLo, function(x,y) return t(x,y)*0.8 + 0.15*math.abs(side(x)) end}},
  coverage=3, fill=true, clip=true, angle=0, length={20,50}})
blend(wallzone:shrink(1), {angle=0})

--@ chunk 60
local b = brush{kind="flat", width=2.4}
local c = brush{kind="round", width=0.8, point=0.8}
local u = brush{kind="flat", width=1.6}
for _, f in ipairs{{165, 245}, {335, 410}} do
  local x0, x1 = f[1], f[2]
  local h = 311
  c:reload(S.frame, 0.4); c:stroke({{x0+8, fy(x0+8,301)}, {x0+8, fy(x0+8,h-1)}}, {pressure=0.4})
  c:reload(S.frame, 0.4); c:stroke({{x1-8, fy(x1-8,301)}, {x1-8, fy(x1-8,h-1)}}, {pressure=0.4})
  b:reload(S.fix, 0.8); b:stroke({{x0, fy(x0,h)}, {x1, fy(x1,h)}}, {pressure=0.75})
  u:reload(S.tube, 0.9); u:stroke({{x0+1, fy(x0,h)+2.1}, {x1-1, fy(x1,h)+2.1}}, {pressure=0.65})
end
-- third fixture in the right pane, smaller (further back)
local x0, x1 = 455, 515
c:reload(S.frame, 0.4); c:stroke({{x0+6, fy(x0+6,301)}, {x0+6, fy(x0+6,309)}}, {pressure=0.35})
c:reload(S.frame, 0.4); c:stroke({{x1-6, fy(x1-6,301)}, {x1-6, fy(x1-6,309)}}, {pressure=0.35})
b:reload(S.fix, 0.8); b:stroke({{x0, fy(x0,310)}, {x1, fy(x1,310)}}, {pressure=0.6})
u:reload(S.tube, 0.9); u:stroke({{x0+1, fy(x0,310)+1.8}, {x1-1, fy(x1,310)+1.8}}, {pressure=0.55})

--@ chunk 61
S.corn = pile{{"bone black",2.5},{"burnt sienna",0.7},{"red earth",0.4},{"ultramarine blue",0.3},{"lead white",0.2}, medium=0.05, name="corn"}
S.cornL = pile{{"bone black",1.5},{"ultramarine blue",0.6},{"viridian",0.3},{"lead white",1.0},{"burnt sienna",0.3}, medium=0.05, name="cornL"}
-- cornice band: h 40..56, slightly projecting; the cap catches sky light
local band = fquad(0, CX, 41, 58)
work(band, {hand="detail", tool={kind="flat", width=4}, pile=S.corn, coverage=5, fill=true, clip=true, angle=fy(1,0)-fy(0,0)})
local cap = fquad(0, CX, 39.5, 43)
work(cap, {hand="detail", tool={kind="flat", width=2.5}, pile=S.cornL, coverage=4, fill=true, clip=true, angle=fy(1,0)-fy(0,0)})
-- dentil-ish shadow line under the band
local b = brush{kind="flat", width=1.6}
b:reload(S.streetD, 0.6)
b:stroke({{0, fy(0,59)}, {CX, fy(CX,59)}}, {pressure=0.6})

--@ chunk 62
HX, HY = 622, 463
local dx, dy = HX - FC[1], HY - FC[2]
local L = math.sqrt(dx*dx+dy*dy); dx, dy = dx/L, dy/L
local nx, ny = -dy, dx
print(dx, dy, fy(HX,545))
-- shadow on the lit sidewalk: from foot to the curb, widening a little
local s0 = 5.5; local s1 = 7.5
local endT = 34
local shad = poly({{HX + nx*s0, HY + ny*s0}, {HX + dx*endT + nx*s1, HY + dy*endT + ny*s1}, {HX + dx*endT - nx*s1, HY + dy*endT - ny*s1}, {HX - nx*s0, HY - ny*s0}}) * walk
S.walkd2 = pile{{"bone black",2.2},{"yellow ochre",0.6},{"burnt sienna",0.5},{"ultramarine blue",0.35},{"lead white",0.6}, medium=0.05, name="walkd3"}
work(shad * spW:grow(2), {hand="detail", tool={kind="flat", width=3}, pile=S.walkd2, coverage=5, fill=true, clip=true, angle=math.atan(dy,dx)})

--@ chunk 63
S.hyd = pile{{"red earth",2},{"bone black",1},{"burnt sienna",0.5},{"lead white",0.15}, medium=0.05, name="hyd"}
S.hydL = pile{{"red earth",1.5},{"deep cadmium",0.5},{"lead white",0.8},{"yellow ochre",0.3}, medium=0.05, name="hydL"}
-- silhouette
local hx, hy = HX, HY
local hydm = poly({
  {hx-7, hy}, {hx+7, hy}, {hx+7, hy-3}, {hx+5, hy-3.5}, {hx+5, hy-18}, {hx+8.5, hy-18.5}, {hx+8.5, hy-22}, {hx+5, hy-22.5},
  {hx+5.8, hy-24}, {hx+4.5, hy-27}, {hx+2, hy-29}, {hx+1, hy-31}, {hx-1, hy-31}, {hx-2, hy-29}, {hx-4.5, hy-27},
  {hx-5.8, hy-24}, {hx-5, hy-22.5}, {hx-8.5, hy-22}, {hx-8.5, hy-18.5}, {hx-5, hy-18}, {hx-5, hy-3.5}, {hx-7, hy-3}}, false)
hydmask = hydm
work(hydm, {hand="detail", tool={kind="round", width=2.2}, pile=S.hyd, coverage=6, fill=true, clip=true, angle=math.pi/2})
-- lit side: the light comes from upper-left behind (the window), so the left/back edge catches it
local lit = hydm * poly({{hx-10, hy-35}, {hx-2.5, hy-35}, {hx-2.5, hy+2}, {hx-10, hy+2}})
work(lit, {hand="detail", tool={kind="round", width=1.6}, pile=S.hydL, coverage=5, fill=true, clip=true, angle=math.pi/2})

--@ chunk 64
S.hydM = pile{{"red earth",2},{"bone black",0.8},{"burnt sienna",0.4},{"lead white",0.35}, medium=0.05, name="hydM"}
local hx, hy = HX, HY
work(hydmask, {hand="detail", tool={kind="round", width=2.2}, pile=S.hyd, coverage=6, fill=true, clip=true, angle=math.pi/2})
local lit = hydmask * poly({{hx-10, hy-35}, {hx-3.6, hy-35}, {hx-3.6, hy+2}, {hx-10, hy+2}})
work(lit, {hand="detail", tool={kind="round", width=1.4}, pile=S.hydM, coverage=5, fill=true, clip=true, angle=math.pi/2})

--@ chunk 65
S.skyT2 = pile{{"ultramarine blue",2},{"viridian",1.1},{"bone black",3.2},{"lead white",0.45}, medium=0.05, name="skyT2"}
S.skyB2 = pile{{"ultramarine blue",1.5},{"viridian",1.3},{"bone black",2},{"lead white",1.3},{"yellow ochre",0.2}, medium=0.05, name="skyB2"}
local function t(x,y) return clamp((y-0)/160,0,1)^1.6 end
local skyall = (sky + slotsky) - facade - farb - sidewall2
work(skyall, {hand="broad", piles={{S.skyT2, function(x,y) return 1-t(x,y) end},{S.skyB2, function(x,y) return t(x,y) end}}, coverage=2.5, fill=true, clip=true, angle=0.03})
blend(skyall:shrink(2), {angle=0.02})

--@ chunk 66
for _,p in ipairs{{60,500},{700,450},{850,420},{622,450},{640,470}} do print(p[1],p[2],drying(p[1],p[2])) end

--@ chunk 67
S.walkdd = pile{{"bone black",2.6},{"yellow ochre",0.45},{"burnt sienna",0.6},{"ultramarine blue",0.45},{"lead white",0.35}, medium=0.05, name="walkdd"}
local keep = spW:grow(1) + hydmask:grow(2) + poly({{610,455},{640,455},{670,490},{630,490}})
local dw = walkonly - keep
-- gentle glow near the light: mix a little lighter near the spill
local near = spW:blur(25)
work(dw, {hand="body", piles={{S.walkdd, function(x,y) return 1 end},{S.walkd, function(x,y) return near:at(x,y)*1.5 end}}, coverage=2.5, fill=true, clip=true, angle=-0.06})
blend(dw:shrink(2), {angle=-0.06})

--@ chunk 68
for _,p in ipairs{{300,386},{150,390},{330,380}} do print(p[1],p[2],drying(p[1],p[2])) end
S.shirt = pile{{"lead white",8},{"ultramarine blue",0.05},{"bone black",0.04}, medium=0.05, name="shirt"}
S.shirtsh = pile{{"lead white",4},{"ultramarine blue",0.25},{"bone black",0.25},{"yellow ochre",0.1}, medium=0.05, name="shirtsh"}
S.reg = pile{{"bone black",2},{"burnt sienna",0.6},{"lead white",0.6},{"viridian",0.2}, medium=0.05, name="reg"}
S.regL = pile{{"bone black",1},{"burnt sienna",0.3},{"lead white",1.6},{"yellow ochre",0.2}, medium=0.05, name="regL"}

--@ chunk 69
local function ctop(x) return 330 + (393 - 330) * (VPX - x) / VPX * 0.97 end
-- folded shirt pile on the counter, under her hands
local sx0, sx1 = 300, 338
local shirtm = poly({{sx0, ctop(sx0)-3.2}, {sx1, ctop(sx1)-3.4}, {sx1+1, ctop(sx1)+0.6}, {sx0-1, ctop(sx0)+0.8}})
work(shirtm, {hand="detail", tool={kind="flat", width=2}, pile=S.shirt, coverage=5, fill=true, clip=true, angle=0})
local shadm = poly({{sx0-1, ctop(sx0)-0.4}, {sx1+1, ctop(sx1)-0.6}, {sx1+1, ctop(sx1)+0.6}, {sx0-1, ctop(sx0)+0.8}})
work(shadm, {hand="detail", tool={kind="flat", width=1.5}, pile=S.shirtsh, coverage=4, fill=true, clip=true, angle=0})
-- hands resting on the shirt
local hands = ribbon({{306, ctop(306)-3.6}, {313, ctop(313)-3.8}}, 2.4) + ribbon({{322, ctop(322)-3.8}, {330, ctop(330)-3.7}}, 2.4)
work(hands, {hand="detail", pile=R.skin, coverage=5, fill=true, clip=true})
-- cash register
local rx = 150; local base = ctop(rx)
local regm = poly({{rx, base}, {rx+26, base-0.3}, {rx+26, base-10}, {rx+22, base-15}, {rx+22, base-22}, {rx+8, base-22}, {rx+8, base-15}, {rx+2, base-13}, {rx, base-10}})
work(regm, {hand="detail", tool={kind="round", width=2}, pile=S.reg, coverage=6, fill=true, clip=true, angle=math.pi/2})
local regtop = poly({{rx+8.5, base-21.5}, {rx+21.5, base-21.5}, {rx+21.5, base-19.5}, {rx+8.5, base-19.5}})
local keys = poly({{rx+1, base-10.5}, {rx+3, base-12.5}, {rx+8, base-14.3}, {rx+8, base-12}, {rx+1.5, base-9.5}})
work(regtop + keys, {hand="detail", tool={kind="round", width=1.2}, pile=S.regL, coverage=5, fill=true, clip=true})

--@ chunk 70
for _,p in ipairs{{200,500},{350,480},{550,470},{430,190},{430,210},{880,190}} do print(p[1],p[2],drying(p[1],p[2])) end

--@ chunk 71
S.spA2 = pile{{"lead white",3},{"yellow ochre",0.75},{"pale cadmium",0.15},{"bone black",0.34},{"viridian",0.06}, medium=0.05, name="spA2"}
S.spB2 = mix{{S.spA2, 0.45}, {S.walkd, 0.55}, name="spB2"}
local function tf(x,y) local b0, b1 = fy(x,470), fy(x,545); return clamp((y-b0)/(b1-b0),0,1) end
local function ang(x,y) return math.atan(y - FC[2], x - FC[1]) end
local zone = spW - hydmask:grow(1.5)
work(zone, {hand="body", tool="filbert 6", piles={{S.spA2, function(x,y) return (1 - tf(x,y))^1.1 end},{S.spB2, function(x,y) return tf(x,y)^0.9 end}},
  coverage=3, fill=true, clip=true, angle=ang, length={15,40}})
blend(zone:shrink(1.5), {angle=-0.06})

--@ chunk 72
local zone = spW - hydmask:grow(1.5)
blend(zone:shrink(2), {angle=0.9})
print(drying(300,480))

--@ chunk 73
print("hello")

--@ chunk 74
for _,p in ipairs{{880,190},{990,260},{825,300},{850,250},{430,200},{300,480},{500,520}} do print(p[1],p[2],drying(p[1],p[2])) end
S.fglow = pile{{"yellow ochre",1.2},{"deep cadmium",0.35},{"lead white",1.2},{"burnt sienna",0.25},{"bone black",0.35}, medium=0.05, name="fglow"}
S.fshade2 = pile{{"yellow ochre",1},{"bone black",1.0},{"burnt sienna",0.6},{"lead white",0.55},{"deep cadmium",0.1}, medium=0.05, name="fshade2"}
S.fsill = pile{{"bone black",2.5},{"ultramarine blue",0.9},{"viridian",0.4},{"lead white",0.9},{"burnt sienna",0.3}, medium=0.05, name="fsill"}

--@ chunk 75
local function W_(x0,x1,h0,h1,p)
  work(fquad(x0, x1, h0, h1) * farb, {hand="detail", tool={kind="flat", width=4}, pile=p, coverage=5, fill=true, clip=true, angle=math.pi/2})
end
-- the bright one: shade drawn most of the way, a warm strip of room below
W_(868, 898, 75, 110, S.fshade2)
W_(868, 898, 110, 127, S.fglow)
-- streaky ones restated evenly
W_(980, 1000, 170, 222, S.glass)
W_(812, 842, 265, 290, S.fshade2)
W_(812, 842, 290, 317, S.glass)

--@ chunk 76
S.fshade3 = mix{{S.fshade2, 0.6}, {S.far, 0.4}, name="fshade3"}
work(fquad(812, 842, 265, 290) * farb, {hand="detail", tool={kind="flat", width=4}, pile=S.fshade3, coverage=5, fill=true, clip=true, angle=math.pi/2})
-- sills under every window: a thin pale-ish top catching the sky, a darker shadow beneath
local rows = {{-20,32},{75,127},{170,222},{265,317}}
local cols = {{812,842},{868,898},{924,954},{980,1010}}
local sillm, shm
for _, r in ipairs(rows) do for _, c in ipairs(cols) do
  local a = fquad(c[1]-2.5, math.min(c[2]+2.5, 1000), r[2]+1, r[2]+4)
  local b = fquad(c[1]-2.5, math.min(c[2]+2.5, 1000), r[2]+4, r[2]+6.5)
  sillm = sillm and (sillm + a) or a
  shm = shm and (shm + b) or b
end end
work(sillm * farb, {hand="detail", tool={kind="flat", width=2}, pile=S.fsill, coverage=5, fill=true, clip=true, angle=fy(1,0)-fy(0,0)})
S.fdark = pile{{"bone black",3},{"ultramarine blue",0.8},{"burnt sienna",0.4},{"lead white",0.1}, medium=0.05, name="fdark"}
work(shm * farb, {hand="detail", tool={kind="flat", width=2}, pile=S.fdark, coverage=4, fill=true, clip=true, angle=fy(1,0)-fy(0,0)})
-- roof coping: a thin edge catching the sky
local cap = fquad(FX, 1000, -60, -54) * farb
work(cap, {hand="detail", tool={kind="flat", width=2}, pile=S.fsill, coverage=5, fill=true, clip=true, angle=fy(1,0)-fy(0,0)})
-- the lit window's shade edge and meeting rail
local b = brush{kind="flat", width=1.6}
b:reload(S.fdark, 0.6); b:stroke({{868, fy(868,110)}, {898, fy(898,110)}}, {pressure=0.55})

--@ chunk 77
S.roomA = pile{{"lead white",3},{"cadmium yellow",0.45},{"yellow ochre",0.7},{"deep cadmium",0.15},{"burnt sienna",0.05}, medium=0.05, name="roomA"}
S.roomB = pile{{"lead white",2},{"yellow ochre",0.9},{"deep cadmium",0.25},{"burnt sienna",0.25},{"bone black",0.08}, medium=0.05, name="roomB"}

--@ chunk 78
local x0, x1 = 395, 478
local roomz = fquad(x0+5, x1-14, 177.5, 224)
local function t(x,y) return clamp((y - fy(x,178)) / (fy(x,224) - fy(x,178)), 0, 1) end
work(roomz, {hand="detail", tool={kind="flat", width=4}, piles={{S.roomA, function(x,y) return 1 - t(x,y) end},{S.roomB, function(x,y) return t(x,y) + 0.1 end}}, coverage=5, fill=true, clip=true, angle=math.pi/2})
blend(roomz:shrink(1), {angle=math.pi/2})

--@ chunk 79
print(wait(4*24*60))
for _,p in ipairs{{300,480},{200,500},{500,470},{350,520},{620,470},{430,200}} do print(p[1],p[2],drying(p[1],p[2])) end

--@ chunk 80
print(wait(3*24*60))
for _,p in ipairs{{300,480},{200,500},{500,470},{350,520},{620,470},{255,500},{440,490}} do print(p[1],p[2],drying(p[1],p[2])) end

--@ chunk 81
print(wait(2*24*60))
for _,p in ipairs{{300,480},{500,470},{620,470},{255,500},{120,535}} do print(p[1],p[2],drying(p[1],p[2])) end
-- where are the current mullion shadow bars? edges of the light panes at the curb
local curb = function(x) return fy(x, 545) end
local inner = function(x) return fy(x, 478) end
for _, xb in ipairs{267, 273, 437, 443} do local a,b = edgept(xb, inner); local c,d = edgept(xb, curb); print(xb, a, b, c, d) end

--@ chunk 82
local curb = function(x) return fy(x, 545) end
local inner = function(x) return fy(x, 478) end
local function bar(xa, xb)
  local a,b = edgept(xa, inner); local c,d = edgept(xb, inner)
  local e,f = edgept(xb, curb); local g,h = edgept(xa, curb)
  return poly({{a,b},{c,d},{e,f},{g,h}})
end
local bars = (bar(264.5, 275.5) + bar(434.5, 445.5)) * walk
local ang = function(x,y) return math.atan(y - FC[2], x - FC[1]) end
work(bars, {hand="detail", tool={kind="flat", width=3}, pile=S.walkd2, coverage=5, fill=true, clip=true, angle=ang})

--@ chunk 83
work(curbface * mask(function(x,y) return x < 700 and 1 or 0 end), {hand="detail", tool={kind="flat", width=3}, pile=S.curbface, coverage=5, fill=true, clip=true, angle=-0.07})
local lip = poly({{0, fy(0,545)-2.0}, {1000, fy(1000,545)-1.5}, {1000, fy(1000,545)+0.3}, {0, fy(0,545)+0.4}}) * spW:grow(1)
work(lip, {hand="detail", tool={kind="flat", width=2}, pile=S.curbtop, coverage=4, fill=true, clip=true, angle=-0.07})

--@ chunk 84
local curb = function(x) return fy(x, 545) end
local inner = function(x) return fy(x, 478) end
local function bar(xa, xb)
  local a,b = edgept(xa, inner); local c,d = edgept(xb, inner)
  local e,f = edgept(xb, function(x) return fy(x,545)+2 end); local g,h = edgept(xa, function(x) return fy(x,545)+2 end)
  return poly({{a,b},{c,d},{e,f},{g,h}})
end
local bars = (bar(264.5, 275.5) + bar(434.5, 445.5))
local lip = poly({{0, fy(0,545)-2.4}, {1000, fy(1000,545)-1.9}, {1000, fy(1000,545)+0.6}, {0, fy(0,545)+0.7}})
work(lip * bars, {hand="detail", tool={kind="round", width=1.5}, pile=S.walkd2, coverage=5, fill=true, clip=true})

--@ chunk 85
print(drying(930,605))
S.sig = pile{{"red earth",1},{"bone black",0.6},{"lead white",0.4},{"burnt sienna",0.2}, medium=0.05, name="sig"}
local G = {
 C={{{0.95,0.82},{0.75,1},{0.3,1},{0.05,0.78},{0.05,0.22},{0.3,0},{0.75,0},{0.95,0.18}}},
 L={{{0.12,1},{0.12,0},{0.9,0}}},
 A={{{0.02,0},{0.5,1},{0.98,0}},{{0.24,0.38},{0.76,0.38}}},
 U={{{0.1,1},{0.1,0.25},{0.3,0},{0.7,0},{0.9,0.25},{0.9,1}}},
 D={{{0.12,0},{0.12,1},{0.55,1},{0.88,0.75},{0.88,0.25},{0.55,0},{0.12,0}}},
 E={{{0.9,1},{0.12,1},{0.12,0},{0.9,0}},{{0.12,0.52},{0.72,0.52}}},
}
local b = brush{kind="round", width=1.3, point=0.5}
local x, base = 920, 610
for ch in ("CLAUDE"):gmatch(".") do
  for _, s in ipairs(G[ch]) do
    local pts = {}
    for _, uv in ipairs(s) do pts[#pts+1] = {x + uv[1]*6, base - uv[2]*8.5 - (x-920)*0.03} end
    b:reload(S.sig, 0.5); b:stroke(pts, {pressure=0.6, ramps={0.05,0.1}})
  end
  x = x + 9
end

--@ chunk 86
print(palette()) for k,v in pairs(S) do print(k,v) end

--@ chunk 87

print(drying(909,444), drying(795,425))
local b = brush{kind="round", width=2.6, point=0.2}
b:reload(S.street, 0.5)
b:touch(909.5, 444.5, {pressure=0.6, drag={2,0.2}})
b:reload(S.street, 0.5)
b:touch(795, 425.5, {pressure=0.6, drag={2,0.2}})

--@ chunk 88

local b = brush{kind="round", width=2.2, point=0.2}
b:reload(S.street, 0.6)
b:touch(908.6, 443.4, {pressure=0.7, drag={1.5,-0.3}})
b:reload(S.street, 0.6)
b:touch(907.8, 443.9, {pressure=0.7})

--@ chunk 89

local b = brush{kind="round", width=3.2, point=0.1}
b:reload(S.street, 0.7)
b:touch(908.3, 444.8, {pressure=0.8, drag={0.5,-1.5}})

--@ chunk 90
print(wait(5*24*60)); print(drying(908,444), drying(795,425))
