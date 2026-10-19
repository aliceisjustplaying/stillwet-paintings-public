paper{width=1056,height=704,kind="cold-press",seed=4417}

local function top(b,W,mix)
  local s=b:status()
  local add={}
  for k,v in pairs(mix) do local have=s.pigments[k] or 0; if v>have then add[k]=math.min(10,v-have) end end
  local w=math.max(0,math.min(100,W-s.water))
  b:load{water=w,pigments=add}
end
local function longstroke(b,W,mix,x0,x1,y,seg)
  local x=x0
  while x<x1 do
    top(b,W,mix)
    local xe=math.min(x1,x+seg)
    b:stroke({{x,y},{xe,y}})
    x=xe
  end
end
local P={0.05,0.15,0.5,1.5}
for i,p in ipairs(P) do
  local b=brush{name="L"..i,width=30}
  longstroke(b,30,{["french-ultramarine"]=p},60,760,60+(i-1)*100,40)
  local s=b:status() print(i,s.water)
end
-- water effect
local b=brush{name="Lw",width=30}
longstroke(b,90,{["french-ultramarine"]=0.5},60,760,460,40)
wait(10)