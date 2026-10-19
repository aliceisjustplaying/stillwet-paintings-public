--@ watercolor-engine 2

paper{width=1180,height=700,kind="cold-press",seed=2013}


local function top(b, mx, target, f)
  local need = target - b:status().water
  if need > 0 then local p={} for k,v in pairs(mx) do p[k]=v*need*(f or 1) end; b:load{water=need, pigments=p} end
end
local seed = 7
local function rnd() seed = (seed*1103515245 + 12345) % 2147483648; return seed/2147483648 end
-- underlayer: light green dabs
local light = {["sap-green"]=0.05, ["green-gold"]=0.03, ["hookers-green"]=0.01}
local b = brush{name="fl", width=26}
for i=1,260 do
  local x = 40 + rnd()*400; local y = 60 + rnd()*260
  top(b, light, 1.6)
  local a = rnd()*6.28
  b:stroke({{x,y,0.6},{x+math.cos(a)*14, y+math.sin(a)*10,0.3}}, {duration=0.03})
end
wait(15)
-- dark clusters glaze
local dark = {["hookers-green"]=0.07, ["sepia"]=0.02, ["french-ultramarine"]=0.015}
local d = brush{name="fd", width=20}
for i=1,160 do
  local x = 40 + rnd()*400; local y = 120 + rnd()*200
  top(d, dark, 1.3)
  local a = rnd()*6.28
  d:stroke({{x,y,0.6},{x+math.cos(a)*10, y+6+math.sin(a)*6,0.25}}, {duration=0.03})
end
-- wet-in-wet version on right
for i=1,6 do drop{x=600+i*60, y=200, water=6, radius=60} end
local b2 = brush{name="fl2", width=26}
for i=1,200 do
  local x = 560 + rnd()*400; local y = 80 + rnd()*240
  top(b2, light, 1.6)
  local a = rnd()*6.28
  b2:stroke({{x,y,0.6},{x+math.cos(a)*14, y+math.sin(a)*10,0.3}}, {duration=0.03})
end
local d2 = brush{name="fd2", width=20}
for i=1,120 do
  local x = 560 + rnd()*400; local y = 140 + rnd()*180
  top(d2, dark, 1.3)
  local a = rnd()*6.28
  d2:stroke({{x,y,0.6},{x+math.cos(a)*10, y+6+math.sin(a)*6,0.25}}, {duration=0.03})
end
wait(15)
