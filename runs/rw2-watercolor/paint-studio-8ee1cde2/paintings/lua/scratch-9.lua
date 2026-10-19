--@ watercolor-engine 2

paper{width=1180,height=700,kind="cold-press",seed=2013}


local function top(b, mx, target, f)
  local need = target - b:status().water
  if need > 0 then local p={} for k,v in pairs(mx) do p[k]=v*need*(f or 1) end; b:load{water=need, pigments=p} end
end
local mixes = {
 {["indian-red"]=0.02, ["burnt-umber"]=0.025, ["burnt-sienna"]=0.015, ["french-ultramarine"]=0.004},
 {["indian-red"]=0.03, ["burnt-umber"]=0.035, ["burnt-sienna"]=0.01, ["french-ultramarine"]=0.008},
 {["burnt-sienna"]=0.03, ["indian-red"]=0.015, ["raw-umber"]=0.015, ["yellow-ochre"]=0.005},
}
for i,mx in ipairs(mixes) do
  local b = brush{name="d"..i, width=44}
  local x0 = 20 + (i-1)*380
  for gx=0,2 do for gy=0,2 do drop{x=x0+50+gx*110, y=60+gy*110, water=4, radius=72} end end
  local t0 = clock()
  for r=0,12 do
    for x=x0, x0+330, 30 do
      local y = 30 + r*26 + (x-x0)*0.35
      top(b, mx, 3)
      b:stroke({{x,y},{x+34,y+12}}, {pressure=0.5, duration=0.03})
    end
  end
  print(i, clock()-t0)
end
wait(15)



local function top(b, mx, target, f)
  local need = target - b:status().water
  if need > 0 then local p={} for k,v in pairs(mx) do p[k]=v*need*(f or 1) end; b:load{water=need, pigments=p} end
end
local mixes = {
 {["indian-red"]=0.025, ["burnt-umber"]=0.02, ["french-ultramarine"]=0.008, ["raw-umber"]=0.01},
 {["indian-red"]=0.018, ["sepia"]=0.012, ["burnt-umber"]=0.015, ["french-ultramarine"]=0.006},
 {["indian-red"]=0.02, ["raw-umber"]=0.02, ["paynes-gray"]=0.005, ["burnt-sienna"]=0.006},
}
for i,mx in ipairs(mixes) do
  local b = brush{name="e"..i, width=40}
  local x0 = 20 + (i-1)*380
  local n=0
  for r=0,5 do
    for x=x0, x0+330, 26 do
      n=n+1
      local y = 520 + r*28 + math.sin(n*1.7)*6
      top(b, mx, 2.5)
      b:stroke({{x,y},{x+30,y+8+math.sin(n)*6}}, {pressure=0.5, duration=0.03})
    end
  end
end
wait(15)
