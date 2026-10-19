local cut = rect(0,0,1000,414)
local C = (cloud2M:grow(9) * cut)
print(C:area())
for _,p in ipairs({{560,400},{600,360},{650,320},{700,280},{760,250},{820,240},{900,290},{990,330},{1000,400},{620,405}}) do print(p[1],p[2],C:at(p[1],p[2])) end
