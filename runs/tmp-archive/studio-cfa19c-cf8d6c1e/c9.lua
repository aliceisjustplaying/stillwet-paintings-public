local B = {{615,378,55,30},{688,352,62,44},{758,322,66,56},{828,342,58,46},{896,358,66,40},{958,378,60,30},{722,380,80,30},{850,388,90,24},{572,398,40,16},{800,300,40,35}}
local parts = {}
for i,b in ipairs(B) do
  parts[#parts+1] = {body.ellipsoid({b[1],b[2],0},{b[3],b[4],(b[3]+b[4])/2}):rough(4, 60, i)}
end
parts.light = {from={-1,-0.9}, front=0.4, ambient=0.25}
cloudF = form(parts)
local sil = cloudF:silhouette{} * below(function(x) return 0 end):map(function(v) return 1 end)
cloudM = (cloudF:silhouette{} * rect(0,0,1000,404)):soften(3)
cloudLit = (cloudF:lit{soft=0.2} * rect(0,0,1000,404))
cs = pile{{"lead white",8},{"pale smalt",2},{"red earth",0.25},{"yellow ochre",0.2}, medium=0.1}
cl = pile{{"lead white",12},{"yellow ochre",0.35},{"vermilion",0.04}}
work(cloudM, {hand="body", pile=cs, angle=0.05, coverage=2, fill=true, pressure={0.4,0.7}, edge="soft", seed=41})
work(cloudLit, {hand="body", pile=cl, tool="filbert 6", angle=function(x,y) return cloudF:across(x,y) end, coverage=2, fill=true, pressure={0.5,0.8}, edge={found=0.5, soft=0.5}, seed=42})
print(cloudM:area(), cloudLit:area())
