--@ chunk 1
canvas{style="friedrich", aspect=1.4, seed=3}
skypal = pal:only{"lead white","pale smalt","cobalt blue","yellow ochre","raw umber","red earth","chrome yellow","vermilion"}
G = function(x, c, s) return math.exp(-((x - c)/s)^2) end
HZ = 600
skycol = function(x, y)
  local t = clamp(y / HZ, 0, 1)
  local c = gradient({{0,"#47536c"},{0.25,"#5f6a82"},{0.5,"#8b8d9c"},{0.66,"#a8999c"},{0.8,"#c6b39e"},{1,"#d2bd98"}}, t)
  return mix(c, "#ecd49e", 0.6*math.exp(-((x-600)/300)^2)*smoothstep(HZ-330, HZ-20, y))
end
skyM = mask(function(x, y) return y < HZ and 1 or 0 end)
P = piles(skycol, {n=6, over=skyM, pal=skypal, seed=7})
print(P)
print(#P, P:pick(500, 100), P:at(500,100))
work(skyM, {hand="broad", color=skycol, angle=0, angle_jitter=0.02, length={120, 320}, coverage=3.8, medium=0.3, load=0.75, pal=skypal, seed=11})
blend(skyM, {angle=0, coverage=1.2, length={150, 400}})
print(timesheet().sitting)
