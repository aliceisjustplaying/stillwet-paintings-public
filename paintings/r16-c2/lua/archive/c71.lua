weedD = pile{{"raw umber",1},{"bone black",0.6},{"green earth",0.4},{"red earth",0.15}}
local spots = {{70,690,14},{120,700,10},{95,676,8},{190,705,12},{250,684,7},{40,660,6},{300,700,9},{160,668,6},{930,700,12},{975,680,8},{880,690,7},{350,672,5}}
for i,s in ipairs(spots) do
  local x,y,r = s[1],s[2],s[3]
  local c = ellipse(x, y, r*2.2, r*0.55):roughen(r*0.35, r*0.9, 200+i)
  stipple(c, {pile=weedD, width=math.max(2, r*0.35), coverage=1.6, pressure={0.4,0.7}, cluster=0.5, drag={r*0.3, 0}})
  if i % 2 == 0 then
    local b = brush{kind="round", width=r*0.8, point=0.1}
    b:load(stoneP, 0.7)
    b:touch(x + r*0.8, y - r*0.1, {pressure=0.7, drag={r*0.5, 0}})
    local h = brush{kind="round", width=r*0.35, point=0.2}
    h:load(stoneHi, 0.45)
    h:touch(x + r*0.7, y - r*0.35, {pressure=0.35, drag={r*0.35, 0}})
  end
end
