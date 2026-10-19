--@ watercolor-engine 2

paper{width=1180,height=700,kind="cold-press",seed=2013}


local function top(b, mx, target, f)
  local need = target - b:status().water
  if need > 0 then local p={} for k,v in pairs(mx) do p[k]=v*need*(f or 1) end; b:load{water=need, pigments=p} end
end
local b = brush{name="soil", width=44}
local mx = {["burnt-umber"]=0.04, ["indian-red"]=0.02, ["sepia"]=0.01, ["french-ultramarine"]=0.01}
for r=0,8 do for x=0,560,28 do local y=10+r*26; top(b, mx, 2.5, 0.9); b:stroke({{x,y},{x+32,y+9}}, {pressure=0.5, duration=0.03}) end end
wait(10)
local g = brush{name="glz", width=44}
local gm = {["burnt-umber"]=0.04, ["sepia"]=0.015, ["french-ultramarine"]=0.012, ["indian-red"]=0.01}
for band=0,2 do for r=0,3 do for x=0,560,28 do local y=10+band*76+r*19; top(g, gm, 3, 0.6); g:stroke({{x,y},{x+32,y+5}}, {pressure=0.5, duration=0.03}) end end; wait(3) end
wait(12)



local function top(b, mx, target, f)
  local need = target - b:status().water
  if need > 0 then local p={} for k,v in pairs(mx) do p[k]=v*need*(f or 1) end; b:load{water=need, pigments=p} end
end
local seed = 31
local function rnd() seed = (seed*1103515245 + 12345) % 2147483648; return seed/2147483648 end
local C = {
 {["buff-titanium"]=0.15, ["indian-red"]=0.012, ["raw-umber"]=0.012, ["burnt-umber"]=0.01},
 {["buff-titanium"]=0.25, ["indian-red"]=0.02, ["raw-umber"]=0.02, ["burnt-umber"]=0.015},
 {["buff-titanium"]=0.25, ["indian-red"]=0.015, ["raw-umber"]=0.02, ["french-ultramarine"]=0.008},
 {["buff-titanium"]=0.4, ["indian-red"]=0.03, ["raw-umber"]=0.03, ["burnt-umber"]=0.02},
}
for i,m in ipairs(C) do
  local cb = brush{name="c"..i, width=24}
  local x0 = 10 + (i-1)*140
  for k=1,50 do
    local x = x0 + rnd()*110; local y = 20 + rnd()*200
    top(cb, m, 1.4)
    local a = (rnd()-0.5)*1.4
    cb:stroke({{x,y,0.5},{x+math.cos(a)*22, y+math.sin(a)*14,0.3}}, {duration=0.03})
  end
end
wait(15)



local function top(b, mx, target, f)
  local need = target - b:status().water
  if need > 0 then local p={} for k,v in pairs(mx) do p[k]=v*need*(f or 1) end; b:load{water=need, pigments=p} end
end
local seed = 41
local function rnd() seed = (seed*1103515245 + 12345) % 2147483648; return seed/2147483648 end
-- dense opaque cover on the right of the trial patch (x 300-560, y 120-230) - wait, use fresh underlayer at y 260+
local b = brush{name="soil2", width=44}
local mx = {["burnt-umber"]=0.04, ["indian-red"]=0.02, ["sepia"]=0.01, ["french-ultramarine"]=0.01}
for r=0,5 do for x=0,560,28 do local y=280+r*26; top(b, mx, 2.5, 1.4); b:stroke({{x,y},{x+32,y+9}}, {pressure=0.5, duration=0.03}) end end
wait(12)
local m1 = {["buff-titanium"]=0.4, ["indian-red"]=0.03, ["raw-umber"]=0.03, ["burnt-umber"]=0.02}
local m2 = {["buff-titanium"]=0.25, ["indian-red"]=0.02, ["raw-umber"]=0.02, ["burnt-umber"]=0.015}
local c1 = brush{name="d1", width=26}
local c2 = brush{name="d2", width=26}
for k=1,130 do
  local x = 10 + rnd()*260; local y = 280 + rnd()*140
  local cb, m = c1, m1
  if rnd() < 0.4 then cb, m = c2, m2 end
  top(cb, m, 1.5)
  local a = (rnd()-0.5)*1.0
  cb:stroke({{x,y,0.5},{x+math.cos(a)*26, y+math.sin(a)*12,0.35}}, {duration=0.03})
end
-- slope midtone dabs
local m3 = {["buff-titanium"]=0.10, ["burnt-umber"]=0.035, ["indian-red"]=0.015, ["french-ultramarine"]=0.01}
local c3 = brush{name="d3", width=26}
for k=1,90 do
  local x = 300 + rnd()*260; local y = 280 + rnd()*140
  top(c3, m3, 1.5)
  local a = (rnd()-0.5)*1.0 + 0.3
  c3:stroke({{x,y,0.5},{x+math.cos(a)*26, y+math.sin(a)*12,0.35}}, {duration=0.03})
end
wait(15)



local function top(b, mx, target, f)
  local need = target - b:status().water
  if need > 0 then local p={} for k,v in pairs(mx) do p[k]=v*need*(f or 1) end; b:load{water=need, pigments=p} end
end
local seed = 51
local function rnd() seed = (seed*1103515245 + 12345) % 2147483648; return seed/2147483648 end
local G = {
 {["indian-red"]=0.015, ["burnt-umber"]=0.02},
 {["burnt-umber"]=0.03, ["raw-umber"]=0.015, ["indian-red"]=0.008, ["french-ultramarine"]=0.004},
}
for i,gm in ipairs(G) do
  local g = brush{name="tg"..i, width=34}
  local x0 = 10 + (i-1)*135
  for k=1,40 do
    local x = x0 + rnd()*110; local y = 280 + rnd()*130
    top(g, gm, 2, 1)
    local a = (rnd()-0.5)*1.0 + 0.35
    g:stroke({{x,y,0.55},{x+math.cos(a)*30, y+math.sin(a)*24,0.35}}, {duration=0.03})
  end
end
wait(15)



local function top(b, mx, target, f)
  local need = target - b:status().water
  if need > 0 then local p={} for k,v in pairs(mx) do p[k]=v*need*(f or 1) end; b:load{water=need, pigments=p} end
end
local seed = 61
local function rnd() seed = (seed*1103515245 + 12345) % 2147483648; return seed/2147483648 end
local b = brush{name="soil3", width=44}
local mx = {["burnt-umber"]=0.04, ["indian-red"]=0.02, ["sepia"]=0.01, ["french-ultramarine"]=0.01}
for r=0,6 do for x=0,560,28 do local y=470+r*26; top(b, mx, 2.5, 1.4); b:stroke({{x,y},{x+32,y+9}}, {pressure=0.5, duration=0.03}) end end
wait(6)
local g = brush{name="glz3", width=44}
local gm = {["burnt-umber"]=0.04, ["sepia"]=0.015, ["french-ultramarine"]=0.012, ["indian-red"]=0.01}
for band=0,1 do for r=0,3 do for x=0,560,28 do local y=470+band*76+r*19; top(g, gm, 3, 1.2); g:stroke({{x,y},{x+32,y+5}}, {pressure=0.5, duration=0.03}) end end; wait(3) end
wait(12)
local D = {
 {["buff-titanium"]=0.08, ["burnt-umber"]=0.05, ["indian-red"]=0.025, ["sepia"]=0.012, ["french-ultramarine"]=0.01},
 {["buff-titanium"]=0.04, ["burnt-umber"]=0.06, ["indian-red"]=0.03, ["sepia"]=0.02, ["french-ultramarine"]=0.012},
}
for i,dm in ipairs(D) do
  local c = brush{name="sd"..i, width=26}
  local x0 = (i-1)*290
  for k=1,90 do
    local x = x0 + rnd()*250; local y = 470 + rnd()*170
    top(c, dm, 1.5)
    local a = 0.5 + (rnd()-0.5)*0.8
    c:stroke({{x,y,0.5},{x+math.cos(a)*24, y+math.sin(a)*18,0.35}}, {duration=0.03})
  end
end
wait(15)
