paper{width=2400,height=128,kind="cold-press",seed=4417}
for i,t in ipairs({{10,0.25},{40,1}}) do
  local b=brush{name="distance"..i}
  b:load{water=t[1],pigments={["french-ultramarine"]=t[2]}}
  local y=32+(i-1)*64
  b:stroke({{64,y},{2336,y}})
  local s=b:status()
  print(i, s.width, s.water, s.pigments["french-ultramarine"])
end
