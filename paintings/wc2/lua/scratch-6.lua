paper{width=1056,height=704,kind="cold-press",seed=3117}


math.randomseed(5)
for y=380,700,95 do for x=40,1056,118 do drop{x=x,y=y,water=8,radius=80} end end
local b = brush{name="mud", width=55}
local i=0
local y=360
while y<700 do
  i=i+1
  local warm = 0.5+0.5*math.sin(i*1.7)
  local m = {["burnt-sienna"]=0.018+0.02*warm, ["french-ultramarine"]=0.03-0.008*warm, ["raw-umber"]=0.01}
  local dir = (i%2==1) and 1 or -1
  local x = dir==1 and -20 or 1076
  while (dir==1 and x<1076) or (dir==-1 and x>-20) do
    local L = 30+math.random()*45
    local s=b:status(); local need = 3.5 - (s.water or 0)
    if need>0 then local pg={} for kk,v in pairs(m) do pg[kk]=v*need end b:load{water=need,pigments=pg} end
    b:stroke({{x,y+math.random()*6-3},{x+L*dir,y+math.random()*6-3}},{pressure=0.6,duration=0.01})
    x = x + L*dir
  end
  y = y + 26 + math.random()*8
end
print(clock())
wait(12) print(balance().dry)
