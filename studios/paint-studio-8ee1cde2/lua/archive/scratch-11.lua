--@ watercolor-engine 2

paper{width=1180,height=700,kind="cold-press",seed=2013}


local function top(b, mx, target, f)
  local need = target - b:status().water
  if need > 0 then local p={} for k,v in pairs(mx) do p[k]=v*need*(f or 1) end; b:load{water=need, pigments=p} end
end
local mx = {["burnt-umber"]=0.04, ["indian-red"]=0.02, ["sepia"]=0.01, ["french-ultramarine"]=0.01}
local b = brush{name="soil_base", width=44}
local n=0
for r=0,20 do for x=-20,1180,28 do n=n+1
  local y = 20 + r*26 + math.sin(n*1.7)*4
  top(b, mx, 2.5, 1.4); b:stroke({{x,y},{x+32,y+9+math.sin(n)*4}}, {pressure=0.5, duration=0.03})
end end
wait(15)
local glz = {
 {["buff-titanium"]=0.06, ["raw-umber"]=0.01},
 {["buff-titanium"]=0.12, ["raw-umber"]=0.015, ["indian-red"]=0.01},
 {["french-ultramarine"]=0.012, ["burnt-umber"]=0.01},
 {["naples-yellow"]=0.05, ["indian-red"]=0.01, ["buff-titanium"]=0.04},
 {["cobalt-blue"]=0.01, ["buff-titanium"]=0.05},
}
for i,g in ipairs(glz) do
  local gb = brush{name="g"..i, width=44}
  local x0 = 20 + (i-1)*230
  for y=60,500,26 do for x=x0, x0+170, 30 do top(gb, g, 3); gb:stroke({{x,y},{x+34,y+3}}, {pressure=0.5, duration=0.03}) end end
end
wait(15)



local function top(b, mx, target, f)
  local need = target - b:status().water
  if need > 0 then local p={} for k,v in pairs(mx) do p[k]=v*need*(f or 1) end; b:load{water=need, pigments=p} end
end
local glz = {
 {["burnt-umber"]=0.03, ["indian-red"]=0.012, ["sepia"]=0.006},
 {["burnt-umber"]=0.05, ["indian-red"]=0.02, ["sepia"]=0.012, ["french-ultramarine"]=0.006},
 {["burnt-sienna"]=0.015, ["raw-umber"]=0.015, ["indian-red"]=0.008},
}
for i,g in ipairs(glz) do
  local gb = brush{name="w"..i, width=40}
  local x0 = 20 + (i-1)*65
  for y=80,440,24 do for x=x0, x0+30, 30 do top(gb, g, 2.5); gb:stroke({{x,y},{x+30,y+6}}, {pressure=0.5, duration=0.03}) end end
end
wait(15)
