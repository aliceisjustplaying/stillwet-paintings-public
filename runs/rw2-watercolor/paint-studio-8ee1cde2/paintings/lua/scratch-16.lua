--@ watercolor-engine 2

paper{width=1180,height=700,kind="cold-press",seed=2013}


local seed = 3
local function rnd() seed = (seed*1103515245 + 12345) % 2147483648; return seed/2147483648 end
local function top(b, mx, target, f)
  local need = target - b:status().water
  if need > 0 then local p={} for k,v in pairs(mx) do p[k]=v*need*(f or 1) end; b:load{water=need, pigments=p} end
end
local b = brush{name="soil", width=44}
local mx = {["burnt-umber"]=0.04, ["indian-red"]=0.02, ["sepia"]=0.01, ["french-ultramarine"]=0.01}
for r=0,11 do for x=0,600,28 do local y=10+r*26; top(b, mx, 2.5, 0.9); b:stroke({{x,y},{x+32,y+9}}, {pressure=0.5, duration=0.03}) end end
wait(10)
local W = brush{name="dir", width=22}
local wm = {["indian-red"]=0.012, ["burnt-umber"]=0.018, ["raw-umber"]=0.006}
for i=1,80 do local x=rnd()*600; local y=rnd()*300; top(W,wm,1.6,1); W:stroke({{x,y,0.45},{x-20,y-40,0.2}},{duration=0.03}) end
wait(12)
-- cover glaze: prewet then rows
for gx=0,5 do for gy=0,2 do drop{x=50+gx*100+(gy%2)*45, y=50+gy*90, water=4, radius=70} end end
local V = brush{name="cov", width=44}
local vm = {["buff-titanium"]=0.08, ["indian-red"]=0.008, ["raw-umber"]=0.006, ["burnt-sienna"]=0.004}
for r=0,11 do for x=0,600,30 do local y=10+r*25; top(V, vm, 3); V:stroke({{x,y},{x+34,y+4}}, {pressure=0.5, duration=0.03}) end end
wait(15)



local seed = 9
local function rnd() seed = (seed*1103515245 + 12345) % 2147483648; return seed/2147483648 end
local d = brush{name="drybr", width=24}
d:load{water=0.5, pigments={["burnt-umber"]=0.15, ["indian-red"]=0.08, ["sepia"]=0.05}}
for i=1,6 do
  local y = 30 + i*40
  d:stroke({{40,y},{140,y-30},{240,y-50}}, {dry=true, pressure=0.4})
end
local d2 = brush{name="drybr2", width=24}
d2:load{water=0.5, pigments={["burnt-umber"]=0.4, ["indian-red"]=0.2, ["sepia"]=0.15}}
for i=1,6 do
  local y = 30 + i*40
  d2:stroke({{300,y},{400,y-30},{500,y-50}}, {dry=true, pressure=0.6})
end
local sp = brush{name="speck", width=4}
for i=1,60 do
  sp:load{water=0.1, pigments={["sepia"]=0.02, ["french-ultramarine"]=0.01}}
  local x = 520+rnd()*100; local y = 30+rnd()*250
  sp:stroke({{x,y},{x+3,y+1}}, {pressure=0.5})
end
wait(10)



local seed = 19
local function rnd() seed = (seed*1103515245 + 12345) % 2147483648; return seed/2147483648 end
local d = brush{name="rutA", width=10}
for i=1,6 do
  d:load{water=0.4, pigments={["burnt-umber"]=0.03, ["indian-red"]=0.015, ["sepia"]=0.01}}
  local y = 30 + i*40
  d:stroke({{40,y,0.5},{90,y-15,0.4},{140,y-30,0.2}}, {duration=0.08})
end
local d2 = brush{name="rutB", width=10}
for i=1,6 do
  d2:load{water=0.8, pigments={["burnt-umber"]=0.03, ["indian-red"]=0.015, ["sepia"]=0.01}}
  local y = 30 + i*40
  d2:stroke({{200,y,0.5},{250,y-15,0.4},{300,y-30,0.2}}, {duration=0.08})
end
local d3 = brush{name="rutC", width=10}
for i=1,6 do
  d3:load{water=0.8, pigments={["burnt-umber"]=0.03, ["indian-red"]=0.015, ["sepia"]=0.01}}
  local y = 30 + i*40
  d3:stroke({{340,y,0.5},{390,y-15,0.4},{440,y-30,0.2}}, {duration=0.08, dry=true})
end
wait(10)
