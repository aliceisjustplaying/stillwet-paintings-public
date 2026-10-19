paper{width=1056,height=704,kind="cold-press",seed=4417}

local tests={{10,0.2},{40,0.2},{40,1},{80,1},{80,4}}
for i,t in ipairs(tests) do
  local b=brush{name="v"..i,width=30}
  b:load{water=t[1],pigments={["french-ultramarine"]=t[2]}}
  local y=60+(i-1)*110
  b:stroke({{60,y},{760,y}},{duration=1.5})
  local s=b:status()
  local pg=0 for k,v in pairs(s.pigments) do pg=pg+v end
  print(i, t[1],t[2], "left water",s.water,"pig",pg)
  wait(5)
end