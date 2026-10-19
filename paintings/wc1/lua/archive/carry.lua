paper{width=1056,height=192,kind="cold-press",seed=4417}
for i,t in ipairs({{40,1},{80,2}}) do
  local b=brush{name="carry"..i}
  b:load{water=t[1],pigments={["french-ultramarine"]=t[2]}}
  local y=48+(i-1)*96
  b:stroke({{60,y},{996,y}})
  local s=b:status()
  print(i,t[1],t[2],s.width,s.water,s.pigments["french-ultramarine"])
end
