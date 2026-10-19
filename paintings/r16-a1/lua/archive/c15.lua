crest = pile{{"lead white",5},{"yellow ochre",0.2},{"vermilion",0.08},{"smalt",0.25}, medium=0.1}
knb = pile{{"lead white",4},{"smalt",1},{"vermilion",0.06},{"raw umber",0.12}, medium=0.1}
fgs = pile{{"lead white",3},{"smalt",1.5},{"raw umber",0.3},{"red earth",0.1}, medium=0.1}
kang = function(x,y) local f = clamp(1-(y-480)/260,0,1); if x < 640 then return -0.07*f else return 0.09*f end end
knollf = function(x) -- piecewise linear over knoll points
  for i=1,#knoll-1 do local a,b = knoll[i],knoll[i+1]; if x>=a[1] and x<=b[1] then return lerp(a[2],b[2],(x-a[1])/(b[1]-a[1])) end end
  return knoll[#knoll][2] end
local crestm = landm * above(function(x) return knollf(x)+45 end)
local bodym = below(function(x) return knollf(x)+30 end) * above(function(x) return 610 end)
local fgm = below(function(x) return 590 end)
work(fgm, {hand="broad", pile=fgs, angle=kang, coverage=2, fill=true})
work(bodym, {hand="body", pile=knb, angle=kang, coverage=2.2, fill=true, length={40,90}})
work(crestm, {hand="body", pile=crest, angle=kang, coverage=2.5, fill=true, clip=true, length={30,80}})
blend(landm, {angle=kang})
