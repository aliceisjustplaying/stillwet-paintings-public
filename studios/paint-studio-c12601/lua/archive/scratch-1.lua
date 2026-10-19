paper{width=1056,height=704,kind="cold-press",seed=4417}

local amts={0.3,1,3,8}
for i,a in ipairs(amts) do
  local b=brush{name="t_u"..i,width=40}
  b:load{water=20,pigments={["french-ultramarine"]=a}}
  b:stroke({{40,40+i*60},{400,40+i*60}})
  local c=brush{name="t_s"..i,width=40}
  c:load{water=20,pigments={["burnt-sienna"]=a}}
  c:stroke({{450,40+i*60},{810,40+i*60}})
  print(i, b:status().water, c:status().water)
end
-- wash test
local w=brush{name="t_w",width=60}
w:load{water=100}
w:wash{x=40,y=360,width=400,height=200}
local p=brush{name="t_p",width=50}
p:load{water=40,pigments={["french-ultramarine"]=3,["burnt-sienna"]=0.6}}
p:stroke({{60,380},{420,380},{420,420},{60,420}},{duration=0.6})
print("w",w:status().water, "p",p:status().water)
print(balance().max_surface_water)
wait(20)
print(balance().dry)