--@ watercolor-engine 2

paper{width=1180,height=700,kind="cold-press",seed=2013}


local function top(b, mx, target, f)
  local need = target - b:status().water
  if need > 0 then local p={} for k,v in pairs(mx) do p[k]=v*need*(f or 1) end; b:load{water=need, pigments=p} end
end
local seed = 71
local function rnd() seed = (seed*1103515245 + 12345) % 2147483648; return seed/2147483648 end
local b = brush{name="soil", width=44}
local mx = {["burnt-umber"]=0.05, ["indian-red"]=0.025, ["sepia"]=0.015, ["french-ultramarine"]=0.012}
for r=0,7 do for x=0,560,28 do local y=20+r*26; top(b, mx, 2.5, 1.4); b:stroke({{x,y},{x+32,y+9}}, {pressure=0.5, duration=0.03}) end end
wait(12)
local mixes = {
 {["buff-titanium"]=0.3, ["raw-umber"]=0.05, ["burnt-umber"]=0.03, ["indian-red"]=0.025},
 {["buff-titanium"]=0.3, ["raw-umber"]=0.03, ["burnt-sienna"]=0.03, ["indian-red"]=0.02, ["yellow-ochre"]=0.02},
 {["buff-titanium"]=0.22, ["raw-umber"]=0.04, ["burnt-umber"]=0.04, ["indian-red"]=0.02, ["french-ultramarine"]=0.006},
}
for i,m in ipairs(mixes) do
  local c = brush{name="cv"..i, width=18}
  local x0 = (i-1)*190
  for k=1,110 do
    local x = x0 + rnd()*170; local y = 20 + rnd()*190
    top(c, m, 1.0, 0.8 + rnd()*0.4)
    local a = 0.8 + (rnd()-0.5)*0.6
    c:stroke({{x,y,0.5},{x+math.cos(a)*16, y+math.sin(a)*14,0.3}}, {duration=0.03})
  end
end
wait(15)



local function top(b, mx, target, f)
  local need = target - b:status().water
  if need > 0 then local p={} for k,v in pairs(mx) do p[k]=v*need*(f or 1) end; b:load{water=need, pigments=p} end
end
local seed = 81
local function rnd() seed = (seed*1103515245 + 12345) % 2147483648; return seed/2147483648 end
-- left half: transparent warm glaze long strokes; right: buff-rich semi glaze
local g1 = brush{name="tg1", width=40}
local m1 = {["raw-umber"]=0.012, ["burnt-sienna"]=0.01, ["indian-red"]=0.005}
for k=1,40 do local x=rnd()*260; local y=10+rnd()*200; top(g1,m1,2.2); g1:stroke({{x,y,0.5},{x+30,y+26,0.4}},{duration=0.03}) end
local g2 = brush{name="tg2", width=40}
local m2 = {["buff-titanium"]=0.06, ["raw-umber"]=0.012, ["burnt-sienna"]=0.01, ["indian-red"]=0.005}
for k=1,40 do local x=300+rnd()*260; local y=10+rnd()*200; top(g2,m2,2.2); g2:stroke({{x,y,0.5},{x+30,y+26,0.4}},{duration=0.03}) end
wait(15)
