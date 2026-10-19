--@ watercolor-engine 2

paper{width=1180,height=700,kind="cold-press",seed=2013}


local function top(b, mx, target, f)
  local need = target - b:status().water
  if need > 0 then local p={} for k,v in pairs(mx) do p[k]=v*need*(f or 1) end; b:load{water=need, pigments=p} end
end
local mixes = {
 {["burnt-umber"]=0.05, ["indian-red"]=0.015, ["french-ultramarine"]=0.012},
 {["burnt-umber"]=0.04, ["indian-red"]=0.02, ["sepia"]=0.01, ["french-ultramarine"]=0.01},
 {["burnt-umber"]=0.06, ["burnt-sienna"]=0.01, ["french-ultramarine"]=0.02, ["indian-red"]=0.01},
 {["sepia"]=0.04, ["indian-red"]=0.025, ["french-ultramarine"]=0.01},
}
for i,mx in ipairs(mixes) do
  for k=1,2 do
  local b = brush{name="f"..i..k, width=40}
  local x0 = 20 + (i-1)*290
  local y0 = 30 + (k-1)*300
  local n=0
  for r=0,6 do
    for x=x0, x0+230, 26 do
      n=n+1
      local y = y0 + r*28 + math.sin(n*1.7)*6
      top(b, mx, 2.5, k==1 and 1 or 2)
      b:stroke({{x,y},{x+30,y+8+math.sin(n)*6}}, {pressure=0.5, duration=0.03})
    end
  end
  end
end
wait(15)
