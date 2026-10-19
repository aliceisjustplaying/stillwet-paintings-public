wait(60*6)
local gD = pile{{"Prussian blue",0.6},{"raw umber",1},{"green earth",1.5},{"yellow ochre",0.6}, medium=0.05}
local gM = pile{{"green earth",1.5},{"yellow ochre",1.2},{"Prussian blue",0.3},{"lead white",0.3}, medium=0.05}
local keep = trunkM:grow(2) + stoneM:grow(1)
math.randomseed(311)
local b = brush{kind="rigger", width=1.4, point=1}
for pass=1,2 do
  local p = pass==1 and gD or gM
  b:reload(p, 0.9)
  local N = pass==1 and 420 or 200
  for i=1,N do
    local x = math.random()*1000
    local y0 = riseY(x) + 40
    if y0 < 712 then
      local y = y0 + math.random()*(716-y0)
      if keep:at(x,y) < 0.5 then
        local s = 0.6 + (y-620)/90
        local hgt = (10 + math.random()*14)*s
        local lean = (math.random()-0.5)*8*s
        b:stroke({{x,y},{x+lean*0.3,y-hgt*0.5},{x+lean,y-hgt}}, {pressure={0.5,0.05}, ramps={0.05,0.5}})
        if i % 15 == 0 then b:load(p, 0.9) end
      end
    end
  end
end
