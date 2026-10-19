--@ watercolor-engine 2

paper{width=1180,height=700,kind="cold-press",seed=2013}


local function top(b, mx, target, f)
  local need = target - b:status().water
  if need > 0 then local p={} for k,v in pairs(mx) do p[k]=v*need*(f or 1) end; b:load{water=need, pigments=p} end
end
local mx = {["burnt-umber"]=0.04, ["indian-red"]=0.02, ["sepia"]=0.01, ["french-ultramarine"]=0.01}
local b = brush{name="soil_base", width=44}
local n=0
for r=0,22 do for x=-20,1180,28 do n=n+1
  local y = 10 + r*26 + math.sin(n*1.7)*4
  top(b, mx, 2.5, r<11 and 1.1 or 1.9); b:stroke({{x,y},{x+32,y+9+math.sin(n)*4}}, {pressure=0.5, duration=0.03})
end end
wait(15)
local glz = {
 {["cerulean-blue"]=0.02, ["buff-titanium"]=0.02},
 {["cerulean-blue"]=0.04},
 {["french-ultramarine"]=0.015, ["buff-titanium"]=0.03},
 {["paynes-gray"]=0.012, ["buff-titanium"]=0.03},
 {["terre-verte"]=0.03, ["buff-titanium"]=0.02},
}
for i,g in ipairs(glz) do
  local gb = brush{name="g"..i, width=40}
  local x0 = 20 + (i-1)*230
  for y=30,660,24 do for x=x0, x0+150, 30 do top(gb, g, 2.5); gb:stroke({{x,y},{x+32,y+3}}, {pressure=0.5, duration=0.03}) end end
end
wait(15)
