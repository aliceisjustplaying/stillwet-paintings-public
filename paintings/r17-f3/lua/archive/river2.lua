local rvA = pile{{"lead white",4},{"pale smalt",1.4},{"smalt",0.35},{"green earth",0.25},{"raw umber",0.08}, medium=0.1}
local rvB = pile{{"lead white",7},{"pale smalt",1.0},{"yellow ochre",0.08}, medium=0.1}
local lower = RIVER * mask(function(x,y) return smoothstep(rtop(x)+0.8, rtop(x)+2.2, y) end)
work(lower, {hand="detail", pile=rvA, tool={kind="round", width=1.2, point=0.5}, angle=0, length={10,30}, coverage=2.2, clip=true, fill=true, load=0.6})
-- reflections of far bank trees and town: soft vertical dabs
local refl = pile{{"lead white",3},{"pale smalt",1.3},{"smalt",0.3},{"raw umber",0.25},{"green earth",0.2}, medium=0.1}
local rb = brush{kind="round", width=1.4, point=0.3}
rb:load(refl, 0.5)
for _,x in ipairs({596,600,604,640,660,678,680,682,700,725,757,760,763,790,810}) do
  local yt = rtop(x) + 0.5
  rb:stroke({{x, yt}, {x + rand(-0.3,0.3), yt + rand(2.5, 5)}}, {pressure={0.5,0.3}})
  if rb:fullness() < 0.3 then rb:reload(refl, 0.5) end
end
-- a few horizontal glints
local g = brush{kind="round", width=0.9, point=0.5}
g:load(rvB, 0.5)
for k=1,14 do
  local x = rand(360, 990)
  local y = rtop(x) + rand(2.5, 4.5)
  g:stroke({{x,y},{x+rand(6,20),y}}, {pressure={0.4,0.3}})
end
print(wait(0))
