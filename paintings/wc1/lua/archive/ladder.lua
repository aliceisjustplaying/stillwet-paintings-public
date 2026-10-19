paper{width=1056,height=704,kind="cold-press",seed=4417}
for i,p in ipairs({0.3,1,3}) do
  local b=brush{name="ladder"..i}
  b:load{water=40,pigments={["french-ultramarine"]=p}}
  local y=120+(i-1)*180
  b:stroke({{60,y},{996,y}})
  local s=b:status()
  print(i,p,s.width,s.water,s.pigments["french-ultramarine"])
  wait(5)
end
