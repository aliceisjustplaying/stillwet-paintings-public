--@ watercolor-engine 2

paper{width=1180,height=700,kind="cold-press",seed=2013}


local function top(b, mx, target, f)
  local need = target - b:status().water
  if need > 0 then local p={} for k,v in pairs(mx) do p[k]=v*need*(f or 1) end; b:load{water=need, pigments=p} end
end
local seed = 11
local function rnd() seed = (seed*1103515245 + 12345) % 2147483648; return seed/2147483648 end
local mid = {["sap-green"]=0.12, ["hookers-green"]=0.04, ["green-gold"]=0.03, ["burnt-umber"]=0.01}
local b = brush{name="base", width=40}
for r=0,8 do for x=40,420,28 do
  top(b, mid, 2.5); local y = 60+r*26+rnd()*8
  b:stroke({{x,y},{x+30,y+rnd()*10-5}}, {pressure=0.5, duration=0.03})
end end
-- ragged top edge dabs
local e = brush{name="edge", width=16}
for i=1,40 do top(e, mid, 0.9); local x=40+rnd()*400; local y=45+rnd()*25; e:stroke({{x,y,0.5},{x+rnd()*10-5,y-8-rnd()*8,0.2}},{duration=0.03}) end
wait(15)
local dark = {["hookers-green"]=0.2, ["sepia"]=0.06, ["french-ultramarine"]=0.04}
local d = brush{name="dark", width=18}
for c=1,14 do
  local cx = 60 + rnd()*360; local cy = 90 + rnd()*170
  for k=1,9 do
    top(d, dark, 1.1)
    local x = cx + (rnd()-0.5)*50; local y = cy + rnd()*20
    d:stroke({{x-8,y,0.3},{x,y+4,0.6},{x+9,y+2,0.3}}, {duration=0.03})
  end
end
wait(15)
-- highlight dabs opaque
local hl = {["cadmium-yellow"]=0.08, ["sap-green"]=0.06, ["green-gold"]=0.03}
local h = brush{name="hl", width=14}
for i=1,90 do top(h, hl, 0.8); local x=50+rnd()*370; local y=70+rnd()*180; h:stroke({{x,y,0.5},{x+6,y-3,0.3}},{duration=0.03}) end
-- second column: same but darker base
local mid2 = {["sap-green"]=0.15, ["hookers-green"]=0.10, ["sepia"]=0.02, ["french-ultramarine"]=0.02}
local b2 = brush{name="base2", width=40}
for r=0,8 do for x=560,940,28 do
  top(b2, mid2, 2.5); local y = 60+r*26+rnd()*8
  b2:stroke({{x,y},{x+30,y+rnd()*10-5}}, {pressure=0.5, duration=0.03})
end end
wait(15)
