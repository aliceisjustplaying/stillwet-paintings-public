local sp = {{248,584},{245,560},{247,530},{250,500},{251,478}}
function spineX(y)
  for i=1,#sp-1 do
    local a,b = sp[i],sp[i+1]
    if y <= a[2] and y >= b[2] then return lerp(a[1], b[1], (a[2]-y)/(a[2]-b[2])) end
  end
  return 251
end
local trunk = oakM * rect(200,470,100,120) - oakSil
tb1 = pile{{"raw umber",2},{"bone black",0.5},{"lead white",0.8},{"Prussian blue",0.1}, medium=0.05}
tb2 = pile{{"lead white",2},{"raw umber",1},{"yellow ochre",0.8},{"bone black",0.15}, medium=0.05}
-- dark bark over all visible limbs and trunk
work(oakM - oakSil:shrink(2), {hand="detail", pile=tb1, tool={kind="round", width=2.2, point=0.5}, angle=math.pi/2, coverage=2.2, fill=true, seed=281})
-- lit left side of trunk
local lit = trunk * mask(function(x,y) return smoothstep(-2, -9, x - spineX(y)) end)
work(lit, {hand="detail", pile=tb2, tool={kind="round", width=1.8, point=0.5}, angle=math.pi/2, coverage=2, fill=true, seed=282})
