--@ watercolor-engine 2

paper{width=1180, height=700, kind="cold-press", seed=2013}
print(table.concat(palette(), ", "))


-- Campaign 1: sky. Pre-wet, graded blue wash, lift clouds while wet.
for gy=0,3 do for gx=0,9 do
  drop{x=250+gx*105 + (gy%2)*50, y=25+gy*95, water=6, radius=80}
end end
local w = brush{name="sky_wash", width=60}
w:load{water=6, pigments={["cobalt-blue"]=0.12, ["french-ultramarine"]=0.065, ["burnt-sienna"]=0.015, ["paynes-gray"]=0.008}}
w:wash{x=540, y=0, width=650, height=250, grade=0.35}
-- reaching blue into the edge of the left cloud, irregular
local e = brush{name="sky_edge", width=40}
e:load{water=8, pigments={["cobalt-blue"]=0.08, ["french-ultramarine"]=0.04, ["burnt-sienna"]=0.01, ["paynes-gray"]=0.006}}
e:stroke({{560,10},{520,60},{530,110},{480,160},{470,200}}, {pressure=0.5, duration=0.3})
e:load{water=5, pigments={["cobalt-blue"]=0.05, ["french-ultramarine"]=0.025, ["burnt-sienna"]=0.007}}
e:stroke({{440,235},{520,225},{600,240}}, {pressure=0.45, duration=0.2})
-- lifts: cirrus streaks and cumulus
local L = brush{name="lift_cirrus", width=22}
local function lift(path, wat, dur)
  L:load{water=wat}
  L:lift(path, {duration=dur})
end
lift({{780,52},{860,38},{950,20},{1040,8}}, 5, 0.25)
lift({{760,125},{880,112},{1000,98},{1180,78}}, 6, 0.3)
lift({{850,168},{960,160},{1080,152},{1185,146}}, 6, 0.3)
lift({{700,90},{760,82},{820,80}}, 3, 0.15)
lift({{1000,40},{1100,30},{1185,26}}, 4, 0.2)
lift({{430,208},{480,200},{540,198}}, 4, 0.15)
local C = brush{name="lift_cumulus", width=44}
local function liftc(path, wat, dur) C:load{water=wat}; C:lift(path, {duration=dur}) end
liftc({{870,265},{920,240},{960,220},{1010,215},{1060,205},{1110,195},{1180,190}}, 10, 0.35)
liftc({{900,280},{980,260},{1060,245},{1130,232},{1185,228}}, 10, 0.35)
liftc({{560,240},{650,250},{740,262}}, 6, 0.25)
wait(3)
local b = balance()
print(b.max_surface_water, b.max_wetness)



local e = brush{name="sky_right", width=50}
e:load{water=10, pigments={["cobalt-blue"]=0.14, ["french-ultramarine"]=0.07, ["burnt-sienna"]=0.016, ["paynes-gray"]=0.01}}
e:stroke({{900,15},{1000,10},{1100,20},{1190,10}}, {pressure=0.5, duration=0.25})
e:load{water=6, pigments={["cobalt-blue"]=0.08, ["french-ultramarine"]=0.04, ["burnt-sienna"]=0.01, ["paynes-gray"]=0.006}}
e:stroke({{1040,60},{1110,52},{1190,45}}, {pressure=0.45, duration=0.2})
e:load{water=6, pigments={["cobalt-blue"]=0.07, ["french-ultramarine"]=0.035, ["burnt-sienna"]=0.01}}
e:stroke({{1000,130},{1100,118},{1190,108}}, {pressure=0.4, duration=0.2})
-- break the hard lifted bars with dabs of blue at intervals
local d = brush{name="sky_dab", width=26}
d:load{water=5, pigments={["cobalt-blue"]=0.06, ["french-ultramarine"]=0.03, ["burnt-sienna"]=0.008}}
for _,p in ipairs({{745,72},{800,100},{880,105},{930,140},{990,150},{760,65}}) do
  d:stroke({{p[1],p[2]},{p[1]+25,p[2]-3}}, {pressure=0.4})
end
wait(2)
local b = balance()
print(b.max_surface_water, b.max_wetness)



-- Sky repair: pre-wet, graded rewash, soft tapered lifts (trialled on scratch)
for gy=0,2 do for gx=0,6 do
  drop{x=560+gx*105+(gy%2)*50, y=40+gy*100, water=9, radius=80}
end end
local r = brush{name="sky_rewash", width=60}
r:load{water=6, pigments={["cobalt-blue"]=0.12, ["french-ultramarine"]=0.065, ["burnt-sienna"]=0.016, ["paynes-gray"]=0.009}}
r:wash{x=540, y=0, width=650, height=250, grade=0.4}
local L = brush{name="sky_softlift", width=26}
local function tl(x0,y0,x1,y1,wat,bend)
  L:load{water=wat}
  local pts = {}
  for i=0,10 do local t=i/10; pts[#pts+1]={x0+(x1-x0)*t, y0+(y1-y0)*t - math.sin(t*3.1)*(bend or 6), 0.15+0.45*math.sin(t*math.pi)} end
  L:lift(pts, {duration=0.3})
end
tl(690,88,840,68,1.5)
tl(740,128,1000,100,2.5)
tl(900,112,1190,84,2.5, 4)
tl(760,172,1000,160,2,3)
tl(980,160,1190,140,2,3)
tl(940,48,1080,32,1.2,3)
local C = brush{name="sky_cumlift", width=46}
local function cl(pts, wat) C:load{water=wat}; C:lift(pts, {duration=0.35}) end
cl({{860,270,0.2},{900,245,0.5},{950,228,0.6},{1000,222,0.6},{1050,212,0.6},{1110,200,0.6},{1190,196,0.5}}, 4)
cl({{890,285,0.3},{960,268,0.6},{1040,255,0.6},{1120,245,0.6},{1190,240,0.5}}, 4)
cl({{560,245,0.2},{640,252,0.5},{740,262,0.2}}, 2)
print(clock())
wait(12)
print(balance().dry)



-- second sky glaze on the right half, to bring pills/bars into the field
for gy=0,2 do for gx=0,4 do
  drop{x=800+gx*100+(gy%2)*45, y=35+gy*95, water=9, radius=78}
end end
local r = brush{name="sky_rewash2", width=60}
r:load{water=6, pigments={["cobalt-blue"]=0.14, ["french-ultramarine"]=0.07, ["burnt-sienna"]=0.02, ["paynes-gray"]=0.014}}
r:wash{x=780, y=0, width=410, height=215, grade=0.45}
local L = brush{name="sky_softlift2", width=24}
local function tl(x0,y0,x1,y1,wat,bend)
  L:load{water=wat}
  local pts = {}
  for i=0,10 do local t=i/10; pts[#pts+1]={x0+(x1-x0)*t, y0+(y1-y0)*t - math.sin(t*3.1)*(bend or 6), 0.12+0.4*math.sin(t*math.pi)} end
  L:lift(pts, {duration=0.25})
end
tl(830,150,1060,118,1.8,5)
tl(1000,190,1190,170,1.8,3)
tl(1060,95,1190,75,1.2,3)
tl(880,60,1000,45,1.0,2)
local C = brush{name="sky_cumlift2", width=40}
C:load{water=3}
C:lift({{900,240,0.2},{960,222,0.5},{1020,215,0.55},{1080,205,0.55},{1140,195,0.5},{1190,192,0.4}}, {duration=0.3})
wait(12)
print(balance().dry)



-- even glaze over the upper-right sky (method trialled on scratch: 4uL pre-wet, short topped-up segments)
for gy=0,2 do for gx=0,4 do drop{x=800+gx*100+(gy%2)*45, y=30+gy*85, water=4, radius=78} end end
local s = brush{name="sky_even", width=50}
local base = {["cobalt-blue"]=0.020, ["french-ultramarine"]=0.010, ["burnt-sienna"]=0.0032, ["paynes-gray"]=0.0022}
local f = 1
local function top(target)
  local need = target - s:status().water
  if need > 0 then local p={} for k,v in pairs(base) do p[k]=v*need*f end; s:load{water=need, pigments=p} end
end
for row=0,6 do
  f = 1 - row*0.11
  local y = 10 + row*31
  for x=770, 1180, 30 do
    top(3)
    s:stroke({{x,y},{x+34,y-1}}, {pressure=0.5, duration=0.03})
  end
end
local L = brush{name="sky_wisp", width=30}
local function tl(x0,y0,x1,y1,wat,bend)
  L:load{water=wat}
  local pts = {}
  for i=0,10 do local t=i/10; pts[#pts+1]={x0+(x1-x0)*t, y0+(y1-y0)*t - math.sin(t*3.1)*(bend or 6), 0.12+0.45*math.sin(t*math.pi)} end
  L:lift(pts, {duration=0.25})
end
tl(800,140,1050,112,2,5)
tl(960,180,1190,160,2,3)
tl(1020,80,1190,62,1.6,3)
tl(860,90,960,80,1.2,2)
wait(12)
print(balance().dry)



-- Campaign 2: lower sky haze, distant ridge, hazy plain (rows of short topped-up segments over light pre-wet)
for gy=0,3 do for gx=0,7 do drop{x=500+gx*100+(gy%2)*45, y=280+gy*80, water=4, radius=75} end end
local s = brush{name="haze_rows", width=46}
local mix, f
local function top(target)
  local need = target - s:status().water
  if need > 0 then local p={} for k,v in pairs(mix) do p[k]=v*need*f end; s:load{water=need, pigments=p} end
end
local function row(y, x0, x1, ywob)
  for x=x0, x1, 30 do
    top(3)
    local yy = y + (ywob and ywob(x) or 0)
    s:stroke({{x,yy},{x+34,yy}}, {pressure=0.5, duration=0.03})
  end
end
-- pale lower sky
mix = {["cobalt-blue"]=0.004, ["paynes-gray"]=0.002, ["quinacridone-rose"]=0.0004}; f=1
row(272, 470, 860)
row(296, 470, 1180)
-- ridge band
local function ridge(x)
  return 8*math.sin(x/60) + 6*math.sin(x/23+1) - ((x>700 and x<800) and 6 or 0)
end
mix = {["cobalt-blue"]=0.010, ["paynes-gray"]=0.006, ["quinacridone-rose"]=0.001, ["terre-verte"]=0.002}; f=1
row(328, 480, 1180, ridge)
-- plain rows, hazy gray-green, slowly greener
local rows = {
 {356, {["cobalt-blue"]=0.006,["paynes-gray"]=0.004,["terre-verte"]=0.006}},
 {384, {["cobalt-blue"]=0.005,["paynes-gray"]=0.004,["terre-verte"]=0.009,["yellow-ochre"]=0.001}},
 {412, {["cobalt-blue"]=0.005,["paynes-gray"]=0.004,["terre-verte"]=0.012,["yellow-ochre"]=0.002}},
 {440, {["cobalt-blue"]=0.005,["paynes-gray"]=0.004,["terre-verte"]=0.016,["yellow-ochre"]=0.003}},
 {468, {["cobalt-blue"]=0.006,["paynes-gray"]=0.004,["terre-verte"]=0.02,["sap-green"]=0.004}},
 {496, {["cobalt-blue"]=0.006,["paynes-gray"]=0.004,["terre-verte"]=0.022,["sap-green"]=0.006}},
}
for _,r in ipairs(rows) do
  mix = r[2]; f = 1
  local x0 = 480
  if r[1] > 440 then x0 = 700 + (r[1]-450) end
  row(r[1], x0, 1180)
end
-- nearer hill on the left, darker blue-grey, into the wet
local h = brush{name="near_hill", width=30}
h:load{water=6, pigments={["cobalt-blue"]=0.06, ["paynes-gray"]=0.04, ["terre-verte"]=0.03}}
h:stroke({{490,372},{530,362},{570,360},{610,366},{650,376},{690,386}}, {pressure=0.5, duration=0.15})
print(clock())
wait(15)
print(balance().dry)



-- Campaign 2b: mountain silhouette, near hill, stronger plain
for gy=0,2 do for gx=0,7 do drop{x=500+gx*100+(gy%2)*45, y=330+gy*80, water=4, radius=75} end end
local ridgeP = {{470,342},{502,339},{545,335},{590,330},{635,327},{679,323},{720,318},{755,316},{780,320},{797,322},{830,326},{856,325},{885,321},{915,319},{945,316},{974,314},{1005,318},{1033,322},{1080,325},{1121,327},{1150,329},{1190,331}}
local function ry(x)
  for i=1,#ridgeP-1 do local a,b = ridgeP[i], ridgeP[i+1]
    if x>=a[1] and x<=b[1] then return a[2]+(b[2]-a[2])*(x-a[1])/(b[1]-a[1]) end end
  return 330
end
local m = brush{name="mtn_strokes", width=28}
local mix = {["cobalt-blue"]=0.016, ["paynes-gray"]=0.010, ["quinacridone-rose"]=0.0015, ["terre-verte"]=0.004}
local function top(b, mx, target, f)
  local need = target - b:status().water
  if need > 0 then local p={} for k,v in pairs(mx) do p[k]=v*need*(f or 1) end; b:load{water=need, pigments=p} end
end
for x=478, 1185, 20 do
  top(m, mix, 2.5)
  local y0 = ry(x) + 3 + math.sin(x*0.37)*2
  m:stroke({{x,y0,0.45},{x+4,y0+18,0.5},{x+2,360,0.2}}, {duration=0.04})
end
-- near hill below the earlier hard stroke
local h = brush{name="near_hill2", width=26}
local hm = {["cobalt-blue"]=0.022, ["paynes-gray"]=0.016, ["terre-verte"]=0.01, ["quinacridone-rose"]=0.001}
for x=490, 690, 18 do
  top(h, hm, 2.2)
  local yt = 372 - 10*math.sin((x-480)/210*math.pi)
  h:stroke({{x,yt},{x+3,yt+14},{x+1,398,0.2}}, {duration=0.04})
end
-- plain: gray-green rows getting greener downward
local s = brush{name="plain_rows", width=44}
local rows = {
 {384, {["paynes-gray"]=0.006,["terre-verte"]=0.014,["cobalt-blue"]=0.004}, 0.8},
 {410, {["paynes-gray"]=0.006,["terre-verte"]=0.02,["cobalt-blue"]=0.004,["yellow-ochre"]=0.002}, 0.9},
 {436, {["paynes-gray"]=0.006,["terre-verte"]=0.024,["sap-green"]=0.006,["cobalt-blue"]=0.004}, 1},
 {462, {["paynes-gray"]=0.007,["terre-verte"]=0.026,["sap-green"]=0.010,["cobalt-blue"]=0.004}, 1},
 {488, {["paynes-gray"]=0.008,["terre-verte"]=0.028,["sap-green"]=0.014,["cobalt-blue"]=0.004}, 1},
 {512, {["paynes-gray"]=0.009,["terre-verte"]=0.03,["sap-green"]=0.018,["cobalt-blue"]=0.004}, 1},
}
for _,r in ipairs(rows) do
  local x0 = 640
  if r[1] > 440 then x0 = 700 + (r[1]-450) end
  for x=x0, 1180, 30 do
    -- leave the hazy town area lighter
    local f = r[3]
    if r[1] < 420 and x > 830 and x < 1110 then f = f*0.55 end
    top(s, r[2], 3, f)
    s:stroke({{x,r[1]},{x+34,r[1]+(math.sin(x*0.05))}}, {pressure=0.5, duration=0.03})
  end
end
print(clock())
wait(15)
print(balance().dry)



local ridgeP = {{470,340},{502,337},{545,332},{590,327},{635,323},{679,318},{720,312},{755,309},{780,313},{797,316},{830,320},{856,319},{885,315},{915,313},{945,310},{974,308},{1005,312},{1033,317},{1080,320},{1121,323},{1150,325},{1190,327}}
local function ry(x)
  for i=1,#ridgeP-1 do local a,b = ridgeP[i], ridgeP[i+1]
    if x>=a[1] and x<=b[1] then return a[2]+(b[2]-a[2])*(x-a[1])/(b[1]-a[1]) end end
  return 327
end
local m = brush{name="ridge_v", width=16}
local mix = {["cobalt-blue"]=0.045, ["paynes-gray"]=0.03, ["quinacridone-rose"]=0.004, ["terre-verte"]=0.01}
local function top(b, mx, target)
  local need = target - b:status().water
  if need > 0 then local p={} for k,v in pairs(mx) do p[k]=v*need end; b:load{water=need, pigments=p} end
end
for x=470,1188,10 do
  top(m, mix, 1.2)
  local y1 = ry(x) + 3*math.sin(x/13) + 2*math.sin(x/5.3)
  m:stroke({{x,y1,0.5},{x+3,y1+14,0.45},{x+5,y1+32,0.15}}, {duration=0.03})
end
-- left nearer hill, darker, over the old hard stroke
local h = brush{name="hill_v", width=16}
local hm = {["cobalt-blue"]=0.06, ["paynes-gray"]=0.045, ["terre-verte"]=0.025, ["quinacridone-rose"]=0.003}
for x=466,700,9 do
  top(h, hm, 1.3)
  local t = (x-466)/234
  local yt = 362 - 16*math.sin(t*math.pi*0.85) + 3*math.sin(x/9)
  h:stroke({{x,yt,0.5},{x+3,yt+16,0.45},{x+6,yt+38,0.15}}, {duration=0.03})
end
wait(12)
print(balance().dry)



-- Campaign 3: valley floor greens, deepening down & right
local function xl(y) if y < 452 then return 575 else return 714 + (y-460)*1.2 end end
for gy=0,3 do for gx=0,6 do
  local x = 620+gx*95+(gy%2)*45; local y = 400+gy*85
  if x > xl(y) - 20 then drop{x=x, y=y, water=4, radius=72} end
end end
local s = brush{name="valley_rows", width=44}
local function top(mx, target, f)
  local need = target - s:status().water
  if need > 0 then local p={} for k,v in pairs(mx) do p[k]=v*need*(f or 1) end; s:load{water=need, pigments=p} end
end
local y = 392
while y <= 700 do
  local t = (y-392)/308
  local mx = {["paynes-gray"]=0.012+0.012*t, ["terre-verte"]=0.03+0.02*t, ["sap-green"]=0.02+0.05*t, ["cobalt-blue"]=0.008*(1-t), ["hookers-green"]=0.012*t}
  local x0 = xl(y)
  for x=x0, 1180, 30 do
    local f = 1
    if y < 418 and x > 780 and x < 1110 then f = 0.5 end
    top(mx, 3, f)
    s:stroke({{x,y},{x+34,y+math.sin(x*0.05)}}, {pressure=0.5, duration=0.03})
  end
  y = y + 26
end
print(clock())
wait(15)
print(balance().dry)



-- haze glaze near the horizon + fill lower right
for gx=0,6 do drop{x=600+gx*95, y=375, water=4, radius=70} end
local s = brush{name="haze_glaze", width=40}
local function top(b, mx, target, f)
  local need = target - b:status().water
  if need > 0 then local p={} for k,v in pairs(mx) do p[k]=v*need*(f or 1) end; b:load{water=need, pigments=p} end
end
local mx = {["buff-titanium"]=0.05, ["cobalt-blue"]=0.014, ["paynes-gray"]=0.003, ["quinacridone-rose"]=0.001}
for i,y in ipairs({350, 374, 398, 420}) do
  local f = ({1, 0.85, 0.6, 0.35})[i]
  for x=565, 1180, 30 do top(s, mx, 3, f); s:stroke({{x,y},{x+34,y}},{pressure=0.5,duration=0.03}) end
end
wait(15)
-- lower right fill
local g = brush{name="valley_fill", width=44}
local gm = {["paynes-gray"]=0.02, ["terre-verte"]=0.045, ["sap-green"]=0.06, ["hookers-green"]=0.012}
for y=530,700,26 do for x=1080,1180,30 do top(g, gm, 3); g:stroke({{x,y},{x+34,y}},{pressure=0.5,duration=0.03}) end end
wait(15)
print(balance().dry)



-- Campaign 4: soil base, slope and trail
local function interp(P, x)
  if x <= P[1][1] then return P[1][2] end
  for i=1,#P-1 do local a,b=P[i],P[i+1]
    if x>=a[1] and x<=b[1] then return a[2]+(b[2]-a[2])*(x-a[1])/(b[1]-a[1]) end end
  return P[#P][2]
end
local topP = {{0,226},{90,250},{177,278},{250,305},{319,332},{360,360},{400,382},{450,404},{500,420},{540,438},{584,448},{650,452},{714,456}}
local function trailR(y) return 714 + math.max(0,(y-456))*1.18 end
local function top(b, mx, target, f)
  local need = target - b:status().water
  if need > 0 then local p={} for k,v in pairs(mx) do p[k]=v*need*(f or 1) end; b:load{water=need, pigments=p} end
end
local mx = {["burnt-umber"]=0.04, ["indian-red"]=0.02, ["sepia"]=0.01, ["french-ultramarine"]=0.01}
local b = brush{name="soil_base", width=44}
-- shade factor: darker on the left slope, lighter on the trail
local function shade(x,y)
  local d = (x - (380 + (y-450)*-0.6))  -- distance right of a diagonal shadow line
  local f = 1.75
  if d > 0 then f = 1.75 - math.min(0.8, d/220*0.8) end
  if y < 470 and x > 540 then f = f*0.9 end
  return f
end
-- band by band: prewet just ahead, then rows (diagonal, following the hillside)
local n = 0
local yb = 200
while yb < 760 do
  for x=20, 1000, 105 do
    local yy = yb + 50 + x*0.3
    if yy > interp(topP,x)+20 and x < trailR(yy) - 20 and yy < 690 then drop{x=x, y=yy, water=4, radius=70} end
  end
  for r=0,3 do
    local yr = yb + r*26
    for x=-20, 1010, 28 do
      n = n + 1
      local y = yr + x*0.3 + math.sin(n*1.7)*4
      local y2 = y + 9 + math.sin(n)*4
      if y > interp(topP, x) - 6 and x < trailR(y) and y < 720 then
        top(b, mx, 2.5, shade(x,y))
        b:stroke({{x,y},{x+32,y2}}, {pressure=0.5, duration=0.03})
      end
    end
  end
  yb = yb + 104
end
-- y extends: slope rows start high on left and go down-right; with x*0.3 offset, start yb low enough
print(n, clock())
wait(15)
print(balance().dry)



-- Campaign 5a: cool/darken the shaded slope; leave the lit trail centre
local function interp(P, x)
  if x <= P[1][1] then return P[1][2] end
  for i=1,#P-1 do local a,b=P[i],P[i+1]
    if x>=a[1] and x<=b[1] then return a[2]+(b[2]-a[2])*(x-a[1])/(b[1]-a[1]) end end
  return P[#P][2]
end
local topP = {{0,226},{90,250},{177,278},{250,305},{319,332},{360,360},{400,382},{450,404},{500,420},{540,438},{584,448},{650,452},{714,456}}
local function trailR(y) return 714 + math.max(0,(y-456))*1.18 end
local function top(b, mx, target, f)
  local need = target - b:status().water
  if need > 0 then local p={} for k,v in pairs(mx) do p[k]=v*need*(f or 1) end; b:load{water=need, pigments=p} end
end
local mx = {["french-ultramarine"]=0.014, ["burnt-umber"]=0.012, ["sepia"]=0.004}
local function dark(x,y)
  -- distance from lit trail centre, elongated along the trail
  local dx, dy = (x-700)/260, (y-580)/150
  local d = math.sqrt(dx*dx+dy*dy)
  local f = math.min(1.2, math.max(0, (d-0.55)*1.1))
  -- extra on the upper slope / under the rocks
  if y < 0.55*x + 260 then f = f + 0.0 end
  if x > 400 and x < 640 and y > 440 and y < 530 then f = f + 0.5 end
  return f
end
local b = brush{name="slope_cool", width=44}
local n = 0
for r=0,22 do
  local yr = 180 + r*24
  for x=-20, 1050, 28 do
    n = n + 1
    local y = yr + x*0.28 + math.sin(n*1.3)*4
    if y > interp(topP, x) - 4 and x < trailR(y) - 10 and y < 715 then
      local f = dark(x,y)
      if f > 0.12 then
        top(b, mx, 2.5, f)
        b:stroke({{x,y},{x+32,y+8+math.sin(n)*3}}, {pressure=0.5, duration=0.03})
      end
    end
  end
end
wait(15)
print(balance().dry)



-- Campaign 5b: dusty veils - pale on the lit trail, greyed on the slope
local function interp(P, x)
  if x <= P[1][1] then return P[1][2] end
  for i=1,#P-1 do local a,b=P[i],P[i+1]
    if x>=a[1] and x<=b[1] then return a[2]+(b[2]-a[2])*(x-a[1])/(b[1]-a[1]) end end
  return P[#P][2]
end
local topP = {{0,226},{90,250},{177,278},{250,305},{319,332},{360,360},{400,382},{450,404},{500,420},{540,438},{584,448},{650,452},{714,456}}
local function trailR(y) return 714 + math.max(0,(y-456))*1.18 end
local function top(b, mx, target, f)
  local need = target - b:status().water
  if need > 0 then local p={} for k,v in pairs(mx) do p[k]=v*need*(f or 1) end; b:load{water=need, pigments=p} end
end
local lit = {["buff-titanium"]=0.07, ["raw-umber"]=0.01, ["indian-red"]=0.008}
local slope = {["buff-titanium"]=0.04, ["french-ultramarine"]=0.008, ["raw-umber"]=0.008}
local function litf(x,y)
  -- along-trail axis from (640,470) to (900,700)
  local ax, ay = 260, 230
  local L = math.sqrt(ax*ax+ay*ay)
  local u = ((x-640)*ax + (y-470)*ay)/L/L
  local v = ((x-640)*(-ay) + (y-470)*ax)/L/ 140
  local w = 1 - math.abs(v)
  if u < -0.1 then w = w - (-0.1-u)*3 end
  return math.max(0, math.min(1, w*1.4))
end
local b1 = brush{name="veil_lit", width=44}
local b2 = brush{name="veil_slope", width=44}
local n=0
for r=0,22 do
  local yr = 180 + r*24
  for x=-20, 1050, 28 do
    n=n+1
    local y = yr + x*0.28 + math.sin(n*1.1)*4
    if y > interp(topP, x) - 4 and x < trailR(y) - 4 and y < 715 then
      local lf = litf(x,y)
      local seg = {{x,y},{x+32,y+8+math.sin(n)*3}}
      if lf > 0.1 then
        top(b1, lit, 3, 0.4 + 0.8*lf)
        b1:stroke(seg, {pressure=0.5, duration=0.03})
      else
        top(b2, slope, 3, 1)
        b2:stroke(seg, {pressure=0.5, duration=0.03})
      end
    end
  end
end
wait(15)
print(balance().dry)



-- Campaign 5c: warm brown glaze back over the slope, stronger to the left and under the rock band
local function interp(P, x)
  if x <= P[1][1] then return P[1][2] end
  for i=1,#P-1 do local a,b=P[i],P[i+1]
    if x>=a[1] and x<=b[1] then return a[2]+(b[2]-a[2])*(x-a[1])/(b[1]-a[1]) end end
  return P[#P][2]
end
local topP = {{0,226},{90,250},{177,278},{250,305},{319,332},{360,360},{400,382},{450,404},{500,420},{540,438},{584,448},{650,452},{714,456}}
local function trailR(y) return 714 + math.max(0,(y-456))*1.18 end
local function top(b, mx, target, f)
  local need = target - b:status().water
  if need > 0 then local p={} for k,v in pairs(mx) do p[k]=v*need*(f or 1) end; b:load{water=need, pigments=p} end
end
local mx = {["burnt-umber"]=0.05, ["indian-red"]=0.02, ["sepia"]=0.012, ["french-ultramarine"]=0.006}
local function litf(x,y)
  local ax, ay = 260, 230
  local L = math.sqrt(ax*ax+ay*ay)
  local u = ((x-640)*ax + (y-470)*ay)/L/L
  local v = ((x-640)*(-ay) + (y-470)*ax)/L/ 150
  local w = 1 - math.abs(v)
  if u < -0.1 then w = w - (-0.1-u)*3 end
  return math.max(0, math.min(1, w*1.4))
end
local b = brush{name="slope_warm", width=40}
local n=0
for r=0,24 do
  local yr = 170 + r*23
  for x=-20, 1050, 27 do
    n=n+1
    local y = yr + x*0.3 + math.sin(n*2.3)*5
    if y > interp(topP, x) - 4 and x < trailR(y) - 6 and y < 715 then
      local f = 1 - litf(x,y)*0.85
      f = f * (1 + math.max(0, (420 - x)/420)*0.4)
      if f > 0.15 then
        top(b, mx, 2.5, f)
        b:stroke({{x,y},{x+31,y+7+math.sin(n*0.7)*4}}, {pressure=0.5, duration=0.03})
      end
    end
  end
end
wait(15)
print(balance().dry)



-- Campaign 6a: tree mass base on the upper-left slope
local function top(b, mx, target, f)
  local need = target - b:status().water
  if need > 0 then local p={} for k,v in pairs(mx) do p[k]=v*need*(f or 1) end; b:load{water=need, pigments=p} end
end
local seed = 2013
local function rnd() seed = (seed*1103515245 + 12345) % 2147483648; return seed/2147483648 end
local function interp(P, x)
  if x <= P[1][1] then return P[1][2] end
  for i=1,#P-1 do local a,b=P[i],P[i+1]
    if x>=a[1] and x<=b[1] then return a[2]+(b[2]-a[2])*(x-a[1])/(b[1]-a[1]) end end
  return P[#P][2]
end
local soil = {{0,226},{90,250},{177,278},{250,305},{319,332},{360,360},{400,382},{450,404},{500,420},{540,438}}
-- silhouette as y -> x boundary (trees left of it)
local sil = {{-10,40},{20,70},{60,105},{100,128},{110,170},{120,205},{135,236},{150,262},{170,290},{190,322},{215,345},{240,368},{262,388},{280,402},{300,410},{330,420},{360,420}}
local function silx(y) return interp(sil, y) end  -- here sil is {y,x}
local function inBoulder(x,y)
  local P = {{178,268},{248,226},{306,238},{334,300},{292,342},{186,334}}
  local c = false
  local j = #P
  for i=1,#P do
    local xi,yi,xj,yj = P[i][1],P[i][2],P[j][1],P[j][2]
    if ((yi>y) ~= (yj>y)) and (x < (xj-xi)*(y-yi)/(yj-yi)+xi) then c = not c end
    j = i
  end
  return c
end
local function inside(x,y)
  -- silhouette given in paper coords as list of points along edge: build function of y
  return y < interp(soil, x) + 4 and not inBoulder(x,y)
end
-- silhouette edge points (x,y) from top-left down to the boulder at right
local edge = {{60,-10},{110,40},{160,100},{236,128},{283,165},{330,195},{378,254},{425,277},{472,330},{500,370},{512,405},{520,430}}
local function edgeY(x) return interp(edge, x) end
local function inTrees(x,y) return y > edgeY(x) and inside(x,y) end
local function mixAt(x,y)
  local lit = math.max(0, math.min(1, (x - 300)/180))  -- bush on the right is lit
  local low = math.max(0, math.min(1, (y - interp(soil,x) + 70)/70)) -- near soil darker
  return {["sap-green"]=0.15, ["hookers-green"]=0.08 + 0.05*low - 0.04*lit, ["green-gold"]=0.02 + 0.08*lit,
          ["sepia"]=0.015 + 0.02*low, ["french-ultramarine"]=0.015*(1-lit)}
end
local b = brush{name="tree_base", width=30}
local n = 0
for y = -10, 440, 14 do
  for x = 0, 530, 18 do
    local px, py = x + rnd()*12, y + rnd()*10
    if inTrees(px,py) then
      n = n + 1
      local mx = mixAt(px,py)
      local need = 2 - b:status().water
      if need > 0 then local p={} for k,v in pairs(mx) do p[k]=v*need end; b:load{water=need, pigments=p} end
      local a = rnd()*6.28
      b:stroke({{px,py,0.55},{px+math.cos(a)*16, py+math.sin(a)*12,0.3}}, {duration=0.03})
    end
  end
end
-- ragged silhouette: small dabs straddling the edge
local e = brush{name="tree_edge", width=14}
for x=60, 520, 7 do
  local y = edgeY(x)
  local mx = mixAt(x,y)
  local need = 0.8 - e:status().water
  if need > 0 then local p={} for k,v in pairs(mx) do p[k]=v*need end; e:load{water=need, pigments=p} end
  local ox = (rnd()-0.5)*10
  local oy = -rnd()*14
  e:stroke({{x+ox, y+8, 0.5},{x+ox+(rnd()-0.5)*8, y+oy, 0.15}}, {duration=0.03})
end
print(n, clock())
wait(15)
print(balance().dry)



-- Campaign 6b: dark foliage clumps and shadow under the trees
local function interp(P, x)
  if x <= P[1][1] then return P[1][2] end
  for i=1,#P-1 do local a,b=P[i],P[i+1]
    if x>=a[1] and x<=b[1] then return a[2]+(b[2]-a[2])*(x-a[1])/(b[1]-a[1]) end end
  return P[#P][2]
end
local seed = 77
local function rnd() seed = (seed*1103515245 + 12345) % 2147483648; return seed/2147483648 end
local soil = {{0,226},{90,250},{177,278},{250,305},{319,332},{360,360},{400,382},{450,404},{500,420},{540,438}}
local edge = {{60,-10},{110,40},{160,100},{236,128},{283,165},{330,195},{378,254},{425,277},{472,330},{500,370},{512,405},{520,430}}
local function inBoulder(x,y)
  local P = {{178,268},{248,226},{306,238},{334,300},{292,342},{186,334}}
  local c = false; local j = #P
  for i=1,#P do
    local xi,yi,xj,yj = P[i][1],P[i][2],P[j][1],P[j][2]
    if ((yi>y) ~= (yj>y)) and (x < (xj-xi)*(y-yi)/(yj-yi)+xi) then c = not c end
    j = i
  end
  return c
end
local function inTrees(x,y) return y > interp(edge,x)+6 and y < interp(soil,x) and not inBoulder(x,y) end
local dark = {["hookers-green"]=0.2, ["sepia"]=0.06, ["french-ultramarine"]=0.04}
local d = brush{name="tree_dark", width=18}
local function dab(x,y)
  local need = 1.1 - d:status().water
  if need > 0 then local p={} for k,v in pairs(dark) do p[k]=v*need end; d:load{water=need, pigments=p} end
  d:stroke({{x-8,y,0.3},{x,y+4,0.6},{x+9,y+2,0.3}}, {duration=0.03})
end
-- clumps: centres chosen across the mass, denser low and left
local placed = 0
for i=1,400 do
  local cx = rnd()*520; local cy = rnd()*440
  if inTrees(cx,cy) then
    local depth = (cy - interp(edge,cx)) / math.max(30, interp(soil,cx) - interp(edge,cx))
    local litx = cx > 330 and cy < 400
    local prob = 0.25 + 0.6*depth - (litx and 0.3 or 0)
    if rnd() < prob and placed < 46 then
      placed = placed + 1
      -- clump: crescent of dabs forming the shaded underside of a foliage mass
      for k=1,7 do
        local x = cx + (rnd()-0.5)*44; local y = cy + 6 + rnd()*14 - math.abs(x-cx)*0.2
        if inTrees(x,y) then dab(x,y) end
      end
    end
  end
end
-- the shadow band along the soil line
for x=0, 520, 12 do
  local y = interp(soil,x) - 10 - rnd()*14
  if inTrees(x,y) then dab(x,y) end
end
print(placed)
wait(15)
print(balance().dry)



-- Campaign 6c: mid-tone foliage to integrate clumps; boulder
local function interp(P, x)
  if x <= P[1][1] then return P[1][2] end
  for i=1,#P-1 do local a,b=P[i],P[i+1]
    if x>=a[1] and x<=b[1] then return a[2]+(b[2]-a[2])*(x-a[1])/(b[1]-a[1]) end end
  return P[#P][2]
end
local seed = 991
local function rnd() seed = (seed*1103515245 + 12345) % 2147483648; return seed/2147483648 end
local soil = {{0,226},{90,250},{177,278},{250,305},{319,332},{360,360},{400,382},{450,404},{500,420},{540,438}}
local edge = {{60,-10},{110,40},{160,100},{236,128},{283,165},{330,195},{378,254},{425,277},{472,330},{500,370},{512,405},{520,430}}
local BP = {{178,268},{248,226},{306,238},{334,300},{292,342},{186,334}}
local function inPoly(P,x,y)
  local c = false; local j = #P
  for i=1,#P do
    local xi,yi,xj,yj = P[i][1],P[i][2],P[j][1],P[j][2]
    if ((yi>y) ~= (yj>y)) and (x < (xj-xi)*(y-yi)/(yj-yi)+xi) then c = not c end
    j = i
  end
  return c
end
local function inTrees(x,y) return y > interp(edge,x)+4 and y < interp(soil,x) and not inPoly(BP,x,y) end
local midm = {["sap-green"]=0.14, ["hookers-green"]=0.09, ["burnt-umber"]=0.015, ["french-ultramarine"]=0.01}
local m = brush{name="tree_mid", width=16}
for i=1,520 do
  local x = rnd()*520; local y = rnd()*440
  if inTrees(x,y) then
    local need = 0.9 - m:status().water
    if need > 0 then local p={} for k,v in pairs(midm) do p[k]=v*need end; m:load{water=need, pigments=p} end
    local a = rnd()*6.28
    m:stroke({{x,y,0.5},{x+math.cos(a)*9, y+3+math.sin(a)*5,0.25}}, {duration=0.03})
  end
end
-- boulder: grey body, cooler shadow side lower-left
local rb = brush{name="boulder", width=22}
local rock = {["french-ultramarine"]=0.03, ["burnt-umber"]=0.025, ["paynes-gray"]=0.012, ["buff-titanium"]=0.03}
for y=232, 340, 14 do
  for x=180, 336, 20 do
    local px, py = x + rnd()*6, y + rnd()*6
    if inPoly(BP, px, py) then
      local f = 1 + math.max(0, (px-250))/80*-0.3 + math.max(0,(py-280))/60*0.6
      local need = 1.6 - rb:status().water
      if need > 0 then local p={} for k,v in pairs(rock) do p[k]=v*need*f end; rb:load{water=need, pigments=p} end
      rb:stroke({{px,py},{px+16,py+4}}, {pressure=0.5, duration=0.03})
    end
  end
end
wait(15)
print(balance().dry)



local seed = 4242
local function rnd() seed = (seed*1103515245 + 12345) % 2147483648; return seed/2147483648 end
local BP = {{178,268},{248,226},{306,238},{334,300},{292,342},{186,334}}
local function inPoly(P,x,y)
  local c = false; local j = #P
  for i=1,#P do
    local xi,yi,xj,yj = P[i][1],P[i][2],P[j][1],P[j][2]
    if ((yi>y) ~= (yj>y)) and (x < (xj-xi)*(y-yi)/(yj-yi)+xi) then c = not c end
    j = i
  end
  return c
end
-- mid grey over the body, leaving the top-right facets light
local g = brush{name="boulder_mid", width=16}
local gm = {["french-ultramarine"]=0.05, ["burnt-umber"]=0.04, ["paynes-gray"]=0.025}
for i=1,90 do
  local x = 180 + rnd()*155; local y = 228 + rnd()*115
  local lit = (y < 270 and x > 225)
  if inPoly(BP,x,y) and not lit then
    local need = 1.0 - g:status().water
    if need > 0 then local p={} for k,v in pairs(gm) do p[k]=v*need end; g:load{water=need, pigments=p} end
    g:stroke({{x,y,0.5},{x+12,y+2+rnd()*4,0.35}}, {duration=0.03})
  end
end
-- dark crevices and underside
local d = brush{name="boulder_dark", width=7}
local dm = {["sepia"]=0.12, ["french-ultramarine"]=0.08, ["paynes-gray"]=0.04}
local lines = {
 {{186,334},{230,338},{292,342},{318,322}},
 {{205,300},{240,292},{262,300}},
 {{250,262},{265,285},{270,318}},
 {{190,276},{215,268}},
 {{300,280},{318,300}},
}
for _,L in ipairs(lines) do
  local need = 1.0 - d:status().water
  if need > 0 then local p={} for k,v in pairs(dm) do p[k]=v*need end; d:load{water=need, pigments=p} end
  d:stroke(L, {pressure=0.5, duration=0.1})
end
wait(15)
print(balance().dry)



-- Campaign 7: pale cloudy sky behind the trees
local function interp(P, x)
  if x <= P[1][1] then return P[1][2] end
  for i=1,#P-1 do local a,b=P[i],P[i+1]
    if x>=a[1] and x<=b[1] then return a[2]+(b[2]-a[2])*(x-a[1])/(b[1]-a[1]) end end
  return P[#P][2]
end
local edge = {{60,-10},{110,40},{160,100},{236,128},{283,165},{330,195},{378,254},{425,277},{472,330},{500,370},{512,405},{520,430}}
for gy=0,3 do for gx=0,3 do
  local x, y = 160+gx*95+(gy%2)*40, 30+gy*85
  if y < interp(edge,x) - 30 then drop{x=x, y=y, water=4, radius=70} end
end end
local s = brush{name="cloud_gray", width=40}
local warm = {["paynes-gray"]=0.006, ["cobalt-blue"]=0.006, ["buff-titanium"]=0.02, ["quinacridone-rose"]=0.0006}
local blue = {["cobalt-blue"]=0.03, ["french-ultramarine"]=0.015, ["burnt-sienna"]=0.004}
local function top(mx, target, f)
  local need = target - s:status().water
  if need > 0 then local p={} for k,v in pairs(mx) do p[k]=v*need*(f or 1) end; s:load{water=need, pigments=p} end
end
for r=0,12 do
  local y = 6 + r*26
  for x=60, 500, 28 do
    if y < interp(edge, x+16) + 2 then
      -- clouds: lighter tops, greyer bellies; bluer toward the right edge where it meets the wash
      local f = 0.6 + 0.6*math.max(0, math.sin((y-20)/60))
      local mx = warm
      if x > 420 then mx = blue; f = 0.8 end
      top(mx, 2.5, f)
      s:stroke({{x,y},{x+30,y-2}}, {pressure=0.5, duration=0.03})
    end
  end
end
-- lift a few bright cloud tops
local L = brush{name="cloud_lift", width=36}
for _,p in ipairs({{{150,40,0.2},{230,30,0.5},{320,40,0.2}}, {{230,120,0.2},{300,110,0.5},{380,125,0.2}}, {{330,215,0.2},{400,205,0.45},{450,225,0.2}}}) do
  L:load{water=2}; L:lift(p, {duration=0.25})
end
wait(15)
print(balance().dry)



-- Campaign 8a: foreground value - darken lower-left & slope under trees, keep trail light
local function interp(P, x)
  if x <= P[1][1] then return P[1][2] end
  for i=1,#P-1 do local a,b=P[i],P[i+1]
    if x>=a[1] and x<=b[1] then return a[2]+(b[2]-a[2])*(x-a[1])/(b[1]-a[1]) end end
  return P[#P][2]
end
local topP = {{0,226},{90,250},{177,278},{250,305},{319,332},{360,360},{400,382},{450,404},{500,420},{540,438},{584,448},{650,452},{714,456}}
local function trailR(y) return 714 + math.max(0,(y-456))*1.18 end
local seed = 5150
local function rnd() seed = (seed*1103515245 + 12345) % 2147483648; return seed/2147483648 end
local mx = {["burnt-umber"]=0.03, ["french-ultramarine"]=0.016, ["sepia"]=0.012, ["indian-red"]=0.006}
local b = brush{name="fg_dark", width=40}
local function amt(x,y)
  -- trail light axis from (620,460) to (930,700)
  local ax, ay = 310, 240
  local L = math.sqrt(ax*ax+ay*ay)
  local v = ((x-620)*(-ay) + (y-460)*ax)/L   -- signed distance; negative = right side
  local f = math.max(0, math.min(1, (v - 90)/200))
  -- also shade just under the tree line
  local under = math.max(0, 1 - (y - interp(topP,x))/60)
  return math.max(f, under*0.8)
end
local n=0
for r=0,24 do
  local yr = 170 + r*23
  for x=-20, 1000, 27 do
    n=n+1
    local y = yr + x*0.3 + math.sin(n*2.1)*5
    if y > interp(topP, x) - 2 and x < trailR(y) and y < 715 then
      local f = amt(x,y)
      if f > 0.1 then
        local need = 2.5 - b:status().water
        if need > 0 then local p={} for k,v in pairs(mx) do p[k]=v*need*f end; b:load{water=need, pigments=p} end
        b:stroke({{x,y},{x+31,y+7+math.sin(n*0.7)*4}}, {pressure=0.5, duration=0.03})
      end
    end
  end
end
wait(15)
print(balance().dry)



-- Campaign 9: horizon haze over the left blue block; woodland patches in the plain
local seed = 31337
local function rnd() seed = (seed*1103515245 + 12345) % 2147483648; return seed/2147483648 end
local function top(b, mx, target, f)
  local need = target - b:status().water
  if need > 0 then local p={} for k,v in pairs(mx) do p[k]=v*need*(f or 1) end; b:load{water=need, pigments=p} end
end
local hz = brush{name="haze2", width=40}
local hm = {["buff-titanium"]=0.06, ["cobalt-blue"]=0.012, ["terre-verte"]=0.006, ["paynes-gray"]=0.002}
for i,y in ipairs({342, 362, 384, 406}) do
  for x=500, 800, 28 do
    local f = ({0.8, 1, 0.9, 0.6})[i] * math.max(0.3, 1 - math.max(0, x-700)/120)
    top(hz, hm, 2.5, f)
    hz:stroke({{x,y},{x+32,y+1}}, {pressure=0.5, duration=0.03})
  end
end
wait(12)
-- woodland patches
local w = brush{name="woods", width=14}
local wm = {["hookers-green"]=0.05, ["terre-verte"]=0.05, ["paynes-gray"]=0.025, ["cobalt-blue"]=0.01}
local function patch(cx, cy, len, h, f)
  local n = math.max(2, math.floor(len/10))
  for k=0,n do
    top(w, wm, 0.8, f)
    local x = cx - len/2 + k*len/n + (rnd()-0.5)*6
    local y = cy + (rnd()-0.5)*h
    w:stroke({{x,y,0.5},{x+12,y+(rnd()-0.5)*3,0.4}}, {duration=0.03})
  end
end
for i=1,26 do
  local y = 395 + rnd()*300
  local x = 730 + rnd()*450
  local xl = 714 + math.max(0,(y-456))*1.18 + 30
  if x > xl then
    local depth = (y-395)/300
    patch(x, y, 30 + 80*depth*rnd() + 20, 3 + 8*depth, 0.6 + 0.6*depth)
  end
end
wait(15)
print(balance().dry)



-- Campaign 10: desaturating veil over the soil (trial: ultramarine/paynes + buff over soil base on scratch)
local function interp(P, x)
  if x <= P[1][1] then return P[1][2] end
  for i=1,#P-1 do local a,b=P[i],P[i+1]
    if x>=a[1] and x<=b[1] then return a[2]+(b[2]-a[2])*(x-a[1])/(b[1]-a[1]) end end
  return P[#P][2]
end
local topP = {{0,226},{90,250},{177,278},{250,305},{319,332},{360,360},{400,382},{450,404},{500,420},{540,438},{584,448},{650,452},{714,456}}
local function trailR(y) return 714 + math.max(0,(y-456))*1.18 end
local function litf(x,y)
  local ax, ay = 300, 240
  local L = math.sqrt(ax*ax+ay*ay)
  local u = ((x-630)*ax + (y-465)*ay)/L/L
  local v = ((x-630)*(-ay) + (y-465)*ax)/L/ 160
  local w = 1 - math.abs(v)
  if u < -0.1 then w = w - (-0.1-u)*3 end
  return math.max(0, math.min(1, w*1.3))
end
local shadeM = {["french-ultramarine"]=0.013, ["paynes-gray"]=0.005, ["buff-titanium"]=0.03}
local litM = {["buff-titanium"]=0.06, ["french-ultramarine"]=0.006, ["paynes-gray"]=0.002, ["raw-umber"]=0.006}
local b1 = brush{name="veil2_shade", width=40}
local b2 = brush{name="veil2_lit", width=40}
local n=0
for r=0,24 do
  local yr = 170 + r*23
  for x=-20, 1050, 28 do
    n=n+1
    local y = yr + x*0.29 + math.sin(n*1.9)*5
    if y > interp(topP, x) - 2 and x < trailR(y) - 2 and y < 715 then
      local lf = litf(x,y)
      local seg = {{x,y},{x+32,y+6+math.sin(n*0.8)*4}}
      local b, mx = b1, shadeM
      if lf > 0.35 then b, mx = b2, litM end
      local need = 2.5 - b:status().water
      if need > 0 then local p={} for k,v in pairs(mx) do p[k]=v*need end; b:load{water=need, pigments=p} end
      b:stroke(seg, {pressure=0.5, duration=0.03})
    end
  end
end
wait(15)
print(balance().dry)



-- Campaign 11: warm volcanic glaze, random-oriented strokes to break the row pattern
local function interp(P, x)
  if x <= P[1][1] then return P[1][2] end
  for i=1,#P-1 do local a,b=P[i],P[i+1]
    if x>=a[1] and x<=b[1] then return a[2]+(b[2]-a[2])*(x-a[1])/(b[1]-a[1]) end end
  return P[#P][2]
end
local topP = {{0,226},{90,250},{177,278},{250,305},{319,332},{360,360},{400,382},{450,404},{500,420},{540,438},{584,448},{650,452},{714,456}}
local function trailR(y) return 714 + math.max(0,(y-456))*1.18 end
local seed = 8080
local function rnd() seed = (seed*1103515245 + 12345) % 2147483648; return seed/2147483648 end
local function litf(x,y)
  local ax, ay = 300, 240
  local L = math.sqrt(ax*ax+ay*ay)
  local u = ((x-630)*ax + (y-465)*ay)/L/L
  local v = ((x-630)*(-ay) + (y-465)*ax)/L/ 170
  local w = 1 - math.abs(v)
  if u < -0.1 then w = w - (-0.1-u)*3 end
  return math.max(0, math.min(1, w*1.3))
end
local mx = {["indian-red"]=0.015, ["burnt-umber"]=0.02}
local b = brush{name="soil_glaze_warm", width=34}
local n = 0
for k=1,900 do
  local x = -20 + rnd()*1020; local y = 215 + rnd()*500
  if y > interp(topP, x) + 4 and x < trailR(y) - 12 and y < 720 then
    n = n + 1
    local f = 1.15 - 0.55*litf(x,y)
    if x < 300 and y > 500 then f = f + 0.25 end
    local need = 2 - b:status().water
    if need > 0 then local p={} for kk,v in pairs(mx) do p[kk]=v*need*f end; b:load{water=need, pigments=p} end
    local a = (rnd()-0.5)*1.0 + 0.35
    b:stroke({{x,y,0.55},{x+math.cos(a)*30, y+math.sin(a)*24,0.35}}, {duration=0.03})
  end
end
print(n)
wait(15)
print(balance().dry)



-- Campaign 12: unify soil: prewet bands; neutral-brown glaze on slope, light buff veil on trail
local function interp(P, x)
  if x <= P[1][1] then return P[1][2] end
  for i=1,#P-1 do local a,b=P[i],P[i+1]
    if x>=a[1] and x<=b[1] then return a[2]+(b[2]-a[2])*(x-a[1])/(b[1]-a[1]) end end
  return P[#P][2]
end
local topP = {{0,226},{90,250},{177,278},{250,305},{319,332},{360,360},{400,382},{450,404},{500,420},{540,438},{584,448},{650,452},{714,456}}
local function trailR(y) return 714 + math.max(0,(y-456))*1.18 end
local function litf(x,y)
  local ax, ay = 300, 240
  local L = math.sqrt(ax*ax+ay*ay)
  local u = ((x-640)*ax + (y-470)*ay)/L/L
  local v = ((x-640)*(-ay) + (y-470)*ax)/L/ 150
  local w = 1 - math.abs(v)
  if u < -0.15 then w = w - (-0.15-u)*3 end
  return math.max(0, math.min(1, w*1.5))
end
local am = {["burnt-umber"]=0.02, ["sepia"]=0.006, ["french-ultramarine"]=0.006}
local bm = {["buff-titanium"]=0.05, ["raw-umber"]=0.008, ["indian-red"]=0.006, ["burnt-sienna"]=0.003}
local A = brush{name="soil_unify", width=44}
local B = brush{name="trail_light", width=44}
local function top(b, mx, target, f)
  local need = target - b:status().water
  if need > 0 then local p={} for k,v in pairs(mx) do p[k]=v*need*(f or 1) end; b:load{water=need, pigments=p} end
end
local function ok(x,y) return y > interp(topP, x) + 2 and x < trailR(y) - 6 and y < 720 end
local n = 0
for band=0,6 do
  local yb = 150 + band*96
  -- prewet this band
  for x=0, 1000, 95 do
    local y = yb + 48 + x*0.29
    if y > interp(topP,x)+55 and x < trailR(y)-60 and y < 690 then drop{x=x, y=y, water=4, radius=55} end
  end
  for r=0,3 do
    local yr = yb + r*24
    for x=-20, 1010, 30 do
      local y = yr + x*0.29
      if ok(x,y) and ok(x+30,y+9) then
        n = n + 1
        local lf = litf(x,y)
        local seg = {{x,y},{x+34,y+10}}
        if lf > 0.4 then
          top(B, bm, 3, 0.6 + 0.6*lf)
          B:stroke(seg, {pressure=0.5, duration=0.03})
        else
          local f = 1.0 - lf
          if x < 300 and y > 520 then f = f + 0.3 end
          top(A, am, 3, f)
          A:stroke(seg, {pressure=0.5, duration=0.03})
        end
      end
    end
  end
end
print(n)
wait(15)
print(balance().dry)



-- Campaign 13: valley glaze - cooler, darker teal below, hazier above
local function trailR(y) return 714 + math.max(0,(y-456))*1.18 end
local seed = 1313
local function rnd() seed = (seed*1103515245 + 12345) % 2147483648; return seed/2147483648 end
local G = brush{name="valley_glaze", width=44}
local function mixAt(y)
  local t = math.max(0, math.min(1, (y-380)/280))
  return {["cobalt-blue"]=0.012 - 0.004*t, ["paynes-gray"]=0.004 + 0.008*t, ["hookers-green"]=0.002 + 0.012*t,
          ["buff-titanium"]=0.03*(1-t)^2, ["terre-verte"]=0.006*t}
end
local n=0
for band=0,3 do
  local yb = 380 + band*84
  for x=0, 1180, 90 do
    local y = yb + 42
    if x > trailR(y) + 70 then drop{x=x, y=y, water=4, radius=55} end
  end
  for r=0,3 do
    local yr = yb + r*21
    for x=580, 1180, 30 do
      local y = yr + (rnd()-0.5)*6
      if x > trailR(y) + 4 and y < 712 then
        n = n + 1
        local mx = mixAt(y)
        local need = 3 - G:status().water
        if need > 0 then local p={} for k,v in pairs(mx) do p[k]=v*need end; G:load{water=need, pigments=p} end
        G:stroke({{x,y},{x+34,y+(rnd()-0.5)*4}}, {pressure=0.5, duration=0.03})
      end
    end
  end
end
print(n)
wait(15)
print(balance().dry)



-- Campaign 14: lava rocks along the rim; strengthen the shaded wedge
local seed = 1414
local function rnd() seed = (seed*1103515245 + 12345) % 2147483648; return seed/2147483648 end
local function top(b, mx, target, f)
  local need = target - b:status().water
  if need > 0 then local p={} for k,v in pairs(mx) do p[k]=v*need*(f or 1) end; b:load{water=need, pigments=p} end
end
local L = brush{name="rock_light", width=14}
local lm = {["buff-titanium"]=0.10, ["french-ultramarine"]=0.012, ["paynes-gray"]=0.01, ["burnt-umber"]=0.006}
local D = brush{name="rock_dark", width=10}
local dm = {["paynes-gray"]=0.07, ["sepia"]=0.07, ["french-ultramarine"]=0.03}
-- rock positions along the rim line
local rim = {{340,352},{380,372},{420,392},{460,410},{500,424},{540,440},{580,448},{620,452},{660,455},{700,458}}
local function rimY(x)
  for i=1,#rim-1 do local a,b=rim[i],rim[i+1]
    if x>=a[1] and x<=b[1] then return a[2]+(b[2]-a[2])*(x-a[1])/(b[1]-a[1]) end end
  return 458
end
local rocks = {}
for i=1,26 do
  local x = 345 + rnd()*360
  local y = rimY(x) - 6 + rnd()*16
  local w = 10 + rnd()*18
  rocks[#rocks+1] = {x,y,w}
end
for _,r in ipairs(rocks) do
  local x,y,w = r[1],r[2],r[3]
  top(L, lm, 1.0)
  L:stroke({{x-w/2,y,0.45},{x,y-4,0.55},{x+w/2,y+1,0.4}}, {duration=0.03})
end
wait(8)
for _,r in ipairs(rocks) do
  local x,y,w = r[1],r[2],r[3]
  top(D, dm, 0.7)
  D:stroke({{x-w/2,y+5,0.35},{x,y+8,0.5},{x+w/2,y+5,0.3}}, {duration=0.03})
end
-- small scattered stones on the trail
local S = brush{name="stones", width=6}
for i=1,40 do
  local y = 470 + rnd()*230
  local x = 560 + (y-470)*0.9 + rnd()*260
  if x < 714 + (y-456)*1.18 - 15 then
    top(S, dm, 0.3, 0.8)
    S:stroke({{x,y,0.4},{x+4+rnd()*4,y+1,0.3}}, {duration=0.03})
  end
end
wait(15)
print(balance().dry)



-- Campaign 15: soften the shadow/light boundary on the trail
local seed = 1515
local function rnd() seed = (seed*1103515245 + 12345) % 2147483648; return seed/2147483648 end
local function top(b, mx, target, f)
  local need = target - b:status().water
  if need > 0 then local p={} for k,v in pairs(mx) do p[k]=v*need*(f or 1) end; b:load{water=need, pigments=p} end
end
local V = brush{name="trail_veil2", width=30}
local vm = {["buff-titanium"]=0.06, ["raw-umber"]=0.006, ["indian-red"]=0.006, ["burnt-sienna"]=0.003}
-- boundary line: (548,445) -> (585,580) -> (620,700)
local function bx(y) if y < 580 then return 548 + (y-445)*37/135 else return 585 + (y-580)*35/120 end end
for i=1,140 do
  local y = 450 + rnd()*260
  local off = (rnd()^0.7) * 70   -- mostly near the boundary, fading to the left
  local x = bx(y) - off + 10
  local f = 1 - off/80
  top(V, vm, 1.8, f)
  local a = 0.4 + (rnd()-0.5)*0.8
  V:stroke({{x,y,0.5},{x+math.cos(a)*24, y+math.sin(a)*18, 0.3}}, {duration=0.03})
end
-- veil over the dark lump that intrudes into the trail
for i=1,50 do
  local x = 630 + rnd()*100; local y = 610 + rnd()*95
  top(V, vm, 1.8, 1.1)
  local a = 0.4 + (rnd()-0.5)*0.8
  V:stroke({{x,y,0.5},{x+math.cos(a)*24, y+math.sin(a)*18, 0.3}}, {duration=0.03})
end
wait(15)
print(balance().dry)



-- Campaign 16: trail direction strokes to integrate; ruts
local seed = 1616
local function rnd() seed = (seed*1103515245 + 12345) % 2147483648; return seed/2147483648 end
local function top(b, mx, target, f)
  local need = target - b:status().water
  if need > 0 then local p={} for k,v in pairs(mx) do p[k]=v*need*(f or 1) end; b:load{water=need, pigments=p} end
end
local function trailR(y) return 714 + math.max(0,(y-456))*1.18 end
-- warm transparent strokes along the trail's direction (pointing to the rim vanishing area ~ (600,450))
local W = brush{name="trail_dir", width=22}
local wm = {["indian-red"]=0.012, ["burnt-umber"]=0.018, ["raw-umber"]=0.006}
for i=1,120 do
  local y = 470 + rnd()*240
  local x = 470 + rnd()*(trailR(y) - 470)
  if x < trailR(y) - 20 then
    local dx, dy = 600 - x, 445 - y
    local L = math.sqrt(dx*dx+dy*dy)
    local len = 20 + rnd()*30
    top(W, wm, 1.6, 0.7 + rnd()*0.6)
    W:stroke({{x,y,0.45},{x+dx/L*len, y+dy/L*len, 0.2}}, {duration=0.03})
  end
end
wait(10)
-- ruts: thin darker wavering lines converging toward the rim
local R = brush{name="ruts", width=5}
local rm = {["burnt-umber"]=0.06, ["sepia"]=0.04, ["indian-red"]=0.02, ["french-ultramarine"]=0.015}
local starts = {{560,700},{640,705},{720,705},{800,705},{870,705},{600,640},{760,650}}
for _,s in ipairs(starts) do
  local x, y = s[1], s[2]
  local pts = {}
  local tx, ty = 610 + rnd()*80, 460
  for k=0,12 do
    local t = k/12
    local px = x + (tx-x)*t + math.sin(t*7 + rnd())*6
    local py = y + (ty-y)*t
    pts[#pts+1] = {px, py, 0.5 - 0.3*t}
  end
  -- break each rut into pieces
  local i = 1
  while i < #pts do
    local j = math.min(#pts, i + 2 + math.floor(rnd()*3))
    local seg = {}
    for k=i,j do seg[#seg+1] = pts[k] end
    top(R, rm, 0.5)
    R:stroke(seg, {duration=0.08})
    i = j + 1 + math.floor(rnd()*2)
  end
end
wait(15)
print(balance().dry)



-- Campaign 17: cover glaze on the lit trail to calm the fan strokes
local function trailR(y) return 714 + math.max(0,(y-456))*1.18 end
local function bx(y) if y < 580 then return 548 + (y-445)*37/135 else return 585 + (y-580)*35/120 end end
local function top(b, mx, target, f)
  local need = target - b:status().water
  if need > 0 then local p={} for k,v in pairs(mx) do p[k]=v*need*(f or 1) end; b:load{water=need, pigments=p} end
end
for gy=0,3 do for gx=0,4 do
  local y = 500 + gy*65; local x = 560 + gx*90 + (gy%2)*40
  if x > bx(y) + 50 and x < trailR(y) - 50 then drop{x=x, y=y, water=4, radius=55} end
end end
local V = brush{name="trail_cover", width=40}
local vm = {["buff-titanium"]=0.065, ["indian-red"]=0.008, ["raw-umber"]=0.006, ["burnt-sienna"]=0.004}
local seed = 1717
local function rnd() seed = (seed*1103515245 + 12345) % 2147483648; return seed/2147483648 end
for r=0,11 do
  local y0 = 452 + r*22
  for x = 500, 1000, 28 do
    local y = y0 + (x-500)*0.08 + (rnd()-0.5)*4
    local xl, xr = bx(y), trailR(y)
    if x + 30 > xl - 30 and x < xr - 14 then
      local f = 1
      if x < xl then f = math.max(0.25, 1 - (xl - x)/40) end
      top(V, vm, 2.6, f)
      V:stroke({{x,y},{x+32,y+3}}, {pressure=0.5, duration=0.03})
    end
  end
end
wait(15)
print(balance().dry)



-- Campaign 18: a nearer blue-grey hill to absorb the hazy block at the horizon
local function top(b, mx, target, f)
  local need = target - b:status().water
  if need > 0 then local p={} for k,v in pairs(mx) do p[k]=v*need*(f or 1) end; b:load{water=need, pigments=p} end
end
local h = brush{name="hill_mid", width=16}
local hm = {["cobalt-blue"]=0.04, ["paynes-gray"]=0.03, ["terre-verte"]=0.02, ["buff-titanium"]=0.02, ["quinacridone-rose"]=0.002}
local P = {{480,352},{520,345},{560,338},{600,333},{640,331},{680,334},{720,342},{760,352},{800,362},{830,372}}
local function hy(x)
  for i=1,#P-1 do local a,b=P[i],P[i+1]
    if x>=a[1] and x<=b[1] then return a[2]+(b[2]-a[2])*(x-a[1])/(b[1]-a[1]) end end
  return 372
end
for x=482, 828, 8 do
  local f = 1
  if x > 740 then f = 1 - (x-740)/110 end
  top(h, hm, 1.1, f)
  local yt = hy(x) + 2*math.sin(x/7) + 1.5*math.sin(x/3.1)
  local len = 46 - math.max(0, x-720)*0.2
  h:stroke({{x,yt,0.5},{x+3,yt+16,0.45},{x+6,yt+len,0.12}}, {duration=0.03})
end
wait(15)
print(balance().dry)



-- Campaign 19: deepen the upper sky to absorb the dark spots; graded, pre-wet
for gy=0,1 do for gx=0,7 do drop{x=480+gx*100+(gy%2)*45, y=30+gy*80, water=4, radius=75} end end
local s = brush{name="sky_top2", width=50}
local base = {["cobalt-blue"]=0.020, ["french-ultramarine"]=0.012, ["burnt-sienna"]=0.0032, ["paynes-gray"]=0.0024}
local seed = 1919
local function rnd() seed = (seed*1103515245 + 12345) % 2147483648; return seed/2147483648 end
for row=0,5 do
  local f = 1.3 - row*0.22
  local y = 6 + row*28
  for x=450, 1180, 30 do
    local ff = f
    if x < 560 then ff = f * math.max(0, (x-450)/110) end
    if ff > 0.05 then
      local need = 3 - s:status().water
      if need > 0 then local p={} for k,v in pairs(base) do p[k]=v*need*ff end; s:load{water=need, pigments=p} end
      s:stroke({{x,y+(rnd()-0.5)*4},{x+34,y-1}}, {pressure=0.5, duration=0.03})
    end
  end
end
local L = brush{name="sky_wisp3", width=28}
local function tl(x0,y0,x1,y1,wat,bend)
  L:load{water=wat}
  local pts = {}
  for i=0,10 do local t=i/10; pts[#pts+1]={x0+(x1-x0)*t, y0+(y1-y0)*t - math.sin(t*3.1)*(bend or 6), 0.12+0.45*math.sin(t*math.pi)} end
  L:lift(pts, {duration=0.25})
end
tl(620,60,800,40,1.5,4)
tl(1000,90,1190,70,1.6,3)
tl(520,120,700,110,1.4,3)
wait(15)
print(balance().dry)



-- Campaign 20: foliage form - mid bridges under clumps, warm lit tops; boulder body
local function interp(P, x)
  if x <= P[1][1] then return P[1][2] end
  for i=1,#P-1 do local a,b=P[i],P[i+1]
    if x>=a[1] and x<=b[1] then return a[2]+(b[2]-a[2])*(x-a[1])/(b[1]-a[1]) end end
  return P[#P][2]
end
local seed = 2020
local function rnd() seed = (seed*1103515245 + 12345) % 2147483648; return seed/2147483648 end
local soil = {{0,226},{90,250},{177,278},{250,305},{319,332},{360,360},{400,382},{450,404},{500,420},{540,438}}
local edge = {{60,-10},{110,40},{160,100},{236,128},{283,165},{330,195},{378,254},{425,277},{472,330},{500,370},{512,405},{520,430}}
local BP = {{178,268},{248,226},{306,238},{334,300},{292,342},{186,334}}
local function inPoly(P,x,y)
  local c = false; local j = #P
  for i=1,#P do
    local xi,yi,xj,yj = P[i][1],P[i][2],P[j][1],P[j][2]
    if ((yi>y) ~= (yj>y)) and (x < (xj-xi)*(y-yi)/(yj-yi)+xi) then c = not c end
    j = i
  end
  return c
end
local function inTrees(x,y) return y > interp(edge,x)+3 and y < interp(soil,x) - 2 and not inPoly(BP,x,y) end
local function top(b, mx, target, f)
  local need = target - b:status().water
  if need > 0 then local p={} for k,v in pairs(mx) do p[k]=v*need*(f or 1) end; b:load{water=need, pigments=p} end
end
-- mid-dark bridging strokes: short arcs
local M = brush{name="tree_bridge", width=12}
local mm = {["hookers-green"]=0.10, ["sap-green"]=0.06, ["sepia"]=0.025, ["french-ultramarine"]=0.015}
for i=1,260 do
  local x = rnd()*520; local y = rnd()*440
  if inTrees(x,y) then
    top(M, mm, 0.7, 0.8 + rnd()*0.4)
    M:stroke({{x-6,y+2,0.3},{x,y-1,0.55},{x+7,y+2,0.3}}, {duration=0.03})
  end
end
wait(8)
-- warm lit dabs on upper-right of foliage
local H = brush{name="tree_lit", width=11}
local hm = {["cadmium-yellow"]=0.06, ["sap-green"]=0.06, ["green-gold"]=0.04}
for i=1,220 do
  local x = rnd()*520; local y = rnd()*440
  if inTrees(x,y) and (y - interp(edge,x)) < 70 then
    top(H, hm, 0.6)
    H:stroke({{x,y,0.5},{x+6,y-2,0.3}}, {duration=0.03})
  end
end
-- boulder body: grey dabs, warm-grey top, cool shadow
local R = brush{name="boulder2", width=14}
for i=1,120 do
  local x = 180 + rnd()*155; local y = 226 + rnd()*118
  if inPoly(BP,x,y) then
    local lit = (y < 275 and x > 220)
    local mx = lit and {["buff-titanium"]=0.06, ["paynes-gray"]=0.01, ["burnt-umber"]=0.008}
                    or {["paynes-gray"]=0.03, ["french-ultramarine"]=0.02, ["burnt-umber"]=0.025}
    top(R, mx, 0.8)
    R:stroke({{x,y,0.5},{x+9,y+3,0.35}}, {duration=0.03})
    R:load{water=0}
  end
end
wait(15)
print(balance().dry)



local function top(b, mx, target, f)
  local need = target - b:status().water
  if need > 0 then local p={} for k,v in pairs(mx) do p[k]=v*need*(f or 1) end; b:load{water=need, pigments=p} end
end
-- boulder: a single grey mass laid wet as a few overlapping strokes, then darker base charged in
local R = brush{name="boulder3", width=22}
local gm = {["paynes-gray"]=0.035, ["french-ultramarine"]=0.02, ["burnt-umber"]=0.03, ["buff-titanium"]=0.03}
local paths = {
 {{222,262},{250,246},{285,244},{312,256}},
 {{215,278},{255,268},{300,270},{322,282}},
 {{225,292},{265,288},{305,292}},
}
for i,p in ipairs(paths) do top(R, gm, 2.2, 0.8 + i*0.25); R:stroke(p, {pressure=0.5, duration=0.08}) end
local D = brush{name="boulder3_dk", width=12}
local dm = {["sepia"]=0.08, ["french-ultramarine"]=0.05, ["paynes-gray"]=0.03}
top(D, dm, 1.2)
D:stroke({{218,298},{250,302},{290,304},{320,296}}, {pressure=0.5, duration=0.08})
-- cover the white specks in the sky by the trees
local S = brush{name="speck_cover", width=12}
local sm = {["paynes-gray"]=0.006, ["cobalt-blue"]=0.008, ["buff-titanium"]=0.02}
for _,p in ipairs({{250,118},{287,120},{305,124},{330,123},{318,121}}) do
  top(S, sm, 0.5)
  S:stroke({{p[1]-5,p[2]},{p[1]+5,p[2]}}, {pressure=0.5, duration=0.03})
end
wait(15)
print(balance().dry)



-- Campaign 21: the big boulder and the dark rim rock
local function top(b, mx, target, f)
  local need = target - b:status().water
  if need > 0 then local p={} for k,v in pairs(mx) do p[k]=v*need*(f or 1) end; b:load{water=need, pigments=p} end
end
local R = brush{name="boulder_body", width=24}
local rm = {["paynes-gray"]=0.05, ["french-ultramarine"]=0.02, ["burnt-umber"]=0.02, ["buff-titanium"]=0.05}
-- boulder rows, following its outline: left edge ~ (183,277)->(177,307)->(189,336); right edge (313,265)->(322,319)->(295,336)
local rows = {
 {236, 215, 290}, {250, 200, 305}, {265, 188, 314}, {280, 182, 318}, {295, 180, 320}, {310, 180, 320}, {324, 186, 312},
}
for i,r in ipairs(rows) do
  local f = 1.0 + (i-1)*0.12
  top(R, rm, 2.2, f)
  R:stroke({{r[2],r[1]},{(r[2]+r[3])/2, r[1]-2},{r[3], r[1]+2}}, {pressure=0.5, duration=0.06})
end
-- rim rock: darker, warmer
local K = brush{name="rimrock_body", width=20}
local km = {["sepia"]=0.05, ["paynes-gray"]=0.035, ["burnt-umber"]=0.02, ["buff-titanium"]=0.03}
local krows = {{412, 512, 545},{426, 503, 560},{440, 498, 572},{454, 500, 580},{468, 505, 585},{482, 512, 584},{494, 520, 578}}
for i,r in ipairs(krows) do
  top(K, km, 1.8, 1 + i*0.08)
  K:stroke({{r[2],r[1]},{r[3],r[1]+3}}, {pressure=0.5, duration=0.05})
end
wait(12)
-- lit faces
local L = brush{name="rock_litface", width=16}
local lm = {["buff-titanium"]=0.14, ["paynes-gray"]=0.012, ["raw-umber"]=0.01}
for _,p in ipairs({{{215,246},{258,232},{292,240}}, {{205,258},{250,246},{300,252}}, {{200,270},{238,262},{262,268}}}) do
  top(L, lm, 1.2); L:stroke(p, {pressure=0.5, duration=0.05})
end
for _,p in ipairs({{{516,414},{535,410},{548,420}}, {{506,428},{530,424}}}) do
  top(L, lm, 1.0, 0.8); L:stroke(p, {pressure=0.45, duration=0.04})
end
-- shadow sides & crevices
local D = brush{name="rock_crev", width=6}
local dm = {["sepia"]=0.1, ["french-ultramarine"]=0.06, ["paynes-gray"]=0.04}
local lines = {
 {{298,240},{312,262},{320,300},{316,322}},
 {{262,268},{276,290},{280,330}},
 {{186,334},{230,340},{295,338}},
 {{200,280},{230,288}},
 {{560,425},{575,450},{584,480}},
 {{503,498},{545,502},{580,496}},
}
for _,l in ipairs(lines) do top(D, dm, 0.7); D:stroke(l, {pressure=0.5, duration=0.06}) end
-- cast shadow of rim rock onto trail, to the right
local S = brush{name="rim_shadow", width=14}
local sm = {["french-ultramarine"]=0.04, ["sepia"]=0.03, ["indian-red"]=0.015}
for _,p in ipairs({{{580,492},{610,494},{640,492}}, {{578,500},{620,503}}}) do
  top(S, sm, 1.0); S:stroke(p, {pressure=0.5, duration=0.04})
end
wait(15)
print(balance().dry)



-- Campaign 21b: darks to model the rocks
local function top(b, mx, target, f)
  local need = target - b:status().water
  if need > 0 then local p={} for k,v in pairs(mx) do p[k]=v*need*(f or 1) end; b:load{water=need, pigments=p} end
end
local seed = 2121
local function rnd() seed = (seed*1103515245 + 12345) % 2147483648; return seed/2147483648 end
local D = brush{name="rock_shade", width=14}
local dm = {["paynes-gray"]=0.09, ["sepia"]=0.07, ["french-ultramarine"]=0.03}
-- boulder: shadowed front face (lower half) and right side, irregular dabs
for i=1,70 do
  local x = 182 + rnd()*140; local y = 270 + rnd()*68
  local rightEdge = 318 - math.max(0, y-320)*1.2
  if x < rightEdge and not (y < 285 and x < 250) then
    top(D, dm, 0.9, 0.7 + rnd()*0.5)
    local a = rnd()*6.28
    D:stroke({{x,y,0.5},{x+math.cos(a)*10, y+math.sin(a)*6,0.35}}, {duration=0.03})
  end
end
-- right side plane
for i=1,22 do
  local y = 240 + rnd()*90; local x = 296 + rnd()*22 - math.max(0,y-320)
  top(D, dm, 0.9, 1.1)
  D:stroke({{x,y,0.5},{x+3,y+12,0.3}}, {duration=0.03})
end
-- rim rock: very dark body, lit just on top
for i=1,60 do
  local y = 425 + rnd()*75; local x = 500 + rnd()*85
  local w = (y < 440) and 30 or 42
  if math.abs(x - 542) < w then
    top(D, dm, 0.9, 1.2 + rnd()*0.5)
    local a = rnd()*6.28
    D:stroke({{x,y,0.5},{x+math.cos(a)*9, y+math.sin(a)*7,0.35}}, {duration=0.03})
  end
end
-- crevice lines on boulder
local C = brush{name="rock_crev2", width=4}
local cm = {["sepia"]=0.14, ["paynes-gray"]=0.08}
for _,l in ipairs({{{226,255},{240,272},{246,300}}, {{262,250},{270,268}}, {{196,300},{216,296},{238,304}}, {{290,280},{300,300}}}) do
  top(C, cm, 0.4); C:stroke(l, {pressure=0.5, duration=0.05})
end
wait(15)
print(balance().dry)



local function top(b, mx, target, f)
  local need = target - b:status().water
  if need > 0 then local p={} for k,v in pairs(mx) do p[k]=v*need*(f or 1) end; b:load{water=need, pigments=p} end
end
local G = brush{name="rock_unify", width=22}
local gm = {["paynes-gray"]=0.06, ["sepia"]=0.05, ["french-ultramarine"]=0.02}
-- boulder shadow face: continuous quick rows
local rows = {{278,252,318},{290,186,320},{302,182,320},{314,182,320},{326,186,312},{336,192,300}}
for i,r in ipairs(rows) do
  top(G, gm, 2.0, 0.9)
  G:stroke({{r[2],r[1]},{r[3],r[1]+1}}, {pressure=0.5, duration=0.04})
end
-- right plane
top(G, gm, 1.5, 1.0)
G:stroke({{306,246},{314,270},{318,300}}, {pressure=0.5, duration=0.04})
-- rim rock body, rounded
local K = brush{name="rimrock_unify", width=20}
local rr = {{430,515,560},{442,506,572},{454,503,580},{466,505,584},{478,510,584},{490,515,580}}
for i,r in ipairs(rr) do
  top(K, gm, 1.8, 1.2)
  K:stroke({{r[2],r[1]},{r[3],r[1]+2}}, {pressure=0.5, duration=0.03})
end
wait(15)
print(balance().dry)



-- Campaign 22: brown glaze over trail, feathered into slope
local function interp(P, x)
  if x <= P[1][1] then return P[1][2] end
  for i=1,#P-1 do local a,b=P[i],P[i+1]
    if x>=a[1] and x<=b[1] then return a[2]+(b[2]-a[2])*(x-a[1])/(b[1]-a[1]) end end
  return P[#P][2]
end
local topP = {{0,226},{90,250},{177,278},{250,305},{319,332},{360,360},{400,382},{450,404},{500,420},{540,438},{584,448},{650,452},{714,456}}
local function trailR(y) return 714 + math.max(0,(y-456))*1.18 end
local function bx(y) if y < 580 then return 548 + (y-445)*37/135 else return 585 + (y-580)*35/120 end end
local function top(b, mx, target, f)
  local need = target - b:status().water
  if need > 0 then local p={} for k,v in pairs(mx) do p[k]=v*need*(f or 1) end; b:load{water=need, pigments=p} end
end
local seed = 2222
local function rnd() seed = (seed*1103515245 + 12345) % 2147483648; return seed/2147483648 end
local gm = {["burnt-umber"]=0.03, ["raw-umber"]=0.012, ["indian-red"]=0.009, ["sepia"]=0.004, ["french-ultramarine"]=0.003}
local G = brush{name="trail_glaze", width=40}
for band=0,2 do
  local y0 = 450 + band*88
  for gx=0,4 do
    local y = y0 + 44; local x = bx(y) + 50 + gx*85
    if x < trailR(y) - 50 then drop{x=x, y=y, water=4, radius=58} end
  end
  for r=0,3 do
    local y = y0 + r*22
    if y < 715 then
      for x = bx(y) - 120, trailR(y) - 20, 28 do
        local yy = y + (rnd()-0.5)*5
        local f = 1
        if x < bx(yy) then f = math.max(0, 1 - (bx(yy)-x)/120) end
        -- lighter at the far end of the trail (atmosphere), and keep a lit streak along the centre
        if yy < 500 then f = f*0.7 end
        if f > 0.12 and yy > interp(topP, x) + 4 then
          top(G, gm, 3, f)
          G:stroke({{x,yy},{x+32,yy+3}}, {pressure=0.5, duration=0.03})
        end
      end
    end
  end
end
wait(15)
print(balance().dry)



-- Campaign 23: unify trail with one-pass opaque cover (trial: cover glaze over banded glaze, scratch)
local function trailR(y) return 714 + math.max(0,(y-456))*1.18 end
local function bx(y) if y < 580 then return 548 + (y-445)*37/135 else return 585 + (y-580)*35/120 end end
local function top(b, mx, target, f)
  local need = target - b:status().water
  if need > 0 then local p={} for k,v in pairs(mx) do p[k]=v*need*(f or 1) end; b:load{water=need, pigments=p} end
end
local seed = 2323
local function rnd() seed = (seed*1103515245 + 12345) % 2147483648; return seed/2147483648 end
for gy=0,3 do for gx=0,5 do
  local y = 500 + gy*62; local x = bx(y) + 60 + gx*80 + (gy%2)*35
  if x < trailR(y) - 70 then drop{x=x, y=y, water=4, radius=45} end
end end
local V = brush{name="trail_cover2", width=40}
local vm = {["buff-titanium"]=0.07, ["indian-red"]=0.009, ["burnt-umber"]=0.008, ["raw-umber"]=0.008, ["burnt-sienna"]=0.003}
for r=0,12 do
  local y0 = 452 + r*21
  for x = 480, 1010, 28 do
    local y = y0 + (rnd()-0.5)*4
    if y < 715 then
      local xl, xr = bx(y), trailR(y)
      if x + 30 > xl - 50 and x < xr - 12 then
        local f = 1
        if x < xl then f = math.max(0.2, 1 - (xl - x)/60) end
        if y < 470 then f = f * 1.15 end
        top(V, vm, 2.6, f)
        V:stroke({{x,y},{x+32,y+3}}, {pressure=0.5, duration=0.03})
      end
    end
  end
end
wait(15)
print(balance().dry)



-- Campaign 24: haze over the brown leak above the rim; repaint rim rock and its shadows
local function top(b, mx, target, f)
  local need = target - b:status().water
  if need > 0 then local p={} for k,v in pairs(mx) do p[k]=v*need*(f or 1) end; b:load{water=need, pigments=p} end
end
local seed = 2424
local function rnd() seed = (seed*1103515245 + 12345) % 2147483648; return seed/2147483648 end
local function tline(x)  -- intended top edge of the trail
  if x < 714 then return 448 + (x-585)*0.07 else return 457 + (x-714)/1.18 end
end
local H = brush{name="haze_patch", width=16}
local hm = {["buff-titanium"]=0.10, ["terre-verte"]=0.02, ["cobalt-blue"]=0.015, ["cerulean-blue"]=0.01}
for _,y in ipairs({410, 421, 432, 443, 454, 465}) do
  for x = 575, 760, 16 do
    local tl = tline(x+8)
    if y < tl - 8 then
      top(H, hm, 1.1)
      H:stroke({{x,y},{x+18,y+1}}, {pressure=0.5, duration=0.03})
    end
  end
end
-- edge strokes ending at the trail line
for x = 580, 760, 9 do
  local tl = tline(x)
  if tl - 30 > 400 then
    top(H, hm, 0.8)
    H:stroke({{x, tl - 22, 0.45},{x+2, tl - 7, 0.35}}, {duration=0.03})
  end
end
wait(10)
-- rim rock
local K = brush{name="rimrock3", width=16}
local km = {["sepia"]=0.24, ["paynes-gray"]=0.17, ["french-ultramarine"]=0.07}
local rows = {{410,522,548},{420,510,562},{431,503,572},{442,499,578},{453,498,582},{464,500,584},{475,503,584},{486,508,582},{496,515,578}}
for i,r in ipairs(rows) do
  top(K, km, 1.4, 0.8 + i*0.06)
  K:stroke({{r[2],r[1]+(rnd()-0.5)*3},{(r[2]+r[3])/2, r[1]-1},{r[3],r[1]+1}}, {pressure=0.5, duration=0.04})
end
-- shadow wedge: from rock base down-left into the gully, and cast shadow right
local S = brush{name="gully_shadow", width=20}
local sm = {["french-ultramarine"]=0.05, ["sepia"]=0.05, ["indian-red"]=0.025, ["burnt-umber"]=0.02}
local wedge = {{500,500,585},{492,510,560},{486,520,540},{478,532,520},{470,545,505}}
for _,w in ipairs(wedge) do
  top(S, sm, 1.6)
  S:stroke({{w[1],w[2]},{w[3],w[2]-4}}, {pressure=0.5, duration=0.03})
end
top(S, sm, 1.4)
S:stroke({{580,496},{610,498},{632,495}}, {pressure=0.45, duration=0.03})
wait(12)
-- lit top of the rock
local L = brush{name="rimrock_lit", width=10}
local lm = {["buff-titanium"]=0.14, ["paynes-gray"]=0.015, ["raw-umber"]=0.012}
for _,p in ipairs({{{514,416},{532,408},{550,414}}, {{506,428},{524,422}}}) do
  top(L, lm, 0.7); L:stroke(p, {pressure=0.45, duration=0.04})
end
wait(12)
print(balance().dry)



-- Campaign 25: cover the stray dark finger; warm textured glaze over the trail, across its left edge
local function trailR(y) return 714 + math.max(0,(y-456))*1.18 end
local function top(b, mx, target, f)
  local need = target - b:status().water
  if need > 0 then local p={} for k,v in pairs(mx) do p[k]=v*need*(f or 1) end; b:load{water=need, pigments=p} end
end
local seed = 2525
local function rnd() seed = (seed*1103515245 + 12345) % 2147483648; return seed/2147483648 end
local O = brush{name="finger_cover", width=16}
local om = {["buff-titanium"]=1.0, ["indian-red"]=0.11, ["burnt-umber"]=0.08, ["naples-yellow"]=0.04}
top(O, om, 1.2); O:stroke({{588,493},{612,496},{636,493}}, {pressure=0.5, duration=0.03})
top(O, om, 0.8); O:stroke({{596,500},{626,500}}, {pressure=0.4, duration=0.03})
wait(8)
local g = brush{name="trail_warm", width=34}
local gm = {["indian-red"]=0.015, ["burnt-umber"]=0.02}
local n = 0
for k=1,700 do
  local y = 440 + rnd()*280
  local x = 420 + rnd()*560
  local xr = trailR(y)
  if x < xr - 18 and y < 720 and y > 452 + math.max(0, (x-585))*0.0 then
    -- lit band: centre line from (640,470) to (860,700)
    local cx = 640 + (y-470)*220/230
    local d = math.abs(x - cx)/150
    local f = 0.45 + 0.4*math.min(1, d)
    if x < 520 then f = f * 1.1 end
    if y < 480 then f = f*0.6 end
    n = n + 1
    top(g, gm, 2, f)
    local a = (rnd()-0.5)*1.0 + 0.35
    g:stroke({{x,y,0.55},{x+math.cos(a)*30, y+math.sin(a)*24,0.35}}, {duration=0.03})
  end
end
print(n)
wait(15)
print(balance().dry)



-- Campaign 26: mute the reds - grey-tan veil on trail, cool neutral veil on slope
local function interp(P, x)
  if x <= P[1][1] then return P[1][2] end
  for i=1,#P-1 do local a,b=P[i],P[i+1]
    if x>=a[1] and x<=b[1] then return a[2]+(b[2]-a[2])*(x-a[1])/(b[1]-a[1]) end end
  return P[#P][2]
end
local topP = {{0,226},{90,250},{177,278},{250,305},{319,332},{360,360},{400,382},{450,404},{500,420},{540,438},{584,448},{650,452},{714,456}}
local function trailR(y) return 714 + math.max(0,(y-456))*1.18 end
local function top(b, mx, target, f)
  local need = target - b:status().water
  if need > 0 then local p={} for k,v in pairs(mx) do p[k]=v*need*(f or 1) end; b:load{water=need, pigments=p} end
end
local function inRim(x,y) return (x-540)^2/50^2 + (y-455)^2/52^2 < 1 end
local function inBoulder(x,y) return x > 175 and x < 325 and y > 226 and y < 342 end
-- trail-ness: 1 on the trail (right of gully line), 0 on slope
local function trailness(x,y)
  local bxv = 520 + (y-450)*0.25
  return math.max(0, math.min(1, (x - bxv)/60 + 0.5))
end
local tm = {["buff-titanium"]=0.05, ["french-ultramarine"]=0.008, ["paynes-gray"]=0.004, ["raw-umber"]=0.006}
local sm = {["french-ultramarine"]=0.016, ["paynes-gray"]=0.006, ["raw-umber"]=0.01, ["buff-titanium"]=0.02}
local T = brush{name="mute_trail", width=40}
local S = brush{name="mute_slope", width=40}
local n = 0
for band=0,6 do
  local yb = 150 + band*96
  for x=0, 1000, 95 do
    local y = yb + 48 + x*0.29
    if y > interp(topP,x)+55 and x < trailR(y)-60 and y < 690 and not inBoulder(x,y) then drop{x=x, y=y, water=4, radius=55} end
  end
  for r=0,3 do
    local yr = yb + r*24
    for x=-20, 1010, 30 do
      local y = yr + x*0.29
      if y > interp(topP, x) + 2 and x < trailR(y) - 8 and y < 720 and not inRim(x+16,y+5) and not inBoulder(x+16,y+5) then
        n = n + 1
        local t = trailness(x,y)
        local seg = {{x,y},{x+34,y+10}}
        if t > 0.5 then
          top(T, tm, 3, 1.1)
          T:stroke(seg, {pressure=0.5, duration=0.03})
        else
          local f = 1
          if x < 300 and y > 520 then f = 1.3 end
          top(S, sm, 3, f)
          S:stroke(seg, {pressure=0.5, duration=0.03})
        end
      end
    end
  end
end
print(n)
wait(15)
print(balance().dry)



-- Campaign 27: transparent brown glaze, rows overlapping (19-cell spacing), value by zone
local function interp(P, x)
  if x <= P[1][1] then return P[1][2] end
  for i=1,#P-1 do local a,b=P[i],P[i+1]
    if x>=a[1] and x<=b[1] then return a[2]+(b[2]-a[2])*(x-a[1])/(b[1]-a[1]) end end
  return P[#P][2]
end
local topP = {{0,226},{90,250},{177,278},{250,305},{319,332},{360,360},{400,382},{450,404},{500,420},{540,438},{584,448},{650,452},{714,456}}
local function trailR(y) return 714 + math.max(0,(y-456))*1.18 end
local function top(b, mx, target, f)
  local need = target - b:status().water
  if need > 0 then local p={} for k,v in pairs(mx) do p[k]=v*need*(f or 1) end; b:load{water=need, pigments=p} end
end
local function inRim(x,y) return (x-540)^2/44^2 + (y-452)^2/48^2 < 1 end
local function inBoulder(x,y) return x > 182 and x < 320 and y > 232 and y < 338 end
local function val(x,y)
  local bxv = 520 + (y-450)*0.25   -- gully/trail boundary
  local t = math.max(0, math.min(1, (x - bxv)/70 + 0.5))
  local slope = 1.1 + 0.35*math.max(0, math.min(1, (360 - x)/300)) + 0.2*math.max(0, (y-560)/150)
  -- gully shadow under the rocks
  local gd = math.sqrt(((x-470)/110)^2 + ((y-500)/70)^2)
  if gd < 1 then slope = slope + 0.5*(1-gd) end
  local trail = 0.55
  if y < 490 then trail = 0.4 end
  local xr = trailR(y)
  if x > xr - 70 then trail = trail + 0.3*(x - (xr-70))/70 end
  return slope*(1-t) + trail*t
end
local gm = {["burnt-umber"]=0.04, ["sepia"]=0.015, ["french-ultramarine"]=0.012, ["indian-red"]=0.01}
local G = brush{name="soil_glaze3", width=44}
local n = 0
for band=0,8 do
  local yb = 140 + band*76
  for x=0, 1000, 95 do
    local y = yb + 38 + x*0.15
    if y > interp(topP,x)+50 and x < trailR(y)-55 and y < 690 and not inBoulder(x,y) then drop{x=x, y=y, water=4, radius=50} end
  end
  for r=0,3 do
    local yr = yb + r*19
    for x=-20, 1010, 28 do
      local y = yr + x*0.15
      local cx, cy = x+16, y+3
      if cy > interp(topP, cx) + 4 and cx < trailR(cy) - 8 and cy < 725 and cy > 200 and not inRim(cx,cy) and not inBoulder(cx,cy) then
        n = n + 1
        top(G, gm, 3, val(cx,cy))
        G:stroke({{x,y},{x+32,y+5}}, {pressure=0.5, duration=0.03})
      end
    end
  end
end
print(n)
wait(15)
print(balance().dry)



-- Campaign 28: opaque gravel cover on the trail (trial: scratch, dense random dabs buff 0.4/ind-red .03/raw-umber .03/b-umber .02 per uL over dark soil)
local function trailR(y) return 714 + math.max(0,(y-456))*1.18 end
local function trailL(y) return 560 - (y-470)*0.35 end
local function top(b, mx, target, f)
  local need = target - b:status().water
  if need > 0 then local p={} for k,v in pairs(mx) do p[k]=v*need*(f or 1) end; b:load{water=need, pigments=p} end
end
local seed = 2828
local function rnd() seed = (seed*1103515245 + 12345) % 2147483648; return seed/2147483648 end
local function inRim(x,y) return (x-540)^2/48^2 + (y-452)^2/52^2 < 1 end
local m1 = {["buff-titanium"]=0.4, ["indian-red"]=0.03, ["raw-umber"]=0.03, ["burnt-umber"]=0.02}
local m2 = {["buff-titanium"]=0.25, ["indian-red"]=0.022, ["raw-umber"]=0.022, ["burnt-umber"]=0.018, ["french-ultramarine"]=0.004}
local c1 = brush{name="gravel_light", width=26}
local c2 = brush{name="gravel_mid", width=26}
local n = 0
for k=1,700 do
  local y = 452 + rnd()*270
  local xl, xr = trailL(y), trailR(y)
  local x = xl - 20 + rnd()*(xr - xl + 10)
  if y < 462 then x = 585 + rnd()*130 end
  if not inRim(x+12,y) and x < xr - 14 and n < 330 then
    n = n + 1
    local u = (x - xl)/(xr - xl)
    local edge = (u < 0.15 or u > 0.88)
    local cb, m = c1, m1
    if edge or rnd() < 0.25 then cb, m = c2, m2 end
    local f = 1
    if u < 0 then f = 0.7 end
    top(cb, m, 1.5, f)
    local a = (rnd()-0.5)*0.9 + 0.1
    local len = 18 + rnd()*14
    cb:stroke({{x,y,0.5},{x+math.cos(a)*len, y+math.sin(a)*len*0.5,0.35}}, {duration=0.03})
  end
end
print(n)
wait(15)
print(balance().dry)



-- Campaign 29: warm-brown transparent glaze over the gravel cover (trial on scratch, recipe 2 at ~0.7)
local function trailR(y) return 714 + math.max(0,(y-456))*1.18 end
local function trailL(y) return 560 - (y-470)*0.35 end
local function top(b, mx, target, f)
  local need = target - b:status().water
  if need > 0 then local p={} for k,v in pairs(mx) do p[k]=v*need*(f or 1) end; b:load{water=need, pigments=p} end
end
local seed = 2929
local function rnd() seed = (seed*1103515245 + 12345) % 2147483648; return seed/2147483648 end
local function inRim(x,y) return (x-540)^2/46^2 + (y-452)^2/50^2 < 1 end
local gm = {["burnt-umber"]=0.03, ["raw-umber"]=0.015, ["indian-red"]=0.01, ["french-ultramarine"]=0.004}
local g = brush{name="trail_brown", width=30}
local n = 0
for k=1,600 do
  local y = 445 + rnd()*275
  local xl, xr = trailL(y) - 30, trailR(y)
  local x = xl + rnd()*(xr - xl)
  if not inRim(x+12,y+6) and x < xr - 16 and n < 300 then
    n = n + 1
    local u = (x - trailL(y))/(xr - trailL(y))
    -- lit streak around u ~ 0.45, darker toward both edges and toward the bottom
    local f = 0.45 + 0.6*math.min(1, math.abs(u - 0.45)/0.45) + 0.25*math.max(0,(y-560)/160)
    if y < 480 then f = f*0.6 end
    top(g, gm, 1.8, f)
    local a = (rnd()-0.5)*1.0 + 0.3
    g:stroke({{x,y,0.55},{x+math.cos(a)*26, y+math.sin(a)*18,0.35}}, {duration=0.03})
  end
end
print(n)
wait(15)
print(balance().dry)



-- Campaign 30: break the slope stripes with diagonal semi-opaque dabs (trial: scratch option 2)
local function interp(P, x)
  if x <= P[1][1] then return P[1][2] end
  for i=1,#P-1 do local a,b=P[i],P[i+1]
    if x>=a[1] and x<=b[1] then return a[2]+(b[2]-a[2])*(x-a[1])/(b[1]-a[1]) end end
  return P[#P][2]
end
local topP = {{0,226},{90,250},{177,278},{250,305},{319,332},{360,360},{400,382},{450,404},{500,420},{540,438},{584,448}}
local function trailL(y) return 560 - (y-470)*0.35 end
local function top(b, mx, target, f)
  local need = target - b:status().water
  if need > 0 then local p={} for k,v in pairs(mx) do p[k]=v*need*(f or 1) end; b:load{water=need, pigments=p} end
end
local seed = 3030
local function rnd() seed = (seed*1103515245 + 12345) % 2147483648; return seed/2147483648 end
local function inRim(x,y) return (x-540)^2/46^2 + (y-452)^2/50^2 < 1 end
local function inBoulder(x,y) return x > 180 and x < 322 and y > 228 and y < 340 end
local dm = {["buff-titanium"]=0.04, ["burnt-umber"]=0.06, ["indian-red"]=0.03, ["sepia"]=0.02, ["french-ultramarine"]=0.012}
local dk = {["burnt-umber"]=0.05, ["sepia"]=0.03, ["french-ultramarine"]=0.02, ["indian-red"]=0.015}
local c = brush{name="slope_dabs", width=26}
local d = brush{name="slope_darkdabs", width=20}
local n = 0
for k=1,900 do
  local x = -10 + rnd()*600; local y = 215 + rnd()*510
  if y > interp(topP, x) + 8 and x < trailL(y) - 4 and not inRim(x,y) and not inBoulder(x,y) and n < 360 then
    n = n + 1
    local a = 0.45 + (rnd()-0.5)*0.9
    local len = 18 + rnd()*14
    if rnd() < 0.72 then
      top(c, dm, 1.5, 0.8 + rnd()*0.4)
      c:stroke({{x,y,0.5},{x+math.cos(a)*len, y+math.sin(a)*len*0.75,0.35}}, {duration=0.03})
    else
      top(d, dk, 1.2, 0.9 + rnd()*0.5)
      d:stroke({{x,y,0.5},{x+math.cos(a)*len, y+math.sin(a)*len*0.75,0.3}}, {duration=0.03})
    end
  end
end
print(n)
wait(15)
print(balance().dry)



-- Campaign 31: transparent soft glaze over the slope with random large strokes to merge the dabs and shade it
local function interp(P, x)
  if x <= P[1][1] then return P[1][2] end
  for i=1,#P-1 do local a,b=P[i],P[i+1]
    if x>=a[1] and x<=b[1] then return a[2]+(b[2]-a[2])*(x-a[1])/(b[1]-a[1]) end end
  return P[#P][2]
end
local topP = {{0,226},{90,250},{177,278},{250,305},{319,332},{360,360},{400,382},{450,404},{500,420},{540,438},{584,448}}
local function trailL(y) return 560 - (y-470)*0.35 end
local function top(b, mx, target, f)
  local need = target - b:status().water
  if need > 0 then local p={} for k,v in pairs(mx) do p[k]=v*need*(f or 1) end; b:load{water=need, pigments=p} end
end
local seed = 3131
local function rnd() seed = (seed*1103515245 + 12345) % 2147483648; return seed/2147483648 end
local function inRim(x,y) return (x-540)^2/44^2 + (y-452)^2/48^2 < 1 end
local function inBoulder(x,y) return x > 184 and x < 318 and y > 232 and y < 336 end
local gm = {["burnt-umber"]=0.025, ["sepia"]=0.01, ["french-ultramarine"]=0.01, ["indian-red"]=0.012}
local g = brush{name="slope_soft", width=40}
local n = 0
for k=1,800 do
  local x = -20 + rnd()*620; local y = 215 + rnd()*520
  local xl = trailL(y)
  if y > interp(topP, x) + 10 and x < xl + 10 and not inRim(x+15,y+8) and not inBoulder(x+15,y+8) and n < 300 then
    n = n + 1
    local f = 0.9 + 0.5*math.max(0, (300 - x)/300) + 0.4*math.max(0,(y-520)/200)
    if x > xl - 40 then f = f * math.max(0.2, (xl + 10 - x)/50) end
    top(g, gm, 2.2, f)
    local a = 0.45 + (rnd()-0.5)*1.0
    g:stroke({{x,y,0.55},{x+math.cos(a)*32, y+math.sin(a)*24,0.4}}, {duration=0.03})
  end
end
print(n)
wait(15)
print(balance().dry)



-- Campaign 32: scattered lava stones (dark) and pebbles (light) - small, larger toward the bottom
local function interp(P, x)
  if x <= P[1][1] then return P[1][2] end
  for i=1,#P-1 do local a,b=P[i],P[i+1]
    if x>=a[1] and x<=b[1] then return a[2]+(b[2]-a[2])*(x-a[1])/(b[1]-a[1]) end end
  return P[#P][2]
end
local topP = {{0,226},{90,250},{177,278},{250,305},{319,332},{360,360},{400,382},{450,404},{500,420},{540,438},{584,448},{650,452},{714,456}}
local function trailR(y) return 714 + math.max(0,(y-456))*1.18 end
local function top(b, mx, target, f)
  local need = target - b:status().water
  if need > 0 then local p={} for k,v in pairs(mx) do p[k]=v*need*(f or 1) end; b:load{water=need, pigments=p} end
end
local seed = 3232
local function rnd() seed = (seed*1103515245 + 12345) % 2147483648; return seed/2147483648 end
local function inBoulder(x,y) return x > 176 and x < 326 and y > 224 and y < 344 end
local D = brush{name="stone_dark", width=8}
local dm = {["sepia"]=0.12, ["paynes-gray"]=0.08, ["french-ultramarine"]=0.03}
local Lb = brush{name="stone_light", width=6}
local lm = {["buff-titanium"]=0.5, ["raw-umber"]=0.02, ["paynes-gray"]=0.01}
local n = 0
for k=1,500 do
  local x = rnd()*1000; local y = 230 + rnd()*490
  if y > interp(topP,x) + 10 and x < trailR(y) - 20 and not inBoulder(x,y) and n < 110 then
    n = n + 1
    local s = 0.5 + (y - 400)/300   -- scale grows toward viewer
    local w = (4 + rnd()*8) * math.max(0.5, s)
    top(D, dm, 0.35, 0.8 + rnd()*0.4)
    D:stroke({{x - w/2, y, 0.3},{x, y + w*0.25, 0.5},{x + w/2, y - 1, 0.3}}, {duration=0.03})
    if rnd() < 0.5 then
      top(Lb, lm, 0.25)
      Lb:stroke({{x - w/3, y - 3*math.max(0.6,s), 0.3},{x + w/4, y - 4*math.max(0.6,s), 0.3}}, {duration=0.03})
    end
  end
end
print(n)
wait(12)
print(balance().dry)



-- Campaign 33: soft neutral glaze over the trail to merge the scale pattern (as C31 on the slope, lighter, cooler)
local function trailR(y) return 714 + math.max(0,(y-456))*1.18 end
local function trailL(y) return 560 - (y-470)*0.35 end
local function top(b, mx, target, f)
  local need = target - b:status().water
  if need > 0 then local p={} for k,v in pairs(mx) do p[k]=v*need*(f or 1) end; b:load{water=need, pigments=p} end
end
local seed = 3333
local function rnd() seed = (seed*1103515245 + 12345) % 2147483648; return seed/2147483648 end
local function inRim(x,y) return (x-540)^2/46^2 + (y-452)^2/50^2 < 1 end
local gm = {["raw-umber"]=0.02, ["burnt-umber"]=0.015, ["french-ultramarine"]=0.007, ["indian-red"]=0.004}
local g = brush{name="trail_soft", width=44}
local n=0
for k=1,700 do
  local y = 450 + rnd()*270
  local xl, xr = trailL(y) - 20, trailR(y)
  local x = xl + rnd()*(xr - xl)
  if x < xr - 22 and not inRim(x+15,y+8) and n < 230 then
    n = n + 1
    local u = (x - trailL(y))/(xr - trailL(y))
    local f = 0.55 + 0.5*math.min(1, math.abs(u-0.45)/0.5)
    if y < 485 then f = f * 0.6 end
    top(g, gm, 2.2, f)
    local a = 0.8 + (rnd()-0.5)*0.8  -- along trail direction (down-right)
    g:stroke({{x,y,0.55},{x+math.cos(a)*30, y+math.sin(a)*26,0.4}}, {duration=0.03})
  end
end
print(n)
wait(15)
print(balance().dry)



-- Campaign 34: light gravel cover on the lit trail, small directional dabs, smaller far away
local function trailR(y) return 714 + math.max(0,(y-456))*1.18 end
local function trailL(y) return 560 - (y-470)*0.35 end
local function top(b, mx, target, f)
  local need = target - b:status().water
  if need > 0 then local p={} for k,v in pairs(mx) do p[k]=v*need*(f or 1) end; b:load{water=need, pigments=p} end
end
local seed = 3434
local function rnd() seed = (seed*1103515245 + 12345) % 2147483648; return seed/2147483648 end
local function inRim(x,y) return (x-540)^2/48^2 + (y-452)^2/52^2 < 1 end
local m1 = {["buff-titanium"]=0.3, ["raw-umber"]=0.03, ["burnt-sienna"]=0.03, ["indian-red"]=0.02, ["yellow-ochre"]=0.02}
local m2 = {["buff-titanium"]=0.3, ["raw-umber"]=0.05, ["burnt-umber"]=0.03, ["indian-red"]=0.025}
local c1 = brush{name="grav2_a", width=18}
local c2 = brush{name="grav2_b", width=18}
local cS = brush{name="grav2_far", width=11}
local n = 0
for k=1,1400 do
  local y = 450 + rnd()*270
  local xl, xr = trailL(y), trailR(y)
  local x = xl + rnd()*(xr - xl)
  local u = (x - xl)/(xr - xl)
  -- density: highest along lit streak u~0.4, sparse at edges
  local p = 1 - math.min(1, math.abs(u - 0.42)/0.5)
  if rnd() < p*p and x < xr - 14 and not inRim(x+8,y+4) and n < 420 then
    n = n + 1
    local s = math.max(0.45, math.min(1.1, (y - 440)/220))
    local a = 0.75 + (rnd()-0.5)*0.6
    local len = 16*s
    local cb, m = c1, m1
    if rnd() < 0.45 then cb, m = c2, m2 end
    if s < 0.6 then cb = cS end
    top(cb, m, 1.0*s + 0.2, 0.8 + rnd()*0.4)
    cb:stroke({{x,y,0.5},{x+math.cos(a)*len, y+math.sin(a)*len*0.85,0.3}}, {duration=0.03})
  end
end
print(n)
wait(15)
print(balance().dry)



-- Campaign 35: grassy fringe along the trail's right edge; far trail gravel
local function trailR(y) return 714 + math.max(0,(y-456))*1.18 end
local function top(b, mx, target, f)
  local need = target - b:status().water
  if need > 0 then local p={} for k,v in pairs(mx) do p[k]=v*need*(f or 1) end; b:load{water=need, pigments=p} end
end
local seed = 3535
local function rnd() seed = (seed*1103515245 + 12345) % 2147483648; return seed/2147483648 end
local G = brush{name="fringe_green", width=9}
local gm = {["sap-green"]=0.1, ["hookers-green"]=0.05, ["yellow-ochre"]=0.03, ["burnt-umber"]=0.01}
local Gd = brush{name="fringe_dark", width=8}
local gd = {["hookers-green"]=0.1, ["sepia"]=0.04, ["french-ultramarine"]=0.02}
for k=1,140 do
  local y = 460 + rnd()*255
  local s = math.max(0.4, (y-440)/240)
  local x = trailR(y) - 10*s + rnd()*30*s
  local cb, m = G, gm
  if rnd() < 0.35 then cb, m = Gd, gd end
  top(cb, m, 0.5)
  local h = (8 + rnd()*12) * s
  local lean = (rnd()-0.3)*6*s
  cb:stroke({{x, y, 0.45},{x+lean, y-h, 0.1}}, {duration=0.03})
end
-- far gravel near the rim
local cS = brush{name="grav_far2", width=9}
local m1 = {["buff-titanium"]=0.3, ["raw-umber"]=0.03, ["burnt-sienna"]=0.03, ["indian-red"]=0.02, ["yellow-ochre"]=0.02}
for k=1,40 do
  local y = 455 + rnd()*35
  local x = 590 + rnd()*(trailR(y) - 600)
  top(cS, m1, 0.5, 0.8)
  cS:stroke({{x,y,0.45},{x+6,y+3,0.3}}, {duration=0.03})
end
wait(12)
print(balance().dry)



-- Campaign 36: semi-opaque warm glaze to merge the gravel dabs (trial: scratch right half, buff .06 raw-umber .012 b-sienna .01 ind-red .005 per uL, w40, 2.2uL)
local function trailR(y) return 714 + math.max(0,(y-456))*1.18 end
local function trailL(y) return 560 - (y-470)*0.35 end
local function top(b, mx, target, f)
  local need = target - b:status().water
  if need > 0 then local p={} for k,v in pairs(mx) do p[k]=v*need*(f or 1) end; b:load{water=need, pigments=p} end
end
local seed = 3636
local function rnd() seed = (seed*1103515245 + 12345) % 2147483648; return seed/2147483648 end
local function inRim(x,y) return (x-540)^2/48^2 + (y-452)^2/52^2 < 1 end
local m2 = {["buff-titanium"]=0.06, ["raw-umber"]=0.012, ["burnt-sienna"]=0.01, ["indian-red"]=0.005}
local g = brush{name="trail_merge", width=40}
local n = 0
for k=1,900 do
  local y = 448 + rnd()*270
  local xl, xr = trailL(y), trailR(y)
  local x = xl + rnd()*(xr - xl)
  local u = (x - xl)/(xr - xl)
  local p = 1 - math.min(1, math.abs(u - 0.42)/0.55)
  if rnd() < p and x < xr - 30 and not inRim(x+15,y+12) and n < 200 then
    n = n + 1
    local s = math.max(0.5, math.min(1, (y-440)/200))
    top(g, m2, 2.2*s, 1)
    local a = 0.75 + (rnd()-0.5)*0.5
    g:stroke({{x,y,0.5*s+0.05},{x+math.cos(a)*30*s, y+math.sin(a)*26*s,0.4*s}}, {duration=0.03})
  end
end
print(n)
wait(15)
print(balance().dry)



-- Campaign 37: transparent warm glaze over the pale trail, more at edges and in the near foreground
local function trailR(y) return 714 + math.max(0,(y-456))*1.18 end
local function trailL(y) return 560 - (y-470)*0.35 end
local function top(b, mx, target, f)
  local need = target - b:status().water
  if need > 0 then local p={} for k,v in pairs(mx) do p[k]=v*need*(f or 1) end; b:load{water=need, pigments=p} end
end
local seed = 3737
local function rnd() seed = (seed*1103515245 + 12345) % 2147483648; return seed/2147483648 end
local function inRim(x,y) return (x-540)^2/48^2 + (y-452)^2/52^2 < 1 end
local m1 = {["raw-umber"]=0.014, ["burnt-sienna"]=0.012, ["indian-red"]=0.007, ["burnt-umber"]=0.006}
local g = brush{name="trail_warm2", width=36}
local n = 0
for k=1,900 do
  local y = 448 + rnd()*272
  local xl, xr = trailL(y) - 10, trailR(y)
  local x = xl + rnd()*(xr - xl)
  local u = (x - trailL(y))/(xr - trailL(y))
  if x < xr - 24 and not inRim(x+15,y+12) and n < 240 then
    n = n + 1
    local f = 0.8 + 0.7*math.min(1, math.abs(u - 0.42)/0.45) + 0.4*math.max(0,(y-580)/140)
    if y < 480 then f = f*0.6 end
    local s = math.max(0.5, math.min(1, (y-440)/200))
    top(g, m1, 2.0*s, f)
    local a = 0.75 + (rnd()-0.5)*0.7
    g:stroke({{x,y,0.5*s+0.05},{x+math.cos(a)*30*s, y+math.sin(a)*26*s,0.4*s}}, {duration=0.03})
  end
end
print(n)
wait(15)
print(balance().dry)



-- Campaign 38: rim rock cluster restated
local function top(b, mx, target, f)
  local need = target - b:status().water
  if need > 0 then local p={} for k,v in pairs(mx) do p[k]=v*need*(f or 1) end; b:load{water=need, pigments=p} end
end
local seed = 3838
local function rnd() seed = (seed*1103515245 + 12345) % 2147483648; return seed/2147483648 end
local K = brush{name="rim_dark2", width=12}
local km = {["sepia"]=0.22, ["paynes-gray"]=0.16, ["french-ultramarine"]=0.06}
-- rocks: centre x,y, half-width, height
local rocks = {{528,425,30,26},{560,440,20,18},{500,418,16,14},{470,408,14,10},{585,447,12,9},{440,398,12,8},{545,460,22,12},{505,448,18,14}}
for _,r in ipairs(rocks) do
  local cx, cy, hw, h = r[1], r[2], r[3], r[4]
  for yy = cy - h/2, cy + h/2, 7 do
    local t = (yy - (cy - h/2))/h
    local w = hw * (0.6 + 0.4*math.sin(math.min(1,t*1.4)*math.pi*0.5))
    top(K, km, 0.9, 0.8 + t*0.5)
    K:stroke({{cx - w, yy + (rnd()-0.5)*2},{cx + w, yy + (rnd()-0.5)*2}}, {pressure=0.45, duration=0.03})
  end
end
wait(10)
local L = brush{name="rim_lit2", width=7}
local lm = {["buff-titanium"]=0.35, ["paynes-gray"]=0.02, ["raw-umber"]=0.02}
for _,r in ipairs(rocks) do
  local cx, cy, hw, h = r[1], r[2], r[3], r[4]
  top(L, lm, 0.5)
  L:stroke({{cx - hw*0.7, cy - h/2 + 2},{cx - hw*0.1, cy - h/2 - 1},{cx + hw*0.5, cy - h/2 + 2}}, {pressure=0.45, duration=0.03})
end
wait(12)
print(balance().dry)



local function top(b, mx, target, f)
  local need = target - b:status().water
  if need > 0 then local p={} for k,v in pairs(mx) do p[k]=v*need*(f or 1) end; b:load{water=need, pigments=p} end
end
local seed = 3939
local function rnd() seed = (seed*1103515245 + 12345) % 2147483648; return seed/2147483648 end
local G = brush{name="rim_grey", width=8}
local gm = {["buff-titanium"]=0.12, ["paynes-gray"]=0.05, ["sepia"]=0.04}
local D = brush{name="rim_dk3", width=6}
local dm = {["sepia"]=0.2, ["paynes-gray"]=0.15}
local rocks = {{528,425,30,26},{560,440,20,18},{500,418,16,14},{470,408,14,10},{585,447,12,9},{440,398,12,8},{545,460,22,12},{505,448,18,14}}
for _,r in ipairs(rocks) do
  local cx, cy, hw, h = r[1], r[2], r[3], r[4]
  for k=1,math.floor(hw/3) do
    local x = cx + (rnd()-0.5)*hw*1.6; local y = cy - h/2 + rnd()*h*0.6
    top(G, gm, 0.4)
    local a = rnd()*6.28
    G:stroke({{x,y,0.4},{x+math.cos(a)*6, y+math.sin(a)*4,0.3}}, {duration=0.03})
  end
  for k=1,math.floor(hw/6)+1 do
    local x = cx + (rnd()-0.5)*hw*1.4; local y = cy + rnd()*h*0.4
    top(D, dm, 0.35)
    D:stroke({{x,y,0.4},{x+5+rnd()*4, y+1+rnd()*2,0.3}}, {duration=0.03})
  end
end
wait(12)
print(balance().dry)



-- Campaign 39: valley patchwork - light fields and dark hedgerows, scaled with distance
local function trailR(y) return 714 + math.max(0,(y-456))*1.18 end
local function top(b, mx, target, f)
  local need = target - b:status().water
  if need > 0 then local p={} for k,v in pairs(mx) do p[k]=v*need*(f or 1) end; b:load{water=need, pigments=p} end
end
local seed = 4040
local function rnd() seed = (seed*1103515245 + 12345) % 2147483648; return seed/2147483648 end
local F = brush{name="fields_light", width=14}
local fm = {["buff-titanium"]=0.06, ["green-gold"]=0.03, ["sap-green"]=0.02, ["yellow-ochre"]=0.01}
local H = brush{name="hedges", width=6}
local hm = {["hookers-green"]=0.08, ["paynes-gray"]=0.04, ["terre-verte"]=0.03}
for k=1,60 do
  local y = 400 + (rnd()^1.3)*300
  local d = (y - 390)/310        -- 0 far, 1 near
  local x = trailR(y) + 30 + rnd()*(1180 - trailR(y))
  if x < 1175 then
    local len = 20 + 70*d*(0.5+rnd())
    local th = 2 + 6*d
    if rnd() < 0.5 then
      top(F, fm, 0.4 + 0.8*d, 0.5 + 0.5*d)
      F:stroke({{x,y,0.25+0.2*d},{x+len, y+(rnd()-0.5)*th, 0.25+0.2*d}}, {duration=0.04})
    else
      top(H, hm, 0.3 + 0.4*d, 0.4 + 0.7*d)
      H:stroke({{x,y,0.3+0.2*d},{x+len*0.5, y+(rnd()-0.5)*2, 0.3},{x+len, y+(rnd()-0.5)*3, 0.25}}, {duration=0.04})
    end
  end
end
wait(12)
print(balance().dry)
