paper{width=1056,height=704,kind="cold-press",seed=3117}


-- sky trial: prewet grid, then rows topped up
for y=40,320,95 do for x=40,1056,118 do drop{x=x,y=y,water=12,radius=80} end end
local b = brush{name="sky1", width=70}
local rows = {
 {y=30,  p={["french-ultramarine"]=0.5, ["burnt-sienna"]=0.08}},
 {y=80,  p={["french-ultramarine"]=0.4, ["burnt-sienna"]=0.08}},
 {y=130, p={["french-ultramarine"]=0.25, ["quinacridone-rose"]=0.05}},
 {y=180, p={["quinacridone-rose"]=0.08, ["french-ultramarine"]=0.08}},
 {y=230, p={["raw-sienna"]=0.2, ["quinacridone-rose"]=0.05}},
 {y=280, p={["raw-sienna"]=0.18}},
 {y=320, p={["raw-sienna"]=0.12, ["hansa-yellow"]=0.05}},
}
for _,r in ipairs(rows) do
  local x=-20
  while x < 1080 do
    local s = b:status()
    local need = 5 - (s.water or 0)
    if need > 0 then
      -- scale pigment by water added
      local pg = {}
      for k,v in pairs(r.p) do pg[k]=v*need/5 end
      b:load{water=need, pigments=pg}
    end
    b:stroke({{x,r.y},{x+40,r.y}}, {pressure=0.6, duration=0.012*1+0.02})
    x = x + 40
  end
end
print(clock())
for i=1,10 do wait(0.5); local s=balance(); print(clock(), s.max_surface_water, s.dry) end
